module TestbenchMultiplier;
	reg [31:0] mp, mc;
	wire [31:0] HI, LO;
	
	twoCompliment DUT(mp, LO);
	
	initial 
	begin 
		//case 0
		mc <= 'h00000000;
		mp <= 'h00000000;
		#10 $display("HI = %b", HI);
		#10 $display("LO = %b", LO);
		//case 1
		mc <= 'hFFFFFFFF;
		mp <= 'hFFFFFFFF;
		#10 $display("HI = %b", HI);
		#10 $display("LO = %b", LO);
		//case 2
		mc <= 'h74FF8201;
		mp <= 'h22019BAA;
		#10 $display("HI = %b", HI);
		#10 $display("LO = %b", LO);
	end
endmodule 