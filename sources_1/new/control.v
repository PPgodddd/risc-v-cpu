`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/10/31 22:23:04
// Design Name:
// Module Name: control
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


module control(
    input [6:0] opcode,
    input [2:0] func3,
    input func7,
    output memread,
    output memtoreg,
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
    output [2:0] rw_type,
    output [3:0] alu_ctr
  );
  wire [1:0] aluop;
  main_control main_control_inst(
                 .opcode(opcode),
                 .func3(func3),
                 .memread(memread),
                 .memtoreg(memtoreg),
                 .aluop(aluop),
                 .memwrite(memwrite),
                 .alusrc(alusrc),
                 .regwrite(regwrite),
                 .lui(lui),
                 .u_type(u_type),
                 .jal(jal),
                 .jalr(jalr),
                 .beq(beq),
                 .bne(bne),
                 .blt(blt),
                 .bge(bge),
                 .bltu(bltu),
                 .bgeu(bgeu),
                 .rw_type(rw_type)
               );
  alu_control alu_control_inst(
                .aluop(aluop),
                .func3(func3),
                .func7(func7),
                .alu_ctr(alu_ctr)
              );
endmodule



