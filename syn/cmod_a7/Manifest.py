target = "xilinx"
action = "synthesis"
fetchto = "../../ip_cores"
top_module = "covidlcd_top_cmod_a7"

syn_device = "xc7a35t"
syn_grade = "-1"
syn_package = "cpg236"
syn_project = "covidlcd_top_cmod_a7"
syn_tool="vivado"
syn_top="covidlcd_top_cmod_a7"

modules = { "local" : [ "../../top/cmod_a7" ] }
