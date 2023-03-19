module CON_FF (input [31:0] IR,
					input [31:0] bus,
					input CONin,
					output CONout);
					
		wire [3:0] decoder_output;
		wire [1:0] decoder_input;
		
		wire equal, notequal, equalorless, greater, d; 
		
		assign equal = (bus == 32'b0) ? 1'b1 : 1'b0;
		assign notequal = (bus != 32'b0) ? 1'b1 : 1'b0;
		assign equalorless = (bus[31] == 1'b0) ? 1'b1 : 1'b0;
		assign greater = (bus[31] == 1'b1) ? 1'b1 : 1'b0;
		
		assign decoder_input = IR[20:19];
		
		two_four_decoder decode (decoder_output, decoder_input);
		
		assign d = ((decoder_output[0] & equal) | (decoder_output[1] & notequal) | (decoder_output[2] & equalorless) | (decoder_output[3] & greater));
		
		dff_Q CONFF (.D(d), .clk(CONin), .clr(1'b0), .Q(CONout));
		
endmodule
		
		
		