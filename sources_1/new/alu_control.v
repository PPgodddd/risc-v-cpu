`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/11/01 16:45:28
// Design Name:
// Module Name: alu_control
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

`include "orders.vh"
module alu_control(
    input [1:0] aluop,
    input [2:0] func3,
    input func7,
    output [3:0] alu_ctr
  );
  wire [3:0] branchop;
  reg [3:0] riop;
  assign branchop = (func3[2] & func3[1]) ? `sltu : (func3[2] ^ func3[1]) ? `slt : `sub;
  always @(*)
  begin
    case (func3)
      3'b000:
        if (aluop[1] & func7)
          riop = `sub;
        else
          riop = `add;
      3'b001:
        riop = `sll;
      3'b010:
        riop = `slt;
      3'b011:
        riop = `sltu;
      3'b100:
        riop = `xor;
      3'b101:
        if (func7)
          riop = `sra;
        else
          riop = `srl;
      3'b110:
        riop = `or;
      3'b111:
        riop = `and;
      default:
        riop = `add;
    endcase
  end
  assign alu_ctr = (aluop[1] ^ aluop[0]) ? riop : (aluop[1] & aluop[0]) ? branchop : `add;
endmodule



