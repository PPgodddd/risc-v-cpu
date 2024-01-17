`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/11/02 09:42:22
// Design Name:
// Module Name: cla_add32
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


module cla_add32(     input [31:0] a,
                        input [31:0] b,
                        input cin,
                        output [31:0] sum,
                        output c32
                  );
  wire px1,gx1,px2,gx2;
  wire c16;
  cla_16 cla1(
           .a(a[15:0]),
           .b(b[15:0]),
           .cin(),
           .sum(sum[15:0]),
           .px(px1),
           .gx(gx1)
         );
  cla_16 cla2(
           .a(a[31:16]),
           .b(b[31:16]),
           .cin(c16),
           .sum(sum[31:16]),
           .px(px2),
           .gx(gx2)
         );
  assign c16 = gx1 ^ (px1 && 0),
         c32 = gx2 ^ (px2 && c16);
endmodule


