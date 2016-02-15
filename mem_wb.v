`timescale 1ns / 1ps
`include "defines.v"

module mem_wb(
    input wire                      clk,
    input wire                      reset_,
    
    input wire                      mem_to_reg_mem,
    input wire                      reg_write_mem,
    
    input wire [`DataBus]           addr_mem,
    input wire [`DataBus]           dout_mem,
    input wire [`RegAddrBus]        dst_addr_mem,
    
    output reg                      mem_to_reg_wb,
    output reg                      reg_write_wb,
    
    output reg [`AddrBus]           addr_wb,
    output reg [`DataBus]           dout_wb,
    output reg [`RegAddrBus]        dst_addr_wb
);
    
    always @(posedge clk or `RESET_EDGE reset_) begin
        if (reset_ == `ENABLED_) begin
            mem_to_reg_wb <= `DISABLED;
            reg_write_wb <= `DISABLED;
            addr_wb <= `ADDR_W'h0;
            dout_wb <= `DATA_W'h0;
            dst_addr_wb <= `REG_ADDR_W'h0;            
        end else begin
            mem_to_reg_wb <= mem_to_reg_mem;
            reg_write_wb <= reg_write_mem;
            addr_wb <= addr_mem;
            dout_wb <= dout_mem;
            dst_addr_wb <= dst_addr_mem;  
        end
    end
endmodule
