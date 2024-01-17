`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/10/31 20:30:43
// Design Name:
// Module Name: cpu
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


module cpu(
    input clk,
    input rst_n,
    output [7:0]rom_addr
  );
  wire [31:0]ram_addr;
  wire [31:0]instr;
  wire [31:0]rd_mem_data;
  wire [31:0]wr_mem_data;
  wire wr_en;
  wire rd_en;
  wire [2:0]rw_type;
  instr_memory instr_memory_inst (
                 .addr(rom_addr),
                 .instr(instr)
               );
  risc_v risc_v_inst (
           .clk(clk),
           .rst_n(rst_n),
           .instr(instr),
           .rd_mem_data(rd_mem_data),
           .rom_addr(rom_addr),
           .wr_mem_data(wr_mem_data),
           .wr_en(wr_en),
           .rd_en(rd_en),
           .ram_addr(ram_addr),
           .rw_type(rw_type)
         );
  data_memory data_memory_inst (
                .clk(clk),
                .rst_n(rst_n),
                .wr_en(wr_en),
                .rd_en(rd_en),
                .addr(ram_addr),
                .rw_type(rw_type),
                .data_in(wr_mem_data),
                .data_out(rd_mem_data)
              );
endmodule



