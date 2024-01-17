`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/11/02 09:11:17
// Design Name:
// Module Name: branch_judge
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


module branch_judge(
    input beq,
    input bne,
    input blt,
    input bge,
    input bltu,
    input bgeu,
    input jal,
    input jalr,
    input alu_zero,
    input alu_result,
    output jump_flag
  );
  assign jump_flag = jal |
         jalr|
         (beq && alu_zero) |
         (bne && (!alu_zero)) |
         (blt && alu_result) |
         (bge && (!alu_result)) |
         (bltu && alu_result) |
         (bgeu && (!alu_result));
endmodule
