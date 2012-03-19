module dist_clock
(
	input fast_clock, 
	output reg dist_clock
);

reg [30:0] S; 

always @( posedge fast_clock ) begin
	if( S < 45000000 ) begin
		S <= S + 1; 
	end
	else begin
		dist_clock <= ~dist_clock; 
		S <= 0; 
	end
	
end

endmodule