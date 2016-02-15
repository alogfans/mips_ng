`timescale 1ns / 1ps
`include "defines.v"

module if_stage(
    input wire                  clk,
    input wire                  clk_rom,
    input wire                  reset_,
    
    input wire                  stall,
    
    input wire                  br,
    input wire                  j,
    input wire                  jr,
    
    input wire [`AddrBus]       addr_br,
    input wire [`AddrBus]       addr_j,
    input wire [`AddrBus]       addr_jr,
    
    output reg [`AddrBus]       pc,
    output reg [`DataBus]       inst,
    output reg                  en
);
    wire [`DataBus] inst_r;
    
    /* --- IP Core ---
    inst_rom inst_rom (
        .clka(clk_rom),         // input clka
        .addra(pc),             // input addra
        .douta(inst_r)          // output [31:0] douta
    );
    */
    
    // For quick validation
    reg [`DataBus] rom [1023:0];
    initial begin
        $readmemh("inst_rom.mif", rom);
    end
    assign inst_r = rom[pc];

    
    always @(posedge clk or `RESET_EDGE reset_) begin
        if (reset_ == `ENABLED_) begin
            pc <= `ADDR_W'h0;
            en <= `DISABLED;
            inst <= `DATA_W'h0;
        end else begin
            if (stall == `DISABLED) begin
                if (j == `ENABLED) begin
                    pc <= addr_j;
                    en <= `DISABLED;
                    inst <= `DATA_W'h0;
                end else if (jr == `ENABLED) begin
                    pc <= addr_jr;
                    en <= `DISABLED;
                    inst <= `DATA_W'h0;
                end else if (br == `ENABLED) begin
                    pc <= addr_br;
                    en <= `DISABLED;
                    inst <= `DATA_W'h0;
                end else begin
                    pc <= pc + 1;
                    en <= `ENABLED;
                    inst <= inst_r;
                end
            end            
        end
    end
endmodule
