module tb_regfile;

    reg         clk = 0;
    reg         reset_n = 0;
    reg         we;
    reg  [1:0]  waddr;
    reg  [31:0] wdata;
    reg  [1:0]  raddr_a, raddr_b;
    wire [31:0] rdata_a, rdata_b;

    regfile_4entry dut (
        .clk       (clk),
        .reset_n   (reset_n),
        .we        (we),
        .waddr     (waddr),
        .wdata     (wdata),
        .raddr_a   (raddr_a),
        .raddr_b   (raddr_b),
        .rdata_a   (rdata_a),
        .rdata_b   (rdata_b)
    );

    always #5 clk = ~clk;

    initial begin
        // Reset
        reset_n = 0; we = 0; #20;
        reset_n = 1; #10;

        // Write some values
        we = 1;
        waddr = 2'd1; wdata = 32'hDEADBEEF; #10;
        waddr = 2'd2; wdata = 32'hCAFEBABE; #10;
        waddr = 2'd3; wdata = 32'h12345678; #10;
        we = 0;

        // Read combinations
        raddr_a = 2'd1; raddr_b = 2'd2; #10;
        raddr_a = 2'd3; raddr_b = 2'd0; #10;
        raddr_a = 2'd0; raddr_b = 2'd1; #20;

        $finish;
    end

endmodule