//-----------------------------------------------------------
// class		:	fifo_env
// Base_class	:	uvm_env
// Type			:	UVM_COMPONENT
// Description	:	Environment will create and connect agent, scoreboard
//-----------------------------------------------------------

class fifo_env extends uvm_env;

	`uvm_component_utils(fifo_env)
	fifo_coverage fifo_cg_h;
	fifo_write_agent wagent_h;
	fifo_read_agent  ragent_h;
	fifo_sb  sb_h;
	
	function new(string name = "fifo_env", uvm_component parent = null);
		super.new(name,parent);
	endfunction 
			
	//build phase : constructs the testbench component hierarchy from the top downwards
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		wagent_h = fifo_write_agent::type_id::create("wagent_h",this);
		ragent_h = fifo_read_agent::type_id::create("ragent_h",this);
		sb_h = fifo_sb::type_id::create("sb_h",this);
		fifo_cg_h = fifo_coverage::type_id::create("fifo_cg_h",this);
    endfunction : build_phase
	
	// connect phase : used to make TLM connections between components 
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		wagent_h.wmon_h.an_w_port.connect(sb_h.an_w_fifoh.analysis_export);
		ragent_h.rmon_h.an_r_port.connect(sb_h.an_r_fifoh.analysis_export);
		wagent_h.wmon_h.an_w_port.connect(fifo_cg_h.an_w_fifoh.analysis_export);
		ragent_h.rmon_h.an_r_port.connect(fifo_cg_h.an_r_fifoh.analysis_export);
	endfunction : connect_phase
	
endclass 