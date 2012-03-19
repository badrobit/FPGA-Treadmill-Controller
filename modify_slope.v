module modify_slope( CLOCK_50, KEY, slope1, slope2, slope, reset );

input wire CLOCK_50, reset; 
input wire [3:0] KEY; 
output reg [3:0] slope1, slope2, slope;

reg old_key1; 
reg old_key0;

always @( posedge CLOCK_50 ) begin
	if( !reset ) begin
		slope = 0; 
		slope2 = 0; 
		slope1 = 0; 
	end
	else begin
		if( old_key1 && !KEY[1] ) begin
			if( slope2 < 9 ) begin
				 slope2 = slope2 + 1;
				 slope = slope + 1; 
			end
			else begin
				if( slope1 < 1 ) begin
					 slope2 = 0;
					 slope1 = slope1 + 1;
					 slope = slope + 1; 
				end
			end
		end
		else if( old_key0 && !KEY[0] ) begin
			if( slope2 > 0 ) begin
				 slope2 = slope2 - 1;
				 slope = slope - 1; 
			end
			else begin
				if( slope1 > 0 ) begin
					slope2 = 9;
					slope1 = slope1 - 1;
					slope = slope - 1; 
				 end
			end
		end
		old_key1 = KEY[1];
		old_key0 = KEY[0];
	end
end
endmodule