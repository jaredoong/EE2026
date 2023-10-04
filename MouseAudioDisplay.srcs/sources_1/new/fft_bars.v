`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2023 18:02:11
// Design Name: 
// Module Name: fft_bars
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


module fft_bars(
    input basys3_clock,
    input sampling_rate,
    input [11:0] curr_Audio,
    input [15:0] sw,
    input left_click,
    input right_click,
    input [6:0] cursor_x,
    input [6:0] cursor_y,
    input [6:0] diff_x,
    input [6:0] diff_y,
    input [3:0] cursor_size,
    input [12:0] pixel_index,
    output reg [11:0] audio_out,
    output reg [15:0] pixel_data
    );

    localparam WHITE = 16'b11111_111111_11111;
    localparam BLACK = 16'b00000_000000_00000;
    localparam RED = 16'b11111_000000_00000;
    localparam GREEN = 16'b00000_111111_00000;
    localparam BLUE = 16'b00000_000000_11111;
    localparam YELLOW = 16'hFFE0;
    localparam CYAN = 16'h07FF;

    wire mouse_pos;
    // For displaying mouse
    assign mouse_pos = (diff_x < cursor_size) && (diff_y < cursor_size);

    // OLED pixel index
    wire [6:0] x_pos;
    wire [5:0] y_pos;
    assign x_pos = pixel_index % 96;
    assign y_pos = pixel_index / 96;

    // For  displaying of bars
    assign bar_info_border_only = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar_border_area = (y_pos <= 10);

    assign bar1hover = (((cursor_x >= 8) && (cursor_x <= 10)) && (cursor_y >= spectrogram[0*6 +:6]));
    assign bar2hover = (((cursor_x >= 12) && (cursor_x <= 14)) && (cursor_y >= spectrogram[1*6 +:6]));
    assign bar3hover = (((cursor_x >= 16) && (cursor_x <= 18)) && (cursor_y >= spectrogram[2*6 +:6]));
    assign bar4hover = (((cursor_x >= 20) && (cursor_x <= 22)) && (cursor_y >= spectrogram[3*6 +:6]));
    assign bar5hover = (((cursor_x >= 24) && (cursor_x <= 26)) && (cursor_y >= spectrogram[4*6 +:6]));
    assign bar6hover = (((cursor_x >= 28) && (cursor_x <= 30)) && (cursor_y >= spectrogram[5*6 +:6]));
    assign bar7hover = (((cursor_x >= 32) && (cursor_x <= 34)) && (cursor_y >= spectrogram[6*6 +:6]));
    assign bar8hover = (((cursor_x >= 36) && (cursor_x <= 38)) && (cursor_y >= spectrogram[7*6 +:6]));
    assign bar9hover = (((cursor_x >= 40) && (cursor_x <= 42)) && (cursor_y >= spectrogram[8*6 +:6]));
    assign bar10hover = (((cursor_x >= 44) && (cursor_x <= 46)) && (cursor_y >= spectrogram[9*6 +:6]));
    assign bar11hover = (((cursor_x >= 48) && (cursor_x <= 50)) && (cursor_y >= spectrogram[10*6 +:6]));
    assign bar12hover = (((cursor_x >= 52) && (cursor_x <= 54)) && (cursor_y >= spectrogram[11*6 +:6]));
    assign bar13hover = (((cursor_x >= 56) && (cursor_x <= 58)) && (cursor_y >= spectrogram[12*6 +:6]));
    assign bar14hover = (((cursor_x >= 60) && (cursor_x <= 62)) && (cursor_y >= spectrogram[13*6 +:6]));
    assign bar15hover = (((cursor_x >= 64) && (cursor_x <= 66)) && (cursor_y >= spectrogram[14*6 +:6]));
    assign bar16hover = (((cursor_x >= 68) && (cursor_x <= 70)) && (cursor_y >= spectrogram[15*6 +:6]));
    assign bar17hover = (((cursor_x >= 72) && (cursor_x <= 74)) && (cursor_y >= spectrogram[16*6 +:6]));
    assign bar18hover = (((cursor_x >= 76) && (cursor_x <= 78)) && (cursor_y >= spectrogram[17*6 +:6]));
    assign bar19hover = (((cursor_x >= 80) && (cursor_x <= 82)) && (cursor_y >= spectrogram[18*6 +:6]));
    assign bar20hover = (((cursor_x >= 84) && (cursor_x <= 86)) && (cursor_y >= spectrogram[19*6 +:6]));

    assign bar1_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || (x_pos == 21 && y_pos == 3) || (x_pos == 27 && y_pos == 3) || (x_pos == 33 && y_pos == 3) || (x_pos == 39 && y_pos == 3) || (x_pos == 52 && y_pos == 3) || (x_pos == 57 && y_pos == 3) || (x_pos == 61 && y_pos == 3) || ((x_pos >= 64 && x_pos <= 68) && y_pos == 3) || ((x_pos >= 71 && x_pos <= 75) && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 20 && y_pos == 4) || (x_pos == 23 && y_pos == 4) || (x_pos == 26 && y_pos == 4) || (x_pos == 29 && y_pos == 4) || (x_pos == 32 && y_pos == 4) || (x_pos == 35 && y_pos == 4) || (x_pos == 38 && y_pos == 4) || (x_pos == 41 && y_pos == 4) || (x_pos == 51 && y_pos == 4) || (x_pos == 54 && y_pos == 4) || (x_pos == 57 && y_pos == 4) || (x_pos == 61 && y_pos == 4) || (x_pos == 64 && y_pos == 4) || (x_pos == 68 && y_pos == 4) || (x_pos == 71 && y_pos == 4) || (x_pos == 75 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || (x_pos == 20 && y_pos == 5) || (x_pos == 23 && y_pos == 5) || (x_pos == 26 && y_pos == 5) || (x_pos == 29 && y_pos == 5) || (x_pos == 32 && y_pos == 5) || (x_pos == 35 && y_pos == 5) || (x_pos == 38 && y_pos == 5) || (x_pos == 41 && y_pos == 5) || ((x_pos >= 45 && x_pos <= 47) && y_pos == 5) || (x_pos == 51 && y_pos == 5) || (x_pos == 54 && y_pos == 5) || ((x_pos >= 57 && x_pos <= 61) && y_pos == 5) || ((x_pos >= 65 && x_pos <= 67) && y_pos == 5) || ((x_pos >= 72 && x_pos <= 74) && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 20 && y_pos == 6) || (x_pos == 23 && y_pos == 6) || (x_pos == 26 && y_pos == 6) || (x_pos == 29 && y_pos == 6) || (x_pos == 32 && y_pos == 6) || (x_pos == 35 && y_pos == 6) || (x_pos == 38 && y_pos == 6) || (x_pos == 41 && y_pos == 6) || (x_pos == 51 && y_pos == 6) || (x_pos == 54 && y_pos == 6) || (x_pos == 61 && y_pos == 6) || (x_pos == 64 && y_pos == 6) || (x_pos == 68 && y_pos == 6) || (x_pos == 71 && y_pos == 6) || (x_pos == 75 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || (x_pos == 21 && y_pos == 7) || (x_pos == 27 && y_pos == 7) || (x_pos == 33 && y_pos == 7) || (x_pos == 39 && y_pos == 7) || (x_pos == 52 && y_pos == 7) || (x_pos == 61 && y_pos == 7) || ((x_pos >= 64 && x_pos <= 68) && y_pos == 7) || ((x_pos >= 71 && x_pos <= 75) && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar2_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || (x_pos == 18 && y_pos == 3) || (x_pos == 23 && y_pos == 3) || (x_pos == 27 && y_pos == 3) || ((x_pos >= 30 && x_pos <= 34) && y_pos == 3) || ((x_pos >= 37 && x_pos <= 41) && y_pos == 3) || (x_pos == 52 && y_pos == 3) || ((x_pos >= 57 && x_pos <= 61) && y_pos == 3) || ((x_pos >= 63 && x_pos <= 67) && y_pos == 3) || ((x_pos >= 70 && x_pos <= 74) && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 17 && y_pos == 4) || (x_pos == 20 && y_pos == 4) || (x_pos == 23 && y_pos == 4) || (x_pos == 27 && y_pos == 4) || (x_pos == 30 && y_pos == 4) || (x_pos == 34 && y_pos == 4) || (x_pos == 37 && y_pos == 4) || (x_pos == 41 && y_pos == 4) || (x_pos == 51 && y_pos == 4) || (x_pos == 54 && y_pos == 4) || (x_pos == 57 && y_pos == 4) || (x_pos == 61 && y_pos == 4) || (x_pos == 67 && y_pos == 4) || (x_pos == 70 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || (x_pos == 17 && y_pos == 5) || (x_pos == 20 && y_pos == 5) || ((x_pos >= 23 && x_pos <= 27) && y_pos == 5) || ((x_pos >= 31 && x_pos <= 33) && y_pos == 5) || ((x_pos >= 38 && x_pos <= 40) && y_pos == 5) || ((x_pos >= 45 && x_pos <= 47) && y_pos == 5) || (x_pos == 51 && y_pos == 5) || (x_pos == 54 && y_pos == 5) || ((x_pos >= 57 && x_pos <= 61) && y_pos == 5) || (x_pos == 66 && y_pos == 5) || ((x_pos >= 70 && x_pos <= 74) && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 17 && y_pos == 6) || (x_pos == 20 && y_pos == 6) || (x_pos == 27 && y_pos == 6) || (x_pos == 30 && y_pos == 6) || (x_pos == 34 && y_pos == 6) || (x_pos == 37 && y_pos == 6) || (x_pos == 41 && y_pos == 6) || (x_pos == 51 && y_pos == 6) || (x_pos == 54 && y_pos == 6) || (x_pos == 61 && y_pos == 6) || (x_pos == 65 && y_pos == 6) || (x_pos == 70 && y_pos == 6) || (x_pos == 74 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || (x_pos == 18 && y_pos == 7) || (x_pos == 27 && y_pos == 7) || ((x_pos >= 30 && x_pos <= 34) && y_pos == 7) || ((x_pos >= 37 && x_pos <= 41) && y_pos == 7) || (x_pos == 52 && y_pos == 7) || ((x_pos >= 57 && x_pos <= 61) && y_pos == 7) || (x_pos == 64 && y_pos == 7) || ((x_pos >= 70 && x_pos <= 74) && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar3_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || (x_pos == 21 && y_pos == 3) || ((x_pos >= 26 && x_pos <= 30) && y_pos == 3) || ((x_pos >= 33 && x_pos <= 37) && y_pos == 3) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 3) || (x_pos == 53 && y_pos == 3) || (x_pos == 57 && y_pos == 3) || (x_pos == 61 && y_pos == 3) || ((x_pos >= 64 && x_pos <= 68) && y_pos == 3) || (x_pos == 71 && y_pos == 3) || (x_pos == 75 && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 20 && y_pos == 4) || (x_pos == 23 && y_pos == 4) || (x_pos == 26 && y_pos == 4) || (x_pos == 30 && y_pos == 4) || (x_pos == 37 && y_pos == 4) || (x_pos == 40 && y_pos == 4) || (x_pos == 54 && y_pos == 4) || (x_pos == 57 && y_pos == 4) || (x_pos == 61 && y_pos == 4) || (x_pos == 64 && y_pos == 4) || (x_pos == 71 && y_pos == 4) || (x_pos == 75 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || (x_pos == 20 && y_pos == 5) || (x_pos == 23 && y_pos == 5) || ((x_pos >= 26 && x_pos <= 30) && y_pos == 5) || (x_pos == 36 && y_pos == 5) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || (x_pos == 54 && y_pos == 5) || ((x_pos >= 57 && x_pos <= 61) && y_pos == 5) || ((x_pos >= 64 && x_pos <= 68) && y_pos == 5) || ((x_pos >= 71 && x_pos <= 75) && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 20 && y_pos == 6) || (x_pos == 23 && y_pos == 6) || (x_pos == 30 && y_pos == 6) || (x_pos == 35 && y_pos == 6) || (x_pos == 40 && y_pos == 6) || (x_pos == 44 && y_pos == 6) || (x_pos == 54 && y_pos == 6) || (x_pos == 61 && y_pos == 6) || (x_pos == 64 && y_pos == 6) || (x_pos == 68 && y_pos == 6) || (x_pos == 75 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || (x_pos == 21 && y_pos == 7) || ((x_pos >= 26 && x_pos <= 30) && y_pos == 7) || (x_pos == 34 && y_pos == 7) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 7) || (x_pos == 54 && y_pos == 7) || (x_pos == 61 && y_pos == 7) || ((x_pos >= 64 && x_pos <= 68) && y_pos == 7) || (x_pos == 75 && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar4_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || (x_pos == 22 && y_pos == 3) || (x_pos == 26 && y_pos == 3) || (x_pos == 30 && y_pos == 3) || ((x_pos >= 33 && x_pos <= 37) && y_pos == 3) || (x_pos == 40 && y_pos == 3) || (x_pos == 44 && y_pos == 3) || (x_pos == 53 && y_pos == 3) || ((x_pos >= 57 && x_pos <= 61) && y_pos == 3) || ((x_pos >= 65 && x_pos <= 68) && y_pos == 3) || ((x_pos >= 71 && x_pos <= 75) && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 23 && y_pos == 4) || (x_pos == 26 && y_pos == 4) || (x_pos == 30 && y_pos == 4) || (x_pos == 33 && y_pos == 4) || (x_pos == 40 && y_pos == 4) || (x_pos == 44 && y_pos == 4) || (x_pos == 54 && y_pos == 4) || (x_pos == 57 && y_pos == 4) || (x_pos == 61 && y_pos == 4) || (x_pos == 64 && y_pos == 4) || (x_pos == 75 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || (x_pos == 23 && y_pos == 5) || ((x_pos >= 26 && x_pos <= 30) && y_pos == 5) || ((x_pos >= 33 && x_pos <= 37) && y_pos == 5) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || (x_pos == 54 && y_pos == 5) || ((x_pos >= 57 && x_pos <= 61) && y_pos == 5) || ((x_pos >= 64 && x_pos <= 68) && y_pos == 5) || ((x_pos >= 72 && x_pos <= 75) && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 23 && y_pos == 6) || (x_pos == 30 && y_pos == 6) || (x_pos == 33 && y_pos == 6) || (x_pos == 37 && y_pos == 6) || (x_pos == 44 && y_pos == 6) || (x_pos == 54 && y_pos == 6) || (x_pos == 61 && y_pos == 6) || (x_pos == 68 && y_pos == 6) || (x_pos == 75 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || (x_pos == 23 && y_pos == 7) || (x_pos == 30 && y_pos == 7) || ((x_pos >= 33 && x_pos <= 37) && y_pos == 7) || (x_pos == 44 && y_pos == 7) || (x_pos == 54 && y_pos == 7) || ((x_pos >= 57 && x_pos <= 61) && y_pos == 7) || ((x_pos >= 64 && x_pos <= 68) && y_pos == 7) || ((x_pos >= 71 && x_pos <= 75) && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar5_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || (x_pos == 22 && y_pos == 3) || ((x_pos >= 26 && x_pos <= 30) && y_pos == 3) || ((x_pos >= 34 && x_pos <= 37) && y_pos == 3) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 3) || (x_pos == 54 && y_pos == 3) || (x_pos == 59 && y_pos == 3) || (x_pos == 63 && y_pos == 3) || (x_pos == 66 && y_pos == 3) || (x_pos == 70 && y_pos == 3) || (x_pos == 73 && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 23 && y_pos == 4) || (x_pos == 26 && y_pos == 4) || (x_pos == 30 && y_pos == 4) || (x_pos == 33 && y_pos == 4) || (x_pos == 44 && y_pos == 4) || (x_pos == 53 && y_pos == 4) || (x_pos == 56 && y_pos == 4) || (x_pos == 59 && y_pos == 4) || (x_pos == 63 && y_pos == 4) || (x_pos == 66 && y_pos == 4) || (x_pos == 70 && y_pos == 4) || (x_pos == 74 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || (x_pos == 23 && y_pos == 5) || ((x_pos >= 26 && x_pos <= 30) && y_pos == 5) || ((x_pos >= 33 && x_pos <= 37) && y_pos == 5) || ((x_pos >= 41 && x_pos <= 44) && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || (x_pos == 55 && y_pos == 5) || ((x_pos >= 59 && x_pos <= 63) && y_pos == 5) || ((x_pos >= 66 && x_pos <= 70) && y_pos == 5) || (x_pos == 74 && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 23 && y_pos == 6) || (x_pos == 30 && y_pos == 6) || (x_pos == 37 && y_pos == 6) || (x_pos == 44 && y_pos == 6) || (x_pos == 54 && y_pos == 6) || (x_pos == 63 && y_pos == 6) || (x_pos == 70 && y_pos == 6) || (x_pos == 74 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || (x_pos == 23 && y_pos == 7) || ((x_pos >= 26 && x_pos <= 30) && y_pos == 7) || ((x_pos >= 33 && x_pos <= 37) && y_pos == 7) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 7) || ((x_pos >= 53 && x_pos <= 56) && y_pos == 7) || (x_pos == 63 && y_pos == 7) || (x_pos == 70 && y_pos == 7) || (x_pos == 74 && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar6_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || (x_pos == 24 && y_pos == 3) || (x_pos == 29 && y_pos == 3) || (x_pos == 33 && y_pos == 3) || (x_pos == 36 && y_pos == 3) || (x_pos == 40 && y_pos == 3) || (x_pos == 43 && y_pos == 3) || (x_pos == 54 && y_pos == 3) || ((x_pos >= 59 && x_pos <= 63) && y_pos == 3) || (x_pos == 67 && y_pos == 3) || ((x_pos >= 72 && x_pos <= 76) && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 23 && y_pos == 4) || (x_pos == 26 && y_pos == 4) || (x_pos == 29 && y_pos == 4) || (x_pos == 33 && y_pos == 4) || (x_pos == 36 && y_pos == 4) || (x_pos == 40 && y_pos == 4) || (x_pos == 44 && y_pos == 4) || (x_pos == 53 && y_pos == 4) || (x_pos == 56 && y_pos == 4) || (x_pos == 59 && y_pos == 4) || (x_pos == 63 && y_pos == 4) || (x_pos == 66 && y_pos == 4) || (x_pos == 69 && y_pos == 4) || (x_pos == 72 && y_pos == 4) || (x_pos == 76 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || (x_pos == 25 && y_pos == 5) || ((x_pos >= 29 && x_pos <= 33) && y_pos == 5) || ((x_pos >= 36 && x_pos <= 40) && y_pos == 5) || (x_pos == 44 && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || (x_pos == 55 && y_pos == 5) || ((x_pos >= 59 && x_pos <= 63) && y_pos == 5) || (x_pos == 68 && y_pos == 5) || ((x_pos >= 72 && x_pos <= 76) && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 24 && y_pos == 6) || (x_pos == 33 && y_pos == 6) || (x_pos == 40 && y_pos == 6) || (x_pos == 44 && y_pos == 6) || (x_pos == 54 && y_pos == 6) || (x_pos == 63 && y_pos == 6) || (x_pos == 67 && y_pos == 6) || (x_pos == 76 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || ((x_pos >= 23 && x_pos <= 26) && y_pos == 7) || (x_pos == 33 && y_pos == 7) || (x_pos == 40 && y_pos == 7) || (x_pos == 44 && y_pos == 7) || ((x_pos >= 53 && x_pos <= 56) && y_pos == 7) || ((x_pos >= 59 && x_pos <= 63) && y_pos == 7) || ((x_pos >= 66 && x_pos <= 69) && y_pos == 7) || ((x_pos >= 72 && x_pos <= 76) && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar7_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || (x_pos == 22 && y_pos == 3) || ((x_pos >= 27 && x_pos <= 31) && y_pos == 3) || (x_pos == 35 && y_pos == 3) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 3) || ((x_pos >= 52 && x_pos <= 56) && y_pos == 3) || (x_pos == 59 && y_pos == 3) || (x_pos == 63 && y_pos == 3) || (x_pos == 67 && y_pos == 3) || ((x_pos >= 72 && x_pos <= 76) && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 21 && y_pos == 4) || (x_pos == 24 && y_pos == 4) || (x_pos == 27 && y_pos == 4) || (x_pos == 31 && y_pos == 4) || (x_pos == 34 && y_pos == 4) || (x_pos == 37 && y_pos == 4) || (x_pos == 40 && y_pos == 4) || (x_pos == 44 && y_pos == 4) || (x_pos == 56 && y_pos == 4) || (x_pos == 59 && y_pos == 4) || (x_pos == 63 && y_pos == 4) || (x_pos == 68 && y_pos == 4) || (x_pos == 76 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || (x_pos == 23 && y_pos == 5) || ((x_pos >= 27 && x_pos <= 31) && y_pos == 5) || (x_pos == 36 && y_pos == 5) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || ((x_pos >= 53 && x_pos <= 56) && y_pos == 5) || ((x_pos >= 59 && x_pos <= 63) && y_pos == 5) || (x_pos == 68 && y_pos == 5) || (x_pos == 75 && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 22 && y_pos == 6) || (x_pos == 31 && y_pos == 6) || (x_pos == 35 && y_pos == 6) || (x_pos == 44 && y_pos == 6) || (x_pos == 56 && y_pos == 6) || (x_pos == 63 && y_pos == 6) || (x_pos == 68 && y_pos == 6) || (x_pos == 74 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || ((x_pos >= 21 && x_pos <= 24) && y_pos == 7) || ((x_pos >= 27 && x_pos <= 31) && y_pos == 7) || ((x_pos >= 34 && x_pos <= 37) && y_pos == 7) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 7) || ((x_pos >= 52 && x_pos <= 56) && y_pos == 7) || (x_pos == 63 && y_pos == 7) || (x_pos == 68 && y_pos == 7) || (x_pos == 73 && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar8_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || ((x_pos >= 20 && x_pos <= 24) && y_pos == 3) || (x_pos == 27 && y_pos == 3) || (x_pos == 31 && y_pos == 3) || ((x_pos >= 34 && x_pos <= 38) && y_pos == 3) || (x_pos == 42 && y_pos == 3) || ((x_pos >= 53 && x_pos <= 57) && y_pos == 3) || ((x_pos >= 60 && x_pos <= 64) && y_pos == 3) || (x_pos == 68 && y_pos == 3) || ((x_pos >= 73 && x_pos <= 77) && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 24 && y_pos == 4) || (x_pos == 27 && y_pos == 4) || (x_pos == 31 && y_pos == 4) || (x_pos == 38 && y_pos == 4) || (x_pos == 43 && y_pos == 4) || (x_pos == 57 && y_pos == 4) || (x_pos == 60 && y_pos == 4) || (x_pos == 64 && y_pos == 4) || (x_pos == 67 && y_pos == 4) || (x_pos == 70 && y_pos == 4) || (x_pos == 73 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || ((x_pos >= 21 && x_pos <= 24) && y_pos == 5) || ((x_pos >= 27 && x_pos <= 31) && y_pos == 5) || (x_pos == 37 && y_pos == 5) || (x_pos == 43 && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || ((x_pos >= 54 && x_pos <= 57) && y_pos == 5) || ((x_pos >= 60 && x_pos <= 64) && y_pos == 5) || (x_pos == 67 && y_pos == 5) || (x_pos == 70 && y_pos == 5) || ((x_pos >= 73 && x_pos <= 77) && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 24 && y_pos == 6) || (x_pos == 31 && y_pos == 6) || (x_pos == 36 && y_pos == 6) || (x_pos == 43 && y_pos == 6) || (x_pos == 57 && y_pos == 6) || (x_pos == 64 && y_pos == 6) || (x_pos == 67 && y_pos == 6) || (x_pos == 70 && y_pos == 6) || (x_pos == 73 && y_pos == 6) || (x_pos == 77 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || ((x_pos >= 20 && x_pos <= 24) && y_pos == 7) || (x_pos == 31 && y_pos == 7) || (x_pos == 35 && y_pos == 7) || (x_pos == 43 && y_pos == 7) || ((x_pos >= 53 && x_pos <= 57) && y_pos == 7) || ((x_pos >= 60 && x_pos <= 64) && y_pos == 7) || (x_pos == 68 && y_pos == 7) || ((x_pos >= 73 && x_pos <= 77) && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar9_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || ((x_pos >= 19 && x_pos <= 23) && y_pos == 3) || ((x_pos >= 26 && x_pos <= 30) && y_pos == 3) || (x_pos == 34 && y_pos == 3) || ((x_pos >= 39 && x_pos <= 43) && y_pos == 3) || (x_pos == 53 && y_pos == 3) || (x_pos == 57 && y_pos == 3) || ((x_pos >= 60 && x_pos <= 64) && y_pos == 3) || ((x_pos >= 67 && x_pos <= 71) && y_pos == 3) || (x_pos == 74 && y_pos == 3) || (x_pos == 78 && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 23 && y_pos == 4) || (x_pos == 26 && y_pos == 4) || (x_pos == 30 && y_pos == 4) || (x_pos == 33 && y_pos == 4) || (x_pos == 36 && y_pos == 4) || (x_pos == 39 && y_pos == 4) || (x_pos == 53 && y_pos == 4) || (x_pos == 57 && y_pos == 4) || (x_pos == 64 && y_pos == 4) || (x_pos == 67 && y_pos == 4) || (x_pos == 71 && y_pos == 4) || (x_pos == 74 && y_pos == 4) || (x_pos == 78 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || ((x_pos >= 20 && x_pos <= 23) && y_pos == 5) || ((x_pos >= 26 && x_pos <= 30) && y_pos == 5) || (x_pos == 33 && y_pos == 5) || (x_pos == 36 && y_pos == 5) || ((x_pos >= 39 && x_pos <= 43) && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || ((x_pos >= 53 && x_pos <= 57) && y_pos == 5) || ((x_pos >= 61 && x_pos <= 64) && y_pos == 5) || ((x_pos >= 67 && x_pos <= 71) && y_pos == 5) || ((x_pos >= 74 && x_pos <= 78) && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 23 && y_pos == 6) || (x_pos == 30 && y_pos == 6) || (x_pos == 33 && y_pos == 6) || (x_pos == 36 && y_pos == 6) || (x_pos == 39 && y_pos == 6) || (x_pos == 43 && y_pos == 6) || (x_pos == 57 && y_pos == 6) || (x_pos == 64 && y_pos == 6) || (x_pos == 71 && y_pos == 6) || (x_pos == 78 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || ((x_pos >= 19 && x_pos <= 23) && y_pos == 7) || ((x_pos >= 26 && x_pos <= 30) && y_pos == 7) || (x_pos == 34 && y_pos == 7) || ((x_pos >= 39 && x_pos <= 43) && y_pos == 7) || (x_pos == 57 && y_pos == 7) || ((x_pos >= 60 && x_pos <= 64) && y_pos == 7) || ((x_pos >= 67 && x_pos <= 71) && y_pos == 7) || (x_pos == 78 && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar10_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || (x_pos == 18 && y_pos == 3) || (x_pos == 22 && y_pos == 3) || ((x_pos >= 25 && x_pos <= 29) && y_pos == 3) || ((x_pos >= 32 && x_pos <= 36) && y_pos == 3) || (x_pos == 39 && y_pos == 3) || (x_pos == 43 && y_pos == 3) || (x_pos == 53 && y_pos == 3) || (x_pos == 57 && y_pos == 3) || ((x_pos >= 60 && x_pos <= 64) && y_pos == 3) || ((x_pos >= 67 && x_pos <= 71) && y_pos == 3) || (x_pos == 76 && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 18 && y_pos == 4) || (x_pos == 22 && y_pos == 4) || (x_pos == 29 && y_pos == 4) || (x_pos == 32 && y_pos == 4) || (x_pos == 36 && y_pos == 4) || (x_pos == 39 && y_pos == 4) || (x_pos == 43 && y_pos == 4) || (x_pos == 53 && y_pos == 4) || (x_pos == 57 && y_pos == 4) || (x_pos == 60 && y_pos == 4) || (x_pos == 64 && y_pos == 4) || (x_pos == 67 && y_pos == 4) || (x_pos == 71 && y_pos == 4) || (x_pos == 75 && y_pos == 4) || (x_pos == 78 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || ((x_pos >= 18 && x_pos <= 22) && y_pos == 5) || ((x_pos >= 26 && x_pos <= 29) && y_pos == 5) || ((x_pos >= 32 && x_pos <= 36) && y_pos == 5) || ((x_pos >= 39 && x_pos <= 43) && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || ((x_pos >= 53 && x_pos <= 57) && y_pos == 5) || ((x_pos >= 61 && x_pos <= 63) && y_pos == 5) || ((x_pos >= 68 && x_pos <= 70) && y_pos == 5) || (x_pos == 77 && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 22 && y_pos == 6) || (x_pos == 29 && y_pos == 6) || (x_pos == 36 && y_pos == 6) || (x_pos == 43 && y_pos == 6) || (x_pos == 57 && y_pos == 6) || (x_pos == 60 && y_pos == 6) || (x_pos == 64 && y_pos == 6) || (x_pos == 67 && y_pos == 6) || (x_pos == 71 && y_pos == 6) || (x_pos == 76 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || (x_pos == 22 && y_pos == 7) || ((x_pos >= 25 && x_pos <= 29) && y_pos == 7) || ((x_pos >= 32 && x_pos <= 36) && y_pos == 7) || (x_pos == 43 && y_pos == 7) || (x_pos == 57 && y_pos == 7) || ((x_pos >= 60 && x_pos <= 64) && y_pos == 7) || ((x_pos >= 67 && x_pos <= 71) && y_pos == 7) || ((x_pos >= 75 && x_pos <= 78) && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar11_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || (x_pos == 18 && y_pos == 3) || (x_pos == 22 && y_pos == 3) || ((x_pos >= 25 && x_pos <= 29) && y_pos == 3) || ((x_pos >= 32 && x_pos <= 36) && y_pos == 3) || (x_pos == 41 && y_pos == 3) || ((x_pos >= 54 && x_pos <= 57) && y_pos == 3) || ((x_pos >= 60 && x_pos <= 64) && y_pos == 3) || ((x_pos >= 67 && x_pos <= 71) && y_pos == 3) || (x_pos == 76 && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 18 && y_pos == 4) || (x_pos == 22 && y_pos == 4) || (x_pos == 25 && y_pos == 4) || (x_pos == 29 && y_pos == 4) || (x_pos == 32 && y_pos == 4) || (x_pos == 36 && y_pos == 4) || (x_pos == 40 && y_pos == 4) || (x_pos == 43 && y_pos == 4) || (x_pos == 53 && y_pos == 4) || (x_pos == 64 && y_pos == 4) || (x_pos == 71 && y_pos == 4) || (x_pos == 77 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || ((x_pos >= 18 && x_pos <= 22) && y_pos == 5) || ((x_pos >= 26 && x_pos <= 28) && y_pos == 5) || ((x_pos >= 33 && x_pos <= 35) && y_pos == 5) || (x_pos == 42 && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || ((x_pos >= 53 && x_pos <= 57) && y_pos == 5) || ((x_pos >= 61 && x_pos <= 64) && y_pos == 5) || (x_pos == 70 && y_pos == 5) || (x_pos == 77 && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 22 && y_pos == 6) || (x_pos == 25 && y_pos == 6) || (x_pos == 29 && y_pos == 6) || (x_pos == 32 && y_pos == 6) || (x_pos == 36 && y_pos == 6) || (x_pos == 41 && y_pos == 6) || (x_pos == 57 && y_pos == 6) || (x_pos == 64 && y_pos == 6) || (x_pos == 69 && y_pos == 6) || (x_pos == 77 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || (x_pos == 22 && y_pos == 7) || ((x_pos >= 25 && x_pos <= 29) && y_pos == 7) || ((x_pos >= 32 && x_pos <= 36) && y_pos == 7) || ((x_pos >= 40 && x_pos <= 43) && y_pos == 7) || ((x_pos >= 53 && x_pos <= 57) && y_pos == 7) || ((x_pos >= 60 && x_pos <= 64) && y_pos == 7) || (x_pos == 68 && y_pos == 7) || (x_pos == 77 && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar12_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || ((x_pos >= 19 && x_pos <= 22) && y_pos == 3) || ((x_pos >= 25 && x_pos <= 29) && y_pos == 3) || ((x_pos >= 32 && x_pos <= 36) && y_pos == 3) || (x_pos == 41 && y_pos == 3) || ((x_pos >= 54 && x_pos <= 57) && y_pos == 3) || ((x_pos >= 60 && x_pos <= 64) && y_pos == 3) || ((x_pos >= 68 && x_pos <= 71) && y_pos == 3) || ((x_pos >= 74 && x_pos <= 78) && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 18 && y_pos == 4) || (x_pos == 29 && y_pos == 4) || (x_pos == 36 && y_pos == 4) || (x_pos == 42 && y_pos == 4) || (x_pos == 53 && y_pos == 4) || (x_pos == 60 && y_pos == 4) || (x_pos == 64 && y_pos == 4) || (x_pos == 67 && y_pos == 4) || (x_pos == 74 && y_pos == 4) || (x_pos == 78 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || ((x_pos >= 18 && x_pos <= 22) && y_pos == 5) || ((x_pos >= 26 && x_pos <= 29) && y_pos == 5) || (x_pos == 35 && y_pos == 5) || (x_pos == 42 && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || ((x_pos >= 53 && x_pos <= 57) && y_pos == 5) || ((x_pos >= 61 && x_pos <= 63) && y_pos == 5) || ((x_pos >= 67 && x_pos <= 71) && y_pos == 5) || ((x_pos >= 74 && x_pos <= 78) && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 22 && y_pos == 6) || (x_pos == 29 && y_pos == 6) || (x_pos == 34 && y_pos == 6) || (x_pos == 42 && y_pos == 6) || (x_pos == 57 && y_pos == 6) || (x_pos == 60 && y_pos == 6) || (x_pos == 64 && y_pos == 6) || (x_pos == 71 && y_pos == 6) || (x_pos == 78 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || ((x_pos >= 18 && x_pos <= 22) && y_pos == 7) || ((x_pos >= 25 && x_pos <= 29) && y_pos == 7) || (x_pos == 33 && y_pos == 7) || (x_pos == 42 && y_pos == 7) || ((x_pos >= 53 && x_pos <= 57) && y_pos == 7) || ((x_pos >= 60 && x_pos <= 64) && y_pos == 7) || ((x_pos >= 67 && x_pos <= 71) && y_pos == 7) || ((x_pos >= 74 && x_pos <= 78) && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar13_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || ((x_pos >= 18 && x_pos <= 21) && y_pos == 3) || ((x_pos >= 24 && x_pos <= 28) && y_pos == 3) || ((x_pos >= 32 && x_pos <= 35) && y_pos == 3) || ((x_pos >= 38 && x_pos <= 42) && y_pos == 3) || ((x_pos >= 53 && x_pos <= 57) && y_pos == 3) || ((x_pos >= 60 && x_pos <= 64) && y_pos == 3) || (x_pos == 67 && y_pos == 3) || (x_pos == 71 && y_pos == 3) || ((x_pos >= 74 && x_pos <= 78) && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 17 && y_pos == 4) || (x_pos == 24 && y_pos == 4) || (x_pos == 28 && y_pos == 4) || (x_pos == 31 && y_pos == 4) || (x_pos == 38 && y_pos == 4) || (x_pos == 42 && y_pos == 4) || (x_pos == 53 && y_pos == 4) || (x_pos == 64 && y_pos == 4) || (x_pos == 67 && y_pos == 4) || (x_pos == 71 && y_pos == 4) || (x_pos == 78 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || ((x_pos >= 17 && x_pos <= 21) && y_pos == 5) || ((x_pos >= 25 && x_pos <= 27) && y_pos == 5) || ((x_pos >= 31 && x_pos <= 35) && y_pos == 5) || ((x_pos >= 38 && x_pos <= 42) && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || ((x_pos >= 53 && x_pos <= 57) && y_pos == 5) || ((x_pos >= 61 && x_pos <= 64) && y_pos == 5) || ((x_pos >= 67 && x_pos <= 71) && y_pos == 5) || (x_pos == 77 && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 21 && y_pos == 6) || (x_pos == 24 && y_pos == 6) || (x_pos == 28 && y_pos == 6) || (x_pos == 35 && y_pos == 6) || (x_pos == 42 && y_pos == 6) || (x_pos == 53 && y_pos == 6) || (x_pos == 57 && y_pos == 6) || (x_pos == 64 && y_pos == 6) || (x_pos == 71 && y_pos == 6) || (x_pos == 76 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || ((x_pos >= 17 && x_pos <= 21) && y_pos == 7) || ((x_pos >= 24 && x_pos <= 28) && y_pos == 7) || ((x_pos >= 31 && x_pos <= 35) && y_pos == 7) || ((x_pos >= 38 && x_pos <= 42) && y_pos == 7) || ((x_pos >= 53 && x_pos <= 57) && y_pos == 7) || ((x_pos >= 60 && x_pos <= 64) && y_pos == 7) || (x_pos == 71 && y_pos == 7) || (x_pos == 75 && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar14_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || ((x_pos >= 17 && x_pos <= 21) && y_pos == 3) || ((x_pos >= 24 && x_pos <= 28) && y_pos == 3) || (x_pos == 31 && y_pos == 3) || (x_pos == 35 && y_pos == 3) || ((x_pos >= 38 && x_pos <= 42) && y_pos == 3) || ((x_pos >= 53 && x_pos <= 57) && y_pos == 3) || ((x_pos >= 60 && x_pos <= 64) && y_pos == 3) || ((x_pos >= 67 && x_pos <= 71) && y_pos == 3) || ((x_pos >= 75 && x_pos <= 78) && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 17 && y_pos == 4) || (x_pos == 28 && y_pos == 4) || (x_pos == 31 && y_pos == 4) || (x_pos == 35 && y_pos == 4) || (x_pos == 42 && y_pos == 4) || (x_pos == 53 && y_pos == 4) || (x_pos == 60 && y_pos == 4) || (x_pos == 64 && y_pos == 4) || (x_pos == 71 && y_pos == 4) || (x_pos == 74 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || ((x_pos >= 17 && x_pos <= 21) && y_pos == 5) || ((x_pos >= 25 && x_pos <= 28) && y_pos == 5) || ((x_pos >= 31 && x_pos <= 35) && y_pos == 5) || (x_pos == 41 && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || ((x_pos >= 53 && x_pos <= 57) && y_pos == 5) || ((x_pos >= 61 && x_pos <= 63) && y_pos == 5) || ((x_pos >= 68 && x_pos <= 71) && y_pos == 5) || ((x_pos >= 74 && x_pos <= 78) && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 17 && y_pos == 6) || (x_pos == 21 && y_pos == 6) || (x_pos == 28 && y_pos == 6) || (x_pos == 35 && y_pos == 6) || (x_pos == 40 && y_pos == 6) || (x_pos == 53 && y_pos == 6) || (x_pos == 57 && y_pos == 6) || (x_pos == 60 && y_pos == 6) || (x_pos == 64 && y_pos == 6) || (x_pos == 71 && y_pos == 6) || (x_pos == 78 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || ((x_pos >= 17 && x_pos <= 21) && y_pos == 7) || ((x_pos >= 24 && x_pos <= 28) && y_pos == 7) || (x_pos == 35 && y_pos == 7) || (x_pos == 39 && y_pos == 7) || ((x_pos >= 53 && x_pos <= 57) && y_pos == 7) || ((x_pos >= 60 && x_pos <= 64) && y_pos == 7) || ((x_pos >= 67 && x_pos <= 71) && y_pos == 7) || ((x_pos >= 74 && x_pos <= 78) && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar15_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || ((x_pos >= 19 && x_pos <= 23) && y_pos == 3) || ((x_pos >= 26 && x_pos <= 30) && y_pos == 3) || ((x_pos >= 33 && x_pos <= 37) && y_pos == 3) || ((x_pos >= 41 && x_pos <= 44) && y_pos == 3) || ((x_pos >= 52 && x_pos <= 56) && y_pos == 3) || ((x_pos >= 58 && x_pos <= 62) && y_pos == 3) || (x_pos == 66 && y_pos == 3) || (x_pos == 71 && y_pos == 3) || (x_pos == 75 && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 19 && y_pos == 4) || (x_pos == 26 && y_pos == 4) || (x_pos == 30 && y_pos == 4) || (x_pos == 37 && y_pos == 4) || (x_pos == 40 && y_pos == 4) || (x_pos == 56 && y_pos == 4) || (x_pos == 62 && y_pos == 4) || (x_pos == 65 && y_pos == 4) || (x_pos == 68 && y_pos == 4) || (x_pos == 71 && y_pos == 4) || (x_pos == 75 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || ((x_pos >= 19 && x_pos <= 23) && y_pos == 5) || ((x_pos >= 27 && x_pos <= 29) && y_pos == 5) || ((x_pos >= 34 && x_pos <= 37) && y_pos == 5) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || (x_pos == 55 && y_pos == 5) || ((x_pos >= 59 && x_pos <= 62) && y_pos == 5) || (x_pos == 67 && y_pos == 5) || ((x_pos >= 71 && x_pos <= 75) && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 19 && y_pos == 6) || (x_pos == 23 && y_pos == 6) || (x_pos == 26 && y_pos == 6) || (x_pos == 30 && y_pos == 6) || (x_pos == 37 && y_pos == 6) || (x_pos == 44 && y_pos == 6) || (x_pos == 54 && y_pos == 6) || (x_pos == 62 && y_pos == 6) || (x_pos == 66 && y_pos == 6) || (x_pos == 75 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || ((x_pos >= 19 && x_pos <= 23) && y_pos == 7) || ((x_pos >= 26 && x_pos <= 30) && y_pos == 7) || ((x_pos >= 33 && x_pos <= 37) && y_pos == 7) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 7) || (x_pos == 53 && y_pos == 7) || ((x_pos >= 58 && x_pos <= 62) && y_pos == 7) || ((x_pos >= 65 && x_pos <= 68) && y_pos == 7) || (x_pos == 75 && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar16_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || ((x_pos >= 21 && x_pos <= 25) && y_pos == 3) || ((x_pos >= 27 && x_pos <= 31) && y_pos == 3) || (x_pos == 35 && y_pos == 3) || (x_pos == 40 && y_pos == 3) || (x_pos == 44 && y_pos == 3) || ((x_pos >= 52 && x_pos <= 56) && y_pos == 3) || ((x_pos >= 58 && x_pos <= 62) && y_pos == 3) || (x_pos == 65 && y_pos == 3) || (x_pos == 70 && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 25 && y_pos == 4) || (x_pos == 31 && y_pos == 4) || (x_pos == 34 && y_pos == 4) || (x_pos == 37 && y_pos == 4) || (x_pos == 40 && y_pos == 4) || (x_pos == 44 && y_pos == 4) || (x_pos == 56 && y_pos == 4) || (x_pos == 58 && y_pos == 4) || (x_pos == 62 && y_pos == 4) || (x_pos == 66 && y_pos == 4) || (x_pos == 69 && y_pos == 4) || (x_pos == 72 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || (x_pos == 24 && y_pos == 5) || ((x_pos >= 28 && x_pos <= 31) && y_pos == 5) || (x_pos == 36 && y_pos == 5) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || (x_pos == 55 && y_pos == 5) || ((x_pos >= 59 && x_pos <= 61) && y_pos == 5) || (x_pos == 66 && y_pos == 5) || (x_pos == 71 && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 23 && y_pos == 6) || (x_pos == 31 && y_pos == 6) || (x_pos == 35 && y_pos == 6) || (x_pos == 44 && y_pos == 6) || (x_pos == 54 && y_pos == 6) || (x_pos == 58 && y_pos == 6) || (x_pos == 62 && y_pos == 6) || (x_pos == 66 && y_pos == 6) || (x_pos == 70 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || (x_pos == 22 && y_pos == 7) || ((x_pos >= 27 && x_pos <= 31) && y_pos == 7) || ((x_pos >= 34 && x_pos <= 37) && y_pos == 7) || (x_pos == 44 && y_pos == 7) || (x_pos == 53 && y_pos == 7) || ((x_pos >= 58 && x_pos <= 62) && y_pos == 7) || (x_pos == 66 && y_pos == 7) || ((x_pos >= 69 && x_pos <= 72) && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar17_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || ((x_pos >= 24 && x_pos <= 28) && y_pos == 3) || ((x_pos >= 30 && x_pos <= 34) && y_pos == 3) || (x_pos == 37 && y_pos == 3) || (x_pos == 42 && y_pos == 3) || ((x_pos >= 52 && x_pos <= 56) && y_pos == 3) || ((x_pos >= 59 && x_pos <= 63) && y_pos == 3) || (x_pos == 67 && y_pos == 3) || (x_pos == 73 && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 28 && y_pos == 4) || (x_pos == 30 && y_pos == 4) || (x_pos == 34 && y_pos == 4) || (x_pos == 38 && y_pos == 4) || (x_pos == 41 && y_pos == 4) || (x_pos == 44 && y_pos == 4) || (x_pos == 52 && y_pos == 4) || (x_pos == 56 && y_pos == 4) || (x_pos == 63 && y_pos == 4) || (x_pos == 66 && y_pos == 4) || (x_pos == 69 && y_pos == 4) || (x_pos == 72 && y_pos == 4) || (x_pos == 75 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || (x_pos == 27 && y_pos == 5) || ((x_pos >= 31 && x_pos <= 33) && y_pos == 5) || (x_pos == 38 && y_pos == 5) || (x_pos == 43 && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || ((x_pos >= 53 && x_pos <= 55) && y_pos == 5) || ((x_pos >= 60 && x_pos <= 63) && y_pos == 5) || (x_pos == 66 && y_pos == 5) || (x_pos == 69 && y_pos == 5) || (x_pos == 72 && y_pos == 5) || (x_pos == 75 && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 26 && y_pos == 6) || (x_pos == 30 && y_pos == 6) || (x_pos == 34 && y_pos == 6) || (x_pos == 38 && y_pos == 6) || (x_pos == 42 && y_pos == 6) || (x_pos == 52 && y_pos == 6) || (x_pos == 56 && y_pos == 6) || (x_pos == 63 && y_pos == 6) || (x_pos == 66 && y_pos == 6) || (x_pos == 69 && y_pos == 6) || (x_pos == 72 && y_pos == 6) || (x_pos == 75 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || (x_pos == 25 && y_pos == 7) || ((x_pos >= 30 && x_pos <= 34) && y_pos == 7) || (x_pos == 38 && y_pos == 7) || ((x_pos >= 41 && x_pos <= 44) && y_pos == 7) || ((x_pos >= 52 && x_pos <= 56) && y_pos == 7) || ((x_pos >= 59 && x_pos <= 63) && y_pos == 7) || (x_pos == 67 && y_pos == 7) || (x_pos == 73 && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar18_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || ((x_pos >= 21 && x_pos <= 25) && y_pos == 3) || ((x_pos >= 28 && x_pos <= 32) && y_pos == 3) || (x_pos == 36 && y_pos == 3) || (x_pos == 42 && y_pos == 3) || ((x_pos >= 52 && x_pos <= 56) && y_pos == 3) || ((x_pos >= 59 && x_pos <= 63) && y_pos == 3) || ((x_pos >= 66 && x_pos <= 70) && y_pos == 3) || ((x_pos >= 73 && x_pos <= 77) && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 21 && y_pos == 4) || (x_pos == 25 && y_pos == 4) || (x_pos == 32 && y_pos == 4) || (x_pos == 35 && y_pos == 4) || (x_pos == 38 && y_pos == 4) || (x_pos == 41 && y_pos == 4) || (x_pos == 44 && y_pos == 4) || (x_pos == 52 && y_pos == 4) || (x_pos == 56 && y_pos == 4) || (x_pos == 63 && y_pos == 4) || (x_pos == 66 && y_pos == 4) || (x_pos == 70 && y_pos == 4) || (x_pos == 73 && y_pos == 4) || (x_pos == 77 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || ((x_pos >= 22 && x_pos <= 24) && y_pos == 5) || ((x_pos >= 29 && x_pos <= 32) && y_pos == 5) || (x_pos == 35 && y_pos == 5) || (x_pos == 38 && y_pos == 5) || (x_pos == 41 && y_pos == 5) || (x_pos == 44 && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || ((x_pos >= 53 && x_pos <= 55) && y_pos == 5) || (x_pos == 62 && y_pos == 5) || ((x_pos >= 67 && x_pos <= 69) && y_pos == 5) || ((x_pos >= 73 && x_pos <= 77) && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 21 && y_pos == 6) || (x_pos == 25 && y_pos == 6) || (x_pos == 32 && y_pos == 6) || (x_pos == 35 && y_pos == 6) || (x_pos == 38 && y_pos == 6) || (x_pos == 41 && y_pos == 6) || (x_pos == 44 && y_pos == 6) || (x_pos == 52 && y_pos == 6) || (x_pos == 56 && y_pos == 6) || (x_pos == 61 && y_pos == 6) || (x_pos == 66 && y_pos == 6) || (x_pos == 70 && y_pos == 6) || (x_pos == 77 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || ((x_pos >= 21 && x_pos <= 25) && y_pos == 7) || ((x_pos >= 28 && x_pos <= 32) && y_pos == 7) || (x_pos == 36 && y_pos == 7) || (x_pos == 42 && y_pos == 7) || ((x_pos >= 52 && x_pos <= 56) && y_pos == 7) || (x_pos == 60 && y_pos == 7) || ((x_pos >= 66 && x_pos <= 70) && y_pos == 7) || ((x_pos >= 73 && x_pos <= 77) && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar19_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || ((x_pos >= 19 && x_pos <= 23) && y_pos == 3) || ((x_pos >= 26 && x_pos <= 30) && y_pos == 3) || ((x_pos >= 33 && x_pos <= 37) && y_pos == 3) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 3) || ((x_pos >= 52 && x_pos <= 56) && y_pos == 3) || (x_pos == 60 && y_pos == 3) || ((x_pos >= 65 && x_pos <= 69) && y_pos == 3) || ((x_pos >= 72 && x_pos <= 76) && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 19 && y_pos == 4) || (x_pos == 23 && y_pos == 4) || (x_pos == 30 && y_pos == 4) || (x_pos == 33 && y_pos == 4) || (x_pos == 37 && y_pos == 4) || (x_pos == 40 && y_pos == 4) || (x_pos == 44 && y_pos == 4) || (x_pos == 52 && y_pos == 4) || (x_pos == 56 && y_pos == 4) || (x_pos == 59 && y_pos == 4) || (x_pos == 62 && y_pos == 4) || (x_pos == 69 && y_pos == 4) || (x_pos == 76 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || ((x_pos >= 20 && x_pos <= 22) && y_pos == 5) || (x_pos == 29 && y_pos == 5) || ((x_pos >= 34 && x_pos <= 36) && y_pos == 5) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || ((x_pos >= 52 && x_pos <= 56) && y_pos == 5) || (x_pos == 61 && y_pos == 5) || (x_pos == 68 && y_pos == 5) || (x_pos == 75 && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 19 && y_pos == 6) || (x_pos == 23 && y_pos == 6) || (x_pos == 28 && y_pos == 6) || (x_pos == 33 && y_pos == 6) || (x_pos == 37 && y_pos == 6) || (x_pos == 44 && y_pos == 6) || (x_pos == 56 && y_pos == 6) || (x_pos == 60 && y_pos == 6) || (x_pos == 67 && y_pos == 6) || (x_pos == 74 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || ((x_pos >= 19 && x_pos <= 23) && y_pos == 7) || (x_pos == 27 && y_pos == 7) || ((x_pos >= 33 && x_pos <= 37) && y_pos == 7) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 7) || ((x_pos >= 52 && x_pos <= 56) && y_pos == 7) || ((x_pos >= 59 && x_pos <= 62) && y_pos == 7) || (x_pos == 66 && y_pos == 7) || (x_pos == 73 && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    assign bar20_20khz = (((x_pos >= 0 && x_pos <= 94) && y_pos == 0) || (x_pos == 0 && y_pos == 1) || (x_pos == 94 && y_pos == 1) || (x_pos == 0 && y_pos == 2) || (x_pos == 94 && y_pos == 2) || (x_pos == 0 && y_pos == 3) || ((x_pos >= 20 && x_pos <= 24) && y_pos == 3) || (x_pos == 28 && y_pos == 3) || ((x_pos >= 33 && x_pos <= 37) && y_pos == 3) || ((x_pos >= 40 && x_pos <= 44) && y_pos == 3) || ((x_pos >= 52 && x_pos <= 56) && y_pos == 3) || ((x_pos >= 59 && x_pos <= 63) && y_pos == 3) || ((x_pos >= 66 && x_pos <= 70) && y_pos == 3) || ((x_pos >= 74 && x_pos <= 77) && y_pos == 3) || (x_pos == 94 && y_pos == 3) || (x_pos == 0 && y_pos == 4) || (x_pos == 20 && y_pos == 4) || (x_pos == 24 && y_pos == 4) || (x_pos == 27 && y_pos == 4) || (x_pos == 30 && y_pos == 4) || (x_pos == 37 && y_pos == 4) || (x_pos == 44 && y_pos == 4) || (x_pos == 52 && y_pos == 4) || (x_pos == 56 && y_pos == 4) || (x_pos == 63 && y_pos == 4) || (x_pos == 66 && y_pos == 4) || (x_pos == 73 && y_pos == 4) || (x_pos == 94 && y_pos == 4) || (x_pos == 0 && y_pos == 5) || ((x_pos >= 20 && x_pos <= 24) && y_pos == 5) || (x_pos == 29 && y_pos == 5) || (x_pos == 36 && y_pos == 5) || (x_pos == 43 && y_pos == 5) || ((x_pos >= 47 && x_pos <= 49) && y_pos == 5) || ((x_pos >= 52 && x_pos <= 56) && y_pos == 5) || (x_pos == 62 && y_pos == 5) || ((x_pos >= 66 && x_pos <= 70) && y_pos == 5) || ((x_pos >= 73 && x_pos <= 77) && y_pos == 5) || (x_pos == 94 && y_pos == 5) || (x_pos == 0 && y_pos == 6) || (x_pos == 24 && y_pos == 6) || (x_pos == 28 && y_pos == 6) || (x_pos == 35 && y_pos == 6) || (x_pos == 42 && y_pos == 6) || (x_pos == 56 && y_pos == 6) || (x_pos == 61 && y_pos == 6) || (x_pos == 66 && y_pos == 6) || (x_pos == 70 && y_pos == 6) || (x_pos == 77 && y_pos == 6) || (x_pos == 94 && y_pos == 6) || (x_pos == 0 && y_pos == 7) || ((x_pos >= 20 && x_pos <= 24) && y_pos == 7) || ((x_pos >= 27 && x_pos <= 30) && y_pos == 7) || (x_pos == 34 && y_pos == 7) || (x_pos == 41 && y_pos == 7) || ((x_pos >= 52 && x_pos <= 56) && y_pos == 7) || (x_pos == 60 && y_pos == 7) || ((x_pos >= 66 && x_pos <= 70) && y_pos == 7) || ((x_pos >= 73 && x_pos <= 77) && y_pos == 7) || (x_pos == 94 && y_pos == 7) || (x_pos == 0 && y_pos == 8) || (x_pos == 94 && y_pos == 8) || (x_pos == 0 && y_pos == 9) || (x_pos == 94 && y_pos == 9) || ((x_pos >= 0 && x_pos <= 94) && y_pos == 10));

    function [15:0] barcolor (input [5:0] bar_number);
        begin
            if (spectrogram[bar_number * 6 +: 6] < 33) begin
                barcolor = RED;
            end else if (spectrogram[bar_number * 6 +: 6] < 43) begin
                barcolor = YELLOW;
            end else if (spectrogram[bar_number * 6 +: 6] < 53) begin
                barcolor = GREEN;
            end else begin
                barcolor = WHITE;
            end
        end
    endfunction

    // Controlling display of bars
    localparam MAX_HEIGHT = 50;
    localparam DOWNSCALE = 3;
    localparam ARROW_COLOR = YELLOW;

    // FFT lib stuff
    wire signed [11:0] sample_imag = 12'b0; //imaginary part is 0
    wire signed [11:0] output_real, output_imag; //bits for output real and imaginary
    wire signed [5:0] output_real_ds;
    wire signed [5:0] output_imag_ds;
    wire fft_ce;
    wire sync; // High when fft is ready
    reg [(6 * 20) - 1:0] spectrogram = 0;
    reg [13:0] abs; //to calculate the absolute magnitude of output real and imaginary
    reg [10:0] maxbins = 1024; // half of 2048 point FFT
    reg [9:0] bin = 0;
    reg [9:0] spectrobinsize = 50;
    reg [5:0] highest_bar = 0;
    integer j;

    assign fft_ce = 1;
    assign output_real_ds = output_real >> 6;
    assign output_imag_ds = output_imag >> 6;

    always @ (posedge basys3_clock) begin
        if (sw[10]) begin
            spectrobinsize <= 25; // view up to 5Khz (4883Hz)
        end
        else if (sw[9]) begin
            spectrobinsize <= 10; // view up to 2Khz (1953Hz)
        end
        else if (sw[8]) begin
            spectrobinsize <= 5; // view up to 1kHz (976Hz)
        end
        else begin
            spectrobinsize <= 50; // view up to 10kHz (9765Hz)
        end
    end

    reg [5:0] prev_highest_range = 21; 
    reg [5:0] curr_highest_range = 21;
    reg [7:0] curr_highest_range_bar_value = 0;
    always @ (posedge sampling_rate) begin
        if(fft_ce) begin
            abs <= ((output_real_ds * output_real_ds) + (output_imag_ds * output_imag_ds) >> DOWNSCALE);
            if (sync) begin
                bin <= 0;
                j <= 0;
                curr_highest_range <= 0;
                curr_highest_range_bar_value <= 0;
                highest_bar <= 0;
            end else begin
                bin <= bin + 1;
            end   
            if (bin < maxbins) begin
                // This is for finding highest of each bin of spectrogram, 0Hz is not included as it always skews results

                if (!sw[0]) begin
                    if (bin != 0) begin
                        if (bin % spectrobinsize == 0) begin
                            if (j < 20) begin
                                spectrogram[j*6 +: 6] <= MAX_HEIGHT - highest_bar + (63 - MAX_HEIGHT);
                                highest_bar = 0;
                                j <= j + 1;
                            end
                        end     
                        if (highest_bar < (abs < MAX_HEIGHT ? abs: MAX_HEIGHT)) begin // update new highest in bin
                            highest_bar <= (abs < MAX_HEIGHT ? abs : MAX_HEIGHT);
                        end   
                        if (curr_highest_range_bar_value < highest_bar) begin
                            curr_highest_range_bar_value <= highest_bar;
                            curr_highest_range <= j;
                        end
                    end
                end
            end
        end
    end

    fftmain fft_0(.i_clk(sampling_rate), .i_reset(0), .i_ce(fft_ce), .i_sample({curr_Audio, sample_imag}), .o_result({output_real, output_imag}), .o_sync(sync));

    reg [31:0] info_display_counter = 0;
    always @ (posedge basys3_clock) begin
        info_display_counter <= (info_display_counter == 200_000_000) ? 0 : info_display_counter + 1;

        if (info_display_counter == 0) begin
            prev_highest_range <= curr_highest_range;
        end
    end

    // Controlling audio output
    
    reg [5:0] selector = 0;
    wire selected_audio_output_maxbit;
 
    always @ (posedge basys3_clock) begin
        if (sw[0]) begin
            if (bar1hover && left_click) begin
                selector <= 1;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar2hover && left_click) begin
                selector <= 2;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar3hover && left_click) begin
                selector <= 3;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar4hover && left_click) begin
                selector <= 4;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar5hover && left_click) begin
                selector <= 5;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar6hover && left_click) begin
                selector <= 6;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar7hover && left_click) begin
                selector <= 7;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar8hover && left_click) begin
                selector <= 8;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar9hover && left_click) begin
                selector <= 9;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar10hover && left_click) begin
                selector <= 10;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar11hover && left_click) begin
                selector <= 11;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar12hover && left_click) begin
                selector <= 12;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar13hover && left_click) begin
                selector <= 13;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar14hover && left_click) begin
                selector <= 14;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar15hover && left_click) begin
                selector <= 15;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar16hover && left_click) begin
                selector <= 16;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar17hover && left_click) begin
                selector <= 17;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar18hover && left_click) begin
                selector <= 18;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar19hover && left_click) begin
                selector <= 19;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else if (bar20hover && left_click) begin
                selector <= 20;
                audio_out[11] <= selected_audio_output_maxbit;
                audio_out[10:0] <= 11'b11111111111;
            end
            else begin
                selector <= 0;
                audio_out <= 12'b0;
            end
        end else begin
            selector <= 0;
            audio_out <= 12'b0;
        end
    end

    play_range fft_audio_device(selector, basys3_clock, selected_audio_output_maxbit);


    always @ (posedge basys3_clock) begin
        pixel_data <= BLACK;

        // Printing range of highest bar
        if (bar_border_area) begin
            if (!sw[0]) begin
                case (prev_highest_range)
                    0 : pixel_data <= (bar1_20khz && ((barcolor(0) == GREEN) || (barcolor(0) == YELLOW) || (barcolor(0) == RED))) ? WHITE : BLACK;
                    1 : pixel_data <= (bar2_20khz && ((barcolor(1) == GREEN) || (barcolor(1) == YELLOW) || (barcolor(1) == RED))) ? WHITE : BLACK;
                    2 : pixel_data <= (bar3_20khz && ((barcolor(2) == GREEN) || (barcolor(2) == YELLOW) || (barcolor(2) == RED))) ? WHITE : BLACK;
                    3 : pixel_data <= (bar4_20khz && ((barcolor(3) == GREEN) || (barcolor(3) == YELLOW) || (barcolor(3) == RED))) ? WHITE : BLACK;
                    4 : pixel_data <= (bar5_20khz && ((barcolor(4) == GREEN) || (barcolor(4) == YELLOW) || (barcolor(4) == RED))) ? WHITE : BLACK;
                    5 : pixel_data <= (bar6_20khz && ((barcolor(5) == GREEN) || (barcolor(5) == YELLOW) || (barcolor(5) == RED))) ? WHITE : BLACK;
                    6 : pixel_data <= (bar7_20khz && ((barcolor(6) == GREEN) || (barcolor(6) == YELLOW) || (barcolor(6) == RED))) ? WHITE : BLACK;
                    7 : pixel_data <= (bar8_20khz && ((barcolor(7) == GREEN) || (barcolor(7) == YELLOW) || (barcolor(7) == RED))) ? WHITE : BLACK;
                    8 : pixel_data <= (bar9_20khz && ((barcolor(8) == GREEN) || (barcolor(8) == YELLOW) || (barcolor(8) == RED))) ? WHITE : BLACK;
                    9 : pixel_data <= (bar10_20khz && ((barcolor(9) == GREEN) || (barcolor(9) == YELLOW) || (barcolor(9) == RED))) ? WHITE : BLACK;
                    10 : pixel_data <= (bar11_20khz && ((barcolor(10) == GREEN) || (barcolor(10) == YELLOW) || (barcolor(10) == RED))) ? WHITE : BLACK;
                    11 : pixel_data <= (bar12_20khz && ((barcolor(11) == GREEN) || (barcolor(11) == YELLOW) || (barcolor(11) == RED))) ? WHITE : BLACK;
                    12 : pixel_data <= (bar13_20khz && ((barcolor(12) == GREEN) || (barcolor(12) == YELLOW) || (barcolor(12) == RED))) ? WHITE : BLACK;
                    13 : pixel_data <= (bar14_20khz && ((barcolor(13) == GREEN) || (barcolor(13) == YELLOW) || (barcolor(13) == RED))) ? WHITE : BLACK;
                    14 : pixel_data <= (bar15_20khz && ((barcolor(14) == GREEN) || (barcolor(14) == YELLOW) || (barcolor(14) == RED))) ? WHITE : BLACK;
                    15 : pixel_data <= (bar16_20khz && ((barcolor(15) == GREEN) || (barcolor(15) == YELLOW) || (barcolor(15) == RED))) ? WHITE : BLACK;
                    16 : pixel_data <= (bar17_20khz && ((barcolor(16) == GREEN) || (barcolor(16) == YELLOW) || (barcolor(16) == RED))) ? WHITE : BLACK;
                    17 : pixel_data <= (bar18_20khz && ((barcolor(17) == GREEN) || (barcolor(17) == YELLOW) || (barcolor(17) == RED))) ? WHITE : BLACK;
                    18 : pixel_data <= (bar19_20khz && ((barcolor(18) == GREEN) || (barcolor(18) == YELLOW) || (barcolor(18) == RED))) ? WHITE : BLACK;
                    19 : pixel_data <= (bar20_20khz && ((barcolor(19) == GREEN) || (barcolor(19) == YELLOW) || (barcolor(19) == RED))) ? WHITE : BLACK;
                    default : pixel_data <= BLACK;
                endcase
            end
            else begin
                pixel_data <= BLACK;
            end
        end

        // For printing spectrogram
        if (x_pos >= 8 && x_pos <= 10 && y_pos >= spectrogram[0*6 +:6]) begin
            pixel_data <= (bar1hover && sw[0]) ? BLUE : barcolor(0);
        end
        else if (x_pos >= 12 && x_pos <= 14 && y_pos >= spectrogram[1*6 +:6]) begin
            pixel_data <= (bar2hover && sw[0]) ? BLUE : barcolor(1);
        end
        else if (x_pos >= 16 && x_pos <= 18 && y_pos >= spectrogram[2*6 +:6]) begin
            pixel_data <= (bar3hover && sw[0]) ? BLUE : barcolor(2);
        end
        else if (x_pos >= 20 && x_pos <= 22 && y_pos >= spectrogram[3*6 +:6]) begin
            pixel_data <= (bar4hover && sw[0]) ? BLUE : barcolor(3);
        end
        else if (x_pos >= 24 && x_pos <= 26 && y_pos >= spectrogram[4*6 +:6]) begin
            pixel_data <= (bar5hover && sw[0]) ? BLUE : barcolor(4);
        end
        else if (x_pos >= 28 && x_pos <= 30 && y_pos >= spectrogram[5*6 +:6]) begin
            pixel_data <= (bar6hover && sw[0]) ? BLUE : barcolor(5);
        end
        else if (x_pos >= 32 && x_pos <= 34 && y_pos >= spectrogram[6*6 +:6]) begin
            pixel_data <= (bar7hover && sw[0]) ? BLUE : barcolor(6);
        end
        else if (x_pos >= 36 && x_pos <= 38 && y_pos >= spectrogram[7*6 +:6]) begin
            pixel_data <= (bar8hover && sw[0]) ? BLUE : barcolor(7);
        end
        else if (x_pos >= 40 && x_pos <= 42 && y_pos >= spectrogram[8*6 +:6]) begin
            pixel_data <= (bar9hover && sw[0]) ? BLUE : barcolor(8);
        end
        else if (x_pos >= 44 && x_pos <= 46 && y_pos >= spectrogram[9*6 +:6]) begin
            pixel_data <= (bar10hover && sw[0]) ? BLUE : barcolor(9);
        end
        else if (x_pos >= 48 && x_pos <= 50 && y_pos >= spectrogram[10*6 +:6]) begin
            pixel_data <= (bar11hover && sw[0]) ? BLUE : barcolor(10);
        end
        else if (x_pos >= 52 && x_pos <= 54 && y_pos >= spectrogram[11*6 +:6]) begin
            pixel_data <= (bar12hover && sw[0]) ? BLUE : barcolor(11);
        end
        else if (x_pos >= 56 && x_pos <= 58 && y_pos >= spectrogram[12*6 +:6]) begin
            pixel_data <= (bar13hover && sw[0]) ? BLUE : barcolor(12);
        end
        else if (x_pos >= 60 && x_pos <= 62 && y_pos >= spectrogram[13*6 +:6]) begin
            pixel_data <= (bar14hover && sw[0]) ? BLUE : barcolor(13);
        end
        else if (x_pos >= 64 && x_pos <= 66 && y_pos >= spectrogram[14*6 +:6]) begin
            pixel_data <= (bar15hover && sw[0]) ? BLUE : barcolor(14);
        end
        else if (x_pos >= 68 && x_pos <= 70 && y_pos >= spectrogram[15*6 +:6]) begin
            pixel_data <= (bar16hover && sw[0]) ? BLUE : barcolor(15);
        end
        else if (x_pos >= 72 && x_pos <= 74 && y_pos >= spectrogram[16*6 +:6]) begin
            pixel_data <= (bar17hover && sw[0]) ? BLUE : barcolor(16);
        end
        else if (x_pos >= 76 && x_pos <= 78 && y_pos >= spectrogram[17*6 +:6]) begin
            pixel_data <= (bar18hover && sw[0]) ? BLUE : barcolor(17);
        end
        else if (x_pos >= 80 && x_pos <= 82 && y_pos >= spectrogram[18*6 +:6]) begin
            pixel_data <= (bar19hover && sw[0]) ? BLUE : barcolor(18);
        end
        else if (x_pos >= 84 && x_pos <= 86 && y_pos >= spectrogram[19*6 +:6]) begin
            pixel_data <= (bar20hover && sw[0]) ? BLUE : barcolor(19);
        end

        if (sw[0]) begin
            if (mouse_pos) begin
                pixel_data <= RED;
            end
            else if (bar_info_border_only) begin
                pixel_data <= WHITE;
            end

            if (bar1hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar1_20khz) ? WHITE : BLACK;
                end
            end

            if (bar2hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar2_20khz) ? WHITE : BLACK;
                end
            end

            if (bar3hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar3_20khz) ? WHITE : BLACK;
                end
            end

            if (bar4hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar4_20khz) ? WHITE : BLACK;
                end
            end

            if (bar5hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar5_20khz) ? WHITE : BLACK;
                end
            end

            if (bar6hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar6_20khz) ? WHITE : BLACK;
                end
            end

            if (bar7hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar7_20khz) ? WHITE : BLACK;
                end
            end

            if (bar8hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar8_20khz) ? WHITE : BLACK;
                end
            end

            if (bar9hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar9_20khz) ? WHITE : BLACK;
                end
            end

            if (bar10hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar10_20khz) ? WHITE : BLACK;
                end
            end

            if (bar11hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar11_20khz) ? WHITE : BLACK;
                end
            end

            if (bar12hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar12_20khz) ? WHITE : BLACK;
                end
            end

            if (bar13hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar13_20khz) ? WHITE : BLACK;
                end
            end

            if (bar14hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar14_20khz) ? WHITE : BLACK;
                end
            end

            if (bar15hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar15_20khz) ? WHITE : BLACK;
                end
            end

            if (bar16hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar16_20khz) ? WHITE : BLACK;
                end
            end

            if (bar17hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar17_20khz) ? WHITE : BLACK;
                end
            end

            if (bar18hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar18_20khz) ? WHITE : BLACK;
                end
            end

            if (bar19hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar19_20khz) ? WHITE : BLACK;
                end
            end

            if (bar20hover) begin
                if (bar_border_area) begin
                    pixel_data <= (bar20_20khz) ? WHITE : BLACK;
                end
            end
        end
    end
endmodule
