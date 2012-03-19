module modify_speed( CLOCK_50, KEY, speed1, speed2, speed3, speed, reset );

input wire CLOCK_50, reset; 
input wire [3:0] KEY; 
output reg [3:0] speed1, speed2, speed3;
output reg [7:0] speed; 

reg old_key2; 
reg old_key3;

always @( posedge CLOCK_50 ) begin
	if( !reset ) begin
		speed = speed; 
		speed3 = speed3; 
		speed2 = speed2; 
		speed1 = speed1; 
	end
	else begin
		if( old_key3 && !KEY[3] ) begin
			if( speed3 < 9 ) begin
				speed3 = speed3 + 1;
				speed = speed + 1; 
			end
			else if( speed2 < 9 ) begin
				speed3 = 0; 
				speed2 = speed2 + 1;
				speed = speed + 1; 
			end
			else begin
				if( speed1 < 1 ) begin
					speed3 = 0; 
					speed2 = 0;
					speed1 = speed1 + 1;
					speed = speed + 1;
				 end
			end
		end
		else if( old_key2 && !KEY[2] ) begin
			if( speed3 > 0 ) begin
				speed3 = speed3 - 1; 
				speed = speed -1; 
			end
			else if( speed2 > 0 ) begin
				 speed3 = 9; 
				 speed2 = speed2 - 1;
				 speed = speed - 1;
			end
			else begin
				 if( speed1 > 0 ) begin
					speed3 = 9;
					speed2 = 9;
					speed1 = speed1 - 1;
					speed = speed - 1;
				 end
			end
		end
		old_key3 = KEY[3];
		old_key2 = KEY[2];
	end
end
endmodule