class fifo_base_test extends uvm_test;

	`uvm_component_utils(fifo_base_test)
	
  	virtual fifo_if vif;
  
	fifo_env env_h;
	fifo_write_sequence wseqs_h;
	fifo_read_sequence rseqs_h;
	
	function new(string name = "fifo_base_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction 
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env_h = fifo_env::type_id::create("env_h",this);
		wseqs_h = fifo_write_sequence::type_id::create("wseqs_h",this);
		rseqs_h = fifo_read_sequence::type_id::create("rseqs_h",this);
      uvm_config_db #(virtual fifo_if)::get(null,"","vif",vif);
		`uvm_info(get_type_name(),"Base test build phase excuted",UVM_NONE)
	endfunction 
	
	// end_of_elaboration_phase : used to make any final adjustments to the structure
	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		// printing the entire top to down hierarchy of components
      `uvm_info(get_type_name(),"Printing Topology of components",UVM_NONE)
		uvm_top.print_topology();
	endfunction
	
	// run phase : used for the stimulus generation and checking activities of the testbench
  task run_phase(uvm_phase phase);
   
		phase.raise_objection(this);// Starting of a test/run phase
    `uvm_info(get_type_name(),"Inside the run phase 0f test ",UVM_NONE)
    // `uvm_info(get_type_name(),$sformatf("Inside the run phase 0f test and reset = %0d",vif.rst),UVM_NONE)
    wait(vif.rst === 0)  	//untill dont deassert the reset 
		//starting the respected sequences 
		//It is much important to tell the sequences to start from which sequencer.
		wseqs_h.start(env_h.wagent_h.wseqr_h); //starting from write sequencer 
		rseqs_h.start(env_h.ragent_h.rseqr_h); //starting from read sequencer	 

		phase.drop_objection(this); // To end the test/run phase 
	endtask
	
endclass 