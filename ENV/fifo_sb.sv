//---------------------------------------------------------------
// Class		:	fifo_sb
// Base_class	:	uvm_scoreboard
// Type			:	UVM_COMPONENT
// Description	:	Connection for monitor in connect phase
//					checkers code
//					comparing ref. model output and design output
//--------------------------------------------------------------- 

`define DATA_WIDTH 8
`define ADDR_WIDTH 16

class fifo_sb extends uvm_scoreboard;

	//factory registration 
	`uvm_component_utils (fifo_sb)
	
	// handle of transaction class
	fifo_wtrans wtrans_h;
	fifo_rtrans rtrans_h;
	
	// declaring uvm tlm analysis fifo
	uvm_tlm_analysis_fifo#(fifo_wtrans) an_w_fifoh;
	uvm_tlm_analysis_fifo#(fifo_rtrans) an_r_fifoh;
	
	//declaring queue array for reference model 
	bit [`DATA_WIDTH - 1 : 0] fifo_que[$];
	bit [`DATA_WIDTH - 1 : 0] exptd_data;
	
	function new(string name = "fifo_sb",uvm_component parent = null);
		super.new(name,parent);
		an_w_fifoh = new("an_w_fifoh",this);
		an_r_fifoh = new("an_r_fifoh",this);
	endfunction 
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin 
		//receiving the transactions using get method from analysis fifo 
		an_w_fifoh.get(wtrans_h);
		an_r_fifoh.get(rtrans_h);
		ref_model();
		check_data();
		end
	endtask
	
	task ref_model();
		begin 
		
			if(wtrans_h.wr_en && !wtrans_h.fifo_full)
				fifo_que.push_front(wtrans_h.data_in);
            else if (wtrans_h.wr_en && wtrans_h.fifo_full)
            $display("FIFO GOT FULL");
              
			if(rtrans_h.rd_en && !rtrans_h.fifo_empty && fifo_que.size() !== 0)
				rtrans_h.exptd_data <= fifo_que.pop_back();
          else if (rtrans_h.rd_en && rtrans_h.fifo_empty && fifo_que.size() !== 0)
            $display("FIFO GOT EMPTY");
		end	
		
	endtask 
	
	task check_data();
		if (rtrans_h.data_out !== 0 && rtrans_h.data_out !== 8'dx) begin 
			if (rtrans_h.data_out !== rtrans_h.exptd_data)
              $display("DATA MISMATCHED! : DUT_RD_DATA = %0h :: %0h = REF_EXPTD_DATA 	TIME : @%0t ",rtrans_h.data_out,rtrans_h.exptd_data,$realtime);
			else 
              $display("DATA SUCCESSFULLY MATCHED! : DUT_RD_DATA = %0h :: %0h = REF_EXPTD_DATA 	TIME : @%0t ",rtrans_h.data_out,rtrans_h.exptd_data,$realtime);
        end
	endtask
endclass