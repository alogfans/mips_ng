`timescale 1ns / 1ps
`include "defines.v"

module control(
    input wire                  reg_write_mem,
    input wire                  reg_write_wb,
    input wire [`RegAddrBus]    rs_id,
    input wire [`RegAddrBus]    rt_id,    
    input wire [`RegAddrBus]    rs_ex,
    input wire [`RegAddrBus]    rt_ex,
    input wire [`RegAddrBus]    reg_write_addr_mem,
    input wire [`RegAddrBus]    reg_write_addr_wb,
    
    input wire                  mem_read_ex,
    
    output wire [`FwdBus]       fwd_a,
    output wire [`FwdBus]       fwd_b,
    
    input wire                  reg_write_ex,
    output wire [`FwdBus]       fwd_a2,
    output wire [`FwdBus]       fwd_b2,
    input wire [`RegAddrBus]    reg_write_addr_ex,
    
    output wire                 stall_if
);

    assign fwd_a = (reg_write_mem == 1 && reg_write_addr_mem == rs_ex && rs_ex != `REG_ADDR_W'h0 ? 
        `FWD_MEM :
        (reg_write_wb == 1 && reg_write_addr_wb == rs_ex && rs_ex != `REG_ADDR_W'h0 && reg_write_addr_mem != rs_ex) ?
        `FWD_WB: `FWD_NO);
    
    assign fwd_b = (reg_write_mem == 1 && reg_write_addr_mem == rt_ex && rt_ex != `REG_ADDR_W'h0 ? 
        `FWD_MEM :
        (reg_write_wb == 1 && reg_write_addr_wb == rt_ex && rt_ex != `REG_ADDR_W'h0 && reg_write_addr_mem != rt_ex) ?
        `FWD_WB: `FWD_NO);
        
    // BRANCH ...
    assign fwd_a2 = (reg_write_ex == 1 && reg_write_addr_ex == rs_id && rs_id != `REG_ADDR_W'h0 ? 
        `FWD_MEM :
        (reg_write_mem == 1 && reg_write_addr_mem == rs_id && rs_id != `REG_ADDR_W'h0 && reg_write_addr_ex != rs_id) ?
        `FWD_WB: `FWD_NO);
    
    assign fwd_b2 = (reg_write_ex == 1 && reg_write_addr_ex == rt_id && rt_id != `REG_ADDR_W'h0 ? 
        `FWD_MEM :
        (reg_write_mem == 1 && reg_write_addr_mem == rt_id && rt_id != `REG_ADDR_W'h0 && reg_write_addr_ex != rt_id) ?
        `FWD_WB: `FWD_NO);

    assign stall_if = (mem_read_ex == 1 && (reg_write_addr_mem == rs_id || reg_write_addr_mem == rt_id) ? 
        `ENABLED: `DISABLED);
    
endmodule
