//-------------------------------------------------------------------------------------
//	Class		:	fifo_read_monitor
//	Base_class	:	uvm_monitor
//	Type		:	uvm_component
//	Description	:	Monitor will fetch data from DUT
//-------------------------------------------------------------------------------------

class fifo_read_monitor extends uvm_monitor;

  `uvm_component_utils(fifo_read_monitor)
	
	fifo_rtrans rtrans_h;
	
	//virtual interface to sampled the data from dut 
	virtual fifo_if.rmon_mp vif;
	
	//declaring analysis port to send the observed data from dut to the other components 
	uvm_analysis_port #(fifo_rtrans) an_r_port;
	
	//class constructor and analysis port creation 
  function new(string name = "fifo_read_monitor", uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		an_r_port = new("an_r_port",this);
      `uvm_info(get_type_name(),$sformatf("analysis read port build "),UVM_NONE)
	endfunction 
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin 
		monitor();
		//using write method of analysis port to send the data to other components like coverage and scoreboard block
		an_r_port.write(rtrans_h);
		end 
	endtask 
	
	task monitor();
		//creating object 
		rtrans_h = fifo_rtrans::type_id::create("rtrans_h",this);		
		//sampling data from dut using virtual interface and assigning to created object 
		@(vif.rmon_cb);
		rtrans_h.rd_en	= vif.rmon_cb.rd_en;
		rtrans_h.data_out = vif.rmon_cb.data_out;
		rtrans_h.fifo_full = vif.rmon_cb.fifo_full;
		rtrans_h.fifo_empty = vif.rmon_cb.fifo_empty;
		rtrans_h.fifo_overflow = vif.rmon_cb.fifo_overflow;
		rtrans_h.fifo_underflow = vif.rmon_cb.fifo_underflow;
		rtrans_h.fifo_almost_empty = vif.rmon_cb.fifo_almost_empty;
		rtrans_h.fifo_almost_full = vif.rmon_cb.fifo_almost_full;
	endtask 
	
endclass 