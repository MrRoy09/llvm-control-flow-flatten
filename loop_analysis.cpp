#include "llvm/IR/PassManager.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Pass.h"

using namespace llvm;

namespace{
    class ControlFlowFlattening : public PassInfoMixin<ControlFlowFlattening>{
        public:
        PreservedAnalyses run(Function &F , FunctionAnalysisManager&P){
            LoopInfo &LI = P.getResult<LoopAnalysis>(F);
            for(auto* L:LI){
                printInfo(L);
            }
            return PreservedAnalyses::all();
       }

       void printInfo(Loop *L){
            outs()<<"Printing loop info\n";
            outs()<<L->getLoopDepth()<<"\n";
            outs()<<L->hasDedicatedExits()<<"\n";
       }
    };
}

PassPluginLibraryInfo getPassPluginInfo()
{
  const auto callback = [](PassBuilder &PB)
  {
    PB.registerPipelineStartEPCallback(
        [&](ModulePassManager &MPM, auto)
        {
          MPM.addPass(createModuleToFunctionPassAdaptor(ControlFlowFlattening()));
          return true;
        });
  };

  return {LLVM_PLUGIN_API_VERSION, "name", "0.0.1", callback};
};


extern "C" LLVM_ATTRIBUTE_WEAK PassPluginLibraryInfo llvmGetPassPluginInfo()
{
  return getPassPluginInfo();
}