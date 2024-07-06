//----------------------------------------------------------------
// Class		: fifo_write_agent
// base_class	: uvm_agent
// type			: UVM_COMPONENT
// Description	: Write_agent for write transaction level activity
//				  Active_Agent Consisting Seqr, Driver, Monitor
//				  Passive_Agent having monitor only
//----------------------------------------------------------------

class fifo_write_agent extends uvm_agent;

	// factory registration of agent
	`uvm_component_utils(fifo_write_agent)
	
	fifo_write_sequencer wseqr_h;
	fifo_write_driver	 wdrv_h;
	fifo_write_monitor 	 wmon_h;
	
	// declaring virtual interface which is used to make connect from dynamic component to static component
	virtual fifo_if vif;
	
	// class constructor
	function new(string name = "fifo_write_agent", uvm_component parent = null);
		super.new(name,parent);
	endfunction : new

//----------------------------------------------------------------
// Method		: build_phase
// Args			: (uvm_phase phase);
// Description	: object for monitor, driver and seqr created
//				  config_db check for virtual interface
//---------------------------------------------------------------
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		wseqr_h = fifo_write_sequencer::type_id::create("wseqr_h",this);
		wdrv_h = fifo_write_driver::type_id::create("wdrv_h",this);
		wmon_h = fifo_write_monitor::type_id::create("wmon_h",this);
		
		//config db not get vif 
		if(!uvm_config_db#(virtual fifo_if)::get(this,"","vif",vif)) begin
		`uvm_fatal("FIFO_WRITE_AGENT","The virtual interface get failed");	
		end
	endfunction : build_phase
	
//-------------------------------------------------------------
// Method		: connect_phase
// Args			: (uvm_phase phase);
// Description	: Connection between driver and seqr
//				  Connection between driver and virtual interface
//				  connection between driver and monitor
//-------------------------------------------------------------

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		wdrv_h.seq_item_port.connect(wseqr_h.seq_item_export);
		wdrv_h.vif = vif;
		wmon_h.vif = vif;
		
	endfunction 
	
endclass 