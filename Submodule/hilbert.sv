module xierbot(
	input clk,
	input reset,
	input signed [23:0] sample,
	input ready,selectA, selectB,
	output signed [23:0] sum,
	output validA, validB
);

logic signed [15:0] tap1,tap2,tap3,tap4,tap5,
tap6,tap7,tap8,tap9,tap10,tap11,tap12,tap13,tap14,tap15,tap16,tap17,tap18,tap19,tap20,tap21,tap22,tap23,tap24;

logic signed [23:0] h1=0, h2=0, h3=0, h4=0, h5=0, h6=0, h7=0,
h8=0, h9=0, h10=0, h11=0, h12=0, h13=0, h14=0, h15=0, h16=0,h17=0,h18=0,h19=0,h20=0,h21=0,h22=0,h23=0,h24=0;

logic signed [39:0] sum2;

// assign tap1 = 16'hFC9C;  // twos(-0.0265 * 32768) = 0xFC9C
// assign tap2 = 16'h0000;  // 0
// assign tap3 = 16'h05A5;  // 0.0441 * 32768 = 1445.0688 = 1445 = 0x05A5
// assign tap4 = 16'h0000;  // 0
// assign tap5 = 16'hF40C;  // twos(-0.0934 * 32768) = 0xF40C
// assign tap6 = 16'h0000;  // 0
// assign tap7 = 16'h282D;  // 0.3139 * 32768 = 10285.8752 = 10285 = 0x282D
// assign tap8 = 16'h4000;  // 0.5000 * 32768 = 16384 = 0x4000
// assign tap9 = 16'h282D;  // 0.3139 * 32768 = 10285.8752 = 10285 = 0x282D
// assign tap10 = 16'h0000;  // 0
// assign tap11 = 16'hF40C; // twos(-0.0934 * 32768) = 0xF40C
// assign tap12 = 16'h0000; // 0
// assign tap13 = 16'h05A5; // 0.0441 * 32768 = 1445.0688 = 1445 = 0x05A5
// assign tap14 = 16'h0000; // 0
// assign tap15 = 16'hFC9C; // twos(-0.0265 * 32768) = 0xFC9C
// assign tap16 = 16'h0000; // 0

 assign tap1 = 16'b1111100100011110;  // twos(-0.0265 * 32768) = 0xFC9C
 assign tap2 = 16'b1111111001011010;  // 0
 assign tap3 = 16'b1111110000101010;  // 0.0441 * 32768 = 1445.0688 = 1445 = 0x05A5
 assign tap4 = 16'b1111110101010110;  // 0
 assign tap5 = 16'b1111101010110110;  // twos(-0.0934 * 32768) = 0xF40C
 assign tap6 = 16'b1111101110110100;  // 0
 assign tap7 = 16'b1111100001100100;  // 0.3139 * 32768 = 10285.8752 = 10285 = 0x282D
 assign tap8 = 16'b1111100010110010;  // 0.5000 * 32768 = 16384 = 0x4000
 assign tap9 = 16'b1111001111010011;  // 0.3139 * 32768 = 10285.8752 = 10285 = 0x282D
 assign tap10 = 16'b1111000100110010;  // 0
 assign tap11 = 16'b1110001111110111; // twos(-0.0934 * 32768) = 0xF40C
 assign tap12 = 16'b1010111110110110; // 0s
 assign tap13 = 16'b0101000001001010; // 0.0441 * 32768 = 1445.0688 = 1445 = 0x05A5
 assign tap14 = 16'b0001110000001001; // 0
 assign tap15 = 16'b0000111011001110; // twos(-0.0265 * 32768) = 0xFC9C
 assign tap16 = 16'b0000001001111111; // 0
assign tap17 = 16'b0000011101001110; //double
assign tap18 = 16'b0000011110011100; //double
 assign tap19 = 16'b0000010001001100; //double
 assign tap20 = 16'b0000010101001010; //double
 assign tap21 = 16'b0000001010101010; //double
 assign tap22 = 16'b0000001111010110; //double
 assign tap23 = 16'b0000000110100110; //double
 assign tap24 = 16'b0000011011100010; //double
 
 logic signed [39:0] m1=0, m2=0, m3=0, m4=0, m5=0, m6=0, m7=0, m8=0,
 m9=0, m10=0, m11=0, m12=0, m13=0, m14=0, m15=0, m16=0, m17=0,m18=0,m19=0,m20=0,m21=0,m22=0,m23=0,m24=0;
 
 logic aaa = 0; 
 logic [9:0] counter = 0;
 logic start = 0;
// mymul	mymul_inst(
//	.dataa ( dataa_sig ),
//	.datab ( datab_sig ),
//	.result ( result_sig )
//	);

 always@(posedge clk)
	begin
		if(!reset)
			begin
				h1<=0;
				h2<=0;
				h3<=0;
				h4<=0;
				h5<=0; 
				h6<=0;
				h7<=0;
				h8<=0;
				h9<=0;
				h10<=0;
				h11<=0;
				h12<=0;
				h13<=0;
				h14<=0;
				h15<=0;
				h16<=0;
				h17<=0;
				h18<=0;
				h19<=0;
				h20<=0;
				h21<=0;
				h22<=0;
				h23<=0;
				h24<=0;
				//validA<=0;
				//validB<=0;
			end
			
		else if(ready&&counter==0)
			begin
				h1 <= sample;
				h2 <= h1;        
				h3 <= h2;         
				h4 <= h3;      
				h5 <= h4;      
				h6 <= h5;       
				h7 <= h6;    
				h8 <= h7;       
			   h9 <= h8;       
				h10 <= h9;       
			   h11 <= h10;        
			   h12 <= h11;       
				h13 <= h12;       
				h14 <= h13;       
				h15 <= h14;
				h16 <= h15;
				h17 <= h16;
				h18<=h17;
				h19<=h18;
				h20<=h19;
				h21<=h20;
				h22<=h21;
				h23<=h22;
				h24<=h23;
		
			end
		else
			begin
				h1 <= h1;
				h2 <= h2;        
				h3 <= h3;         
				h4 <= h4;      
				h5 <= h5;      
				h6 <= h6;       
				h7 <= h7;    
				h8 <= h8;       
			   h9 <= h9;       
				h10 <= h10;       
			   h11 <= h11;        
			   h12 <= h12;       
				h13 <= h13;       
				h14 <= h14;       
				h15 <= h15;
				h16 <= h16;	
				h17<=h17;
				h18<=h18;
				h19<=h19;
				h20<=h20;
				h21<=h21;
				h22<=h22;
				h23<=h23;
				h24<=h24;
				//validA<=0;
				//validB<=0;	
			end
	end
	
always@(posedge clk)
	begin	
		if(ready&&counter==0)
			begin
				m1 <= h1*tap1;
				m2 <= h2*tap2;
				m3 <= h3*tap3;
				m4 <= h4*tap4;
				m5 <= h5*tap5;
				m6 <= h6*tap6;
				m7 <= h7*tap7;
				m8 <= h8*tap8;
				m9 <= h9*tap9;
				m10 <= h10*tap10;
				m11 <= h11*tap11;
				m12 <= h12*tap12;
				m13 <= h13*tap13;
				m14 <= h14*tap14;
				m15 <= h15*tap15;
				m16 <= h16*tap16;
				m17<=h17*tap17;
				m18<=h18*tap18;
				m19<=h19*tap19;
				m20<=h20*tap20;
				m21<=h21*tap21;
				m22<=h22*tap22;
				m23<=h23*tap23;
				m24<=h24*tap24;
				counter<=0;
				start<=0;
				if(selectA)
					validA <=1;
				else if(selectB)
					validB <=1;
			end
		else
		begin
			validA<=0;
			validB<=0;
			end
	
		if(start)
		begin
			counter<=counter+1;
			if(counter==10'd1|counter==10'd2|counter==10'd3|counter==10'd4)
				begin
					if(selectA)
					validA <=1;
					else if(selectB)
					validB <=1;
				end
			else
				validA<=0;
				validB<=0;
		end
		if((counter==10'd508)&start)
			begin
				counter<=0;
				start<=0;
			end
			
			
	end

always@(posedge clk)
begin
 sum2 = m1+m2+m3+m4+m5+m6+m7+m8+m9+m10+m11+m12+m13+m14+m15+m16
+m17+m18+m19+m20+m21+m22+m23+m24;
end
 assign sum = sum2[38:15];
endmodule


module delay(
	input clk,
	input reset,
	input signed [23:0] sample,
	input ready,
	output signed [23:0] sum,
	output logic valid
);

	logic [23:0] tempdata;

	always @(posedge clk)
		begin
		if(!reset)
		begin
			valid<=0;
			tempdata<=0;
		end
		if(ready)
			begin
			tempdata<= sample & {24{1'b1}};
			valid<=1'b1;
			end
		else
			valid<=1'b0;
		end
		
	assign sum = tempdata;
endmodule
