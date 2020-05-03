#vlog -sv main.sv
vsim -t 1ps -L unisims_ver work.main work.glbl -voptargs="+acc"
set StdArithNoWarnings 1
set NumericStdNoWarnings 1
do wave.do
radix -hexadecimal
run 3000us
wave zoomfull
radix -hexadecimal
