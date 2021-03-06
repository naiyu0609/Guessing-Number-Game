module gn(clk,rst,start,keyb,max_ten,max_unit,min_ten,min_unit,g_ten,g_unit);
input clk,rst,start;
input [6:0]keyb;
output reg [7:0]max_ten,max_unit,min_ten,min_unit,g_ten,g_unit;
reg [6:0]max_number,min_number,g_number_ten,g_number_unit;
reg [6:0]c_number=7'd43;
reg [3:0]state;
reg [6:0]seed=7'd93;
parameter zero=8'hC0,
		  one=8'hF9,
		  two=8'hA4,
		  three=8'hB0,
		  four=8'h99,
		  five=8'h92,
		  six=8'h82,
		  seven=8'hF8,
		  eight=8'h80,
		  nine=8'h90,
		  blank=8'hFF;

always @(posedge clk or negedge rst)
begin
	if(!rst)
	begin
		max_number=7'd99;
		min_number=7'd0;
		g_number_ten=7'd0;
		g_number_unit=7'd0;
		max_ten=nine;
		max_unit=nine;
		min_ten=zero;
		min_unit=zero;
		g_ten=8'd0;
		g_unit=8'd0;
		state=4'd0;
	end
	else
	begin
		case(state)
			4'd0:
			begin
				seed[0] <= seed[6];
				seed[1] <= (c_number[1])? seed[0]^seed[6]:seed[0];
				seed[2] <= (c_number[2])? seed[1]^seed[6]:seed[1];
				seed[3] <= (c_number[3])? seed[2]^seed[6]:seed[2];
				seed[4] <= (c_number[4])? seed[3]^seed[6]:seed[3];
				seed[5] <= (c_number[5])? seed[4]^seed[6]:seed[4];
				seed[6] <= (c_number[6])? seed[5]^seed[6]:seed[5];
				c_number[0] <= c_number[6];
				c_number[1] <= (seed[1])? c_number[0]^c_number[6]:c_number[0];
				c_number[2] <= (seed[2])? c_number[1]^c_number[6]:c_number[1];
				c_number[3] <= (seed[3])? c_number[2]^c_number[6]:c_number[2];
				c_number[4] <= (seed[4])? c_number[3]^c_number[6]:c_number[3];
				c_number[5] <= (seed[5])? c_number[4]^c_number[6]:c_number[4];
				c_number[6] <= (seed[6])? c_number[5]^c_number[6]:c_number[5];
				state = (start)? 4'd0:4'd1;
			end
			4'd1:
			begin
				c_number[0] <= c_number[6];
				c_number[1] <= (seed[1])? c_number[0]^c_number[6]:c_number[0];
				c_number[2] <= (seed[2])? c_number[1]^c_number[6]:c_number[1];
				c_number[3] <= (seed[3])? c_number[2]^c_number[6]:c_number[2];
				c_number[4] <= (seed[4])? c_number[3]^c_number[6]:c_number[3];
				c_number[5] <= (seed[5])? c_number[4]^c_number[6]:c_number[4];
				c_number[6] <= (seed[6])? c_number[5]^c_number[6]:c_number[5];
				g_ten=blank;
				g_unit=blank;
				state = 4'd2;
			end
			4'd2:
			begin
				c_number <= c_number%100;
				case(keyb)
					7'b0110111:
					begin
						g_number_ten=7'd10;
						g_ten=one;
						state=4'd3;
					end
					7'b1010111:
					begin
						g_number_ten=7'd20;
						g_ten=two;
						state=4'd3;
					end
					7'b1100111:
					begin
						g_number_ten=7'd30;
						g_ten=three;
						state=4'd3;
					end
					7'b0111011:
					begin
						g_number_ten=7'd40;
						g_ten=four;
						state=4'd3;
					end
					7'b1011011:
					begin
						g_number_ten=7'd50;
						g_ten=five;
						state=4'd3;
					end
					7'b1101011:
					begin
						g_number_ten=7'd60;
						g_ten=six;
						state=4'd3;
					end
					7'b0111101:
					begin
						g_number_ten=7'd70;
						g_ten=seven;
						state=4'd3;
					end
					7'b1011101:
					begin
						g_number_ten=7'd80;
						g_ten=eight;
						state=4'd3;
					end
					7'b1101101:
					begin
						g_number_ten=7'd90;
						g_ten=nine;
						state=4'd3;
					end
					7'b1011110:
					begin
						g_number_ten=7'd0;
						g_ten=zero;
						state=4'd3;
					end
					default: state=4'd2;
				endcase
			end
			4'd3:
			begin
				case(keyb)
					7'b0110111:
					begin
						g_number_unit=7'd1;
						g_unit=one;
						state=4'd4;
					end
					7'b1010111:
					begin
						g_number_unit=7'd2;
						g_unit=two;
						state=4'd4;
					end
					7'b1100111:
					begin
						g_number_unit=7'd3;
						g_unit=three;
						state=4'd4;
					end
					7'b0111011:
					begin
						g_number_unit=7'd4;
						g_unit=four;
						state=4'd4;
					end
					7'b1011011:
					begin
						g_number_unit=7'd5;
						g_unit=five;
						state=4'd4;
					end
					7'b1101011:
					begin
						g_number_unit=7'd6;
						g_unit=six;
						state=4'd4;
					end
					7'b0111101:
					begin
						g_number_unit=7'd7;
						g_unit=seven;
						state=4'd4;
					end
					7'b1011101:
					begin
						g_number_unit=7'd8;
						g_unit=eight;
						state=4'd4;
					end
					7'b1101101:
					begin
						g_number_unit=7'd9;
						g_unit=nine;
						state=4'd4;
					end
					7'b1011110:
					begin
						g_number_unit=7'd0;
						g_unit=zero;
						state=4'd4;
					end
					7'b0111110:
					begin
						g_number_ten=7'd0;
						g_ten=blank;
						state=4'd2;
					end
					default: state=4'd3;
				endcase
			end
			4'd4:
			begin
				case(keyb)
					7'b1101110:
					begin
						if((g_number_ten+g_number_unit>max_number)||(g_number_ten+g_number_unit<min_number)) 
						begin
							g_number_ten=7'd0;
							g_ten=blank;
							g_number_unit=7'd0;
							g_unit=blank;
							state=4'd2;
						end
						else if(g_number_ten+g_number_unit>c_number) state=4'd5;
						else if(g_number_ten+g_number_unit<c_number) state=4'd6;
						else state=4'd7;
					end
					7'b0111110:
					begin
					    g_number_ten=7'd0;
						g_ten=blank;
						g_number_unit=7'd0;
						g_unit=blank;
						state=4'd2;
					end
					default: state=4'd4;
				endcase
			end
			4'd5:
			begin
				max_ten=g_ten;
				max_unit=g_unit;
				max_number=g_number_ten+g_number_unit;
				g_ten=blank;
				g_unit=blank;
				state=4'd2;
			end
			4'd6:
			begin
				min_ten=g_ten;
				min_unit=g_unit;
				min_number=g_number_ten+g_number_unit;
				g_ten=blank;
				g_unit=blank;
				state=4'd2;
			end
			4'd7:
			begin
				max_ten=8'd0;
				max_unit=8'd0;
				min_ten=8'd0;
				min_unit=8'd0;
				g_ten=8'd0;
				g_unit=8'd0;
			end
		endcase
	end
	
end
endmodule
