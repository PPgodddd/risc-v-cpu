`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/11/01 16:34:56
// Design Name:
// Module Name: register_file
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module register_file(
    input clk,
    input wr_en,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] wr_data,
    output [31:0] rd_data1,
    output [31:0] rd_data2
  );
  reg [31:0] regs [31:0];
  always@(posedge clk )
  begin
    if(wr_en & (rd != 5'b0))
      regs[rd] <= wr_data;
  end
  assign rd_data1 = (rs1 == 5'b0) ? {32'b0} : regs[rs1];
  assign rd_data2 = (rs2 == 5'b0) ? {32'b0} : regs[rs2];
endmodule



