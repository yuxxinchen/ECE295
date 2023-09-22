module fir_L(
	input clk,
	input reset,
	input signed [23:0] sample,
	input ready,
	output signed [23:0] sum,
	output logic valid
);

logic signed [15:0] tap1,tap2,tap3,tap4,tap5,
tap6,tap7,tap8,tap9,tap10,tap11,tap12,tap13,tap14,tap15,tap16,
tap17,tap18,tap19,tap20,tap21,tap22,tap23,tap24,tap25,tap26,tap27,tap28,
tap29,tap30,tap31,tap32,tap33,tap34,tap35,tap36,tap37,tap38,tap39,tap40,
tap41,tap42,tap43,tap44,tap45,tap46,tap47,tap48,tap49,tap50,tap51,tap52,
tap53,tap54,tap55,tap56,tap57,tap58,tap59,tap60,tap61,tap62,tap63,tap64,
tap65,tap66,tap67,tap68;

logic signed [23:0] h1=0, h2=0, h3=0, h4=0, h5=0, h6=0, h7=0,
h8=0, h9=0, h10=0, h11=0, h12=0, h13=0, h14=0, h15=0, h16=0,
h17=0,h18=0,h19=0,h20=0,h21=0,h22=0,h23=0,h24=0,h25=0,h26=0,h27=0,
h28=0,h29=0,h30=0,h31=0,h32=0,h33=0,h34=0,h35=0,h36=0,h37=0,h38=0,h39=0,
h40=0,h41=0,h42=0,h43=0,h44=0,h45=0,h46=0,h47=0,h48=0,h49=0,h50=0,h51=0,
h52=0,h53=0,h54=0,h55=0,h56=0,h57=0,h58=0,h59=0,h60=0,h61=0,h62=0,h63=0,
h64=0,h65=0,h66=0,h67=0,h68=0;

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

// assign tap1 = {16'b0000000011000111};  // B0000000011000111
// assign tap2 = {16'b1111110101000101};  // C
// assign tap3 = {16'b1111110110000011};  // D
// assign tap4 = {16'b1111110101010010};  // E
// assign tap5 = {16'b1111110101111010};  // F
// assign tap6 = {16'b1111111000110001};  // G
// assign tap7 = {16'b1111111101100101};  // H
// assign tap8 = {16'b0000000011010010};  // I
// assign tap9 = {16'b0000001000010010};  // J
// assign tap10 = {16'b0000001010111001};  // k
// assign tap11 = {16'b0000001001111100}; // L
// assign tap12 = {16'b0000000101000111}; // M
// assign tap13 = {16'b1111111101010111}; // N
// assign tap14 = {16'b1111110100110000}; // O
// assign tap15 = {16'b1111101110001001}; // P
// assign tap16 = {16'b1111101100011001}; // Q
// assign tap17 = {16'b1111110001101001};//R
// assign tap18 = {16'b1111111110100110};//S
// assign tap19 = {16'b0000010010001000};//T
// assign tap20 = {16'b0000101001011010};//u
// assign tap21 = {16'b0001000000011101};//v
// assign tap22 = {16'b0001010010111010};//w
// assign tap23 = {16'b0001011101001011};//x
// assign tap24 = {16'b0001011101001011};//y
// assign tap25 = {16'b0001010010111010};//z
// assign tap26 = {16'b0001000000011101};//aa
// assign tap27 = {16'b0000101001011010};//ab
// assign tap28 = {16'b0000010010001000};//ac
// assign tap29 = {16'b1111111110100110};//ad
// assign tap30 = {16'b1111110001101001};//ae
// assign tap31 = {16'b1111101100011001};//af
// assign tap32 = {16'b1111101110001001};//ag
// assign tap33 = {16'b1111110100110000};//ah
// assign tap34 = {16'b1111111101010111};//ai
// assign tap35 = {16'b0000000101000111};//aj
// assign tap36 = {16'b0000001001111100};//ak
// assign tap37 = {16'b0000001010111001};//al
// assign tap38 = {16'b0000001000010010}; //am
// assign tap39 = {16'b0000000011010010};//an
// assign tap40 = {16'b1111111101100101};//ao
// assign tap41 = {16'b1111111000110001};//ap
// assign tap42 = {16'b1111110101111010};//aq
// assign tap43 = {16'b1111110101010010};//ar
// assign tap44 = {16'b1111110110000011};//as
// assign tap45 = {16'b1111110101000101};//at
// assign tap46 = {16'b0000000011000111}; //au

assign tap1 =16'b1111111111111101;  
assign tap2 = 16'b0000000000000001;  
assign tap3 =16'b0000000000000110;  
assign tap4 = 16'b0000000000010000;  
assign tap5 = 16'b0000000000100000;  
assign tap6 = 16'b0000000000110111;  
assign tap7 = 16'b0000000001010100;  
assign tap8 = 16'b0000000001110111;  
assign tap9 = 16'b0000000010011101;  
assign tap10 = 16'b0000000011000001;  
assign tap11 = 16'b0000000011011100;  
assign tap12 = 16'b0000000011101001;  
assign tap13 = 16'b0000000011100000;  
assign tap14 = 16'b0000000010111100;  
assign tap15 = 16'b0000000001111000;  
assign tap16 = 16'b0000000000010110;  
assign tap17 = 16'b1111111110011010;  
assign tap18 = 16'b1111111100001110;  
assign tap19 = 16'b1111111010000001;  
assign tap20 = 16'b1111111000000111;  
assign tap21 = 16'b1111110110110100;  
assign tap22 = 16'b1111110110011110;  
assign tap23 = 16'b1111110111011001;
assign tap24 = 16'b1111111001110100;
assign tap25 = 16'b1111111101110101;
assign tap26 = 16'b0000000011011010;
assign tap27 = 16'b0000001010010110;
assign tap28 = 16'b0000010010010010; 
assign tap29 = 16'b0000011010110000;
assign tap30 = 16'b0000100011001010; 
assign tap31 = 16'b0000101010110111; 
assign tap32 = 16'b0000110001010001;
assign tap33 = 16'b0000110101110111; 
assign tap34 = 16'b0000111000010001;
assign tap35 = 16'b0000111000010001;
assign tap36 = 16'b0000110101110111;
assign tap37 = 16'b0000110001010001;
assign tap38 = 16'b0000101010110111; 
assign tap39 = 16'b0000100011001010; 
assign tap40 = 16'b0000011010110000;
assign tap41 = 16'b0000010010010010;
assign tap42 = 16'b0000001010010110;
assign tap43 = 16'b0000000011011010;
assign tap44 = 16'b1111111101110101; 
assign tap45 = 16'b1111111001110100;
assign tap46 = 16'b1111110111011001;
assign tap47 = 16'b1111110110011110;
assign tap48 = 16'b1111110110110100;
assign tap49 = 16'b1111111000000111;  
assign tap50 = 16'b1111111010000001;  
assign tap51 = 16'b1111111100001110;  
assign tap52 = 16'b1111111110011010;  
assign tap53 = 16'b0000000000010110;  
assign tap54 = 16'b0000000001111000;  
assign tap55 = 16'b0000000010111100;  
assign tap56 = 16'b0000000011100000;  
assign tap57 = 16'b0000000011101001;
assign tap58 = 16'b0000000011011100;
assign tap59 = 16'b0000000011000001;  
assign tap60 = 16'b0000000010011101;  
assign tap61 = 16'b0000000001110111;
assign tap62 = 16'b0000000001010100;
assign tap63 = 16'b0000000000110111;
assign tap64 = 16'b0000000000100000;
assign tap65 = 16'b0000000000010000;
assign tap66 = 16'b0000000000000110;  
assign tap67 = 16'b0000000000000001;   
assign tap68 = 16'b1111111111111101;  


logic start = 0;
 
 logic signed [39:0] m1=0, m2=0, m3=0, m4=0, m5=0, m6=0, m7=0, m8=0,
 m9=0, m10=0, m11=0, m12=0, m13=0, m14=0, m15=0, m16=0,m17=0,m18=0,
 m19=0,m20=0,m21=0,m22=0,m23=0,m24=0,m25=0,m26=0,m27=0,m28=0,m29=0,
 m30=0,m31=0,m32=0,m33=0,m34=0,m35=0,m36=0,m37=0,m38=0,m39=0,m40=0,
 m41=0,m42=0,m43=0,m44=0,m45=0,m46=0,m47=0,m48=0,m49=0,m50=0,m51=0,
 m52=0,m53=0,m54=0,m55=0,m56=0,m57=0,m58=0,m59=0,m60=0,m61=0,m62=0,
 m63=0,m64=0,m65=0,m66=0,m67=0,m68=0;
 
 logic aaa = 0; 
 logic [9:0] counter = 0;
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
				h25<=0;
				h26<=0;
				h27<=0;
				h28<=0;
				h29<=0;
				h30<=0;
				h31<=0;
				h32<=0;
				h33<=0;
				h34<=0;
				h35<=0;
				h36<=0;
				h37<=0; 
				h38<=0;
				h39<=0;
				h40<=0;
				h41<=0;
				h42<=0;
				h43<=0;
				h44<=0;
				h45<=0;
				h46<=0;
				h47<=0;
				h48<=0;
				h49<=0;
				h50<=0;
				h51<=0;
				h52<=0;
				h53<=0;
				h54<=0;
				h55<=0;
				h56<=0;
				h57<=0;
				h58<=0;
				h59<=0;
				h60<=0;
				h61<=0;
				h62<=0;
				h63<=0;
				h64<=0;
				h65<=0;
				h66<=0;
				h67<=0;
				h68<=0;
				//valid<=0;
			end
			
		else if(ready&(counter==0))
			begin
				h1 <= sample;
//				aaa<=~aaa;
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
				h18 <= h17;        
				h19 <= h18;         
				h20 <= h19;      
				h21 <= h20;      
				h22 <= h21;       
				h23 <= h22;    
				h24 <= h23;       
			   	h25 <= h24;       
				h26 <= h25;       
			   	h27 <= h26;        
			    h28 <= h27;       
				h29 <= h28;       
				h30 <= h29;       
				h31 <= h30;
				h32 <= h31;
				h33 <= h32;
				h34 <= h33;        
				h35 <= h34;         
				h36 <= h35;      
				h37 <= h36;      
				h38 <= h37;       
				h39 <= h38;    
				h40 <= h39;       
			   	h41 <= h40;       
				h42 <= h41;       
			   	h43 <= h42;        
			    h44 <= h43;       
				h45 <= h44;       
				h46 <= h45;
				h47 <= h46;
				h48 <= h47;
				h49 <= h48;
				h50 <= h49;
				h51 <= h50;
				h52 <= h51;
				h53 <= h52;
				h54 <= h53;
				h55 <= h54;
				h56 <= h55;
				h57 <= h56;
				h58 <= h57;
				h59 <= h58;
				h60 <= h59;
				h61 <= h60;
				h62 <= h61;
				h63 <= h62;
				h64 <= h63;
				h65 <= h64;
				h66 <= h65;
				h67 <= h66;
				h68 <= h67; 
				//valid<=1;
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
				h17 <= h17;
				h18 <= h18;        
				h19 <= h19;         
				h20 <= h20;      
				h21 <= h21;      
				h22 <= h22;       
				h23 <= h23;    
				h24 <= h24;       
			   	h25 <= h25;       
				h26 <= h26;       
			   	h27 <= h27;        
			    h28 <= h28;       
				h29 <= h29;       
				h30 <= h30;       
				h31 <= h31;
				h32 <= h32;
				h33 <= h33;
				h34 <= h34;        
				h35 <= h35;         
				h36 <= h36;      
				h37 <= h37;      
				h38 <= h38;       
				h39 <= h39;    
				h40 <= h40;       
			   	h41 <= h41;       
				h42 <= h42;       
			   	h43 <= h43;        
			    h44 <= h44;       
				h45 <= h45;       
				h46 <= h46;
				h47 <= h47;
				h48 <= h48;
				h49 <= h49;
				h50 <= h50;
				h51 <= h51;
				h52 <= h52;
				h53 <= h53;
				h54 <= h54;
				h55 <= h55;
				h56 <= h56;
				h57 <= h57;
				h58 <= h58;
				h59 <= h59;
				h60 <= h60;
				h61 <= h61;
				h62 <= h62;
				h63 <= h63;
				h64 <= h64;
				h65 <= h65;
				h66 <= h66;
				h67 <= h67;
				h68 <= h68;
				//valid<=0;
			end
		
	end
	
always@(posedge clk)
	begin
		if(!reset)
		begin
		valid<=0;
		counter<=0;
		start <=0;
		end
	
		if(ready&(counter==0))
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
				m17 <= h17*tap17;
				m18 <= h18*tap18;
				m19 <= h19*tap19;
				m20 <= h20*tap20;
				m21 <= h21*tap21;
				m22 <= h22*tap22;
				m23 <= h23*tap23;
				m24 <= h24*tap24;
				m25 <= h25*tap25;
				m26 <= h26*tap26;
				m27 <= h27*tap27;
				m28 <= h28*tap28;
				m29 <= h29*tap29;
				m30 <= h30*tap30;
				m31 <= h31*tap31;
				m32 <= h32*tap32;
				m33 <= h33*tap33;
				m34 <= h34*tap34;
				m35 <= h35*tap35;
				m36 <= h36*tap36;
				m37 <= h37*tap37;
				m38 <= h38*tap38;
				m39 <= h39*tap39;
				m40 <= h40*tap40;
				m41 <= h41*tap41;
				m42 <= h42*tap42;
				m43 <= h43*tap43;
				m44 <= h44*tap44;
				m45 <= h45*tap45;
				m46 <= h46*tap46;
				m47 <= h47*tap47;
				m48 <= h48*tap48;
				m49 <= h49*tap49;
				m50 <= h50*tap50;
				m51 <= h51*tap51;
				m52 <= h52*tap52;
				m53 <= h53*tap53;
				m54 <= h54*tap54;
				m55 <= h55*tap55;
				m56 <= h56*tap56;
				m57 <= h57*tap57;
				m58 <= h58*tap58;
				m59 <= h59*tap59;
				m60 <= h60*tap60;
				m61 <= h61*tap61;
				m62 <= h62*tap62;
				m63 <= h63*tap63;
				m64 <= h64*tap64;
				m65 <= h65*tap65;
				m66 <= h66*tap66;
				m67 <= h67*tap67;
				m68 <= h68*tap68;
				valid<=1;
				start<=1;
			end	
		else
			begin
			valid<=0;
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

always@(posedge clk)
begin
 sum2 = m1+m2+m3+m4+m5+m6+m7+m8+m9+m10+m11+m12+m13+m14+m15+m16
+m17+m18+m19+m20+m21+m22+m23+m24+m25+m26+m27+m28+m29+m30+m31+m32+m33
+m34+m35+m36+m37+m38+m39+m40+m41+m42+m43+m44+m45+m46+m47+m48+m49+m50
+m51+m52+m53+m54+m55+m56+m57+m58+m59+m60+m61+m62+m63+m64+m65+m66+m67
+m68;
end
 assign sum = sum2[38:15];
endmodule



module fir_R(
	input clk,
	input reset,
	input signed [23:0] sample,
	input ready,
	output signed [23:0] sum,
	output logic valid
);

logic signed [15:0] tap1,tap2,tap3,tap4,tap5,
tap6,tap7,tap8,tap9,tap10,tap11,tap12,tap13,tap14,tap15,tap16,
tap17,tap18,tap19,tap20,tap21,tap22,tap23,tap24,tap25,tap26,tap27,tap28,
tap29,tap30,tap31,tap32,tap33,tap34,tap35,tap36,tap37,tap38,tap39,tap40,
tap41,tap42,tap43,tap44,tap45,tap46,tap47,tap48,tap49,tap50,tap51,tap52,
tap53,tap54,tap55,tap56,tap57,tap58,tap59,tap60,tap61,tap62,tap63,tap64,
tap65,tap66,tap67,tap68;

logic signed [23:0] h1=0, h2=0, h3=0, h4=0, h5=0, h6=0, h7=0,
h8=0, h9=0, h10=0, h11=0, h12=0, h13=0, h14=0, h15=0, h16=0,
h17=0,h18=0,h19=0,h20=0,h21=0,h22=0,h23=0,h24=0,h25=0,h26=0,h27=0,
h28=0,h29=0,h30=0,h31=0,h32=0,h33=0,h34=0,h35=0,h36=0,h37=0,h38=0,h39=0,
h40=0,h41=0,h42=0,h43=0,h44=0,h45=0,h46=0,h47=0,h48=0,h49=0,h50=0,h51=0,
h52=0,h53=0,h54=0,h55=0,h56=0,h57=0,h58=0,h59=0,h60=0,h61=0,h62=0,h63=0,
h64=0,h65=0,h66=0,h67=0,h68=0;

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

// assign tap1 = {16'b0000000011000111};  // B0000000011000111
// assign tap2 = {16'b1111110101000101};  // C
// assign tap3 = {16'b1111110110000011};  // D
// assign tap4 = {16'b1111110101010010};  // E
// assign tap5 = {16'b1111110101111010};  // F
// assign tap6 = {16'b1111111000110001};  // G
// assign tap7 = {16'b1111111101100101};  // H
// assign tap8 = {16'b0000000011010010};  // I
// assign tap9 = {16'b0000001000010010};  // J
// assign tap10 = {16'b0000001010111001};  // k
// assign tap11 = {16'b0000001001111100}; // L
// assign tap12 = {16'b0000000101000111}; // M
// assign tap13 = {16'b1111111101010111}; // N
// assign tap14 = {16'b1111110100110000}; // O
// assign tap15 = {16'b1111101110001001}; // P
// assign tap16 = {16'b1111101100011001}; // Q
// assign tap17 = {16'b1111110001101001};//R
// assign tap18 = {16'b1111111110100110};//S
// assign tap19 = {16'b0000010010001000};//T
// assign tap20 = {16'b0000101001011010};//u
// assign tap21 = {16'b0001000000011101};//v
// assign tap22 = {16'b0001010010111010};//w
// assign tap23 = {16'b0001011101001011};//x
// assign tap24 = {16'b0001011101001011};//y
// assign tap25 = {16'b0001010010111010};//z
// assign tap26 = {16'b0001000000011101};//aa
// assign tap27 = {16'b0000101001011010};//ab
// assign tap28 = {16'b0000010010001000};//ac
// assign tap29 = {16'b1111111110100110};//ad
// assign tap30 = {16'b1111110001101001};//ae
// assign tap31 = {16'b1111101100011001};//af
// assign tap32 = {16'b1111101110001001};//ag
// assign tap33 = {16'b1111110100110000};//ah
// assign tap34 = {16'b1111111101010111};//ai
// assign tap35 = {16'b0000000101000111};//aj
// assign tap36 = {16'b0000001001111100};//ak
// assign tap37 = {16'b0000001010111001};//al
// assign tap38 = {16'b0000001000010010}; //am
// assign tap39 = {16'b0000000011010010};//an
// assign tap40 = {16'b1111111101100101};//ao
// assign tap41 = {16'b1111111000110001};//ap
// assign tap42 = {16'b1111110101111010};//aq
// assign tap43 = {16'b1111110101010010};//ar
// assign tap44 = {16'b1111110110000011};//as
// assign tap45 = {16'b1111110101000101};//at
// assign tap46 = {16'b0000000011000111}; //au

assign tap1 =16'b1111111111111101;  
assign tap2 = 16'b0000000000000001;  
assign tap3 =16'b0000000000000110;  
assign tap4 = 16'b0000000000010000;  
assign tap5 = 16'b0000000000100000;  
assign tap6 = 16'b0000000000110111;  
assign tap7 = 16'b0000000001010100;  
assign tap8 = 16'b0000000001110111;  
assign tap9 = 16'b0000000010011101;  
assign tap10 = 16'b0000000011000001;  
assign tap11 = 16'b0000000011011100;  
assign tap12 = 16'b0000000011101001;  
assign tap13 = 16'b0000000011100000;  
assign tap14 = 16'b0000000010111100;  
assign tap15 = 16'b0000000001111000;  
assign tap16 = 16'b0000000000010110;  
assign tap17 = 16'b1111111110011010;  
assign tap18 = 16'b1111111100001110;  
assign tap19 = 16'b1111111010000001;  
assign tap20 = 16'b1111111000000111;  
assign tap21 = 16'b1111110110110100;  
assign tap22 = 16'b1111110110011110;  
assign tap23 = 16'b1111110111011001;
assign tap24 = 16'b1111111001110100;
assign tap25 = 16'b1111111101110101;
assign tap26 = 16'b0000000011011010;
assign tap27 = 16'b0000001010010110;
assign tap28 = 16'b0000010010010010; 
assign tap29 = 16'b0000011010110000;
assign tap30 = 16'b0000100011001010; 
assign tap31 = 16'b0000101010110111; 
assign tap32 = 16'b0000110001010001;
assign tap33 = 16'b0000110101110111; 
assign tap34 = 16'b0000111000010001;
assign tap35 = 16'b0000111000010001;
assign tap36 = 16'b0000110101110111;
assign tap37 = 16'b0000110001010001;
assign tap38 = 16'b0000101010110111; 
assign tap39 = 16'b0000100011001010; 
assign tap40 = 16'b0000011010110000;
assign tap41 = 16'b0000010010010010;
assign tap42 = 16'b0000001010010110;
assign tap43 = 16'b0000000011011010;
assign tap44 = 16'b1111111101110101; 
assign tap45 = 16'b1111111001110100;
assign tap46 = 16'b1111110111011001;
assign tap47 = 16'b1111110110011110;
assign tap48 = 16'b1111110110110100;
assign tap49 = 16'b1111111000000111;  
assign tap50 = 16'b1111111010000001;  
assign tap51 = 16'b1111111100001110;  
assign tap52 = 16'b1111111110011010;  
assign tap53 = 16'b0000000000010110;  
assign tap54 = 16'b0000000001111000;  
assign tap55 = 16'b0000000010111100;  
assign tap56 = 16'b0000000011100000;  
assign tap57 = 16'b0000000011101001;
assign tap58 = 16'b0000000011011100;
assign tap59 = 16'b0000000011000001;  
assign tap60 = 16'b0000000010011101;  
assign tap61 = 16'b0000000001110111;
assign tap62 = 16'b0000000001010100;
assign tap63 = 16'b0000000000110111;
assign tap64 = 16'b0000000000100000;
assign tap65 = 16'b0000000000010000;
assign tap66 = 16'b0000000000000110;  
assign tap67 = 16'b0000000000000001;   
assign tap68 = 16'b1111111111111101;  


logic start = 0;
 
 logic signed [39:0] m1=0, m2=0, m3=0, m4=0, m5=0, m6=0, m7=0, m8=0,
 m9=0, m10=0, m11=0, m12=0, m13=0, m14=0, m15=0, m16=0,m17=0,m18=0,
 m19=0,m20=0,m21=0,m22=0,m23=0,m24=0,m25=0,m26=0,m27=0,m28=0,m29=0,
 m30=0,m31=0,m32=0,m33=0,m34=0,m35=0,m36=0,m37=0,m38=0,m39=0,m40=0,
 m41=0,m42=0,m43=0,m44=0,m45=0,m46=0,m47=0,m48=0,m49=0,m50=0,m51=0,
 m52=0,m53=0,m54=0,m55=0,m56=0,m57=0,m58=0,m59=0,m60=0,m61=0,m62=0,
 m63=0,m64=0,m65=0,m66=0,m67=0,m68=0;
 
 logic aaa = 0; 
 logic [9:0] counter = 0;
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
				h25<=0;
				h26<=0;
				h27<=0;
				h28<=0;
				h29<=0;
				h30<=0;
				h31<=0;
				h32<=0;
				h33<=0;
				h34<=0;
				h35<=0;
				h36<=0;
				h37<=0; 
				h38<=0;
				h39<=0;
				h40<=0;
				h41<=0;
				h42<=0;
				h43<=0;
				h44<=0;
				h45<=0;
				h46<=0;
				h47<=0;
				h48<=0;
				h49<=0;
				h50<=0;
				h51<=0;
				h52<=0;
				h53<=0;
				h54<=0;
				h55<=0;
				h56<=0;
				h57<=0;
				h58<=0;
				h59<=0;
				h60<=0;
				h61<=0;
				h62<=0;
				h63<=0;
				h64<=0;
				h65<=0;
				h66<=0;
				h67<=0;
				h68<=0;
				//valid<=0;
			end
			
		else if(ready&(counter==0))
			begin
				h1 <= sample;
//				aaa<=~aaa;
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
				h18 <= h17;        
				h19 <= h18;         
				h20 <= h19;      
				h21 <= h20;      
				h22 <= h21;       
				h23 <= h22;    
				h24 <= h23;       
			   	h25 <= h24;       
				h26 <= h25;       
			   	h27 <= h26;        
			    h28 <= h27;       
				h29 <= h28;       
				h30 <= h29;       
				h31 <= h30;
				h32 <= h31;
				h33 <= h32;
				h34 <= h33;        
				h35 <= h34;         
				h36 <= h35;      
				h37 <= h36;      
				h38 <= h37;       
				h39 <= h38;    
				h40 <= h39;       
			   	h41 <= h40;       
				h42 <= h41;       
			   	h43 <= h42;        
			    h44 <= h43;       
				h45 <= h44;       
				h46 <= h45;
				h47 <= h46;
				h48 <= h47;
				h49 <= h48;
				h50 <= h49;
				h51 <= h50;
				h52 <= h51;
				h53 <= h52;
				h54 <= h53;
				h55 <= h54;
				h56 <= h55;
				h57 <= h56;
				h58 <= h57;
				h59 <= h58;
				h60 <= h59;
				h61 <= h60;
				h62 <= h61;
				h63 <= h62;
				h64 <= h63;
				h65 <= h64;
				h66 <= h65;
				h67 <= h66;
				h68 <= h67; 
				//valid<=1;
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
				h17 <= h17;
				h18 <= h18;        
				h19 <= h19;         
				h20 <= h20;      
				h21 <= h21;      
				h22 <= h22;       
				h23 <= h23;    
				h24 <= h24;       
			   	h25 <= h25;       
				h26 <= h26;       
			   	h27 <= h27;        
			    h28 <= h28;       
				h29 <= h29;       
				h30 <= h30;       
				h31 <= h31;
				h32 <= h32;
				h33 <= h33;
				h34 <= h34;        
				h35 <= h35;         
				h36 <= h36;      
				h37 <= h37;      
				h38 <= h38;       
				h39 <= h39;    
				h40 <= h40;       
			   	h41 <= h41;       
				h42 <= h42;       
			   	h43 <= h43;        
			    h44 <= h44;       
				h45 <= h45;       
				h46 <= h46;
				h47 <= h47;
				h48 <= h48;
				h49 <= h49;
				h50 <= h50;
				h51 <= h51;
				h52 <= h52;
				h53 <= h53;
				h54 <= h54;
				h55 <= h55;
				h56 <= h56;
				h57 <= h57;
				h58 <= h58;
				h59 <= h59;
				h60 <= h60;
				h61 <= h61;
				h62 <= h62;
				h63 <= h63;
				h64 <= h64;
				h65 <= h65;
				h66 <= h66;
				h67 <= h67;
				h68 <= h68;
				//valid<=0;
			end
		
	end
	
always@(posedge clk)
	begin
		if(!reset)
		begin
		valid<=0;
		counter<=0;
		start <=0;
		end
	
		if(ready&(counter==0))
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
				m17 <= h17*tap17;
				m18 <= h18*tap18;
				m19 <= h19*tap19;
				m20 <= h20*tap20;
				m21 <= h21*tap21;
				m22 <= h22*tap22;
				m23 <= h23*tap23;
				m24 <= h24*tap24;
				m25 <= h25*tap25;
				m26 <= h26*tap26;
				m27 <= h27*tap27;
				m28 <= h28*tap28;
				m29 <= h29*tap29;
				m30 <= h30*tap30;
				m31 <= h31*tap31;
				m32 <= h32*tap32;
				m33 <= h33*tap33;
				m34 <= h34*tap34;
				m35 <= h35*tap35;
				m36 <= h36*tap36;
				m37 <= h37*tap37;
				m38 <= h38*tap38;
				m39 <= h39*tap39;
				m40 <= h40*tap40;
				m41 <= h41*tap41;
				m42 <= h42*tap42;
				m43 <= h43*tap43;
				m44 <= h44*tap44;
				m45 <= h45*tap45;
				m46 <= h46*tap46;
				m47 <= h47*tap47;
				m48 <= h48*tap48;
				m49 <= h49*tap49;
				m50 <= h50*tap50;
				m51 <= h51*tap51;
				m52 <= h52*tap52;
				m53 <= h53*tap53;
				m54 <= h54*tap54;
				m55 <= h55*tap55;
				m56 <= h56*tap56;
				m57 <= h57*tap57;
				m58 <= h58*tap58;
				m59 <= h59*tap59;
				m60 <= h60*tap60;
				m61 <= h61*tap61;
				m62 <= h62*tap62;
				m63 <= h63*tap63;
				m64 <= h64*tap64;
				m65 <= h65*tap65;
				m66 <= h66*tap66;
				m67 <= h67*tap67;
				m68 <= h68*tap68;
				valid<=1;
				start<=1;
			end	
		else
			begin
			valid<=0;
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

always@(posedge clk)
begin
 sum2 = m1+m2+m3+m4+m5+m6+m7+m8+m9+m10+m11+m12+m13+m14+m15+m16
+m17+m18+m19+m20+m21+m22+m23+m24+m25+m26+m27+m28+m29+m30+m31+m32+m33
+m34+m35+m36+m37+m38+m39+m40+m41+m42+m43+m44+m45+m46+m47+m48+m49+m50
+m51+m52+m53+m54+m55+m56+m57+m58+m59+m60+m61+m62+m63+m64+m65+m66+m67
+m68;
end
 assign sum = sum2[38:15];
endmodule