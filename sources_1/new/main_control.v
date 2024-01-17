`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/11/01 12:40:04
// Design Name:
// Module Name: main_control
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
module main_control(
    input [6:0] opcode,
    input [2:0] func3,
    output memread,
    output memtoreg,
    output [1:0] aluop,
    output memwrite,
    output alusrc,
    output regwrite,
    output lui,
    output u_type,
    output jal,
    output jalr,
    output beq,
    output bne,
    output blt,
    output bge,
    output bltu,
    output bgeu,
    output [2:0] rw_type
  );
  wire branch;
  wire r_type;
  wire i_type;
  wire load;
  wire store;
  wire auipc;
  assign branch = (opcode == `b_type) ? 1'b1 : 1'b0;
  assign r_type = (opcode == `r_type) ? 1'b1 : 1'b0;
  assign i_type = (opcode == `i_type) ? 1'b1 : 1'b0;
  assign u_type = (lui | auipc) ? 1'b1 : 1'b0;
  assign load = (opcode == `load) ? 1'b1 : 1'b0;
  assign store = (opcode == `store) ? 1'b1 : 1'b0;
  assign jal = (opcode == `jal) ? 1'b1 : 1'b0;
  assign jalr = (opcode == `jalr) ? 1'b1 : 1'b0;
  assign lui = (opcode == `lui) ? 1'b1 : 1'b0;
  assign auipc = (opcode == `auipc) ? 1'b1 : 1'b0;
  assign beq = branch & (func3 == 3'b000);
  assign bne = branch & (func3 == 3'b001);
  assign blt = branch & (func3 == 3'b100);
  assign bge = branch & (func3 == 3'b101);
  assign bltu = branch & (func3 == 3'b110);
  assign bgeu = branch & (func3 == 3'b111);
  assign rw_type = func3;
  assign memread = load;
  assign memwrite = store;
  assign regwrite = jal | jalr | load | i_type | r_type | u_type;
  assign alusrc = load | store | i_type | jalr;
  assign memtoreg = load;
  assign aluop[1] = r_type | branch;
  assign aluop[0] = i_type | branch;
endmodule


