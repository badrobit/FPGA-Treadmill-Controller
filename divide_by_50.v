module divide_by_50(Q,CLK,RST);
input CLK, RST;
output Q;
reg Q;
reg [4:0] count;
always @ (posedge CLK or negedge RST)
	begin
		if (~RST)
			begin
				Q <= 1'b0;
				count <= 5'b00000;
			end
		else if (count < 24)
			begin 
			 	count <= count+1'b1;
			end
		else 
			begin
				count <= 5'b00000;
				Q <= ~Q;
			end
	end
endmodule
