`timescale 1ns/1ps

module adder #(
    parameter DATA_W = 24
) 
(   
    /*
        This module contains signals used for pipelining (ready/valid),
        the only signal to worry about is o_valid which is set to the logic value
        of delayed_i_valid. delayed_i_valid should be asserted when the output of your 
        module is finished computing and is ready at the output.
    */
	 
    input logic clk,
    input logic reset,
    //input is valid
    input logic i_valid,
    //consumer module (downstream module in which c is the input) is ready for new inputs
    input logic signed [DATA_W-1:0] a,
    input logic signed [DATA_W-1:0] b,
    // signed so output datawidth should be [DATA_WIDTH-1+1:0]
    output logic signed [DATA_W:0] o_c,
    //the output is valid
    output logic o_valid
	 //output logic [64:0][24:0] sum,
    //the module is ready to receive a new input
);

    // This should be asserted when your modules output data is ready.
    // There is only a single delayed valid signal in this case as the computation is expected to
    // take a single cycle, for a multi cycle module which takes X cycles the o_valid needs to be delayed X cycles
    logic delayed_i_valid;
//	 logic signed[23:0] a,b;
//	 assign a = i_a;
//	 assign b = i_b;
    assign o_valid = delayed_i_valid;
//	 assign o_valid=1;
	 logic cin=0;
	 logic cout, s;
	 logic [7:0] i=0, j=0;
	 logic [24:0] sum;
	 logic flow =0;
	 logic [8:0] counter = 9'd64;
	 
	 always@(posedge clk)
	 begin
			if(!reset)
			begin
//				a<=24'b0;
//				b<=24'b0;
				i<=0;
				cin<=0;
				//o_ready<=0;
				s<=0;
				cout<=0;
				delayed_i_valid <=0;
			end


//			if(counter == 9'd0)
//			//if(o_valid)
//				begin
//					//o_c <= a+b;
//					o_c<=sum[j];
//					delayed_i_valid <= 1;
//					//o_ready<=1;
//					
//					counter<=9'd0;
//					j<=j+1;
//				end
			if(i_valid)
				begin
					sum<=a+b;
					//counter<=counter-1;
					delayed_i_valid<=1;
					o_c<=sum;
					//i<=i+1;
					//o_c<=o_c;
				end
			else
				delayed_i_valid<=0;
	 end
	 
	
		
	 
	 
endmodule
//
//module FA(input a, b, c, output s, cout);
//	 assign s=c^a^b;
//	 assign cout=(a&b)|(c&a)|(c&b);
//endmodule

//					for(i=0;i<5'd24;i=i+1)
//						begin
//							
//							if(i<5'd24)
//							begin
//								s<=cin^a[i]^b[i];
//								cout<=(a[i]&b[i])|(cin&a[i])|(cin&b[i]);
//								if(i==5'd22)
//									flow <= cout;
//								if(i==5'd23)
//								begin
//									o_c[i] <= s;
//									o_c[i+1] <= (cout^flow);
//									//o_c<=sum;
//									delayed_i_valid<=1;
//								end
//								else
//								begin
//									o_c[i] <= s;
//				//				sum[i]<=s;
//									cin<=cout;
//								end
//							end
////							if(i==5'd23)
////							begin
////								o_c<=sum;
////								delayed_i_valid<=1;
////							end
//						end

