module hex_display( hex_digit, seg );
input [3:0] hex_digit;
output [6:0] seg;
reg [6:0] seg;

always @ (hex_digit)
case (hex_digit)
		4'h0: seg = ~7'h3F;
		4'h1: seg = ~7'h06; 
		4'h2: seg = ~7'h5B; 
		4'h3: seg = ~7'h4F; 	
		4'h4: seg = ~7'h66; 
		4'h5: seg = ~7'h6D; 
		4'h6: seg = ~7'h7D;
		4'h7: seg = ~7'h07; 	
		4'h8: seg = ~7'h7F; 	
		4'h9: seg = ~7'h67; 	
		4'ha: seg = ~7'b00000000;
		4'hb: seg = ~7'b00000000;
		4'hc: seg = ~7'b00000000;
		4'hd: seg = ~7'b00000000;
		4'he: seg = ~7'b00000000;
		4'hf: seg = ~7'b01011100;
endcase

endmodule
