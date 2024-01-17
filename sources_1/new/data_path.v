`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/11/01 12:42:09
// Design Name:
// Module Name: data_path
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


module data_path(
    input 	clk,
    input   rst_n,
    input   [31:0] instr,
    input   memtoreg,
    input   alusrc,
    input   regwrite,
    input   lui,
    input   u_type,
    input   jal,
    input   jalr,
    input   beq,
    input   bne,
    input   blt,
    input   bge,
    input   bltu,
    input   bgeu,
    input   [3:0] alu_ctr,
    input [31:0] rd_mem_data,
    output  [7:0] rom_addr,
    output [31:0] wr_mem_data,
    output [31:0] alu_result,
    output [6:0] opcode,
    output [2:0] func3,
    output func7
  );
  wire [4:0] rs1;
  wire [4:0] rs2;
  wire [4:0] rd;
  wire [31:0] imme;
  wire [31:0] wr_reg_data;
  wire [31:0] rd_data1;
  wire [31:0] rd_data2;
  wire zero;
  wire [31:0] pc_order;
  wire [31:0] pc_jump;
  wire   [31:0] pc_new;
  wire [31:0] pc_out;
  wire jump_flag;
  wire [31:0] alu_db;
  wire [31:0] wb_data;
  wire reg_sel;
  wire [31:0] wr_reg_data1;
  wire [31:0] wr_reg_data2;
  wire [31:0] pc_jump_order;
  wire [31:0] pc_jalr;
  assign reg_sel = jal | jalr ;
  assign wr_mem_data = rd_data2;
  assign rom_addr = pc_out[9:2];
  assign pc_jalr = {alu_result[31:1], 1'b0};
  pc pc_inst (
       .clk(clk),
       .rst_n(rst_n),
       .pc_new(pc_new),
       .pc_out(pc_out)
     );
  instr_decode instr_decode_inst (
                 .instr(instr),
                 .opcode(opcode),
                 .func3(func3),
                 .func7(func7),
                 .rs1(rs1),
                 .rs2(rs2),
                 .rd(rd),
                 .imme(imme)
               );
  register_file register_file_inst (
                  .clk(clk),
                  .wr_en(regwrite),
                  .rs1(rs1),
                  .rs2(rs2),
                  .rd(rd),
                  .wr_data(wr_reg_data),
                  .rd_data1(rd_data1),
                  .rd_data2(rd_data2)
                );
  alu alu_inst (
        .alu_a(rd_data1),
        .alu_b(alu_b),
        .alu_ctr(alu_ctr),
        .alu_zero(zero),
        .alu_result(alu_result)
      );
  branch_judge branch_judge_inst (
                 .beq(beq),
                 .bne(bne),
                 .blt(blt),
                 .bge(bge),
                 .bltu(bltu),
                 .bgeu(bgeu),
                 .jal(jal),
                 .jalr(jalr),
                 .alu_zero(alu_zero),
                 .alu_result(alu_result),
                 .jump_flag(jump_flag)
               );
  cla_add32 pc_adder_4 (
              .a(pc_out),
              .b(32'd4),
              .cin(1'd0),
              .sum(pc_order),
              .c32()
            );
  cla_add32 pc_adder_imme (
              .a(pc_out),
              .b(imme),
              .cin(1'd0),
              .sum(pc_jump),
              .c32()
            );
  mux pc_mux (
        .data_in1(pc_jump),
        .data_in2(pc_order),
        .sel(jump_flag),
        .data_out(pc_jump_order)
      );
  mux pc_jalr_mux (
        .data_in1(pc_jalr),
        .data_in2(pc_jump_order),
        .sel(jalr),
        .data_out(pc_new)
      );
  mux alu_data_mux (
        .data_in1(imme),
        .data_in2(rd_data2),
        .sel(alusrc),
        .data_out(alu_db)
      );
  mux wb_data_mux (
        .data_in1(rd_mem_data),
        .data_in2(alu_result),
        .sel(memtoreg),
        .data_out(wb_data)
      );
  mux jalr_mux (
        .data_in1(pc_order),
        .data_in2(wb_data),
        .sel(reg_sel),
        .data_out(wr_reg_data2)
      );
  mux lui_mux (
        .data_in1(imme),
        .data_in2(pc_jump),
        .sel(lui),
        .data_out(wr_reg_data1)
      );
  mux wr_reg_mux (
        .data_in1(wr_reg_data1),
        .data_in2(wr_reg_data2),
        .sel(u_type),
        .data_out(wr_reg_data)
      );
endmodule



