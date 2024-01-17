`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/11/02 00:06:14
// Design Name:
// Module Name: mux
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


module mux(
    input [31:0]data_in1,
    input [31:0]data_in2,
    input sel,
    output  [31:0]data_out
  );
  assign data_out = sel ? data_in1 : data_in2;
endmodule
