files = ["covidlcd_top_cmod_a7.vhd",
	 "cmod_a7.xdc",
	 "reset_gen.vhd" ]

fetchto = "../../ip_cores"

modules = {
    "local" : ["../../rtl/", "../../ip_cores/urv-core", "../../ip_cores/general-cores" ]
    }
