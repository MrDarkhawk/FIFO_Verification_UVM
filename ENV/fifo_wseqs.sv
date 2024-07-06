//----------------------------------------------------------------
// Class		:	fifo_write_wseqs
// Base_class	: 	uvm_sequence
// Type			:	UVM_OBJECT
// Description	:	To generate Sequence_items,
//					creating object of write_trans
//					send it to sequencer by start_item
//					randomization of write_trans object
//					Finish Sequence_items through signal finish_item
//----------------------------------------------------------------

class fifo_write_sequence extends uvm_sequence #(fifo_wtrans);
		
		// factory registraion of object
		`uvm_object_utils(fifo_write_sequence)
  
		// handle of transaction class
		fifo_wtrans wtrans_h;
	  
		//construction of class 
		function new(string name = "fifo_write_sequence");
			super.new(name);
		endfunction 
		
		//task for handsking mechanism with driver through sequencer
		task body();
          repeat(no_of_trans) begin
		//creating the object of transaction class
		wtrans_h = fifo_wtrans::type_id::create("wtrans_h");
		// start sequence and randomize 
            //`uvm_info(get_type_name(),"inside the body task of write sequence",UVM_NONE)
			start_item(wtrans_h);
			assert(wtrans_h.randomize());
			//printing sequence items using inbuilt transaction method 
			//             wtrans_h.print();
			//`uvm_info(get_type_name(),$sformatf("@%0t \t Print the write transactions",$realtime),UVM_NONE)
			finish_item(wtrans_h);
          end
		endtask 
endclass