`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/11/02 10:35:20
// Design Name:
// Module Name: cla_16
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


module cla_16(
  input [15:0] a,
  input [15:0] b,
  input cin,
  output gx, px,
  output [15:0] sum
);
  wire c4, c8, c12;
  wire pm1, gm1, pm2, gm2, pm3, gm3, pm4, gm4;
  adder_4 adder1(
    .a(a[3:0]),
    .b(b[3:0]),
    .cin(cin),
    .cout(),
    .sum(sum[3:0]),
    .gm(gm1),
    .pm(pm1)
  );
  adder_4 adder2(
    .a(a[7:4]),
    .b(b[7:4]),
    .cin(c4),
    .cout(),
    .sum(sum[7:4]),
    .gm(gm2),
    .pm(pm2)
  );
  adder_4 adder3(
    .a(a[11:8]),
    .b(b[11:8]),
    .cin(c8),
    .cout(),
    .sum(sum[11:8]),
    .gm(gm3),
    .pm(pm3)
  );
  adder_4 adder4(
    .a(a[15:12]),
    .b(b[15:12]),
    .cin(c12),
    .cout(),
    .sum(sum[15:12]),
    .gm(gm4),
    .pm(pm4)
  );
  assign c4 = gm1 ^ (pm1 & cin);
  assign c8 = gm2 ^ (pm2 & gm1) ^ (pm2 & pm1 & cin);
  assign c12 = gm3 ^ (pm3 & gm2) ^ (pm3 & pm2 & gm1) ^ (pm3 & pm2 & pm1 & cin);
  assign px = pm1 & pm2 & pm3 & pm4;
  assign gx = gm4 ^ (pm4 & gm3) ^ (pm4 & pm3 & gm2) ^ (pm4 & pm3 & pm2 & gm1);
endmodule

