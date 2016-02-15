`timescale 1ns / 1ps
`include "defines.v"

module mem_stage(
    input wire                  clk,
    input wire                  reset_,
    input wire                  mem_write,
    input wire [`AddrBus]       addr,
    input wire [`DataBus]       din,
    output wire [`DataBus]      dout
);
    /* --- IP Core ---
    data_ram data_ram(
        .addra(addr),
        .dina(din),
        .douta(dout),
        .wea(mem_write),
        .clka(clk),
        .rsta(reset_)
    );
    */
    
    reg [`DataBus] ram [1023:0];
    integer i;
    always @(posedge clk or `RESET_EDGE reset_) begin
        if (reset_ == `ENABLED_) begin
            $readmemh("data_ram.mif", ram);
        end else if (mem_write == `ENABLED) begin
            ram[addr] <= din;
            $display("write mem: addr %h, val %h", addr, din);
        end
    end
    
    assign dout = ram[addr];
    
endmodule
