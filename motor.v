module motor( clock, speed, lights ); 

input wire clock; 
output reg [8:0] lights; 
input wire [7:0] speed; 

reg [7:0] count; 

always @( posedge clock ) begin
	if ( count < speed ) begin
		count = count + 1; 
		lights = 8'b11111111;
		
	end
	else begin
		lights = 8'b00000000;		
		count = 0; 
	end
end

endmodule