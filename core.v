`timescale 1ns / 1ps
`include "defines.v"

/*
module core(
    input wire                      clk,
    input wire                      reset_,
    
);
    wire                            stall_if;
    wire                            br;
    wire                            j;
    wire                            jr;  
    wire [`AddrBus]                 addr_br;
    wire [`AddrBus]                 addr_j;
    wire [`AddrBus]                 addr_jr;
    wire [`AddrBus]                 pc_if;
    wire [`DataBus]                 inst_if;
    wire                            en_if;
    
    wire [`AddrBus]                 pc_id;
    wire [`DataBus]                 inst_id;
    wire                            we_id;
    wire [`RegAddrBus]              wr_addr_id;
    wire [`DataBus]                 wr_data_id;
    wire [`RegAddrBus]              rs_addr_id;
    wire [`RegAddrBus]              rt_addr_id;
    wire [`RegAddrBus]              rd_addr_id;
    wire [`DataBus]                 rs_data_id;
    wire [`DataBus]                 rt_data_id;
    wire [`DataBus]                 imm_32_id;
    wire [`DataBus]                 shamt_32_id;
    wire                            mem_to_reg_id;
    wire                            reg_dst_id;
    wire                            mem_write_id;
    wire                            mem_read_id;
    wire                            reg_write_id;
    wire [`AluOpBus]                alu_op_id;
    wire                            alu_src_a_id;
    wire                            alu_src_b_id;
    wire                            stall_id;
    
    wire [`RegAddrBus]              rs_addr_ex;
    wire [`RegAddrBus]              rt_addr_ex;
    wire [`RegAddrBus]              rd_addr_ex;
    wire [`DataBus]                 rs_data_ex;
    wire [`DataBus]                 rt_data_ex;
    wire [`DataBus]                 imm_32_ex;
    wire [`DataBus]                 shamt_32_ex;
    wire                            mem_to_reg_ex;
    wire                            reg_dst_ex;
    wire                            mem_write_ex;
    wire                            mem_read_ex;
    wire                            reg_write_ex;
    wire [`AluOpBus]                alu_op_ex;
    wire                            alu_src_a_ex;
    wire                            alu_src_b_ex;
    wire [`FwdBus]                  fwd_a_ex;
    wire [`FwdBus]                  fwd_b_ex;    
    wire [`DataBus]                 mem_data_ex;
    wire [`DataBus]                 wb_data_ex;    
    wire [`DataBus]                 alu_out_ex;
    wire [`RegAddrBus]              dst_addr_ex;
    wire [`DataBus]                 dst_data_ex;
  
    wire                            mem_to_reg_mem;
    wire                            mem_write_mem;
    wire                            reg_write_mem;
    wire [`DataBus]                 alu_out_mem;
    wire [`RegAddrBus]              dst_addr_mem;
    wire [`DataBus]                 dst_data_mem;    
    wire [`DataBus]                 dout_data_mem;

    wire                            mem_to_reg_wb;
    wire                            reg_write_wb;
    wire [`DataBus]                 alu_out_wb;
    wire [`RegAddrBus]              dst_addr_wb;    
    wire [`DataBus]                 dout_data_wb;
*/

module core(
    input wire                             clk,
    input wire                             clk_rom,
    input wire                             reset_,
    output wire                            stall_if,

    
    output wire                            br,
    output wire                            j,
    output wire                            jr,  
    output wire [`AddrBus]                 addr_br,
    output wire [`AddrBus]                 addr_j,
    output wire [`AddrBus]                 addr_jr,
    output wire [`AddrBus]                 pc_if,
    output wire [`DataBus]                 inst_if,
    output wire                            en_if,
    
    output wire [`AddrBus]                 pc_id,
    output wire [`DataBus]                 inst_id,
    output wire                            we_id,
    output wire [`RegAddrBus]              wr_addr_id,
    output wire [`DataBus]                 wr_data_id,
    output wire [`RegAddrBus]              rs_addr_id,
    output wire [`RegAddrBus]              rt_addr_id,
    output wire [`RegAddrBus]              rd_addr_id,
    output wire [`DataBus]                 rs_data_id,
    output wire [`DataBus]                 rt_data_id,
    output wire [`DataBus]                 imm_32_id,
    output wire [`DataBus]                 shamt_32_id,
    output wire                            mem_to_reg_id,
    output wire                            reg_dst_id,
    output wire                            mem_write_id,
    output wire                            mem_read_id,
    output wire                            reg_write_id,
    output wire [`AluOpBus]                alu_op_id,
    output wire                            alu_src_a_id,
    output wire                            alu_src_b_id,
    output wire                            stall_id,
    
    output wire [`RegAddrBus]              rs_addr_ex,
    output wire [`RegAddrBus]              rt_addr_ex,
    output wire [`RegAddrBus]              rd_addr_ex,
    output wire [`DataBus]                 rs_data_ex,
    output wire [`DataBus]                 rt_data_ex,
    output wire [`DataBus]                 imm_32_ex,
    output wire [`DataBus]                 shamt_32_ex,
    output wire                            mem_to_reg_ex,
    output wire                            reg_dst_ex,
    output wire                            mem_write_ex,
    output wire                            mem_read_ex,
    output wire                            reg_write_ex,
    output wire [`AluOpBus]                alu_op_ex,
    output wire                            alu_src_a_ex,
    output wire                            alu_src_b_ex,
    output wire [`FwdBus]                  fwd_a_ex,
    output wire [`FwdBus]                  fwd_b_ex,    
    output wire [`DataBus]                 mem_data_ex,
    output wire [`DataBus]                 wb_data_ex,    
    output wire [`DataBus]                 alu_out_ex,
    output wire [`RegAddrBus]              dst_addr_ex,
    output wire [`DataBus]                 dst_data_ex,
  
    output wire                            mem_to_reg_mem,
    output wire                            mem_write_mem,
    output wire                            reg_write_mem,
    output wire [`DataBus]                 alu_out_mem,
    output wire [`RegAddrBus]              dst_addr_mem,
    output wire [`DataBus]                 dst_data_mem,    
    output wire [`DataBus]                 dout_data_mem,

    output wire                            mem_to_reg_wb,
    output wire                            reg_write_wb,
    output wire [`DataBus]                 alu_out_wb,
    output wire [`RegAddrBus]              dst_addr_wb,    
    output wire [`DataBus]                 dout_data_wb,
    
    output wire [`DataBus]                 ex_data_id,
    output wire [`FwdBus]                  fwd_a2,
    output wire [`FwdBus]                  fwd_b2
);

    if_stage if_stage(
        .clk(clk),
        .clk_rom(clk_rom),
        .reset_(reset_),
        .stall(stall_if),
        
        .br(br),
        .j(j),
        .jr(jr),
        
        .addr_br(addr_br),
        .addr_j(addr_j),
        .addr_jr(addr_jr),
        
        .pc(pc_if),
        .inst(inst_if),
        .en(en_if)
    );

    if_id if_id(
        .clk(clk),
        .reset_(reset_),
        .pc_if(pc_if),
        .inst_if(inst_if),
        .en_if(en_if),
        .pc_id(pc_id),
        .inst_id(inst_id)
    );
    
    id_stage id_stage(
        .clk(clk),
        .reset_(reset_),
        
        .pc(pc_id),
        .inst(inst_id),
        .we_(we_id),
        .wr_addr(wr_addr_id),
        .wr_data(wr_data_id),
        .rs_addr(rs_addr_id),
        .rt_addr(rt_addr_id),
        .rd_addr(rd_addr_id),
        .rs_data(rs_data_id),
        .rt_data(rt_data_id),
        .imm_32(imm_32_id),
        .shamt_32(shamt_32_id),
        .addr_br(addr_br),
        .addr_j(addr_j),
        .addr_jr(addr_jr),
        .br(br),
        .j(j),
        .jr(jr),
        .mem_to_reg(mem_to_reg_id),
        .reg_dst(reg_dst_id),
        .mem_write(mem_write_id),
        .mem_read(mem_read_id),
        .reg_write(reg_write_id),
        .alu_op(alu_op_id),
        .alu_src_a(alu_src_a_id),
        .alu_src_b(alu_src_b_id),
        
        .ex_data(ex_data_id),
        .mem_data(mem_data_ex),
        .fwd_a(fwd_a2),
        .fwd_b(fwd_b2)
    );
    
    id_ex id_ex (
        .clk(clk),
        .reset_(reset_),
        .stall(~en_if),
        
        .mem_to_reg_id(mem_to_reg_id),
        .reg_dst_id(reg_dst_id),
        .mem_write_id(mem_write_id),
        .mem_read_id(mem_read_id),
        .reg_write_id(reg_write_id),
        .alu_op_id(alu_op_id),
        .alu_src_a_id(alu_src_a_id),
        .alu_src_b_id(alu_src_b_id),
        .rs_addr_id(rs_addr_id),
        .rt_addr_id(rt_addr_id),
        .rd_addr_id(rd_addr_id),    
        .rs_data_id(rs_data_id),
        .rt_data_id(rt_data_id),
        .imm_32_id(imm_32_id),
        .shamt_32_id(shamt_32_id),
        
        .mem_to_reg_ex(mem_to_reg_ex),
        .reg_dst_ex(reg_dst_ex),
        .mem_write_ex(mem_write_ex),
        .mem_read_ex(mem_read_ex),
        .reg_write_ex(reg_write_ex),
        .alu_op_ex(alu_op_ex),
        .alu_src_a_ex(alu_src_a_ex),
        .alu_src_b_ex(alu_src_b_ex),
        .rs_addr_ex(rs_addr_ex),
        .rt_addr_ex(rt_addr_ex),
        .rd_addr_ex(rd_addr_ex),    
        .rs_data_ex(rs_data_ex),
        .rt_data_ex(rt_data_ex),
        .imm_32_ex(imm_32_ex),
        .shamt_32_ex(shamt_32_ex)        
    );
    
    ex_stage ex_stage(
        .fwd_a(fwd_a_ex),
        .fwd_b(fwd_b_ex),
        .reg_dst(reg_dst_ex),
        .alu_op(alu_op_ex),
        .alu_src_a(alu_src_a_ex),
        .alu_src_b(alu_src_b_ex),
        .rt_addr(rt_addr_ex),
        .rd_addr(rd_addr_ex),    
        .rs_data(rs_data_ex),
        .rt_data(rt_data_ex),
        .imm_32(imm_32_ex),
        .shamt_32(shamt_32_ex),
        .mem_data(mem_data_ex),
        .wb_data(wb_data_ex),
        .alu_out(alu_out_ex),
        .dst_addr(dst_addr_ex),
        .dst_data(dst_data_ex)
    );
    
    
    ex_mem ex_mem(
        .clk(clk),
        .reset_(reset_),
        
        .mem_to_reg_ex(mem_to_reg_ex),
        .mem_write_ex(mem_write_ex),
        .reg_write_ex(reg_write_ex),
        .alu_out_ex(alu_out_ex),
        .dst_addr_ex(dst_addr_ex),
        .dst_data_ex(dst_data_ex),
        
        .mem_to_reg_mem(mem_to_reg_mem),
        .mem_write_mem(mem_write_mem),
        .reg_write_mem(reg_write_mem),
        .alu_out_mem(alu_out_mem),
        .dst_addr_mem(dst_addr_mem),
        .dst_data_mem(dst_data_mem)
    );
    
    mem_stage mem_stage(
        .clk(clk),
        .reset_(reset_),
        .mem_write(mem_write_mem),
        .addr(alu_out_mem),
        .din(dst_data_mem),
        .dout(dout_data_mem)
    );
    
    mem_wb mem_wb(
        .clk(clk),
        .reset_(reset_),
        
        .mem_to_reg_mem(mem_to_reg_mem),
        .reg_write_mem(reg_write_mem),        
        .addr_mem(alu_out_mem),
        .dout_mem(dout_data_mem),
        .dst_addr_mem(dst_addr_mem),
        
        .mem_to_reg_wb(mem_to_reg_wb),
        .reg_write_wb(reg_write_wb),
        .addr_wb(alu_out_wb),
        .dout_wb(dout_data_wb),
        .dst_addr_wb(dst_addr_wb)
    );
    
    // WB
    assign we_id = ~reg_write_wb;
    assign wr_addr_id = dst_addr_wb;
    assign wr_data_id = (mem_to_reg_wb == `ENABLED ? dout_data_wb : alu_out_wb);
    
    assign ex_data_id = alu_out_ex;
    assign mem_data_ex = alu_out_mem;
    assign wb_data_ex = wr_data_id;
    assign stall_id = br || j || jr;

    control control(
        .reg_write_mem(reg_write_mem),
        .reg_write_wb(reg_write_wb),
        .rs_id(rs_addr_id),
        .rt_id(rt_addr_id),    
        .rs_ex(rs_addr_ex),
        .rt_ex(rt_addr_ex),
        .reg_write_addr_mem(dst_addr_mem),
        .reg_write_addr_wb(dst_addr_wb),
        .mem_read_ex(mem_read_ex),        
        .fwd_a(fwd_a_ex),
        .fwd_b(fwd_b_ex),
        
        .reg_write_ex(reg_write_ex),
        .fwd_a2(fwd_a2),
        .fwd_b2(fwd_b2),
        .reg_write_addr_ex(dst_addr_ex),
        
        .stall_if(stall_if)
    );
endmodule
