`timescale 1ns / 1ps
`include "defines.v"

module id_stage(
    input wire                      clk,
    input wire                      reset_,

    input wire [`AddrBus]           pc,
    input wire [`DataBus]           inst,
    
    input wire                      we_,
    input wire [`RegAddrBus]        wr_addr,
    input wire [`DataBus]           wr_data,
    
    output wire [`RegAddrBus]       rs_addr,
    output wire [`RegAddrBus]       rt_addr,
    output wire [`RegAddrBus]       rd_addr,
    
    output wire [`DataBus]          rs_data,
    output wire [`DataBus]          rt_data,
    output wire [`DataBus]          imm_32,
    output wire [`DataBus]          shamt_32,
    
    output reg  [`AddrBus]          addr_br,
    output reg  [`AddrBus]          addr_j,
    output reg  [`AddrBus]          addr_jr,
    
    output reg                      br,
    output reg                      j,
    output reg                      jr,
    
    output reg                      mem_to_reg,
    output reg                      reg_dst,
    output reg                      mem_write,
    output reg                      mem_read,
    output reg                      reg_write,
    output reg  [`AluOpBus]         alu_op,
    output reg                      alu_src_a,
    output reg                      alu_src_b,
    
    input wire [`DataBus]           ex_data,
    input wire [`DataBus]           mem_data,
    input wire [`FwdBus]            fwd_a,
    input wire [`FwdBus]            fwd_b
);

    wire [`IsaOpBus]                op          = inst[`IsaOpLoc];
    wire [`IsaFunctBus]             funct       = inst[`IsaFunctLoc];
    wire [`ShamtBus]                shamt       = inst[`IsaShamtLoc];
    wire [`IsaTargetBus]            target      = inst[`IsaTargetLoc];
    wire [`IsaImmBus]               imm         = inst[`IsaImmLoc];
    
    assign rs_addr  = inst[`IsaRsAddrLoc];
    assign rt_addr  = inst[`IsaRtAddrLoc];
    assign rd_addr  = inst[`IsaRdAddrLoc];
    assign imm_32   = {{`ISA_IMM_W{imm[`ISA_IMM_W - 1]}}, imm};
    assign shamt_32 = {{`ISA_IMM_W{1'b0}}, shamt};
    
    // BRANCH ONLY
    wire [`DataBus] fwd_a_data = (fwd_a == `FWD_NO ? rs_data : (fwd_a == `FWD_WB ? mem_data : ex_data));
    wire [`DataBus] fwd_b_data = (fwd_b == `FWD_NO ? rt_data : (fwd_b == `FWD_WB ? mem_data : ex_data));
    
    regfile regfile(
        .clk(clk),
        .reset_(reset_),
        .we_(we_),
        .wr_addr(wr_addr),
        .wr_data(wr_data),
        .rd_addr_0(rs_addr),
        .rd_data_0(rs_data),
        .rd_addr_1(rt_addr),
        .rd_data_1(rt_data)   
    );
    
    always @(*) begin
        br          <= `DISABLED;
        j           <= `DISABLED;
        jr          <= `DISABLED;
        mem_to_reg  <= `DISABLED;
        reg_dst     <= `REG_DST_RT;
        mem_write   <= `DISABLED;
        mem_read    <= `DISABLED;
        reg_write   <= `DISABLED;
        alu_op      <= `ALU_NOP;
        alu_src_a   <= `ALU_SRC_NORMAL;
        alu_src_b   <= `ALU_SRC_NORMAL;
        addr_br     <= (imm_32 >> 2) + pc;
        addr_j      <= {{`ISA_OP_W{pc[`IsaOpLoc]}}, target};
        addr_jr     <= fwd_a_data;
        
        if (inst != `DATA_W'h0) begin            
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_SLL) begin
                reg_dst         <= `REG_DST_RD;
                reg_write       <= `ENABLED;
                alu_src_a       <= `ALU_SRC_SHAMT;
                alu_op          <= `ALU_SLL;
            end else
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_SRL) begin
                reg_dst         <= `REG_DST_RD;
                reg_write       <= `ENABLED;
                alu_src_a       <= `ALU_SRC_SHAMT;
                alu_op          <= `ALU_SRL;
            end else
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_SRA) begin
                reg_dst         <= `REG_DST_RD;
                reg_write       <= `ENABLED;
                alu_src_a       <= `ALU_SRC_SHAMT;
                alu_op          <= `ALU_SRA;
            end else
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_SLLV) begin
                reg_dst         <= `REG_DST_RD;
                reg_write       <= `ENABLED;
                alu_op          <= `ALU_SLL;
            end else
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_SRLV) begin
                reg_dst         <= `REG_DST_RD;
                reg_write       <= `ENABLED;
                alu_op          <= `ALU_SRL;
            end else
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_JR) begin
                jr              <= `ENABLED;
            end else
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_ADD) begin
                reg_dst         <= `REG_DST_RD;
                reg_write       <= `ENABLED;
                alu_op          <= `ALU_ADD;
            end else
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_ADDU) begin
                reg_dst         <= `REG_DST_RD;
                reg_write       <= `ENABLED;
                alu_op          <= `ALU_ADDU;
            end else
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_SUB) begin
                reg_dst         <= `REG_DST_RD;
                reg_write       <= `ENABLED;
                alu_op          <= `ALU_SUB;
            end else
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_SUBU) begin
                reg_dst         <= `REG_DST_RD;
                reg_write       <= `ENABLED;
                alu_op          <= `ALU_SUBU;
            end else
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_AND) begin
                reg_dst         <= `REG_DST_RD;
                reg_write       <= `ENABLED;
                alu_op          <= `ALU_AND;
            end else
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_OR) begin
                reg_dst         <= `REG_DST_RD;
                reg_write       <= `ENABLED;
                alu_op          <= `ALU_OR;
            end else
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_XOR) begin
                reg_dst         <= `REG_DST_RD;
                reg_write       <= `ENABLED;
                alu_op          <= `ALU_XOR;
            end else
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_NOR) begin
                reg_dst         <= `REG_DST_RD;
                reg_write       <= `ENABLED;
                alu_op          <= `ALU_NOR;
            end else
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_SLT) begin
                reg_dst         <= `REG_DST_RD;
                reg_write       <= `ENABLED;
                alu_op          <= `ALU_SLT;
            end else
            if (op == `ISA_OP_SPECIAL && funct == `ISA_FUNCT_SLTU) begin
                reg_dst         <= `REG_DST_RD;
                reg_write       <= `ENABLED;
                alu_op          <= `ALU_SLTU;
            end else
            if (op == `ISA_OP_BLTZ) begin
                alu_src_b       <= `ALU_SRC_IMM;
                if (rt_addr == `REG_ADDR_W'h0 && $signed(fwd_a_data) < 0) begin
                    br          <= `ENABLED;
                end else if (rt_addr == `REG_ADDR_W'h1 && $signed(fwd_a_data) >= 0) begin
                    br          <= `ENABLED;
                end
            end else
            if (op == `ISA_OP_BGEZ) begin
                alu_src_b       <= `ALU_SRC_IMM;
                if ($signed(fwd_a_data) >= 0) begin
                    br          <= `ENABLED;
                end
            end else
            if (op == `ISA_OP_J) begin
                j               <= `ENABLED;
            end else
            if (op == `ISA_OP_BEQ) begin
                alu_src_b       <= `ALU_SRC_IMM;
                if ($signed(fwd_a_data) == $signed(fwd_b_data)) begin
                    br          <= `ENABLED;
                end
            end else
            if (op == `ISA_OP_BNE) begin
                alu_src_b       <= `ALU_SRC_IMM;
                if ($signed(fwd_a_data) != $signed(fwd_b_data)) begin
                    br          <= `ENABLED;
                end
            end else
            if (op == `ISA_OP_BLEZ) begin
                alu_src_b       <= `ALU_SRC_IMM;
                if ($signed(fwd_a_data) <= 0) begin
                    br          <= `ENABLED;
                end
            end else
            if (op == `ISA_OP_BGTZ) begin
                alu_src_b       <= `ALU_SRC_IMM;
                if ($signed(fwd_a_data) >= 0) begin
                    br          <= `ENABLED;
                end
            end else
            if (op == `ISA_OP_ADDI) begin
                reg_write       <= `ENABLED;
                alu_src_b       <= `ALU_SRC_IMM;
                alu_op          <= `ALU_ADD;
            end else
            if (op == `ISA_OP_ADDIU) begin
                reg_write       <= `ENABLED;
                alu_src_b       <= `ALU_SRC_IMM;
                alu_op          <= `ALU_ADDU;
            end else
            if (op == `ISA_OP_SLTI) begin
                reg_write       <= `ENABLED;
                alu_src_b       <= `ALU_SRC_IMM;
                alu_op          <= `ALU_SLT;
            end else
            if (op == `ISA_OP_SLTIU) begin
                reg_write       <= `ENABLED;
                alu_src_b       <= `ALU_SRC_IMM;
                alu_op          <= `ALU_SLTU;
            end else
            if (op == `ISA_OP_ANDI) begin
                reg_write       <= `ENABLED;
                alu_src_b       <= `ALU_SRC_IMM;
                alu_op          <= `ALU_AND;
            end else
            if (op == `ISA_OP_ORI) begin
                reg_write       <= `ENABLED;
                alu_src_b       <= `ALU_SRC_IMM;
                alu_op          <= `ALU_OR;
            end else
            if (op == `ISA_OP_XORI) begin
                reg_write       <= `ENABLED;
                alu_src_b       <= `ALU_SRC_IMM;
                alu_op          <= `ALU_XOR;
            end else
            if (op == `ISA_OP_LW) begin
                reg_write       <= `ENABLED;
                mem_read        <= `ENABLED;
                alu_src_b       <= `ALU_SRC_IMM;
                alu_op          <= `ALU_ADDU;            
            end else
            if (op == `ISA_OP_SW) begin
                mem_to_reg      <= `ENABLED;
                mem_write       <= `ENABLED;
                alu_src_b       <= `ALU_SRC_IMM;
                alu_op          <= `ALU_ADDU;
            end
        end
    end
    
endmodule
