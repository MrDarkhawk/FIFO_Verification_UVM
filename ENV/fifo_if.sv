// Class : Interface 
// Description : for communication between TB and DUT 
interface fifo_if #(parameter DATA_WIDTH = 8)(input bit clk);

	logic rst;
	
	//Write signals
	logic wr_en; // to write data
	logic [DATA_WIDTH - 1:0] data_in;
		
	// Read signals
	logic rd_en;  //to read data
	logic [DATA_WIDTH - 1:0] data_out;
	
	logic fifo_full;
	logic fifo_empty; 
	logic fifo_overflow;
	logic fifo_underflow;
	logic fifo_almost_full;
	logic fifo_almost_empty;

	// clocking block : it is used to syncronize the input and output data transfers 
	
	clocking wdrv_cb @(posedge clk);
	default input #1 output #1;
	output rst;
	output wr_en,data_in;
	endclocking
	
	clocking wmon_cb @(posedge clk);
	default input #1 output #1;	
	input rst;
	input wr_en,data_in,fifo_full,fifo_empty,fifo_overflow,fifo_underflow,fifo_almost_full,fifo_almost_empty;
	endclocking 
	
	clocking rdrv_cb @(posedge clk);
	default input #1 output #1;
	input rst;
	output rd_en;
	endclocking 
	
	clocking rmon_cb @(posedge clk);
	default input #1 output #1;
	input rst;
	input rd_en,data_out,fifo_full,fifo_empty,fifo_overflow,fifo_underflow,fifo_almost_full,fifo_almost_empty;
	endclocking
	
	// Modport block : it is used to manage the direction of signals.
	
	modport wdrv_mp (clocking wdrv_cb);
	
	modport wmon_mp (clocking wmon_cb);
	
	modport rdrv_mp (clocking rdrv_cb);
	
	modport rmon_mp (clocking rmon_cb);
		
	// check that on  if reset = 1 then wr_en == 0, rd_en == 0, fifo_empty == 1, fifo_full == 0; 

	property fifo_reset_prop;
		@(posedge clk)
			disable iff(!rst) rst |->  (rd_en == 0) && (wr_en == 0) && (fifo_empty == 1) && (fifo_full == 0); 
	endproperty 
		
	property fifo_overflow_prop;
		@(posedge clk)
      disable iff(rst) (fifo_full && wr_en) |-> (fifo_overflow) ; 
	endproperty
      
	property fifo_underflow_prop;
		@(posedge clk)
      disable iff(rst) (fifo_empty && rd_en) |-> (fifo_underflow) ; 
	endproperty
      
      fifo_reset_assert : assert property (fifo_reset_prop) ;
	
      fifo_overflow_assert : assert property (fifo_overflow_prop) ;
	
      fifo_underflow_assert : assert property (fifo_underflow_prop);
	
endinterface : fifo_if	