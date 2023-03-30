`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2023 17:45:13
// Design Name: 
// Module Name: individual_d
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


module individual_d(
    input [15:0] sw,
    input [12:0] pixel_index,
    output reg [15:0] pixel_data = 0
    );

    localparam GREEN = 16'b00000_111111_00000;
    localparam WHITE = 16'b11111_111111_11111;
    localparam BLACK = 16'b00000_000000_00000;

    wire [6:0] x_pos;
    wire [5:0] y_pos;

    reg showGreenBorder = 0;

    assign x_pos = pixel_index % 96;
    assign y_pos = pixel_index / 96;

    assign greenBorder = (((x_pos == 56 || x_pos == 57 || x_pos == 58) && (y_pos <= 58)) || ((y_pos == 56 || y_pos == 57 || y_pos == 58) && (x_pos <= 58)));

    assign topLeft0 = (((x_pos >= 14 && x_pos <= 46) && y_pos == 3) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 4) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 5) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 6) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 7) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 8) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 9) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 9) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 10) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 10) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 11) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 11) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 12) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 12) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 13) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 13) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 14) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 14) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 15) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 15) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 16) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 16) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 17) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 17) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 18) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 18) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 19) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 19) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 20) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 20) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 21) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 21) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 22) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 22) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 23) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 23) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 24) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 24) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 25) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 25) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 26) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 26) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 27) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 27) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 28) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 28) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 29) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 29) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 30) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 30) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 31) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 31) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 32) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 32) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 33) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 33) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 34) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 34) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 35) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 35) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 36) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 36) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 37) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 37) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 38) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 38) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 39) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 39) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 40) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 40) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 41) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 41) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 42) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 43) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 44) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 45) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 46) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 47));

    assign topLeft1 = (((x_pos >= 41 && x_pos <= 46) && y_pos == 3) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 4) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 5) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 6) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 7) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 8) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 9) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 10) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 11) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 12) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 13) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 14) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 15) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 16) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 17) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 18) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 19) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 20) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 21) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 22) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 23) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 24) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 25) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 26) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 27) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 28) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 29) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 30) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 31) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 32) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 33) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 34) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 35) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 36) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 37) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 38) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 39) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 40) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 41) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 42) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 43) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 44) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 45) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 46) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 47));

    assign topLeft2 = (((x_pos >= 14 && x_pos <= 46) && y_pos == 3) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 4) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 5) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 6) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 7) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 8) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 9) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 10) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 11) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 12) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 13) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 14) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 15) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 16) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 17) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 18) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 19) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 20) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 21) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 22) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 23) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 24) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 25) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 26) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 27) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 28) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 29) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 30) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 31) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 32) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 33) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 34) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 35) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 36) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 37) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 38) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 39) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 40) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 41) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 42) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 43) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 44) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 45) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 46) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 47));

    assign topLeft3 = (((x_pos >= 14 && x_pos <= 46) && y_pos == 3) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 4) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 5) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 6) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 7) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 8) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 9) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 10) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 11) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 12) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 13) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 14) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 15) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 16) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 17) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 18) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 19) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 20) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 21) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 22) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 23) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 24) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 25) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 26) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 27) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 28) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 29) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 30) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 31) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 32) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 33) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 34) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 35) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 36) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 37) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 38) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 39) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 40) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 41) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 42) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 43) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 44) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 45) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 46) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 47));

    assign topLeft4 = (((x_pos >= 14 && x_pos <= 19) && y_pos == 3) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 3) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 4) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 4) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 5) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 5) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 6) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 6) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 7) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 7) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 8) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 8) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 9) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 9) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 10) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 10) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 11) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 11) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 12) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 12) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 13) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 13) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 14) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 14) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 15) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 15) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 16) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 16) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 17) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 17) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 18) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 18) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 19) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 19) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 20) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 20) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 21) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 21) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 22) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 23) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 24) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 25) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 26) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 27) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 28) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 29) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 30) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 31) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 32) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 33) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 34) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 35) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 36) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 37) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 38) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 39) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 40) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 41) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 42) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 43) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 44) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 45) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 46) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 47));

    assign topLeft5 = (((x_pos >= 14 && x_pos <= 46) && y_pos == 3) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 4) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 5) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 6) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 7) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 8) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 9) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 10) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 11) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 12) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 13) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 14) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 15) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 16) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 17) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 18) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 19) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 20) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 21) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 22) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 23) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 24) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 25) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 26) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 27) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 28) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 29) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 30) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 31) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 32) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 33) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 34) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 35) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 36) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 37) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 38) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 39) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 40) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 41) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 42) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 43) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 44) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 45) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 46) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 47));

    assign topLeft6 = (((x_pos >= 14 && x_pos <= 46) && y_pos == 3) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 4) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 5) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 6) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 7) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 8) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 9) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 10) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 11) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 12) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 13) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 14) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 15) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 16) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 17) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 18) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 19) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 20) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 21) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 22) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 23) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 24) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 25) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 26) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 27) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 28) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 28) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 29) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 29) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 30) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 30) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 31) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 31) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 32) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 32) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 33) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 33) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 34) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 34) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 35) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 35) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 36) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 36) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 37) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 37) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 38) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 38) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 39) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 39) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 40) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 40) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 41) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 41) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 42) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 43) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 44) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 45) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 46) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 47));

    assign topLeft7 = (((x_pos >= 14 && x_pos <= 46) && y_pos == 3) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 4) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 5) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 6) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 7) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 8) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 9) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 10) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 11) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 12) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 13) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 14) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 15) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 16) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 17) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 18) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 19) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 20) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 21) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 22) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 23) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 24) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 25) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 26) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 27) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 28) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 29) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 30) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 31) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 32) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 33) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 34) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 35) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 36) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 37) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 38) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 39) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 40) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 41) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 42) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 43) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 44) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 45) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 46) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 47));

    assign topLeft8 = (((x_pos >= 14 && x_pos <= 46) && y_pos == 3) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 4) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 5) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 6) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 7) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 8) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 9) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 9) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 10) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 10) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 11) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 11) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 12) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 12) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 13) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 13) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 14) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 14) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 15) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 15) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 16) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 16) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 17) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 17) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 18) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 18) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 19) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 19) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 20) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 20) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 21) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 21) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 22) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 23) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 24) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 25) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 26) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 27) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 28) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 28) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 29) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 29) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 30) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 30) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 31) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 31) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 32) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 32) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 33) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 33) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 34) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 34) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 35) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 35) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 36) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 36) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 37) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 37) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 38) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 38) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 39) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 39) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 40) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 40) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 41) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 41) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 42) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 43) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 44) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 45) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 46) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 47));

    assign topLeft9 = (((x_pos >= 14 && x_pos <= 46) && y_pos == 3) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 4) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 5) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 6) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 7) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 8) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 9) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 9) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 10) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 10) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 11) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 11) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 12) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 12) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 13) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 13) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 14) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 14) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 15) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 15) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 16) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 16) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 17) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 17) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 18) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 18) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 19) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 19) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 20) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 20) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 21) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 21) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 22) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 22) || ((x_pos >= 14 && x_pos <= 19) && y_pos == 23) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 23) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 24) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 25) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 26) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 27) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 28) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 29) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 30) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 31) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 32) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 33) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 34) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 35) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 36) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 37) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 38) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 39) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 40) || ((x_pos >= 41 && x_pos <= 46) && y_pos == 41) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 42) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 43) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 44) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 45) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 46) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 47));

    always @ (*) begin
        showGreenBorder = sw[0] ? 1 : 0;
    end

    always @ (*) begin
        // Individual task D
        if (showGreenBorder == 1 && greenBorder) begin
            pixel_data <= GREEN;
        end

        else if (sw[9] == 1) begin
            pixel_data <= (topLeft9) ? WHITE : BLACK;
        end
        else if (sw[8] == 1) begin
            pixel_data <= (topLeft8) ? WHITE : BLACK;
        end
        else if (sw[7] == 1) begin
            pixel_data <= (topLeft7) ? WHITE : BLACK;
        end
        else if (sw[6] == 1) begin
            pixel_data <= (topLeft6) ? WHITE : BLACK;
        end
        else if (sw[5] == 1) begin
            pixel_data <= (topLeft5) ? WHITE : BLACK;
        end
        else if (sw[4] == 1) begin
            pixel_data <= (topLeft4) ? WHITE : BLACK;
        end
        else if (sw[3] == 1) begin
            pixel_data <= (topLeft3) ? WHITE : BLACK;
        end
        else if (sw[2] == 1) begin
            pixel_data <= (topLeft2) ? WHITE : BLACK;
        end
        else if (sw[1] == 1) begin
            pixel_data <= (topLeft1) ? WHITE : BLACK;
        end
        else begin
            pixel_data <= (topLeft0) ? WHITE : BLACK;
        end
    end

endmodule
