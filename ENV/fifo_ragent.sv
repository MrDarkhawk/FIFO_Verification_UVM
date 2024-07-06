//----------------------------------------------------------------
// Class		: fifo_read_agent
// base_class	: uvm_agent
// type			: UVM_COMPONENT
// Description	: Read_agent for read transaction level activity
//				  Active_Agent Consisting Seqr, Driver, Monitor
//				  Passive_Agent having monitor only
//----------------------------------------------------------------

class fifo_read_agent extends uvm_agent;

	//factoring registration of component
	`uvm_component_utils(fifo_read_agent)
	
	//virtual interface declaration 
	virtual fifo_if vif;
	
	fifo_read_driver rdrv_h;
	fifo_read_sequencer rseqr_h;
	fifo_read_monitor rmon_h;
	
	//class constructor 
	function new(string name = "fifo_read_agent", uvm_component parent = null);
		super.new(name,parent);
	endfunction 
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		rdrv_h = fifo_read_driver::type_id::create("rdrv_h",this);
		rseqr_h = fifo_read_sequencer::type_id::create("rseqr_h",this);
		rmon_h = fifo_read_monitor::type_id::create("rmon_h",this);
		
		if(!uvm_config_db#(virtual fifo_if)::get(this,"","vif",vif)) begin
          `uvm_fatal("fifo_read_agent","virtual interface is get failed");
		end
	endfunction 
	
	function void connect_phase(uvm_phase phase);
		rdrv_h.seq_item_port.connect(rseqr_h.seq_item_export);
		rdrv_h.vif = vif;
		rmon_h.vif = vif;
	endfunction 
		
endclass