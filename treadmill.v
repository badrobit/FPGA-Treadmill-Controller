module treadmill
(
  input 		CLOCK_50,
  input		CLOCK_27,
  input 		[3:0]  KEY,
  input  	[17:0]  SW,
  output 	[6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7, 
  output  	[8:0]  LEDG, 
  output  	[17:0]  LEDR
);

// SLOW THE CLOCK DOWN TO 1HZ
wire clock_1hz;
wire clock_dist; 
slow_clock s_clock( CLOCK_50, clock_1hz );
dist_clock d_clock( CLOCK_50, clock_dist ); 

// Start (up) & Reset (down)
wire reset; 
assign reset = SW[0]; 

// WIRES COMING FROM THE TIMER MODULE
wire [3:0] minute1; 
wire [3:0] minute2; 
wire [3:0] second1; 
wire [3:0] second2; 

// WIRES COMING FROM THE DISTANCE MODULE
wire [3:0] distance1;
wire [3:0] distance2;
wire [3:0] distance3;

// Wires coming from the speed module
wire [3:0] speed1; 
wire [3:0] speed2; 
wire [3:0] speed3; 
wire [7:0] speed; // output the speed value in binary (stored in 1/10th of a km/h)

// Wires coming from the slope module
wire [3:0] slope1; 
wire [3:0] slope2; 
wire [3:0] slope; // output the value in binary

// 4HEX DISPLAYS 0-3 This will be either time passed or distance ran
reg [3:0] display0; 
reg [3:0] display1;
reg [3:0] display2;
reg [3:0] display3;

// Wires for PMW
wire [8:0] pmw_wire; 

// 2-Hex displays 4/5 wil be used to display the current slope. 
reg [3:0] display4; 
reg [3:0] display5; 

// 2HEX DISPLAYS 7/6 will be used to display the current speed. 
reg [3:0] display6; 
reg [3:0] display7;

// Track the time
timer time1( clock_1hz, minute1, minute2, second1, second2, reset ); 

// Track the distance
distance dist1( clock_dist, speed, distance1, distance2, distance3 ); 

// Modify the current speed of the treadmill using KEY3 & KEY2
modify_speed speed_control( CLOCK_50, KEY, speed1, speed2, speed3, speed, reset ); 

// Modify the current slope of the treadmill using KEY1 & KEY0
modify_slope slope_control( CLOCK_50, KEY, slope1, slope2, slope, reset );

// PWM Stuff
motor pmw( CLOCK_50, speed, pmw_wire ); 

// HEX for speed & distance
hex_display dsp0( display0, HEX3 );
hex_display dsp1( display1, HEX2 );
hex_display dsp2( display2, HEX1 );
hex_display dsp3( display3, HEX0 );

// HEX for slope
hex_display dsp4( display4, HEX4 );
hex_display dsp5( display5, HEX5 );

// Hex for speed
hex_display dsp6( display6, HEX6 );
hex_display dsp7( display7, HEX7 );

assign LEDR[8:0] = speed;  // debugging to make sure that i am actually changing speed
assign LEDG[8:0] = pmw_wire;

always @( posedge CLOCK_50 ) begin
	if( !SW[17] ) begin // show time
		display0 = minute1; 
		display1 = minute2; 
		display2 = second1; 
		display3 = second2;
	end
	else if( SW[17] ) begin // show distance
		display0 = distance1; 
		display1 = distance2;  
		display2 = ~3'b1000; 
		display3 = distance3;
	end
	if( !SW[16] ) begin // show angle
		display6 = slope2; 
		display7 = slope1; 
		display4 = ~3'b0100; 
		display5 = ~3'b0100; 
	end
	else if( SW[16] ) begin // show speed
		display4 = speed3; 
		display5 = ~3'b1000; 
		display6 = speed2; 
		display7 = speed1; 
	end
end 
endmodule