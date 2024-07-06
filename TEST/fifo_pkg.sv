package fifo_pkg;
   
	import uvm_pkg::*;
	parameter DATA_WIDTH = 8;
	parameter DEPTH = 16;
	parameter ASIZE = 3;
	int no_of_trans = 10;
	`include "uvm_macros.svh"
	`include "fifo_defines.sv"
	//`include "fifo_if.sv"
     	`include "fifo_wtrans.sv"
  	`include "fifo_rtrans.sv"

  	`include "fifo_wseqs.sv"
  	`include "fifo_rseqs.sv"
  	`include "fifo_full_seqs.sv"
  	`include "fifo_empty_seqs.sv"
	`include "fifo_overflow_seqs.sv"
  	`include "fifo_underflow_seqs.sv"
  
  	`include "fifo_wseqr.sv"
  	`include "fifo_rseqr.sv"
  
  	`include "fifo_wdrv.sv"
  	`include "fifo_rdrv.sv"
  
  	`include "fifo_wmon.sv"
  	`include "fifo_rmon.sv"
  
  	`include "fifo_wagent.sv"
  	`include "fifo_ragent.sv"
	
  	`include "fifo_coverage.sv"
  	`include "fifo_sb.sv"
  	`include "fifo_env.sv"
 	`include "fifo_test.sv"
	`include "fifo_full_test.sv"
  	`include "fifo_empty_test.sv"
  	`include "fifo_write_reset_test.sv"
  	`include "fifo_overflow_test.sv"
  	`include "fifo_underflow_test.sv"

endpackage