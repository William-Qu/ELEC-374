// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Full Version"
// CREATED		"Sun Feb 26 14:58:46 2023"

module full_adder(
	xi,
	yi,
	c_in,
	si,
	c_out
);


input wire	xi;
input wire	yi;
input wire	c_in;
output wire	si;
output wire	c_out;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;





half_adder	b2v_inst(
	.x(c_in),
	.y(SYNTHESIZED_WIRE_0),
	.s(si),
	.c(SYNTHESIZED_WIRE_2));


half_adder	b2v_inst1(
	.x(xi),
	.y(yi),
	.s(SYNTHESIZED_WIRE_0),
	.c(SYNTHESIZED_WIRE_1));

assign	c_out = SYNTHESIZED_WIRE_1 | SYNTHESIZED_WIRE_2;


endmodule
