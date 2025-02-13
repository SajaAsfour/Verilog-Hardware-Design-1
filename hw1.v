//saja asfour
//1210737
//sec 2
module Quad_Mux2x1(input[3:0] A,B,input sel,en,output reg[3:0]out);
	always @(*)
		begin
			case(en)
				1'b0: if(sel) out=B; else out=A;
				1'b1: out=0;
			endcase
		end
endmodule

module BCD_7Segment_driver(input [3:0] bcd, output reg [6:0] segment);
    // Drive the segment output with the appropriate code for the input bcd
    always @(*) begin
        case(bcd)
            4'h0: segment = 7'b1111110;
            4'h1: segment = 7'b0110000;
            4'h2: segment = 7'b1101101;
            4'h3: segment = 7'b1111001;
            4'h4: segment = 7'b0110011;
            4'h5: segment = 7'b1011011;
            4'h6: segment = 7'b1011111;
            4'h7: segment = 7'b1110000;
            4'h8: segment = 7'b1111111;
            4'h9: segment = 7'b1111011;
            default: segment = 7'b0000000; // all segments off for invalid input
        endcase
    end
endmodule 

//active low decoder2*4 with enable
module Decoder2x4(input A1,B1,input en, output reg [3:0] out); 
	always @(*)
		begin
			//if enable 0 the decoder work
			if(~en)
				if(A1==0 & B1==0)
					out = 4'b0111;
				else if(A1==0 & B1==1)
					out = 4'b1011;
				else if(A1==1 & B1==0)
					out = 4'b1101;
				else if(A1==1 & B1==1)
					out =  4'b1110;
			//if the enable 1 the decoder does not work
			else
				out = 4'b1111;
		end
endmodule

module circuit(input [3:0]A,B,input sel,output[6:0]seg,output[3:0]Y);
	wire [3:0] w;
	Quad_Mux2x1 mux(A,B,sel,0,w);
	BCD_7Segment_driver bcd(w,seg);
	Decoder2x4 dec(sel,0,0,Y);
endmodule

module circuit_test;
	
	reg [3:0] A,B;
	reg sel;
	wire [6:0] seg;
	wire [3:0] Y;
	
	circuit c1(A,B,sel,seg,Y);
	
	initial
		begin
			A = 4'b0000;
    		B = 4'b0000;
    		sel=0;
			repeat(15)
			begin 
				#10ns sel=1'b1;
    			#10ns A= A+ 4'b0001; B= B+ 4'b0010;
    		    #10ns sel = 1'b0;
			end
		end

endmodule