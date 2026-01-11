`timescale 1ns/1ps

module testbench;

    reg clock;
    reg [15:0] inp;     // not used by CPU but required by module
    integer i;

    // Instantiate CPU
    i281_CPU uut (
        .inp(inp),
        .clock(clock)
    );

    // Clock generator (100 MHz)
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    // Test procedure
    initial begin
        inp = 16'b0;

        $display("Starting CPU simulation…");
        $dumpfile("cpu_sort.vcd");     
        $dumpvars(0, testbench);

        
        // Step 1: run CPU for a fixed number of cycles
                
        repeat(4000) @(posedge clock);

        
        // Dump final data memory contents
        $display("\n--- DATA MEMORY AFTER SIMULATION ---");
        for (i = 0; i < 16; i = i + 1) begin
            $display("DMEM[%0d] = %0d", i, uut.DMEM.mem[i]);
        end
        $stop;
    end

endmodule
