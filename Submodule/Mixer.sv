//Mixer is composed of a multiplier and a low pass filter
module Mixer_L(
	input logic  mclk,
	input a, b, c, d,
   input logic  sclk,
   input logic  reset,
	input logic ready,
	input [23:0] i_data,
	output [23:0] o_data,
	output logic valid
);
	logic [15:0] i_sig_data;
	logic [39:0] tempdata;
//	logic enable; //enable signal for the oscillator
	logic [23:0] newdata;
	logic [9:0] counter=0;
	logic start = 0;
	/* instantiation of the oscillator */
	osc_advanced osc_inst(
		.MCLK(mclk),
		.freq('d10_100),
		.out(i_sig_data),
		.next_sclk_rise(a),
		.next_sclk_fall(b),
		.next_lrclk_rise(c),
		.next_lrclk_fall(d)
	);
	
	always@(posedge mclk)
		begin
			if(!reset)
				begin
					tempdata<=0;
					valid<=1'b0;
					counter<=0;
					start<=0;
				end
			else if (ready&(counter==0))
				begin
					tempdata<=i_sig_data*i_data;
					newdata <= tempdata [38:15];
					valid<=1'b1;
				end
			else
				begin
					valid<=1'b0;
				end
				
			if(start)
			begin
				counter<=counter+1;
				if(counter==10'd1|counter==10'd2|counter==10'd3|counter==10'd4)
					begin
						valid<=1;
					end
				else
					valid<=0;
			end
			if((counter==10'd508)&start)
				begin
					counter<=0;
					start<=0;
				end
		end	
		
	
		
	assign o_data=newdata;
	/* The multiplier multiply the input sample data with the oscillator output */
//	assign tempdata = i_sig_data*i_data;
//	assign newdata = tempdata [38:15];
//	
	
	
	/* The tempdata goes through a low pass filter(FIR filter) */
//	fir fir_inst (
//		.clk(mclk),
//		.reset(reset),
//		.sample(newdata),
//		.ready(ready),
//		.sum(o_data),
//		.valid(valid)
//	);
	
endmodule

/*	osc osc_inst (
		.mclk(mclk),
		.sclk(sclk),
		.reset(reset),
		.en(enable), // enable signal
		.o_sig_data(i_sig_data) // get the cosine siganl from oscillator
	);*/
	
	
//Mixer is composed of a multiplier and a low pass filter
module Mixer_R(
	input logic  mclk,
	input a, b, c, d,
   input logic  sclk,
   input logic  reset,
	input logic ready,
	input [23:0] i_data,
	output [23:0] o_data,
	output logic valid
);
	logic [15:0] i_sig_data;
	logic [39:0] tempdata;
//	logic enable; //enable signal for the oscillator
	logic [23:0] newdata;
	logic [9:0] counter=0;
	logic start = 0;
	/* instantiation of the oscillator */
	osc_advanced osc_inst(
		.MCLK(mclk),
		.freq('d10_100),
		.out(i_sig_data),
		.next_sclk_rise(a),
		.next_sclk_fall(b),
		.next_lrclk_rise(c),
		.next_lrclk_fall(d)
	);
	
	always@(posedge mclk)
		begin
			if(!reset)
				begin
					tempdata<=0;
					valid<=1'b0;
					counter<=0;
					start<=0;
				end
			else if (ready&(counter==0))
				begin
					tempdata<=i_sig_data*i_data;
					newdata <= tempdata [38:15];
					valid<=1'b1;
				end
			else
				begin
					valid<=1'b0;
				end
				
			if(start)
			begin
				counter<=counter+1;
				if(counter==10'd1|counter==10'd2|counter==10'd3|counter==10'd4)
					begin
						valid<=1;
					end
				else
					valid<=0;
			end
			if((counter==10'd508)&start)
				begin
					counter<=0;
					start<=0;
				end
		end	
		
	
		
	assign o_data=newdata;
	
	/* The multiplier multiply the input sample data with the oscillator output */
//	assign tempdata = i_sig_data*i_data;
//	assign newdata = tempdata [38:15];
//	
	
	
	/* The tempdata goes through a low pass filter(FIR filter) */
//	fir fir_inst (
//		.clk(mclk),
//		.reset(reset),
//		.sample(newdata),
//		.ready(ready),
//		.sum(o_data),
//		.valid(valid)
//	);
	
endmodule
/*	osc osc_inst (
		.mclk(mclk),
		.sclk(sclk),
		.reset(reset),
		.en(enable), // enable signal
		.o_sig_data(i_sig_data) // get the cosine siganl from oscillator
	);*/