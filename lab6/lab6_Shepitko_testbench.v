module test_sum;
    // Test registers and wires
    reg [6:0] Ain_r, Bin_r;
    reg Ci_r;
    wire [6:0] Ain, Bin;
    wire Ci;
    wire [6:0] res_my, res_ref;
    wire cm, cr;

    assign Ain = Ain_r;
    assign Bin = Bin_r;
    assign Ci = Ci_r;

    // Instantiate the modules to be tested
    my_sum my_block (Ain, Bin, Ci, res_my, cm);    // Structural adder
    ref_sum ref_block (Ain, Bin, Ci, res_ref, cr); // Behavioral reference model

    initial begin
        $display("Time\tAin    \tBin    \tCi\tres_my \tcm\tres_ref \tcr");
        // ??????? ?????? ?????? ?? %07b ??? 7-??????? ?????
        $monitor("%4d\t%07b\t%07b\t%b\t%07b\t%b\t%07b\t%b",
                 $time, Ain, Bin, Ci, res_my, cm, res_ref, cr);
        #500 $finish;
    end

    // Initial block for Ain stimulus
    initial begin
        // Test various values for Ain
        Ain_r = 7'b0000001; // 1
        #50 Ain_r = 7'b0001010; // 10
        #50 Ain_r = 7'b0101010; // 42
        #50 Ain_r = 7'b1010101; // 85 (??????????? ??? 7 ???)
        #50 Ain_r = 7'b1111111; // 127 (???????? ??? 7 ???)
        #50 Ain_r = 7'b0000000; // 0
        #50 Ain_r = 7'b1000000; // 64 
        #50 Ain_r = 7'b1111111; // 127
    end

    // Initial block for Bin stimulus
    initial begin
        // Test various values for Bin
        Bin_r = 7'b0000010; // 2
        #50 Bin_r = 7'b0001100; // 12
        #50 Bin_r = 7'b0101010; // 42 
        #50 Bin_r = 7'b1110000; // 112 (??????????? ??? 7 ???)
        #100 Bin_r = 7'b0000001; // 1
        #100 Bin_r = 7'b1111111; // 127
    end

    // Initial block for Carry-in stimulus
    initial begin
        // Test with and without carry-in
        Ci_r = 1'b0;
        #250 Ci_r = 1'b1;
    end
endmodule