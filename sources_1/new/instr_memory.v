`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/10/31 20:43:50
// Design Name:
// Module Name: instr_memory
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


module instr_memory(
    input [31:0]addr,
    output [31:0]instr
  );
  reg[31:0] rom[255:0];//256��ÿ��32��
  initial
  begin
 $readmemb("rom_binary_file.txt.txt", rom);
  end
  assign instr = rom[addr];
endmodule

