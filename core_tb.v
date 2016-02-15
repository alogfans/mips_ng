`timescale 1ns / 1ps
`include "defines.v"

module core_tb;

	// Inputs
	reg clk;
    reg clk_rom;
	reg reset_;

	// Outputs
	wire stall_if;
	wire br;
	wire j;
	wire jr;
	wire [31:0] addr_br;
	wire [31:0] addr_j;
	wire [31:0] addr_jr;
	wire [31:0] pc_if;
	wire [31:0] inst_if;
	wire en_if;
	wire [31:0] pc_id;
	wire [31:0] inst_id;
	wire we_id;
	wire [4:0] wr_addr_id;
	wire [31:0] wr_data_id;
	wire [4:0] rs_addr_id;
	wire [4:0] rt_addr_id;
	wire [4:0] rd_addr_id;
	wire [31:0] rs_data_id;
	wire [31:0] rt_data_id;
	wire [31:0] imm_32_id;
	wire [31:0] shamt_32_id;
	wire mem_to_reg_id;
	wire reg_dst_id;
	wire mem_write_id;
	wire mem_read_id;
	wire reg_write_id;
	wire [4:0] alu_op_id;
	wire alu_src_a_id;
	wire alu_src_b_id;
	wire stall_id;
	wire [4:0] rs_addr_ex;
	wire [4:0] rt_addr_ex;
	wire [4:0] rd_addr_ex;
	wire [31:0] rs_data_ex;
	wire [31:0] rt_data_ex;
	wire [31:0] imm_32_ex;
	wire [31:0] shamt_32_ex;
	wire mem_to_reg_ex;
	wire reg_dst_ex;
	wire mem_write_ex;
	wire mem_read_ex;
	wire reg_write_ex;
	wire [4:0] alu_op_ex;
	wire alu_src_a_ex;
	wire alu_src_b_ex;
	wire [1:0] fwd_a_ex;
	wire [1:0] fwd_b_ex;
	wire [31:0] mem_data_ex;
	wire [31:0] wb_data_ex;
	wire [31:0] alu_out_ex;
	wire [4:0] dst_addr_ex;
	wire [31:0] dst_data_ex;
	wire mem_to_reg_mem;
	wire mem_write_mem;
	wire reg_write_mem;
	wire [31:0] alu_out_mem;
	wire [4:0] dst_addr_mem;
	wire [31:0] dst_data_mem;
	wire [31:0] dout_data_mem;
	wire mem_to_reg_wb;
	wire reg_write_wb;
	wire [31:0] alu_out_wb;
	wire [4:0] dst_addr_wb;
	wire [31:0] dout_data_wb;

	// Instantiate the Unit Under Test (UUT)
	core uut (
		.clk(clk), 
        .clk_rom(clk_rom),
		.reset_(reset_), 
		.stall_if(stall_if), 
		.br(br), 
		.j(j), 
		.jr(jr), 
		.addr_br(addr_br), 
		.addr_j(addr_j), 
		.addr_jr(addr_jr), 
		.pc_if(pc_if), 
		.inst_if(inst_if), 
		.en_if(en_if), 
		.pc_id(pc_id), 
		.inst_id(inst_id), 
		.we_id(we_id), 
		.wr_addr_id(wr_addr_id), 
		.wr_data_id(wr_data_id), 
		.rs_addr_id(rs_addr_id), 
		.rt_addr_id(rt_addr_id), 
		.rd_addr_id(rd_addr_id), 
		.rs_data_id(rs_data_id), 
		.rt_data_id(rt_data_id), 
		.imm_32_id(imm_32_id), 
		.shamt_32_id(shamt_32_id), 
		.mem_to_reg_id(mem_to_reg_id), 
		.reg_dst_id(reg_dst_id), 
		.mem_write_id(mem_write_id), 
		.mem_read_id(mem_read_id), 
		.reg_write_id(reg_write_id), 
		.alu_op_id(alu_op_id), 
		.alu_src_a_id(alu_src_a_id), 
		.alu_src_b_id(alu_src_b_id), 
		.stall_id(stall_id), 
		.rs_addr_ex(rs_addr_ex), 
		.rt_addr_ex(rt_addr_ex), 
		.rd_addr_ex(rd_addr_ex), 
		.rs_data_ex(rs_data_ex), 
		.rt_data_ex(rt_data_ex), 
		.imm_32_ex(imm_32_ex), 
		.shamt_32_ex(shamt_32_ex), 
		.mem_to_reg_ex(mem_to_reg_ex), 
		.reg_dst_ex(reg_dst_ex), 
		.mem_write_ex(mem_write_ex), 
		.mem_read_ex(mem_read_ex), 
		.reg_write_ex(reg_write_ex), 
		.alu_op_ex(alu_op_ex), 
		.alu_src_a_ex(alu_src_a_ex), 
		.alu_src_b_ex(alu_src_b_ex), 
		.fwd_a_ex(fwd_a_ex), 
		.fwd_b_ex(fwd_b_ex), 
		.mem_data_ex(mem_data_ex), 
		.wb_data_ex(wb_data_ex), 
		.alu_out_ex(alu_out_ex), 
		.dst_addr_ex(dst_addr_ex), 
		.dst_data_ex(dst_data_ex), 
		.mem_to_reg_mem(mem_to_reg_mem), 
		.mem_write_mem(mem_write_mem), 
		.reg_write_mem(reg_write_mem), 
		.alu_out_mem(alu_out_mem), 
		.dst_addr_mem(dst_addr_mem), 
		.dst_data_mem(dst_data_mem), 
		.dout_data_mem(dout_data_mem), 
		.mem_to_reg_wb(mem_to_reg_wb), 
		.reg_write_wb(reg_write_wb), 
		.alu_out_wb(alu_out_wb), 
		.dst_addr_wb(dst_addr_wb), 
		.dout_data_wb(dout_data_wb)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
        clk_rom = 0;
		reset_ = `ENABLED_;        

		// Wait 10 ns for global reset to finish
		#10;
        
		// Add stimulus here
        reset_ = `DISABLED_;
        #100 $finish;
	end
    
    always #5 begin
        clk = ~clk;
        clk_rom = ~clk_rom;
    end

endmodule

