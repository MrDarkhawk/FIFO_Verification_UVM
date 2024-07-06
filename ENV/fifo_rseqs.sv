//---------------------------------------------------------------
// Class		: fifo_read_sequence #(fifo_rtrans); (Parameterized)
// Base_class	: uvm_sequence
// Type			: UVM_OBJECT
// Description	: Create read operation related seq_items
//				  Randomization of read signals done here
//---------------------------------------------------------------

class fifo_read_sequence extends uvm_sequence #(fifo_rtrans);

	`uvm_object_utils(fifo_read_sequence)
	
	fifo_rtrans rtrans_h;
  
	function new(string name = "fifo_read_sequence");
		super.new(name);
	endfunction 
//--------------------------------------------------------------
// Method		:	task body();
// Args			:	Null
// Description	:	Creation of read_trans object
//					Randomization of read signals
//					put them into object created for read_trans
//--------------------------------------------------------------

	task body();
		repeat(no_of_trans) begin 
		rtrans_h = fifo_rtrans::type_id::create("rtrans_h");
		// handshaking mechanism with driver sequencer 
		start_item(rtrans_h);
		assert(rtrans_h.randomize());
//         rtrans_h.print();
		finish_item(rtrans_h);
		end 		
	endtask
	
endclass 