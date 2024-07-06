//-------------------------------------------------------------------------
// Class		: fifo_write_driver
// Base Class	: uvm_driver
// Type			: UVM_COMPONENT
// Description	: Receive sequence_items from Sequencer
//				  Send them to DUT
//				  Send Acknowledgement signal to Sequence through sequencer
//--------------------------------------------------------------------------

class fifo_write_driver extends uvm_driver #(fifo_wtrans);

	`uvm_component_utils(fifo_write_driver)
	
	// declaring virtual interface to drive the transactions 
	//fifo_wtrans wtrans_h;
	virtual fifo_if.wdrv_mp vif;
  
  function new(string name = "fifo_write_driver", uvm_component parent = null);
		super.new(name,parent);
	endfunction 
	
	//handshaking of driver seqeuncer and sequence
	task run_phase(uvm_phase phase);
		repeat(no_of_trans) begin 
        //if(vif.wdrv_cb.rst) fifo_wr_rst();
		seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
		end 	
	endtask 

	//drive data items to dut at the posedge of clk of interface 
	task send_to_dut(fifo_wtrans req);
      @(vif.wdrv_cb);
		vif.wdrv_cb.wr_en <= req.wr_en;
		vif.wdrv_cb.data_in <= req.data_in;
	endtask
  
  // if reset is asserted then wr_en and data_in should get deasserted
  /*
  task fifo_wr_rst();
    @(vif.wdrv_cb);
    	vif.wdrv_cb.wr_en <= 0;
    	vif.wdrv_cb.data_in <= 0;
  endtask	
  */
endclass 
