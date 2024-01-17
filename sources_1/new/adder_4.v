`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/11/02 10:38:08
// Design Name:
// Module Name: adder_4
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


module adder_4(
  input [3:0] a,
  input [3:0] b,
  input cin,
  output cout, gm, pm,
  output [3:0] sum
);
  wire p1, p2, p3, p4, g1, g2, g3, g4;
  wire c1, c2, c3, c4;
  adder adder1(
    .a(a[0]),
    .b(b[0]),
    .cin(cin),
    .sum(sum[0]),
    .cout(c1)
  );
  adder adder2(
    .a(a[1]),
    .b(b[1]),
    .cin(c1),
    .sum(sum[1]),
    .cout(c2)
  );
  adder adder3(
    .a(a[2]),
    .b(b[2]),
    .cin(c2),
    .sum(sum[2]),
    .cout(c3)
  );
  adder adder4(
    .a(a[3]),
    .b(b[3]),
    .cin(c3),
    .sum(sum[3]),
    .cout(c4)
  );
  cla cla(
    .cin(cin),
    .c1(c1),
    .c2(c2),
    .c3(c3),
    .c4(c4),
    .p1(p1),
    .p2(p2),
    .p3(p3),
    .p4(p4),
    .g1(g1),
    .g2(g2),
    .g3(g3),
    .g4(g4)
  );
  assign p1 = a[0] ^ b[0];
  assign p2 = a[1] ^ b[1];
  assign p3 = a[2] ^ b[2];
  assign p4 = a[3] ^ b[3];
  assign g1 = a[0] & b[0];
  assign g2 = a[1] & b[1];
  assign g3 = a[2] & b[2];
  assign g4 = a[3] & b[3];
  assign pm = p1 & p2 & p3 & p4;
  assign gm = g4 ^ (p4 & g3) ^ (p4 & p3 & g2) ^ (p4 & p3 & p2 & g1);
endmodule

