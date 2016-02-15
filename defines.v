// General
`define RESET_EDGE              negedge
`define ENABLED_                0
`define DISABLED_               1
`define ENABLED                 1
`define DISABLED                0

// Regfiles
`define RegAddrBus              4:0
`define REG_ADDR_W              5
`define COUNT_REGS              32

// Properties
`define AddrBus                 31:0
`define ADDR_W                  32
`define DataBus                 31:0
`define DATA_W                  32
`define ShamtBus                4:0
`define SHAMT_W                 5
`define IsaOpBus                5:0
`define ISA_OP_W                6
`define IsaFunctBus             5:0
`define ISA_FUNCT_W             6
`define IsaTargetBus            25:0
`define ISA_TARGET_W            26
`define IsaImmBus               15:0
`define ISA_IMM_W               16

`define IsaOpLoc                31:26
`define IsaRsAddrLoc            25:21
`define IsaRtAddrLoc            20:16
`define IsaRdAddrLoc            15:11
`define IsaShamtLoc             10:6
`define IsaFunctLoc             5:0
`define IsaTargetLoc            25:0
`define IsaImmLoc               15:0

`define REG_DST_RT              0
`define REG_DST_RD              1

`define ALU_SRC_NORMAL          0
`define ALU_SRC_SHAMT           1
`define ALU_SRC_IMM             1

// ISA
`define ISA_OP_SPECIAL          6'b000000
`define ISA_OP_BLTZ             6'b000001
`define ISA_OP_BGEZ             6'b000001
`define ISA_OP_J                6'b000010
`define ISA_OP_BEQ              6'b000100
`define ISA_OP_BNE              6'b000101
`define ISA_OP_BLEZ             6'b000110
`define ISA_OP_BGTZ             6'b000111
`define ISA_OP_ADDI             6'b001000
`define ISA_OP_ADDIU            6'b001001
`define ISA_OP_SLTI             6'b001010
`define ISA_OP_SLTIU            6'b001011
`define ISA_OP_ANDI             6'b001100
`define ISA_OP_ORI              6'b001101
`define ISA_OP_XORI             6'b001110
`define ISA_OP_LW               6'b100011
`define ISA_OP_SW               6'b101011

`define ISA_FUNCT_SLL           6'b000000
`define ISA_FUNCT_SRL           6'b000010
`define ISA_FUNCT_SRA           6'b000011
`define ISA_FUNCT_SLLV          6'b000100
`define ISA_FUNCT_SRLV          6'b000110
`define ISA_FUNCT_JR            6'b001000
`define ISA_FUNCT_ADD           6'b100000
`define ISA_FUNCT_ADDU          6'b100001
`define ISA_FUNCT_SUB           6'b100010
`define ISA_FUNCT_SUBU          6'b100011
`define ISA_FUNCT_AND           6'b100100
`define ISA_FUNCT_OR            6'b100101
`define ISA_FUNCT_XOR           6'b100110
`define ISA_FUNCT_NOR           6'b100111
`define ISA_FUNCT_SLT           6'b101010
`define ISA_FUNCT_SLTU          6'b101011

// ALU
`define AluOpBus                4:0
`define ALU_OP_W                5
`define ALU_NOP                 5'h0
`define ALU_AND                 5'h1
`define ALU_OR                  5'h2
`define ALU_XOR                 5'h3
`define ALU_NOR                 5'h4
`define ALU_ADD                 5'h5
`define ALU_ADDU                5'h6
`define ALU_SUB                 5'h7
`define ALU_SUBU                5'h8
`define ALU_SRL                 5'h9
`define ALU_SLL                 5'ha
`define ALU_SRA                 5'hb
`define ALU_SLA                 5'hc
`define ALU_SLT                 5'hd
`define ALU_SLTU                5'he

// Others
`define FwdBus                  1:0
`define FWD_W                   2
`define FWD_NO                  2'h0
`define FWD_WB                  2'h1
`define FWD_MEM                 2'h2
