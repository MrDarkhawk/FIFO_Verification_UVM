
import uvm_pkg::*;
`include "uvm_macros.svh"
import fifo_pkg::*;
//`include "fifo_defines.sv"
module fifo_top;

	
	//int no_of_trans = 5;
	parameter DATA_WIDTH = 8;
	parameter DEPTH = 16;
	parameter ASIZE = 3;
	bit clk;
	bit rst;
	
	//Instatiate the interface with tb in top module 
	fifo_if #(DATA_WIDTH) inf(clk);
	// Instantiate the signals of dut with tb in top module.
	FIFO #(DATA_WIDTH,DEPTH,ASIZE)dut(.clk(clk),.rst(inf.rst),.wr_en(inf.wr_en),.rd_en(inf.rd_en),.data_in(inf.data_in),.data_out(inf.data_out),.fifo_full(inf.fifo_full),.fifo_empty(inf.fifo_empty),.fifo_overflow(inf.fifo_overflow),.fifo_underflow(inf.fifo_underflow),.fifo_almost_full(inf.fifo_almost_full),.fifo_almost_empty(inf.fifo_almost_empty));
			 
	always #5 clk = ~clk;
	
	initial begin 
	@(posedge clk) inf.rst = 1;
	#10;
        @(posedge clk) inf.rst = 0;
	end 

	initial begin 
	// configuration : used to pass configuration data objects between component objects
	//we are in the HDL part of the testbench, a null object handle is assigned.
	 uvm_config_db #(virtual fifo_if) :: set (null,"*","vif",inf);
//       run_test("fifo_base_test");
//       run_test("fifo_full_test");
//       run_test("fifo_empty_test");
//       run_test("fifo_write_reset_test");
//       run_test("fifo_overflow_test");
      run_test("fifo_underflow_test");
	end 
	initial begin 
		$dumpfile("dump.vcd"); 
		$dumpvars;
	end 
endmodule 