class fifo_empty_seqs extends uvm_sequence #(fifo_rtrans);

	`uvm_object_utils(fifo_empty_seqs)
	
	fifo_rtrans rtrans_h;
	
	function new(string name = "fifo_empty_seqs");
		super.new(name);
	endfunction

	task body();
		repeat(no_of_trans) begin 
		rtrans_h = fifo_rtrans::type_id::create("rtrans_h");
          `uvm_info(get_type_name(),"inside the body task of fifo empty sequence",UVM_NONE)
			start_item(rtrans_h);
			assert(rtrans_h.randomize);
			//printing sequence items using inbuilt do_print method 
				//`uvm_info(get_type_name(),$sformatf("@%0t \t Print the read transactions",$realtime),UVM_NONE)
				//rtrans_h.print();
          finish_item(rtrans_h);
		end
	endtask 
	
endclass 