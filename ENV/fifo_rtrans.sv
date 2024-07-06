//---------------------------------------------------------------
// Class		: fifo_rtrans
// Base_class	: uvm_sequence_item
// Type			: UVM_OBJECT
// Description	: Read operation related signals defined here
//				  constraint related read signals defined here
//---------------------------------------------------------------

class fifo_rtrans extends uvm_sequence_item;

	rand bit rd_en;
	bit [DATA_WIDTH - 1 : 0] data_out; // read out data 
	static bit [DATA_WIDTH - 1 : 0] exptd_data; // use in scoreboard to compare with actual data 
	bit fifo_full;
	bit fifo_empty;
	bit fifo_overflow;
	bit fifo_underflow;
	bit fifo_almost_empty;
	bit fifo_almost_full;
	
	constraint c1{rd_en == 1'b1;}

	`uvm_object_utils_begin(fifo_rtrans)
		`uvm_field_int(rd_en,UVM_ALL_ON)
		`uvm_field_int(data_out,UVM_ALL_ON)
		`uvm_field_int(exptd_data,UVM_ALL_ON)
		`uvm_field_int(fifo_full,UVM_ALL_ON)
		`uvm_field_int(fifo_empty,UVM_ALL_ON)
		`uvm_field_int(fifo_overflow,UVM_ALL_ON)
		`uvm_field_int(fifo_underflow,UVM_ALL_ON)
		`uvm_field_int(fifo_almost_full,UVM_ALL_ON)
		`uvm_field_int(fifo_almost_empty,UVM_ALL_ON)
	`uvm_object_utils_end

	function new(string name = "fifo_rtrans");
		super.new(name);
	endfunction
		
	function string sprint_pkt();
		sprint_pkt=$sformatf("FIFO_RD_TXN: rd_enb=0x%0h rd_data=0x%0h  exptd_data=0x%0h fifo_full=0x%0h fifo_empty=0x%0h",rd_en,data_out,exptd_data,fifo_full,fifo_empty);
	endfunction	
	
endclass 