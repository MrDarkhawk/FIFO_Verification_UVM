//----------------------------------------------------------------
// Class		:	fifo_underflow_seqs
// Base_class	: 	uvm_sequence
// Type			:	UVM_OBJECT
// Description	:	To generate Sequence_items,
//					creating object of read_trans
//					send it to sequencer by start_item
//					randomization of read_trans object
//					Finish Sequence_items through signal finish_item
//----------------------------------------------------------------

class fifo_underflow_seqs extends uvm_sequence #(fifo_rtrans);

	`uvm_object_utils(fifo_underflow_seqs)
	
	fifo_rtrans rtrans_h;
	
	function new(string name = "fifo_underflow_seqs");
      super.new(name);	
	endfunction 
	
	task body();
      repeat(no_of_trans ) begin 
			rtrans_h = fifo_rtrans::type_id::create("rtrans_h");
// 			`uvm_info(get_type_name(),"inside the body task of fifo underflow sequence",UVM_NONE)
			start_item(rtrans_h);
			assert(rtrans_h.randomize);
			//printing sequence items using inbuilt transaction method 
				//`uvm_info(get_type_name(),$sformatf("@%0t \t Print the write transactions",$realtime),UVM_NONE)
				//rtrans_h.print();
			finish_item(rtrans_h);
		end 
	endtask 

endclass 