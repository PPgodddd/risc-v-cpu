`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/11/02 10:44:04
// Design Name:
// Module Name: cla
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


module cla(  input cin, g1, g2, g3, g4, p1, p2, p3, p4,
output c1, c2, c3, c4);
  assign c1 = g1 ^ (p1 & cin);
  assign c2 = g2 ^ (p2 & g1) ^ (p2 & p1 & cin);
  assign c3 = g3 ^ (p3 & g2) ^ (p3 & p2 & g1) ^ (p3 & p2 & p1 & cin);
  assign c4 = g4 ^ (p4 & g3) ^ (p4 & p3 & g2) ^ (p4 & p3 & p2 & g1) ^ (p4 & p3 & p2 & p1 & cin);
endmodule

