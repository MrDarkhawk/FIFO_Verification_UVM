//----------------------------------------------------------------
// class		: fifo_read_sequencer
// Base_class	: uvm_sequencer
// Type			: UVM_COMPONENT
// Description	: Sequencer will receive sequence_items from
//				  sequence and send them to driver.
//----------------------------------------------------------------

class fifo_read_sequencer extends uvm_sequencer #(fifo_rtrans);

	`uvm_component_utils(fifo_read_sequencer)
	
	function new(string name = "fifo_read_sequencer", uvm_component parent = null);
		super.new(name,parent);
	endfunction

endclass 