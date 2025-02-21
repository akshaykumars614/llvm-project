add_llvm_pass_plugin(PPProfiler PPProfiler.cpp)

add_llvm_component_library(LLVMPPProfiler
  PPProfiler.cpp
  LINK_COMPONENTS
  Core
  Support
)
