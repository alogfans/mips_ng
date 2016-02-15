`timescale 1ns / 1ps
`include "defines.v"

module if_id(
    input wire                  clk,
    input wire                  reset_,

    input wire [`AddrBus]       pc_if,
    input wire [`DataBus]       inst_if,
    input wire                  en_if,

    output reg [`AddrBus]       pc_id,
    output reg [`DataBus]       inst_id
);

    always @(posedge clk or `RESET_EDGE reset_) begin
        if (reset_ == `ENABLED_) begin
            pc_id = `ADDR_W'h0;
            inst_id = `DATA_W'h0;
        end else begin
            if (en_if == `DISABLED) begin
                pc_id = `ADDR_W'h0;
                inst_id = `DATA_W'h0;            
            end else begin
                pc_id = pc_if;
                inst_id = inst_if;
            end
        end
    end
endmodule
