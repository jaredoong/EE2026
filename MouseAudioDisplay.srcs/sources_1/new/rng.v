`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2023 18:27:28
// Design Name: 
// Module Name: rng
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


module rng(
  input clk,
  output reg [5:0] rand_num
);

  // Define LCG parameters
  parameter integer a = 1664525;
  parameter integer c = 1013904223;
  parameter integer m = 65536; // 2^16
  
  // Define internal state
  reg [15:0] state = 1;

  // Generate random number
  always @ (posedge clk) begin
    state <= (a * state + c) % m;
    rand_num <= (state % 36) + 1; // Scale to range [1, 36]
  end

endmodule
