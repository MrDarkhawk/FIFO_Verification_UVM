class fifo_coverage extends uvm_component ;

	`uvm_component_utils(fifo_coverage)
	
	fifo_wtrans wtrans_h;
	fifo_rtrans rtrans_h;
		
	uvm_tlm_analysis_fifo #(fifo_wtrans) an_w_fifoh;
	uvm_tlm_analysis_fifo #(fifo_rtrans) an_r_fifoh;
	
	real fifo_cov;
  
	covergroup fifo_cg; 
		    option.per_instance = 1;
			option.goal = 100;
			option.name = "coverage";
	
			// Coverpoints For Write Transactions 
      wr_en : coverpoint (wtrans_h.wr_en)  {bins wr_en_b1 = (0 => 1);
                                           ignore_bins wr_en_b2 = (1 => 0);
                                           bins wr_en_b3 = {0,1};} //wr_en_b2 transition is not covering due to giving of hard core constraint
						
      fifo_data_in : coverpoint(wtrans_h.data_in)  {bins wr_data_in_b1 = {[0:255]};}
			
      wr_fifo_full : coverpoint(wtrans_h.fifo_full)  {bins wr_fifo_full_b1 = {0,1};}
			
			wr_fifo_empty : coverpoint(wtrans_h.fifo_empty)  {bins wr_fifo_empty_b1 = {0,1};}
			
			wr_fifo_overflow : coverpoint(wtrans_h.fifo_empty)  {bins wr_fifo_overflow_b1 = {0,1};}
			
			wr_fifo_underflow : coverpoint(wtrans_h.fifo_empty)  {bins wr_fifo_underflow_b1 = {0,1};}
	
			wr_fifo_almost_full : coverpoint(wtrans_h.fifo_almost_full)  {bins wr_fifo_almost_full_b1 = {0,1};}
			
			wr_fifo_almost_empty : coverpoint(wtrans_h.fifo_almost_empty)  {bins wr_fifo_almost_empty_b1 = {0,1};}
			
			// Coverpoints For Read Transactions
			rd_en : coverpoint(rtrans_h.rd_en)  {bins rd_en_b1 = {0,1};}
			
      fifo_data_out : coverpoint(rtrans_h.data_out) {bins rd_data_out = {[0:255]};}
			
			// exptd_data :
			
			rd_fifo_full : coverpoint(rtrans_h.fifo_full)  {bins rd_fifo_full_b1 = {0,1};}
			
			rd_fifo_empty : coverpoint(rtrans_h.fifo_empty)  {bins rd_fifo_empty_b1 = {0,1};}
			
			rd_fifo_overflow : coverpoint(rtrans_h.fifo_overflow)  {bins rd_fifo_overflow_b = {0,1};}
			
			rd_fifo_underflow : coverpoint(rtrans_h.fifo_underflow)  {bins rd_fifo_underflow_b = {0,1};}
	
			rd_fifo_almost_full : coverpoint(rtrans_h.fifo_almost_full)  {bins rd_fifo_almost_full_b = {0,1};}
			
			rd_fifo_almost_empty : coverpoint(rtrans_h.fifo_almost_empty)  {bins rd_fifo_almost_empty_b = {0,1};}
			
      data_in_X_data_out : cross fifo_data_in,fifo_data_out;
			
	endgroup 
  
	function new(string name = "fifo_coverage", uvm_component parent = null);
		super.new(name,parent);
      fifo_cg = new();
    endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		wtrans_h = fifo_wtrans::type_id::create("wtrans_h");
		an_w_fifoh = new("an_w_fifoh",this);
		an_r_fifoh = new("an_r_fifoh",this);
	endfunction
			
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("coverage_info","fifo_coverage task run_phase started",UVM_NONE)
		forever 
          begin
		an_w_fifoh.get(wtrans_h);
		an_r_fifoh.get(rtrans_h);
		fifo_cg.sample();
		end
      `uvm_info("coverage_info","fifo_coverage task run_phase ended",UVM_NONE)
	endtask
	
	function void extract_phase(uvm_phase phase);
		super.extract_phase(phase);
      `uvm_info("coverage_info","fifo_coverage extract_phase started",UVM_MEDIUM)
		fifo_cov = fifo_cg.get_coverage();
	endfunction

	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
      `uvm_info("coverage_info","fifo_coverage report_phase started",UVM_MEDIUM)
		`uvm_info(get_type_name(),$sformatf("coverage is : %f",fifo_cov),UVM_MEDIUM)
	endfunction
	
endclass 