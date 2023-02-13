module boothMultiplier(input [31:0] multiplier, multiplicand, output [31:0] ansHI, ansLO);
	integer i, k, j;

	reg [63:0] ans;
	reg [32:0] mrShifted; //This is the register that is prepared for the booth algorithm counting

	reg [63:0] mc, mcTwos; //The 64 bit register of the Multiplicand and the Twos Compliment of the Multiplicand (1 * M and -1 * M)
	reg [63:0] dmc, dmcTwos; //The doubled Twos Compliment of the Multiplicand (2 * M and -2 * M)

	wire [31:0] mcTemp, mcTempTwos; //Temporary 32 bit twos compliment of 
	
	twoCompliment(multiplicand, mcTempTwos);
	assign mcTemp = multiplicand;
	
	always @ (*) begin
		mcTwos = 64'hFFFFFFFFFFFFFFFF; //Set this register to all 1's

		for (i=0; i<32; i=i+1) //Prep all of the multiplicand values into sign extended 64 bit registers
			begin
				mrShifted[i+1] <= multiplier[i];
				mc[i] <= mcTemp[i];
				mcTwos[i] <= mcTempTwos[i];
			end
		dmc = mc <<< 1;
		dmcTwos = mcTwos <<< 1;
		

		//At this point all of the multiplicand values should be prepped, and so should the mrShifted register
		for (k=1; k<33; k=k+2) 
			begin
				if (multiplierShifted[k+1] == 0 && multiplierShifted[k] == 0 && multiplierShifted[k-1] == 0) ans = ans + (0 <<< (k-1)); else
				if (multiplierShifted[k+1] == 0 && multiplierShifted[k] == 0 && multiplierShifted[k-1] == 1) ans = ans + (mc <<< (k-1)); else
				if (multiplierShifted[k+1] == 0 && multiplierShifted[k] == 1 && multiplierShifted[k-1] == 0) ans = ans + (mc <<< (k-1)); else
				if (multiplierShifted[k+1] == 0 && multiplierShifted[k] == 1 && multiplierShifted[k-1] == 1) ans = ans + (dmc <<< (k-1)); else
				if (multiplierShifted[k+1] == 1 && multiplierShifted[k] == 0 && multiplierShifted[k-1] == 0) ans = ans + (dmcTwos <<< (k-1)); else
				if (multiplierShifted[k+1] == 1 && multiplierShifted[k] == 0 && multiplierShifted[k-1] == 1) ans = ans + (mcTwos <<< (k-1)); else
				if (multiplierShifted[k+1] == 1 && multiplierShifted[k] == 1 && multiplierShifted[k-1] == 0) ans = ans + (mcTwos <<< (k-1)); else
				if (multiplierShifted[k+1] == 1 && multiplierShifted[k] == 1 && multiplierShifted[k-1] == 1) ans = ans + (0 <<< (k-1)); else
			end

		//At this point the multiplication should be done for the signed mc and mr, and the answer should be stored in the 64 bit ans register
		for (j=0; j<32; j=j+1) //Prep all of the multiplicand values into sign extended 64 bit registers
			begin
				ansHI[j] = ans[j+32];
				ansLO[j] = ans[j];
			end
	end //At this point the answer from the ans register should be split into the output registers ansHI and ansLO
endmodule
