module my_design #(
    parameter WIDTH = 32,
    parameter USE_ADD_MODE = 0
) (
    input  wire             clk,
    input  wire             reset_n,
    input  wire             enable,
    input  wire [WIDTH-1:0] d_in_1,
    input  wire [WIDTH-1:0] d_in_2,
    output wire [WIDTH-1:0] d_out,
    
    output wire             valid_out
);

    reg  [WIDTH-1:0] stage1_reg;
    reg  [WIDTH-1:0] stage2_reg;
    
    reg              valid_reg;
    
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            stage1_reg <= {WIDTH{1'b0}};
            valid_reg  <= 1'b0;
        end
        else if (enable) begin
            stage1_reg <= d_in_1;
            valid_reg  <= 1'b1;
        end
    end

    // -------------------------------------------------------------------------
    // Pipeline stage 2
    // -------------------------------------------------------------------------
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            stage2_reg <= {WIDTH{1'b0}};
        end
        else if (enable) begin
            stage2_reg <= stage1_reg;
        end
    end

    // -------------------------------------------------------------------------
    // Output logic - operation selected by parameter
    // -------------------------------------------------------------------------
    wire [WIDTH-1:0] operation_result;
    
    generate
        if (USE_ADD_MODE == 1) begin : gen_add
            assign operation_result = d_in_2 + stage2_reg;
        end
        else begin : gen_xor
            assign operation_result = d_in_2 ^ stage2_reg;
        end
    endgenerate

    reg [WIDTH-1:0] d_out_reg;
    
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            d_out_reg <= {WIDTH{1'b0}};
        else if (enable)
            d_out_reg <= operation_result;
    end

    assign d_out     = d_out_reg;
    assign valid_out = valid_reg;

endmodule