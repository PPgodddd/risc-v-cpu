`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/11/01 16:50:39
// Design Name:
// Module Name: alu
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


module alu(
    input [31:0] alu_a,
    input [31:0] alu_b,
    input [3:0] alu_ctr,
    output alu_zero,
    output  [31:0] alu_result
  );
  wire al_ctr;
  wire lr_ctr;
  wire us_ctr;
  wire sa_ctr;
  assign al_ctr = alu_ctr[3];
  assign lr_ctr = alu_ctr[2];
  assign us_ctr = alu_ctr[3];
  assign sa_ctr = alu_ctr[3] | alu_ctr[1];
  barrelshifter barrelshifter(.din(alu_a),
                              .shamt(alu_b),
                              .l_r(lr_ctr),
                              .a_l(al_ctr),
                              .dout(dout));
  wire [31:0] a1,b1;
  wire add_carry,add_overflow;
  wire [31:0] add_result;
  assign a1 = alu_a;
  assign b1 = {32{ sa_ctr }} ^ alu_b;
  adder32 adder32(.a(a1),
                  .b(b1),
                  .cin(sa_ctr),
                  .add_carry(add_carry),
                  .add_overflow(add_overflow),
                  .add_zero(add_zero),
                  .add_result(add_result));
  assign alu_zero = add_zero;
  wire [31:0] slt_result;
  wire less_m1,less_m2,less_s;
  assign less_m1 = add_carry ^ sa_ctr;
  assign less_m2 = add_overflow ^ add_result[31];
  assign less_s = us_ctr ?  less_m1 :  less_m2;
  assign slt_result = {31'b0,less_s};
  assign alu_less = less_s;
  assign alu_result = (alu_ctr[2:0] == 3'b000) ? add_result :
         (alu_ctr[2:0] == 3'b001) ? dout :
         (alu_ctr[2:0] == 3'b010) ? slt_result :
         (alu_ctr[2:0] == 3'b011) ? alu_b :
         (alu_ctr[2:0] == 3'b100) ? (alu_a ^ alu_b) :
         (alu_ctr[2:0] == 3'b101) ? dout :
         (alu_ctr[2:0] == 3'b110) ? (alu_a | alu_b) :
         (alu_ctr[2:0] == 3'b111) ? (alu_a & alu_b) :
         32'b0;
endmodule
module barrelshifter(
    output reg [31:0] dout,
    input [31:0] din,
    input a_l,
    input l_r,
    input [4:0] shamt
  );
  always @(*)
  case({a_l,l_r})
    2'b00:
    begin
      dout = shamt[0] ? {1'b0, din[31:1]} : din;
      dout = shamt[1] ? {2'b0, dout[31:2]} : dout;
      dout = shamt[2] ? {4'b0, dout[31:4]} : dout;
      dout = shamt[3] ? {8'b0, dout[31:8]} : dout;
      dout = shamt[4] ? {16'b0, dout[31:16]} : dout;
    end
    2'b01:
    begin
      dout = shamt[0] ? {din[30:0], 1'b0} : din;
      dout = shamt[1] ? {dout[29:0], 2'b0} : dout;
      dout = shamt[2] ? {dout[27:0], 4'b0} : dout;
      dout = shamt[3] ? {dout[23:0], 8'b0} : dout;
      dout = shamt[4] ? {dout[15:0], 16'b0} : dout;
    end
    2'b10:
    begin
      dout = shamt[0] ? {din[31], din[31:1]} : din;
      dout = shamt[1] ? {{2{dout[31]}}, dout[31:2]} : dout;
      dout = shamt[2] ? {{4{dout[31]}}, dout[31:4]} : dout;
      dout = shamt[3] ? {{8{dout[31]}}, dout[31:8]} : dout;
      dout = shamt[4] ? {{16{dout[31]}}, dout[31:16]} : dout;
    end
    2'b11:
    begin
      dout = shamt[0] ? {din[30:0], 1'b0} : din;
      dout = shamt[1] ? {dout[29:0], 2'b0} : dout;
      dout = shamt[2] ? {dout[27:0], 4'b0} : dout;
      dout = shamt[3] ? {dout[23:0], 8'b0} : dout;
      dout = shamt[4] ? {dout[15:0], 16'b0} : dout;
    end
  endcase
endmodule
module adder32(
    input [31:0] a,
    input [31:0] b,
    input cin,
    output add_carry,
    output add_overflow,
    output add_zero,
    output [31:0] add_result
  );
  assign {add_carry, add_result} = cin ? (a + (~b+1) + cin) : (a + b + cin);
  assign add_zero = ~(|add_result);
  assign add_overflow = (a[31] == b[31]) && (add_result[31] != a[31]);
endmodule
