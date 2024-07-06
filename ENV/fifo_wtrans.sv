//------------------------------------------------------------------
//	class		:	fifo_wtrans
//	Base_class	:	uvm_sequence_item
//	Type		:	UVM_OBJECT
//	Description	:	Contains Write Transaction Signals & Constraints
//------------------------------------------------------------------

class fifo_wtrans extends uvm_sequence_item;

	rand bit wr_en;
	randc bit[DATA_WIDTH-1:0] data_in;
	bit fifo_full;
	bit fifo_empty;
	bit fifo_overflow;
	bit fifo_underflow;
	bit fifo_almost_empty;
	bit fifo_almost_full;

	// Hard constraint 
  constraint c1 {soft wr_en == 1'b1;}
	
	// factory registration of objects
	`uvm_object_utils_begin(fifo_wtrans)
		`uvm_field_int(wr_en,UVM_ALL_ON)
 		`uvm_field_int(data_in,UVM_ALL_ON)
		`uvm_field_int(fifo_full,UVM_ALL_ON)
		`uvm_field_int(fifo_empty,UVM_ALL_ON)
		`uvm_field_int(fifo_overflow,UVM_ALL_ON)
		`uvm_field_int(fifo_underflow,UVM_ALL_ON)
		`uvm_field_int(fifo_almost_empty,UVM_ALL_ON)
		`uvm_field_int(fifo_almost_full,UVM_ALL_ON)
	`uvm_object_utils_end
	
	//class constructor 
	function new(string name = "fifo_wtrans");
		super.new(name);
	endfunction 
endclass 