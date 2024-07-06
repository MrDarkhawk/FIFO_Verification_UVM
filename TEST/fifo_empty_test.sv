class fifo_empty_test extends uvm_test;

	`uvm_component_utils(fifo_empty_test)
	
	fifo_env env_h;
	fifo_empty_seqs empty_seq_h;
	virtual fifo_if vif;
	
	function new(string name = "fifo_empty_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env_h = fifo_env::type_id::create("env_h",this);
		empty_seq_h = fifo_empty_seqs::type_id::create("empty_seq_h",this);
		
		uvm_config_db #(virtual fifo_if) :: get(null,"","vif",vif);
      `uvm_info(get_type_name(),"FIFO EMPTY test build phase excuted",UVM_NONE)
	endfunction 
	
	// end_of_elaboration_phase : used to make any final adjustments to the structure
	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		// printing the entire top to down hierarchy of components
		`uvm_info(get_type_name(),"Printing Topology of components",UVM_NONE)
		uvm_top.print_topology();
	endfunction
	
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
			`uvm_info(get_type_name(),"Inside the run phase of fifo empty test ",UVM_NONE)
			wait(vif.rst === 0);
      empty_seq_h.start(env_h.ragent_h.rseqr_h);
		phase.drop_objection(this);
	endtask 
	
endclass
 