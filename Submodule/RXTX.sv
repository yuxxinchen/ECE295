module i2s_tx #(
	parameter DATA_RES = 24
) (
	input logic mclk, sclk, lrclk, a, b, c, d,load,rrready,
	
	input logic [DATA_RES-1:0] i_ldin,i_rdin, 
    output logic o_sdout
);


	//logic load;
	logic [23:0] data = 24'b0;
	
//	logic a,b,c,d;

//clockdiv u2 (mclk,sclk,lrclk,a,b,c,d);

	always@(posedge sclk)
	begin
//		if(!reset)
//		begin
//			data=24'd0;
//			//count=0;
//			//R=0;
//			//L=0;
//			//aaa=0;
//			//rrready = 0;
//		end
		if(load==1)
			begin
				if(lrclk==1&&rrready)
				begin
					data<=i_rdin;
					
				end
				else if(lrclk==0&&rrready)
				begin
					data<=i_ldin;
					
				end
			end
		
		else if(a==1)
		begin
			o_sdout<=data[23];
			data<=(data<<1);
			
		end	
		
	end

endmodule


module enableT (input clk,output logic loadT);
	logic [8:0] counter=9'd0;
	logic valid = 1;
	//logic load = 1;
	logic aaa=1;
	always@(posedge clk)
	begin
		if(counter==0)
		begin
			counter<=9'd255;
			valid<=1;
			//aaa<=0;
		end
		else if(counter==9'd255 || counter==9'd254 || (counter==9'd253))
		begin
			counter<=counter-1;
			valid<=1;
			//aaa<=0;
		end
		
		else
		begin
			counter<=counter-1;
			valid<=0;
			aaa<=0;
		end
			//load<=0;
	end
	
	assign loadT=valid;
	//assign counterT = counter;
endmodule

module clockdiv (
    input MCLK,
	 //output logic [23:0] left,
	 //output logic [23:0] right,
    output SCLK,
    output LRCLK,
	 output high,
    output next_sclk_rise,
    output next_sclk_fall,
    output next_lrclk_rise,
    output next_lrclk_fall
	 
	
	 
	 //input [23:0] i_ldin, i_rdin
 );
	assign high = 1'b1;
	 logic [2:0] s_Counter=3'd3;
	 logic [7:0] lr_Counter=8'd255;
	 logic [23:0] left;
	 logic [23:0] right;
	 logic S=0;
	 logic LR=0;
	 logic sclk_rise;
	 logic sclk_fall;
	 logic lrclk_rise;
	 logic lrclk_fall=1;
	 logic loadT, loadR;
	 logic out=0;
	 logic rrready;
	 enableT u1 (MCLK,loadT);
	 enableR	uu (MCLK,loadR);
	 //assign i_data=i_sdata;
	 //assign mmclk = MCLK;
	 logic [7:0] count;
//	i2s_tx u3(.mclk(MCLK),.sclk(SCLK),.lrclk(LRCLK),
//	 .a(next_sclk_rise),.b(next_sclk_fall),.c(next_lrclk_rise),
//	 .d(next_lrclk_fall)
//	 ,.i_ldin(left),.i_rdin(right),.o_sdout(o_sdout),.load(loadT),.rrready(rrready));
	 
//	 i2s_rx u9(.mclk(MCLK),.sclk(SCLK),.lrclk(LRCLK),.a(next_sclk_rise),.b(next_sclk_fall),
//	 .c(next_lrclk_rise),.d(next_lrclk_fall)
//	 ,.o_left(left),.o_right(right),.i_sdata(i_sdata), .load(loadR),.count(count),.rrready(rrready));
	 
	 always@(posedge MCLK)
	 begin
			
		if(s_Counter==0)
			begin
				s_Counter<=3'd3;
				if(S==0)
				begin	
					S<=1;
					sclk_rise<=1;
				end
				else if(S==1)
				begin
					S<=0;
					sclk_fall<=1;
				end
			end
		
		else
			begin
				s_Counter<=s_Counter-1;
				sclk_rise<=0;
				sclk_fall<=0;	
			end
	
			
		if(lr_Counter==0)
			begin
				lr_Counter<=8'd255;
				if(LR==0)
				begin
					LR<=1;
					lrclk_rise<=1;
				end
				else if(LR==1)
				begin
					LR<=0;
					lrclk_fall<=1;
				end
			end
		else if(lr_Counter==1|lr_Counter==2|lr_Counter==3|lr_Counter==4)
		begin
			if(LR==0)
			lrclk_rise<=1;
			else if(LR==1)
			lrclk_fall<=1;
		lr_Counter<=lr_Counter-1;
		end
		
		else
			begin
				lr_Counter<=lr_Counter-1;
				lrclk_rise<=0;
				lrclk_fall<=0;
			end
	 end
	 
	 assign SCLK=S;
	 assign LRCLK=LR;
	 assign next_sclk_rise=sclk_rise;
	 assign next_sclk_fall=sclk_fall;
	 assign next_lrclk_rise=lrclk_rise;
	 assign next_lrclk_fall=lrclk_fall;
	 

endmodule

module i2s_rx #(
	parameter DATA_RES = 24
) (
	input logic mclk, sclk, lrclk, i_sdata,a,b,c,d, load,AM,

	output logic [DATA_RES-1:0] o_left, o_right,
	output logic rrready,AMready//high when one left and right is finished
);

//logic load ;
	logic [47:0] data;
//	logic a,b,c,d;
	logic [7:0] count;
	logic [23:0] R;
	logic [23:0] L;
	logic aaa;

initial begin
//	load =0;
	data=48'd0;
	count=0;
	R=0;
	L=0;
	aaa=0;
	rrready = 0;
end
//	
//clockdiv u2 (mclk,sclk,lrclk,a,b,c,d);
//enable u1 (mclk,load);

	always@(posedge sclk)
	begin
		
		if(load==1)
			begin
				count<=0;
				aaa=0;
				L[23:0]<=data[47:24];
				R[23:0]<=data[23:0];
			if((c==1|d==1)&&(!AM))
				begin
				rrready <= 1;
				AMready <= 0;
				end
			else if((c==1|d==1)&&(AM))
				begin
				rrready <= 0;
				AMready <= 1;
				end
				
			end
			
		                             
		else
		begin
			if(count<7'd25&&count>7'd0)
			begin
			data<={data[46:0],i_sdata};
			aaa=1;
			rrready<= 0;
			AMready<=0;
			end
			count<=count+1;
		end
	
		if(c==1|d==1)
			begin
				aaa=1;
				count<=0;
			end
//		if((c==1|d==1)&&(!AM))
//		begin
//		rrready <= 1;
//		AMready <= 0;
//		end
//		else if((c==1|d==1)&&(AM))
//		begin
//		rrready <= 0;
//		AMready <= 1;
		//end
	end
	
	assign o_right=R;
	assign o_left=L;

endmodule

module enableR (input clk,output logic load);
	//logic [8:0] 
	logic [8:0] counter=9'd511;
	logic valid = 0;
	//logic load = 1;
	always@(posedge clk)
	begin
		if(counter==0)
		begin
			counter<=9'd511;
			//valid<=1;
		end
		
		else if(counter==9'd4 || counter==9'd2 || counter==9'd3|| counter == 9'd1)
		begin
			counter<=counter-1;
			valid<=1;
		end
		
		else
		begin
			counter<=counter-1;
			valid<=0;
		end
			//load<=0;
	end
	
	assign load=valid;
	//assign Tcounter = counter;
endmodule



module pick(
input [9:0] SW,
input clk,
input reset,
output logic add, sub, am
);
	always @(posedge clk)
	begin
		if(!reset)
		begin
			add <=0;
			sub<=0;
			am<=0;
		end
		else
		begin
		case (SW)
			3'b001: add <= 1;
			3'b010: sub <=1;
			3'b100: am <= 1;
		endcase
		end
	end
endmodule


module selectTop( input [23:0] n,c,t,
						input aespa,//resetn
						input clk,
						input e,x,o,//e-->am, x-->add, o-->sub
						output logic [23:0] bts,
						output txt);
	logic temp;				
	always @ (posedge clk)
	begin
		if(!aespa)
		begin
			temp <= 1'b0;
			bts <= 24'b0;
		end
		
		if(e)
		begin
			bts <= n;
			temp <= 1'b1;
		end
		else if(x)
		begin
			bts <= c;
			temp <= 1'b1;
		end
		else if(o)
		begin
			bts <= t;
			temp <= 1'b1;
		end
		else 
		begin
			temp <= 1'b0;
			bts <= 24'b0;
		end
	end
	assign txt = temp;
endmodule
		
