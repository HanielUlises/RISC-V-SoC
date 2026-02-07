module regfile_4entry (
    input  wire        clk,
    input  wire        reset_n,
    input  wire        we,
    input  wire  [1:0] waddr,              
    input  wire  [31:0] wdata,
    input  wire  [1:0] raddr_a,
    input  wire  [1:0] raddr_b,
    output reg  [31:0] rdata_a,
    output reg  [31:0] rdata_b
);

reg [31:0] regs [0:3];                      // 4 registers, each 32 bits

// ======================================================================
// Synchronous write logic
// ======================================================================
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        // Reset all registers to zero
        regs[0] <= 32'h00000000;
        regs[1] <= 32'h00000000;
        regs[2] <= 32'h00000000;
        regs[3] <= 32'h00000000;
    end
    else if (we) begin
        // Write only when write enable is active
        regs[waddr] <= wdata;
    end
end

// ======================================================================
// Combinational read logic (async read)
// ======================================================================
always @(*) begin
    // Port A
    if (raddr_a == 2'd0)
        rdata_a = 32'h00000000;
    else
        rdata_a = regs[raddr_a];

    // Port B
    if (raddr_b == 2'd0)
        rdata_b = 32'h00000000;
    else
        rdata_b = regs[raddr_b];
end

`ifdef SIMULATION
    initial begin
        $monitor("Time=%0t | we=%b waddr=%d wdata=%h | ra=%d rda=%h | rb=%d rdb=%h",
                 $time, we, waddr, wdata, raddr_a, rdata_a, raddr_b, rdata_b);
    end
`endif

endmodule