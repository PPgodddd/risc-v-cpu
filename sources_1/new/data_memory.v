`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/10/31 20:46:37
// Design Name:
// Module Name: data_memory
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


module data_memory(
    input clk,
    input rst_n,
    input wr_en,
    input rd_en,
    input [31:0] addr,
    input [2:0] rw_type,
    input [31:0] data_in,
    output [31:0] data_out
  );
  reg [31:0] ram[255:0];
  wire [31:0] rd_data;
  wire [31:0] wr_data_byte;
  wire [31:0] wr_data_nibble;
  wire [31:0] wr_data;
  assign rd_data = ram[addr[31:2]];
  assign wr_data_byte = (addr[1:0] == 2'b00) ? {rd_data[31:8], data_in[7:0]} :
         (addr[1:0] == 2'b01) ? {rd_data[31:16], data_in[7:0], rd_data[7:0]} :
         (addr[1:0] == 2'b10) ? {rd_data[31:24], data_in[7:0], rd_data[15:0]} :
         (addr[1:0] == 2'b11) ? {data_in[7:0], rd_data[23:0]} :
         {32{1'b0}};
  assign wr_data_nibble = (addr[1]) ? {data_in[15:0], rd_data[15:0]} : {rd_data[31:16], data_in[15:0]};
  assign wr_data = (rw_type[1:0] == 2'b00) ? wr_data_byte :
         ((rw_type[1:0] == 2'b01) ? wr_data_nibble : data_in);
  always @(posedge clk)
  begin
    if (wr_en)
      ram[addr[9:2]] <= wr_data;
  end
  wire [7:0] rd_data_byte;
  wire [15:0] rd_data_nibble;
  wire [31:0] rd_data_byte_ext;
  wire [31:0] rd_data_nibble_ext;
  assign rd_data_byte = (addr[1:0] == 2'b00) ? rd_data[7:0] :
         (addr[1:0] == 2'b01) ? rd_data[15:8] :
         (addr[1:0] == 2'b10) ? rd_data[23:16] :
         (addr[1:0] == 2'b11) ? rd_data[31:24] :
         {8{1'b0}};
  assign rd_data_nibble = (addr[1]) ? rd_data[31:16] : rd_data[15:0];
  assign rd_data_byte_ext = (rw_type[2]) ? {24'd0, rd_data_byte} : {{24{rd_data_byte[7]}}, rd_data_byte};
  assign rd_data_nibble_ext = (rw_type[2]) ? {16'd0, rd_data_nibble} : {{16{rd_data_nibble[15]}}, rd_data_nibble};
  assign data_out = (rw_type[1:0] == 2'b00) ? rd_data_byte_ext :
         ((rw_type[1:0] == 2'b01) ? rd_data_nibble_ext : rd_data);
endmodule


