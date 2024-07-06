
file delete -force work
vlib work
vlog 
vopt +acc tb_top -o ace
vsim -l simulation.log ace +UVM_TESTNAME=ace_reset_test
do ../fifo_wave.do
run -all
quit -f
