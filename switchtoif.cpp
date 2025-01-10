#include "llvm/IR/PassManager.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include <llvm/IR/Instructions.h>
#include "llvm/Pass.h"
#include <vector>

using namespace llvm;

namespace
{

    class SwitchToIf : public PassInfoMixin<SwitchToIf>
    {
    public:
        PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM)
        {

            for (Function &F : M)
            {
                switchtoif(F);
            }
            return PreservedAnalyses::none();
        }

        static bool isRequired() { return true; };

        bool checkIsSwitchStatement(Instruction *i)
        {
            if (SwitchInst *ir = dyn_cast<SwitchInst>(i))
            {
                return 1;
            }
            return 0;
        }

        bool switchtoif(Function &F)
        {
            std::vector<BasicBlock *> target_conditionals;
            std::vector<BasicBlock *> target_switch_statements;
            std::vector<BasicBlock *> BasicBlocks;
            for (auto &BB : F)
            {
                BasicBlocks.push_back(&BB);
            }

            if (BasicBlocks.size() < 2)
            {
                return 0;
            }

            BasicBlock &entry_block = F.getEntryBlock();

            for (auto *bb : BasicBlocks)
            {
                if (checkIsSwitchStatement(bb->getTerminator()))
                {
                    target_switch_statements.push_back(bb);
                }
            }

            if (target_switch_statements.size() != 0)
            {
                for (auto i = target_switch_statements.rbegin(); i != target_switch_statements.rend(); i++)
                {
                    flattenSwitchStatements(*i, F);
                }
            }

            return 1;
        }

        bool flattenSwitchStatements(BasicBlock *switch_block, Function &F)
        {
            SwitchInst *Switch = dyn_cast<SwitchInst>(switch_block->getTerminator());
            Value *Condition = Switch->getCondition();

            BasicBlock *DefaultBlock = Switch->getDefaultDest();
            BasicBlock *NextBlock = switch_block->splitBasicBlock(Switch, "afterSwitch");

            for (auto i = Switch->case_begin(); i != Switch->case_end(); i++)
            {
                Value *cmp = new ICmpInst(NextBlock->getTerminator(), ICmpInst::ICMP_EQ, i->getCaseValue(), Condition, "cmp");
                switch_block = NextBlock->splitBasicBlock(Switch, "afterSwitch");
                NextBlock->getTerminator()->removeFromParent();
                BranchInst::Create(i->getCaseSuccessor(), switch_block, cmp, NextBlock);
                NextBlock = switch_block;
            }
            switch_block->getPrevNode()->getTerminator()->setSuccessor(1, DefaultBlock);

            Switch->getParent()->removeFromParent();

            return 1;
        }
    };
}

PassPluginLibraryInfo getPassPluginInfo()
{
  static std::atomic<bool> ONCE_FLAG(false);
  return {LLVM_PLUGIN_API_VERSION, "control-flow-flatten", "0.0.1",
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
                    MPM.addPass(SwitchToIf());
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
