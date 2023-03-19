`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2023 01:25:13
// Design Name: 
// Module Name: start_menu
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


module start_menu(
    input basys3_clock,
    input [12:0] pixel_index,
    output reg [15:0] pixel_data = 0
    );

    localparam WHITE = 16'b11111_111111_11111;
    localparam BLACK = 16'b00000_000000_00000;

    wire [6:0] x_pos;
    wire [5:0] y_pos;

    assign x_pos = pixel_index % 96;
    assign y_pos = pixel_index / 96;

    assign UI = (((x_pos >= 1 && x_pos <= 17) && y_pos == 3) || ((x_pos >= 20 && x_pos <= 36) && y_pos == 3) || ((x_pos >= 39 && x_pos <= 55) && y_pos == 3) || ((x_pos >= 58 && x_pos <= 74) && y_pos == 3) || ((x_pos >= 77 && x_pos <= 93) && y_pos == 3) || ((x_pos >= 1 && x_pos <= 17) && y_pos == 4) || ((x_pos >= 20 && x_pos <= 36) && y_pos == 4) || ((x_pos >= 39 && x_pos <= 55) && y_pos == 4) || ((x_pos >= 58 && x_pos <= 74) && y_pos == 4) || ((x_pos >= 77 && x_pos <= 93) && y_pos == 4) || (x_pos == 1 && y_pos == 5) || (x_pos == 16 && y_pos == 5) || (x_pos == 20 && y_pos == 5) || (x_pos == 35 && y_pos == 5) || (x_pos == 39 && y_pos == 5) || (x_pos == 54 && y_pos == 5) || (x_pos == 58 && y_pos == 5) || (x_pos == 73 && y_pos == 5) || (x_pos == 77 && y_pos == 5) || (x_pos == 92 && y_pos == 5) || (x_pos == 1 && y_pos == 6) || (x_pos == 16 && y_pos == 6) || (x_pos == 20 && y_pos == 6) || (x_pos == 35 && y_pos == 6) || (x_pos == 39 && y_pos == 6) || (x_pos == 54 && y_pos == 6) || (x_pos == 58 && y_pos == 6) || (x_pos == 73 && y_pos == 6) || (x_pos == 77 && y_pos == 6) || (x_pos == 92 && y_pos == 6) || (x_pos == 1 && y_pos == 7) || ((x_pos >= 8 && x_pos <= 10) && y_pos == 7) || (x_pos == 16 && y_pos == 7) || (x_pos == 20 && y_pos == 7) || ((x_pos >= 24 && x_pos <= 31) && y_pos == 7) || (x_pos == 35 && y_pos == 7) || (x_pos == 39 && y_pos == 7) || ((x_pos >= 44 && x_pos <= 50) && y_pos == 7) || (x_pos == 54 && y_pos == 7) || (x_pos == 58 && y_pos == 7) || ((x_pos >= 62 && x_pos <= 68) && y_pos == 7) || (x_pos == 73 && y_pos == 7) || (x_pos == 77 && y_pos == 7) || ((x_pos >= 81 && x_pos <= 89) && y_pos == 7) || (x_pos == 92 && y_pos == 7) || (x_pos == 1 && y_pos == 8) || (x_pos == 7 && y_pos == 8) || (x_pos == 11 && y_pos == 8) || (x_pos == 16 && y_pos == 8) || (x_pos == 20 && y_pos == 8) || (x_pos == 24 && y_pos == 8) || (x_pos == 32 && y_pos == 8) || (x_pos == 35 && y_pos == 8) || (x_pos == 39 && y_pos == 8) || (x_pos == 43 && y_pos == 8) || (x_pos == 51 && y_pos == 8) || (x_pos == 54 && y_pos == 8) || (x_pos == 58 && y_pos == 8) || (x_pos == 62 && y_pos == 8) || (x_pos == 69 && y_pos == 8) || (x_pos == 73 && y_pos == 8) || (x_pos == 77 && y_pos == 8) || (x_pos == 81 && y_pos == 8) || (x_pos == 92 && y_pos == 8) || (x_pos == 1 && y_pos == 9) || (x_pos == 6 && y_pos == 9) || (x_pos == 12 && y_pos == 9) || (x_pos == 16 && y_pos == 9) || (x_pos == 20 && y_pos == 9) || (x_pos == 24 && y_pos == 9) || (x_pos == 32 && y_pos == 9) || (x_pos == 35 && y_pos == 9) || (x_pos == 39 && y_pos == 9) || (x_pos == 43 && y_pos == 9) || (x_pos == 54 && y_pos == 9) || (x_pos == 58 && y_pos == 9) || (x_pos == 62 && y_pos == 9) || (x_pos == 70 && y_pos == 9) || (x_pos == 73 && y_pos == 9) || (x_pos == 77 && y_pos == 9) || (x_pos == 81 && y_pos == 9) || (x_pos == 92 && y_pos == 9) || (x_pos == 1 && y_pos == 10) || (x_pos == 5 && y_pos == 10) || (x_pos == 13 && y_pos == 10) || (x_pos == 16 && y_pos == 10) || (x_pos == 20 && y_pos == 10) || (x_pos == 24 && y_pos == 10) || (x_pos == 32 && y_pos == 10) || (x_pos == 35 && y_pos == 10) || (x_pos == 39 && y_pos == 10) || (x_pos == 43 && y_pos == 10) || (x_pos == 54 && y_pos == 10) || (x_pos == 58 && y_pos == 10) || (x_pos == 62 && y_pos == 10) || (x_pos == 70 && y_pos == 10) || (x_pos == 73 && y_pos == 10) || (x_pos == 77 && y_pos == 10) || (x_pos == 81 && y_pos == 10) || (x_pos == 92 && y_pos == 10) || (x_pos == 1 && y_pos == 11) || (x_pos == 5 && y_pos == 11) || (x_pos == 13 && y_pos == 11) || (x_pos == 16 && y_pos == 11) || (x_pos == 20 && y_pos == 11) || ((x_pos >= 24 && x_pos <= 31) && y_pos == 11) || (x_pos == 35 && y_pos == 11) || (x_pos == 39 && y_pos == 11) || (x_pos == 43 && y_pos == 11) || (x_pos == 54 && y_pos == 11) || (x_pos == 58 && y_pos == 11) || (x_pos == 62 && y_pos == 11) || (x_pos == 70 && y_pos == 11) || (x_pos == 73 && y_pos == 11) || (x_pos == 77 && y_pos == 11) || (x_pos == 81 && y_pos == 11) || (x_pos == 92 && y_pos == 11) || (x_pos == 1 && y_pos == 12) || ((x_pos >= 5 && x_pos <= 13) && y_pos == 12) || (x_pos == 16 && y_pos == 12) || (x_pos == 20 && y_pos == 12) || (x_pos == 24 && y_pos == 12) || (x_pos == 32 && y_pos == 12) || (x_pos == 35 && y_pos == 12) || (x_pos == 39 && y_pos == 12) || (x_pos == 43 && y_pos == 12) || (x_pos == 54 && y_pos == 12) || (x_pos == 58 && y_pos == 12) || (x_pos == 62 && y_pos == 12) || (x_pos == 70 && y_pos == 12) || (x_pos == 73 && y_pos == 12) || (x_pos == 77 && y_pos == 12) || (x_pos == 81 && y_pos == 12) || ((x_pos >= 87 && x_pos <= 89) && y_pos == 12) || (x_pos == 92 && y_pos == 12) || (x_pos == 1 && y_pos == 13) || (x_pos == 5 && y_pos == 13) || (x_pos == 13 && y_pos == 13) || (x_pos == 16 && y_pos == 13) || (x_pos == 20 && y_pos == 13) || (x_pos == 24 && y_pos == 13) || (x_pos == 32 && y_pos == 13) || (x_pos == 35 && y_pos == 13) || (x_pos == 39 && y_pos == 13) || (x_pos == 43 && y_pos == 13) || (x_pos == 54 && y_pos == 13) || (x_pos == 58 && y_pos == 13) || (x_pos == 62 && y_pos == 13) || (x_pos == 70 && y_pos == 13) || (x_pos == 73 && y_pos == 13) || (x_pos == 77 && y_pos == 13) || (x_pos == 81 && y_pos == 13) || (x_pos == 89 && y_pos == 13) || (x_pos == 92 && y_pos == 13) || (x_pos == 1 && y_pos == 14) || (x_pos == 5 && y_pos == 14) || (x_pos == 13 && y_pos == 14) || (x_pos == 16 && y_pos == 14) || (x_pos == 20 && y_pos == 14) || (x_pos == 24 && y_pos == 14) || (x_pos == 32 && y_pos == 14) || (x_pos == 35 && y_pos == 14) || (x_pos == 39 && y_pos == 14) || (x_pos == 43 && y_pos == 14) || (x_pos == 51 && y_pos == 14) || (x_pos == 54 && y_pos == 14) || (x_pos == 58 && y_pos == 14) || (x_pos == 62 && y_pos == 14) || (x_pos == 69 && y_pos == 14) || (x_pos == 73 && y_pos == 14) || (x_pos == 77 && y_pos == 14) || (x_pos == 81 && y_pos == 14) || (x_pos == 89 && y_pos == 14) || (x_pos == 92 && y_pos == 14) || (x_pos == 1 && y_pos == 15) || (x_pos == 5 && y_pos == 15) || (x_pos == 13 && y_pos == 15) || (x_pos == 16 && y_pos == 15) || (x_pos == 20 && y_pos == 15) || ((x_pos >= 24 && x_pos <= 31) && y_pos == 15) || (x_pos == 35 && y_pos == 15) || (x_pos == 39 && y_pos == 15) || ((x_pos >= 44 && x_pos <= 50) && y_pos == 15) || (x_pos == 54 && y_pos == 15) || (x_pos == 58 && y_pos == 15) || ((x_pos >= 62 && x_pos <= 68) && y_pos == 15) || (x_pos == 73 && y_pos == 15) || (x_pos == 77 && y_pos == 15) || ((x_pos >= 81 && x_pos <= 89) && y_pos == 15) || (x_pos == 92 && y_pos == 15) || (x_pos == 1 && y_pos == 16) || (x_pos == 16 && y_pos == 16) || (x_pos == 20 && y_pos == 16) || (x_pos == 35 && y_pos == 16) || (x_pos == 39 && y_pos == 16) || (x_pos == 54 && y_pos == 16) || (x_pos == 58 && y_pos == 16) || (x_pos == 73 && y_pos == 16) || (x_pos == 77 && y_pos == 16) || (x_pos == 92 && y_pos == 16) || (x_pos == 1 && y_pos == 17) || (x_pos == 16 && y_pos == 17) || (x_pos == 20 && y_pos == 17) || (x_pos == 35 && y_pos == 17) || (x_pos == 39 && y_pos == 17) || (x_pos == 54 && y_pos == 17) || (x_pos == 58 && y_pos == 17) || (x_pos == 73 && y_pos == 17) || (x_pos == 77 && y_pos == 17) || (x_pos == 92 && y_pos == 17) || ((x_pos >= 1 && x_pos <= 17) && y_pos == 18) || ((x_pos >= 20 && x_pos <= 36) && y_pos == 18) || ((x_pos >= 39 && x_pos <= 55) && y_pos == 18) || ((x_pos >= 58 && x_pos <= 74) && y_pos == 18) || ((x_pos >= 77 && x_pos <= 93) && y_pos == 18) || ((x_pos >= 1 && x_pos <= 17) && y_pos == 19) || ((x_pos >= 20 && x_pos <= 36) && y_pos == 19) || ((x_pos >= 39 && x_pos <= 55) && y_pos == 19) || ((x_pos >= 58 && x_pos <= 74) && y_pos == 19) || ((x_pos >= 77 && x_pos <= 93) && y_pos == 19));

    always @ (posedge basys3_clock) begin
        pixel_data <= UI ? WHITE : BLACK;
    end
endmodule
