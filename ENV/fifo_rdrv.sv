//------------------------------------------------------------------------------------
// 	Class		: fifo_read_driver
//	Base_class	: uvm_driver
//	Type		: UVM_COMPONENT
//	Description	: Driver get data from Seqr and send it to DUT
//------------------------------------------------------------------------------------

class fifo_read_driver extends uvm_driver #(fifo_rtrans);
	
	//factory registration 
	`uvm_component_utils(fifo_read_driver)
	
    //fifo_rtrans rtrans_h;
  
	virtual fifo_if.rdrv_mp vif;
  
	//class constructor
	function new(string name = "fifo_read_driver",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
      super.run_phase(phase);
		repeat(no_of_trans)
		begin 
		seq_item_port.get_next_item(req);
		send_to_dut(req);
       // if(vif.rdrv_cb.rst) fifo_rd_rst(); // if rst = 1 then task call
//          @(vif.rdrv_cb);
//           begin
// 		vif.rdrv_cb.rd_en <= req.rd_en;
//           end
		seq_item_port.item_done();
		end 
	endtask 
	
  	task send_to_dut (fifo_rtrans req);  
//       my_transaction send_req;
// 		$cast(send_req,req);
      @(vif.rdrv_cb);
		vif.rdrv_cb.rd_en <= req.rd_en;	
	endtask 
  
  //if reset is asserted 
  /*
  task fifo_rd_rst();
    @(vif.rdrv_cb);
    vif.rdrv_cb.rd_en <= 0;
  endtask 
  */
endclass