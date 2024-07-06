//----------------------------------------------------------------
// Class		:	fifo_overflow_seqs
// Base_class	: 	uvm_sequence
// Type			:	UVM_OBJECT
// Description	:	To generate Sequence_items,
//					creating object of write_trans
//					send it to sequencer by start_item
//					randomization of write_trans object
//					Finish Sequence_items through signal finish_item
//----------------------------------------------------------------

class fifo_overflow_seqs extends uvm_sequence #(fifo_wtrans);

	`uvm_object_utils(fifo_overflow_seqs)
	
	fifo_wtrans wtrans_h;
	
	function new(string name = "fifo_overflow_seqs");
      super.new(name);	
	endfunction 
	
	task body();
		repeat(no_of_trans) begin 
			wtrans_h = fifo_wtrans::type_id::create("wtrans_h");
// 			`uvm_info(get_type_name(),"inside the body task of fifo overflow sequence",UVM_NONE)
			start_item(wtrans_h);
			assert(wtrans_h.randomize);
			//printing sequence items using inbuilt transaction method 
				//`uvm_info(get_type_name(),$sformatf("@%0t \t Print the write transactions",$realtime),UVM_NONE)
				//wtrans_h.print();
			finish_item(wtrans_h);
		end 
	endtask 

endclass 