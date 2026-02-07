module my_design (
    input clk,
    input reset_n,
    input [31:0] d_in_1,
    input [31:0] d_in_2,
    output [31:0] d_out
);

    reg [31:0] d_out_pre;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n) begin
            d_out_pre <= 'h0;
        end
        else begin
            d_out_pre <= d_in_1;
        end

        assign d_out = d_in_2 ^ d_out_pre;
    end

endmodule