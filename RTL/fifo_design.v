//`define DATA_WIDTH 8 
//`define DEPTH 16  
//`define ASIZE 3
module FIFO #(parameter DATA_WIDTH = 8, DEPTH = 16, ASIZE = 3)(clk,rst,wr_en,rd_en,data_in,data_out,fifo_full,fifo_empty,fifo_overflow,fifo_underflow,fifo_almost_full,fifo_almost_empty);

//parameter declaration

	//port declaration
	input clk;  //clk is apply
	input rst;  //rst is apply
	input wr_en; //input write
	input rd_en;  //input read
	input [(DATA_WIDTH-1):0]data_in; //input data or write data 
	output reg[(DATA_WIDTH-1):0]data_out; //output of data or read data 
	//output reg [3:0]fifo_count; //count the fifo is full or empty
	output fifo_full; //fifo is full
	output fifo_empty; //fifo is empty
	output fifo_overflow;
	output fifo_underflow;
	output fifo_almost_full;
	output fifo_almost_empty;

	//take variable
	
	reg [(DATA_WIDTH-1):0] mem[(DEPTH-1):0];//memory where data is store
	reg [ASIZE:0]w_ptr; //write pointer
	reg [ASIZE:0]r_ptr; //read pointer
	integer i;
	
	//write operation
	always @(posedge clk or posedge rst)
		begin
			if(rst)
			begin
              //wr_en <= 0;
				w_ptr <= 0;
				    for(i=0; i<=15; i= i+1)
				     mem[i] <= 0;
		    end
          else if(wr_en && ! fifo_full)
				begin
					mem[w_ptr] <= data_in;
      					w_ptr <= w_ptr + 1;
				end
			else
				w_ptr <= w_ptr;
		end
	//read operation
	always @(posedge clk or posedge rst)
		begin
			if(rst)
			begin
              	//rd_en <= 0;
				r_ptr <= 0;
				data_out <= 0;
				end
          else if(rd_en && !fifo_empty)
			begin
			    data_out <= mem[r_ptr];
				r_ptr <= r_ptr + 1;
			end
			else
				r_ptr <= r_ptr;
		end
     
	//assign output
	assign fifo_empty = (w_ptr == r_ptr)? 1 : 0;	//fifo is empty
	assign fifo_full = (((w_ptr[3] != r_ptr[3]) && (w_ptr[2:0]==r_ptr[2:0])) ? 1 : 0); //FIFO is full
	assign fifo_overflow = (fifo_full && wr_en) ? 1 : 0;
	assign fifo_underflow = (fifo_empty && rd_en) ? 1 : 0;
  	assign fifo_almost_full = (fifo_full - 1) ? 0 : 1 ;
	assign fifo_almost_empty = (fifo_empty + 1) ? 1 : 0;

// for debug the problem of memory getting full 
/*
	always begin 
	@(posedge clk);
	$display($time,"%p,data_in=%0d ,r_ptr=%0d ,mem[r_ptr]=%0d",mem,data_in,r_ptr,mem[r_ptr]);
	end
*/
endmodule	