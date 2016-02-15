`timescale 1ns / 1ps
`include "defines.v"

module alu(
    input wire [`AluOpBus]      op,
    input wire [`DataBus]       in_0,       // rs, shamt, or forwarding...
    input wire [`DataBus]       in_1,       // rt, imm, or forwarding...
    output reg [`DataBus]       out,
    output reg                  of
);
    wire signed [`DataBus]      s_in_0  = $signed(in_0);
    wire signed [`DataBus]      s_in_1  = $signed(in_1);
    wire signed [`DataBus]      s_out   = $signed(out);
    
    always @(*) begin
        case (op)
        `ALU_AND: begin
            out <= in_0 & in_1;
        end
        `ALU_OR: begin
            out <= in_0 | in_1;
        end
        `ALU_XOR: begin
            out <= in_0 ^ in_1;
        end
        `ALU_NOR: begin
            out <= ~(in_0 | in_1);
        end
        `ALU_ADD: begin
            out <= in_0 + in_1;
        end
        `ALU_ADDU: begin
            out <= in_0 + in_1;
        end
        `ALU_SUB: begin
            out <= in_0 - in_1;
        end
        `ALU_SUBU: begin
            out <= in_0 - in_1;
        end
        `ALU_SRL: begin
            out <= in_1 >> in_0;
        end
        `ALU_SLL: begin
            out <= in_1 << in_0;
        end
        `ALU_SRA: begin
            out <= in_1 >>> in_0;
        end
        `ALU_SLA: begin
            out <= in_1 <<< in_0;
        end
        `ALU_SLT: begin
            if ($signed(in_0) < $signed(in_1)) begin
                out <= `DATA_W'h1;
            end else begin
                out <= `DATA_W'h0;
            end
        end
        `ALU_SLTU: begin
            if (in_0 < in_1) begin
                out <= `DATA_W'h1;
            end else begin
                out <= `DATA_W'h0;
            end
        end
        default: begin
            out <= `DATA_W'h0;
        end
        endcase
    end
    
    always @(*) begin
        case (op)
        `ALU_ADD: begin
            if ((s_in_0 > 0) && (s_in_0 > 0) && (s_out < 0)) begin
                of <= `ENABLED;
            end else if ((s_in_0 < 0) && (s_in_0 < 0) && (s_out > 0)) begin
                of <= `ENABLED;
            end else begin
                of <= `DISABLED;
            end
        end
        `ALU_SUB: begin
            if ((s_in_0 > 0) && (s_in_0 < 0) && (s_out < 0)) begin
                of <= `ENABLED;
            end else if ((s_in_0 < 0) && (s_in_0 > 0) && (s_out > 0)) begin
                of <= `ENABLED;
            end else begin
                of <= `DISABLED;
            end
        end
        default: begin
            of <= `DISABLED;
        end       
        endcase
    end
endmodule
