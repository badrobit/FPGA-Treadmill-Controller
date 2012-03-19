module slow_clock
(
	input fast_clock, 
	output reg slow_clock
);

reg [25:0] R;


always @( posedge fast_clock ) begin
	if( R < 25000000 ) begin
		R <= R + 1;
	end
	else begin
		slow_clock <= ~slow_clock;
		R <= 0;
	end
	
end

endmodule