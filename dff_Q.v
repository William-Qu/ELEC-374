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
// CREATED		"Sun Feb 26 14:59:17 2023"

module dff_Q(
	D,
	clk,
	clr,
	Q
);


input wire	D;
input wire	clk;
input wire	clr;
output wire	Q;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;

assign	Q = SYNTHESIZED_WIRE_2;



assign	SYNTHESIZED_WIRE_1 = ~(clk & D);

assign	SYNTHESIZED_WIRE_2 = ~(SYNTHESIZED_WIRE_0 & SYNTHESIZED_WIRE_1);

assign	SYNTHESIZED_WIRE_4 =  ~D;

assign	SYNTHESIZED_WIRE_0 = ~(SYNTHESIZED_WIRE_2 & SYNTHESIZED_WIRE_3 & clr);

assign	SYNTHESIZED_WIRE_3 = ~(SYNTHESIZED_WIRE_4 & clk);


endmodule
