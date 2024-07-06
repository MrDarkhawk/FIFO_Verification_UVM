//----------------------------------------------------------------
//	class		: fifo_wmon
//	base_class	: uvm_monitor
//	type		: UVM_COMPONENT
//	Description	: Getting Response from DUT
//				  Send them to scoreboard for analysis purpose
//----------------------------------------------------------------

class fifo_write_monitor extends uvm_monitor;
	
	//factory registration of component 
	`uvm_component_utils(fifo_write_monitor)
	
	// virtual interface for monitor transactions with dut 
	virtual fifo_if.wmon_mp vif;
	
	// taking handle of write transaction 
	fifo_wtrans wtrans_h;
	
	// Declaring the tlm analysis port to subscribe the data to other components 
	uvm_analysis_port #(fifo_wtrans) an_w_port;
	
	// class constructor 
	function new(string name = "fifo_write_monitor", uvm_component parent = null );
		super.new(name,parent);
	endfunction
	
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    an_w_port = new("an_w_port",this);
  endfunction
  
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
		// We should always use the forever block for monitor to sample the data continously
		forever begin 
		// calling monitor block to sampling data from dut 
		monitor();
		// using write method 
		an_w_port.write(wtrans_h);
		end 
	endtask 

	task monitor();
		// creating the write transaction class objects
		wtrans_h = fifo_wtrans::type_id::create("wtrans_h",this);
		
		//using write monitor clocking block to get the transactions through virtual interface 
		@(vif.wmon_cb);
      //`uvm_info(get_type_name(),$sformatf("%0t clocking block execution of monitor",$realtime),UVM_NONE)
		// sampling data from dut through vif and assigning it to write transactions 
		wtrans_h.wr_en	= vif.wmon_cb.wr_en;
		wtrans_h.data_in = vif.wmon_cb.data_in;
		wtrans_h.fifo_full = vif.wmon_cb.fifo_full;
		wtrans_h.fifo_empty = vif.wmon_cb.fifo_empty;
		wtrans_h.fifo_overflow = vif.wmon_cb.fifo_overflow;
		wtrans_h.fifo_underflow = vif.wmon_cb.fifo_underflow;
		wtrans_h.fifo_almost_full = vif.wmon_cb.fifo_almost_full;
		wtrans_h.fifo_almost_empty = vif.wmon_cb.fifo_almost_empty;
	endtask 
	
endclass