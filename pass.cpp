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
            if(F.isDeclaration()){
                outs()<<"Declaration found "<<F.getName()<<"\n";
            }
            else{
                outs()<<"For function "<<F.getName()<<"\n";
                for(auto& B:F){
                    for(auto& I:B.instructionsWithoutDebug()){
                        outs()<<I.getOpcodeName()<<"\n";
                    }
                }
            }
            return PreservedAnalyses::all();
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