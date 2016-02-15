`timescale 1ns / 1ps
`include "defines.v"

module ex_mem(
    input wire                      clk,
    input wire                      reset_,
    
    input wire                      mem_to_reg_ex,
    input wire                      mem_write_ex,
    input wire                      reg_write_ex,
    input wire [`DataBus]           alu_out_ex,
    input wire [`RegAddrBus]        dst_addr_ex,
    input wire [`DataBus]           dst_data_ex,
    
    output reg                      mem_to_reg_mem,
    output reg                      mem_write_mem,
    output reg                      reg_write_mem,
    output reg [`DataBus]           alu_out_mem,
    output reg [`RegAddrBus]        dst_addr_mem,
    output reg [`DataBus]           dst_data_mem
);
    
    always @(posedge clk or `RESET_EDGE reset_) begin
        if (reset_ == `ENABLED_) begin
            mem_to_reg_mem <= `DISABLED;
            mem_write_mem <= `DISABLED;
            reg_write_mem <= `DISABLED;
            alu_out_mem <= `DATA_W'h0;
            dst_addr_mem <= `REG_ADDR_W'h0;
            dst_data_mem <= `DATA_W'h0;
        end else begin
            mem_to_reg_mem <= mem_to_reg_ex;
            mem_write_mem <= mem_write_ex;
            reg_write_mem <= reg_write_ex;
            alu_out_mem <= alu_out_ex;
            dst_addr_mem <= dst_addr_ex;
            dst_data_mem <= dst_data_ex;
        end
    end
endmodule
