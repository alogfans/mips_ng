`timescale 1ns / 1ps
`include "defines.v"

module regfile(
    input wire                  clk,
    input wire                  reset_,
    
    input wire                  we_,
    input wire [`RegAddrBus]    wr_addr,
    input wire [`DataBus]       wr_data,
    
    input wire [`RegAddrBus]    rd_addr_0,
    output wire [`DataBus]      rd_data_0,
    input wire [`RegAddrBus]    rd_addr_1,
    output wire [`DataBus]      rd_data_1    
);
    // Note: because r0 is hard-wired to 0, when user try to modified, nothing should be
    // changed, so gpr[0] is not existed in reality.
    reg [`DataBus]              gpr[`COUNT_REGS-1:1];
    integer i;
    
    // Read access. If the same address is ready to write new value, output
    // directly (bypassing the gpr).
    assign rd_data_0 = (rd_addr_0 == `REG_ADDR_W'h0) ? 
        `DATA_W'h0 : 
        (((we_ == `ENABLED_) && (wr_addr == rd_addr_0)) ? wr_data : gpr[rd_addr_0]);
        
    assign rd_data_1 = (rd_addr_1 == `REG_ADDR_W'h0) ? 
        `DATA_W'h0 : 
        (((we_ == `ENABLED_) && (wr_addr == rd_addr_1)) ? wr_data : gpr[rd_addr_1]);
    
    // Write data or reset all registers.
    always @(posedge clk or `RESET_EDGE reset_) begin
        if (reset_ == `ENABLED_) begin
            for (i = 1; i < `COUNT_REGS; i = i + 1) begin
                gpr[i] <= `DATA_W'h0;
            end
        end else begin
            if ((we_ == `ENABLED_) && (wr_addr != `REG_ADDR_W'h0)) begin
                gpr[wr_addr] <= wr_data;
                $display("write reg: addr %h, val %h", wr_addr, wr_data);
            end
        end
    end
endmodule
