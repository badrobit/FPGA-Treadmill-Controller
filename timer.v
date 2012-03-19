module timer( slow_clock, minute1, minute2, second1, second2, reset );

input wire slow_clock, reset; 
output reg [3:0] minute1, minute2, second1, second2;

always @( posedge slow_clock ) begin
	if( !reset ) begin
		second2 = 0; 
		second1 = 0; 
		minute2 = 0; 
		minute1 = 0; 
	end
	else begin
		if( second2 < 9) begin
			 second2 <= second2 + 1'b1;
		end
		else if( second1 < 5 ) begin
			 second2 <= 4'b0000;
			 second1 <= second1 + 1'b1;
		end
		else begin
			second1 <= 4'b0000;
			second2 <= 4'b0000;
			if( minute2 < 9 ) begin
				minute2 <= minute2 + 1'b1; 
			end
			else if( minute1 < 5 ) begin
				minute2 <= 4'b0000; 
				minute1 <= minute1 + 1'b1; 
			end
			else begin
			end
		end
	end
end
endmodule