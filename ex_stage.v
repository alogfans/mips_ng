`timescale 1ns / 1ps
`include "defines.v"

module ex_stage(
    input wire [`FwdBus]            fwd_a,
    input wire [`FwdBus]            fwd_b,
    input wire                      reg_dst,
    input wire [`AluOpBus]          alu_op,
    input wire                      alu_src_a,
    input wire                      alu_src_b,
    input wire [`RegAddrBus]        rt_addr,
    input wire [`RegAddrBus]        rd_addr,    
    input wire [`DataBus]           rs_data,
    input wire [`DataBus]           rt_data,
    input wire [`DataBus]           imm_32,
    input wire [`DataBus]           shamt_32,
    
    input wire [`DataBus]           mem_data,
    input wire [`DataBus]           wb_data,
    
    output wire [`DataBus]          alu_out,
    output wire [`RegAddrBus]       dst_addr,
    output wire [`DataBus]          dst_data
);
    wire [`DataBus] fwd_a_data = (fwd_a == `FWD_NO ? rs_data : (fwd_a == `FWD_WB ? wb_data : mem_data));
    wire [`DataBus] fwd_b_data = (fwd_b == `FWD_NO ? rt_data : (fwd_b == `FWD_WB ? wb_data : mem_data));
    wire [`DataBus] alu_in_0 = (alu_src_a == `ALU_SRC_SHAMT ? shamt_32 : fwd_a_data);
    wire [`DataBus] imm_32_zero = {16'h0, imm_32[15:0]}; 
    wire [`DataBus] imm_32_ = (alu_op >= `ALU_AND && alu_op <= `ALU_NOR ? imm_32_zero : imm_32);
    wire [`DataBus] alu_in_1 = (alu_src_b == `ALU_SRC_IMM ? imm_32_ : fwd_b_data);
    assign dst_addr = (reg_dst == `REG_DST_RD ? rd_addr : rt_addr);
    assign dst_data = fwd_b_data;
    
    alu alu(
        .op(alu_op),
        .in_0(alu_in_0),
        .in_1(alu_in_1),
        .out(alu_out)
    );
endmodule
