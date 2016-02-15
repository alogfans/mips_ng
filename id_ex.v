`timescale 1ns / 1ps
`include "defines.v"

module id_ex(
    input wire                      clk,
    input wire                      reset_,

    input wire                      stall,

    input wire                      mem_to_reg_id,
    input wire                      reg_dst_id,
    input wire                      mem_write_id,
    input wire                      mem_read_id,
    input wire                      reg_write_id,
    input wire  [`AluOpBus]         alu_op_id,
    input wire                      alu_src_a_id,
    input wire                      alu_src_b_id,
    input wire [`RegAddrBus]        rs_addr_id,
    input wire [`RegAddrBus]        rt_addr_id,
    input wire [`RegAddrBus]        rd_addr_id,    
    input wire [`DataBus]           rs_data_id,
    input wire [`DataBus]           rt_data_id,
    input wire [`DataBus]           imm_32_id,
    input wire [`DataBus]           shamt_32_id,
    
    output reg                      mem_to_reg_ex,
    output reg                      reg_dst_ex,
    output reg                      mem_write_ex,
    output reg                      mem_read_ex,
    output reg                      reg_write_ex,
    output reg  [`AluOpBus]         alu_op_ex,
    output reg                      alu_src_a_ex,
    output reg                      alu_src_b_ex,    
    output reg [`RegAddrBus]        rs_addr_ex,
    output reg [`RegAddrBus]        rt_addr_ex,
    output reg [`RegAddrBus]        rd_addr_ex,    
    output reg [`DataBus]           rs_data_ex,
    output reg [`DataBus]           rt_data_ex,
    output reg [`DataBus]           imm_32_ex,
    output reg [`DataBus]           shamt_32_ex
);
    
    always @(posedge clk or `RESET_EDGE reset_) begin
        if (reset_ == `ENABLED_) begin
            mem_to_reg_ex <= `DISABLED;
            reg_dst_ex <= `REG_DST_RT;
            mem_write_ex <= `DISABLED;
            mem_read_ex <= `DISABLED;
            reg_write_ex <= `DISABLED;
            alu_op_ex <= `ALU_NOP;
            alu_src_a_ex <= `ALU_SRC_NORMAL;
            alu_src_b_ex <= `ALU_SRC_NORMAL;
            rs_addr_ex <= `REG_ADDR_W'h0;
            rt_addr_ex <= `REG_ADDR_W'h0;
            rd_addr_ex <= `REG_ADDR_W'h0;
            rs_data_ex <= `ADDR_W'h0;
            rt_data_ex <= `ADDR_W'h0;
            imm_32_ex  <= `ADDR_W'h0;
            shamt_32_ex <= `ADDR_W'h0;
        end else begin
            if (stall == `ENABLED) begin
                mem_to_reg_ex <= `DISABLED;
                reg_dst_ex <= `REG_DST_RT;
                mem_write_ex <= `DISABLED;
                mem_read_ex <= `DISABLED;
                reg_write_ex <= `DISABLED;
                alu_op_ex <= `ALU_NOP;
                alu_src_a_ex <= `ALU_SRC_NORMAL;
                alu_src_b_ex <= `ALU_SRC_NORMAL;
                rs_addr_ex <= `REG_ADDR_W'h0;
                rt_addr_ex <= `REG_ADDR_W'h0;
                rd_addr_ex <= `REG_ADDR_W'h0;
                rs_data_ex <= `ADDR_W'h0;
                rt_data_ex <= `ADDR_W'h0;
                imm_32_ex  <= `ADDR_W'h0;
                shamt_32_ex <= `ADDR_W'h0;
            end else begin
                mem_to_reg_ex <= #1mem_to_reg_id;
                reg_dst_ex <= reg_dst_id;
                mem_write_ex <= mem_write_id;
                mem_read_ex <= mem_read_id;
                reg_write_ex <= reg_write_id;
                alu_op_ex <= alu_op_id;
                alu_src_a_ex <= alu_src_a_id;
                alu_src_b_ex <= alu_src_b_id;
                rs_addr_ex <= rs_addr_id;
                rt_addr_ex <= rt_addr_id;
                rd_addr_ex <= rd_addr_id;
                rs_data_ex <= rs_data_id;
                rt_data_ex <= rt_data_id;
                imm_32_ex  <= imm_32_id;
                shamt_32_ex <= shamt_32_id;
            end            
        end
    end
endmodule
