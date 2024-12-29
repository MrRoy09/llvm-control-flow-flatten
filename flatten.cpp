#include "llvm/IR/PassManager.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include <llvm/IR/Instructions.h>
#include "llvm/Pass.h"
#include <vector>
#include <unordered_map>

using namespace llvm;

namespace
{
  class ControlFlowFlatten : public PassInfoMixin<ControlFlowFlatten>
  {
  public:
    PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM)
    {
      for (Function &F : M)
      {
        flattenFunction(F);
      }
      return PreservedAnalyses::none();
    }

    bool checkIsConditional(Instruction *i)
    {
      if (BranchInst *ir = dyn_cast<BranchInst>(i))
      {
        return ir->isConditional();
      }
      return 0;
    }

    bool flattenFunction(Function &F)
    {
      AllocaInst *switchVar = NULL;
      LoadInst *load = NULL;
      std::vector<BasicBlock *> BasicBlocks;
      BasicBlock &entry_block = F.getEntryBlock();
      if (F.size() < 2)
      {
        return 0;
      }

      BasicBlock *new_block = entry_block.splitBasicBlockBefore(entry_block.getTerminator());

      for (auto &BB : F)
      {
        BasicBlocks.push_back(&BB);
      }

      BasicBlock *conditionalBlock = new_block;
      while (!checkIsConditional(conditionalBlock->getTerminator()))
      {
        conditionalBlock = conditionalBlock->getSingleSuccessor();
        if (!conditionalBlock)
        {
          errs() << "Multiple successors detected without conditional branch instruction\n";
          return 0;
        }
      }

      auto *branchInstruction = dyn_cast<BranchInst>(conditionalBlock->getTerminator());
      Value *condition = branchInstruction->getCondition();
      switchVar = new AllocaInst(Type::getInt32Ty(F.getContext()), 0, "switchVar", branchInstruction);
      new StoreInst(ConstantInt::get(Type::getInt32Ty(F.getContext()), 1), switchVar, branchInstruction);
      load = new LoadInst(IntegerType::getInt32Ty(F.getContext()), switchVar, "switchVar", branchInstruction);
      Value *cmp = new ICmpInst(branchInstruction, ICmpInst::ICMP_EQ, load, ConstantInt::get(Type::getInt32Ty(F.getContext()), 1), "cmp");
      BasicBlock *trueBlock = branchInstruction->getSuccessor(0);
      BasicBlock *falseBlock = branchInstruction->getSuccessor(1);
      BranchInst::Create(trueBlock, falseBlock, cmp, branchInstruction);
      branchInstruction->removeFromParent();
      outs() << load << "\n";

      BasicBlock *switch_case_3 = dyn_cast<BranchInst>(conditionalBlock->getTerminator())->getSuccessor(0);
      BasicBlock *switch_case_1 = BasicBlock::Create(F.getContext(), "case_1", &F);
      
      new StoreInst(ConstantInt::get(F.getContext(), APInt(32, 2)), switchVar, switch_case_1);

      BasicBlock *switch_block = BasicBlock::Create(F.getContext(), "switch_statement", &F);
      dyn_cast<BranchInst>(conditionalBlock->getTerminator())->setSuccessor(0, switch_block);
      SwitchInst *switchI = SwitchInst::Create(load, falseBlock, 2, switch_block);
      BranchInst::Create(conditionalBlock, switch_case_1);


      switchI->addCase(ConstantInt::get(F.getContext(), APInt(32, 1)), switch_case_1);
      switchI->addCase(ConstantInt::get(F.getContext(), APInt(32, 3)), switch_case_3);
      return 1;
    }
  };
}

PassPluginLibraryInfo getPassPluginInfo()
{
  static std::atomic<bool> ONCE_FLAG(false);
  return {LLVM_PLUGIN_API_VERSION, "obfs", "0.0.1",
          [](PassBuilder &PB)
          {
            try
            {
              PB.registerPipelineEarlySimplificationEPCallback(
                  [&](ModulePassManager &MPM, OptimizationLevel opt)
                  {
                    if (ONCE_FLAG)
                    {
                      return true;
                    }
                    MPM.addPass(ControlFlowFlatten());
                    ONCE_FLAG = true;
                    return true;
                  });
            }
            catch (const std::exception &e)
            {
              outs() << "Error: " << e.what() << "\n";
            }
          }};
};

extern "C" __attribute__((visibility("default"))) LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo()
{
  return getPassPluginInfo();
}
