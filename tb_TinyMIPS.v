`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer: Emirhan Tala
//
// Description: CSE224 Term Project
// Verilog Test Fixture created by ISE for module: TinyMIPS
//////////////////////////////////////////////////////////////////////////////////

module tb_TinyMIPS_test1;
	parameter SIZE = 8, DEPTH = 2**SIZE;
	reg clk, rst;
	wire wrEn;
	wire [SIZE-1:0] addr_toRAM;
	wire [15:0] data_toRAM, data_fromRAM;
	
	TinyMIPS uut1 (clk, rst, data_fromRAM, wrEn, addr_toRAM, data_toRAM);

	blram #(SIZE, DEPTH) uut2 (clk, rst, wrEn, addr_toRAM, data_toRAM, data_fromRAM);

	initial begin
		clk = 1;
		forever
			#5 clk = ~clk;
	end

	initial begin
		rst = 1;
		repeat (10) @(posedge clk);
		rst <= #1 0;
		repeat (120) @(posedge clk);

        if (uut1.RF[2] == 1 + 2 + 3 + 4 + 5)
		    $display("Test 1 Passed: Sum of 1 to 5 is correct.");
		else
		    $display("Test 1 Failed: Expected %d, got %d", 15, uut1.RF[2]);

		$finish;
	end

	initial begin
	    $dumpfile("dump.vcd"); $dumpvars;
      	
        // Test 1: Sum of 1 to 5
		uut2.mem[0] = 16'b0111001000000001; // CPi R1 1			// i = 1
        uut2.mem[1] = 16'b0111010000000000; // CPi R2 0			// sum = 0
        uut2.mem[2] = 16'b0111011000000110; // CPi R3 6			// max = 6
        uut2.mem[3] = 16'b0000010010001000; // ADD R2 R2 R1	// sum = sum + i
        uut2.mem[4] = 16'b0001001001000001; // ADDi R1 R1 1	// i++
        uut2.mem[5] = 16'b1001001011111110; // BLT R1 R3 -2	// if (i < max) then go back to address 5-2=3      	
	end
endmodule

module tb_TinyMIPS_test2;
	parameter SIZE = 8, DEPTH = 2**SIZE;
	reg clk, rst;
	wire wrEn;
	wire [SIZE-1:0] addr_toRAM;
	wire [15:0] data_toRAM, data_fromRAM;
	
	TinyMIPS uut1 (clk, rst, data_fromRAM, wrEn, addr_toRAM, data_toRAM);

	blram #(SIZE, DEPTH) uut2 (clk, rst, wrEn, addr_toRAM, data_toRAM, data_fromRAM);

	initial begin
		clk = 1;
		forever
			#5 clk = ~clk;
	end

	initial begin
		rst = 1;
		repeat (10) @(posedge clk);
		rst <= #1 0;
		repeat (120) @(posedge clk);

        if (uut1.RF[2] == 5 + 8 + 15 + 17 + 22)
		    $display("Test 2.1 Passed: Sum of 5 numbers in register2 is correct.");
		else
		    $display("Test 2.1 Failed: Expected %d, got %d", 67, uut1.RF[2]);

        if (uut2.mem[15] == 5 + 8 + 15 + 17 + 22)
		    $display("Test 2.2 Passed: Sum of 5 numbers in mem[15] is correct.");
		else
		    $display("Test 2.2 Failed: Expected %d, got %d", 67, uut2.mem[15]);

		$finish;
	end

	initial begin
	    $dumpfile("dump.vcd"); $dumpvars;
      	
        // Test 2: Sum of 5 numbers in the memory
        // The result is stored at address 15
		uut2.mem[0] = 16'b0111001000000000; // 0: CPi R1 0 // i = 0
        uut2.mem[1] = 16'b0111010000000000; // 1: CPi R2 0 // sum = 0
        uut2.mem[2] = 16'b0111011000000101; // 2: CPi R3 5 // max = 5
        uut2.mem[3] = 16'b0100100001001010; // 3: LD R4 R1 10 // x = mem[10+i]
        uut2.mem[4] = 16'b0000010010100000; // 4: ADD R2 R2 R4 // sum = sum + x
        uut2.mem[5] = 16'b0001001001000001; // 5: ADDi R1 R1 1 // i++
        uut2.mem[6] = 16'b1001001011111101; // 6: BLT R1 R3 -3 // if (i < max) then go back to address 6-3=3
        uut2.mem[7] = 16'b0101010001001010; // 7: ST R2 R1 10 // mem[10+i] = sum
        uut2.mem[10] = 16'b0000000000000101; // 10: 5
        uut2.mem[11] = 16'b0000000000001000; // 11: 8
        uut2.mem[12] = 16'b0000000000001111; // 12: 15
        uut2.mem[13] = 16'b0000000000010001; // 13: 17
        uut2.mem[14] = 16'b0000000000010110; // 14: 22
        uut2.mem[15] = 16'b0000000000000000; // 15: 0
	end
endmodule

module tb_TinyMIPS_test3;
	parameter SIZE = 8, DEPTH = 2**SIZE;
	reg clk, rst;
	wire wrEn;
	wire [SIZE-1:0] addr_toRAM;
	wire [15:0] data_toRAM, data_fromRAM;
	
	TinyMIPS uut1 (clk, rst, data_fromRAM, wrEn, addr_toRAM, data_toRAM);

	blram #(SIZE, DEPTH) uut2 (clk, rst, wrEn, addr_toRAM, data_toRAM, data_fromRAM);

	initial begin
		clk = 1;
		forever
			#5 clk = ~clk;
	end

	initial begin
		rst = 1;
		repeat (10) @(posedge clk);
		rst <= #1 0;
		repeat (120) @(posedge clk);

        if (uut1.RF[2] == 1 * 2 * 3 * 4 * 5)
		    $display("Test 3 Passed: Factorial of 5 is correct.");
		else
		    $display("Test 3 Failed: Expected %d, got %d", 120, uut1.RF[2]);

		$finish;
	end

	initial begin
	    $dumpfile("dump.vcd"); $dumpvars;
      	
        // Test 3: Factorial of 5
		uut2.mem[0] = 16'b0111001000000001; // 0: CPi R1 1 // i = 1
        uut2.mem[1] = 16'b0110010001000000; // 1: CP R2 R1 // fact = i = 1
        uut2.mem[2] = 16'b0111011000000110; // 2: CPi R3 6 // max = 6
        uut2.mem[3] = 16'b0010010010001000; // 3: MUL R2 R2 R1 // fact = fact * i
        uut2.mem[4] = 16'b0001001001000001; // 4: ADDi R1 R1 1 // i++
        uut2.mem[5] = 16'b1001001011111110; // 5: BLT R1 R3 -2 // if (i < max) then go back to address 5-2=3
	end
endmodule

module tb_TinyMIPS_test4;
	parameter SIZE = 8, DEPTH = 2**SIZE;
	reg clk, rst;
	wire wrEn;
	wire [SIZE-1:0] addr_toRAM;
	wire [15:0] data_toRAM, data_fromRAM;
	
	TinyMIPS uut1 (clk, rst, data_fromRAM, wrEn, addr_toRAM, data_toRAM);

	blram #(SIZE, DEPTH) uut2 (clk, rst, wrEn, addr_toRAM, data_toRAM, data_fromRAM);

	initial begin
		clk = 1;
		forever
			#5 clk = ~clk;
	end

	initial begin
		rst = 1;
		repeat (10) @(posedge clk);
		rst <= #1 0;
		repeat (120) @(posedge clk);

        if (uut2.mem[15] == ((5 + 5) >> 2)  &&
            uut2.mem[16] == 0 &&
            uut2.mem[17] == ((15 + 5) >> 2) &&
            uut2.mem[18] == ((17 + 5) >> 2) &&
            uut2.mem[19] == ((22 + 5) >> 2)) begin
            $display("Test 4 Passed.");
        end else begin
            $display("Test 4 Failed.");
            $display("Memory[15]: %d", uut2.mem[15]);
            $display("Memory[16]: %d", uut2.mem[16]);
            $display("Memory[17]: %d", uut2.mem[17]);
            $display("Memory[18]: %d", uut2.mem[18]);
            $display("Memory[19]: %d", uut2.mem[19]);
        end
		$finish;
	end

	initial begin
	    $dumpfile("dump.vcd"); $dumpvars;
      	
        // Test 4: In-place memory update
		uut2.mem[0] = 16'b0111001000000101; // 0: CPi R1 5 // i = 5
        uut2.mem[1] = 16'b0111010000000000; // 1: CPi R2 0 // min = 0
        uut2.mem[2] = 16'b0110011010000000; // 2: CP R3 R2 // j = min = 0
        uut2.mem[3] = 16'b0111100000000010; // 3: CPi R4 2 // sh = 2
        uut2.mem[4] = 16'b0100101001001110; // 4: LD R5 R1 14 // x = mem[14+i]
        uut2.mem[5] = 16'b1000101011000100; // 5: BEQ R5 R3 4 // if (x==j) then go to address 5+4=9
        uut2.mem[6] = 16'b0001101101000101; // 6: ADDi R5 R5 5 // x = x + 5
        uut2.mem[7] = 16'b0011101101100000; // 7: SRL R5 R5 R4 // x = x >> 2
        uut2.mem[8] = 16'b0101101001001110; // 8: ST R5 R1 14 // mem[14+i] = x
        uut2.mem[9] = 16'b0001001001111111; // 9: ADDi R1 R1 -1 // i--
        uut2.mem[10] = 16'b1010001010111011; // 10: BGT R1 R2 -5 // if (i > min) then go back to address 9-5=4
        uut2.mem[15] = 16'b0000000000000101; // 15: 5
        uut2.mem[16] = 16'b0000000000000000; // 16: 0
        uut2.mem[17] = 16'b0000000000001111; // 17: 15
        uut2.mem[18] = 16'b0000000000010001; // 18: 17
        uut2.mem[19] = 16'b0000000000010110; // 19: 22
	end
endmodule