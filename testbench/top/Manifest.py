action = "simulation"
target = "xilinx"
fetchto = "../../ip_cores"
sim_tool="modelsim"
syn_device="xc6slx45t"
top_module="main"
files = [ "glbl.v", "main.sv" ]
include_dirs=["../include", "../../sim", "../../ip_cores/urv-core/rtl"]
modules = { "local" :  [ "../../top/cmod_a7" ] }

