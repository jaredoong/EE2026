`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2023 01:58:07
// Design Name: 
// Module Name: keyboard_typer
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


module keyboard_typer(
    input [15:0] sw,
    input [12:0] pixel_index,
    input left_click,
    input right_click,
    input [6:0] cursor_x,
    input [6:0] cursor_y,
    input [6:0] diff_x,
    input [6:0] diff_y,
    output reg [3:0] cursor_size = 2,
    output reg [15:0] pixel_data = 0
    );

    localparam WHITE = 16'hFFFF;
    localparam BLACK = 16'h0000;
    localparam GREEN = 16'h07E0;
    localparam RED = 16'hF800;
    localparam BLUE = 16'h001F;
    localparam YELLOW = 16'hFFE0;
    localparam CYAN = 16'h07FF;
    localparam MAGENTA = 16'hF81F;
    localparam ORANGE = 16'hFC00;

    parameter KEYBOARD_COLOUR = WHITE;
    parameter HOVER_COLOURED = GREEN;
    parameter HOVER_NOT_COLOURED = WHITE;

    wire [6:0] x_pos;
    wire [5:0] y_pos;
    
    assign x_pos = pixel_index % 96;
    assign y_pos = pixel_index / 96;

    assign mouse_pos = (diff_x < cursor_size) && (diff_y < cursor_size);

    // Keyboard borders // ! Not used anymore
    assign letter_A_border = (x_pos >= 0 && x_pos <= 8) && (y_pos >= 39 && y_pos <= 47);
    assign letter_B_border = (x_pos >= 8 && x_pos <= 16) && (y_pos >= 39 && y_pos <= 47);
    assign letter_C_border = (x_pos >= 16 && x_pos <= 23) && (y_pos >= 39 && y_pos <= 47);
    assign letter_D_border = (x_pos >= 23 && x_pos <= 31) && (y_pos >= 39 && y_pos <= 47);
    assign letter_E_border = (x_pos >= 31 && x_pos <= 39) && (y_pos >= 39 && y_pos <= 47);
    assign letter_F_border = (x_pos >= 39 && x_pos <= 47) && (y_pos >= 39 && y_pos <= 47);
    assign letter_G_border = (x_pos >= 47 && x_pos <= 55) && (y_pos >= 39 && y_pos <= 47);
    assign letter_H_border = (x_pos >= 55 && x_pos <= 63) && (y_pos >= 39 && y_pos <= 47);
    assign letter_I_border = (x_pos >= 63 && x_pos <= 71) && (y_pos >= 39 && y_pos <= 47);
    assign letter_J_border = (x_pos >= 71 && x_pos <= 79) && (y_pos >= 39 && y_pos <= 47);
    assign letter_K_border = (x_pos >= 79 && x_pos <= 87) && (y_pos >= 39 && y_pos <= 47);
    assign letter_L_border = (x_pos >= 87 && x_pos <= 95) && (y_pos >= 39 && y_pos <= 47);
    assign letter_M_border = (x_pos >= 0 && x_pos <= 8) && (y_pos >= 47 && y_pos <= 55);
    assign letter_N_border = (x_pos >= 8 && x_pos <= 16) && (y_pos >= 47 && y_pos <= 55);
    assign letter_O_border = (x_pos >= 16 && x_pos <= 23) && (y_pos >= 47 && y_pos <= 55);
    assign letter_P_border = (x_pos >= 23 && x_pos <= 31) && (y_pos >= 47 && y_pos <= 55);
    assign letter_Q_border = (x_pos >= 31 && x_pos <= 39) && (y_pos >= 47 && y_pos <= 55);
    assign letter_R_border = (x_pos >= 39 && x_pos <= 47) && (y_pos >= 47 && y_pos <= 55);
    assign letter_S_border = (x_pos >= 47 && x_pos <= 55) && (y_pos >= 47 && y_pos <= 55);
    assign letter_T_border = (x_pos >= 55 && x_pos <= 63) && (y_pos >= 47 && y_pos <= 55);
    assign letter_U_border = (x_pos >= 63 && x_pos <= 71) && (y_pos >= 47 && y_pos <= 55);
    assign letter_V_border = (x_pos >= 71 && x_pos <= 79) && (y_pos >= 47 && y_pos <= 55);
    assign letter_W_border = (x_pos >= 79 && x_pos <= 87) && (y_pos >= 47 && y_pos <= 55);
    assign letter_X_border = (x_pos >= 87 && x_pos <= 95) && (y_pos >= 47 && y_pos <= 55);
    assign letter_Y_border = (x_pos >= 0 && x_pos <= 8) && (y_pos >= 55 && y_pos <= 63);
    assign letter_Z_border = (x_pos >= 8 && x_pos <= 16) && (y_pos >= 55 && y_pos <= 63);
    assign number_0_border = (x_pos >= 16 && x_pos <= 23) && (y_pos >= 55 && y_pos <= 63);
    assign number_1_border = (x_pos >= 23 && x_pos <= 31) && (y_pos >= 55 && y_pos <= 63);
    assign number_2_border = (x_pos >= 31 && x_pos <= 39) && (y_pos >= 55 && y_pos <= 63);
    assign number_3_border = (x_pos >= 39 && x_pos <= 47) && (y_pos >= 55 && y_pos <= 63);
    assign number_4_border = (x_pos >= 47 && x_pos <= 55) && (y_pos >= 55 && y_pos <= 63);
    assign number_5_border = (x_pos >= 55 && x_pos <= 63) && (y_pos >= 55 && y_pos <= 63);
    assign number_6_border = (x_pos >= 63 && x_pos <= 71) && (y_pos >= 55 && y_pos <= 63);
    assign number_7_border = (x_pos >= 71 && x_pos <= 79) && (y_pos >= 55 && y_pos <= 63);
    assign number_8_border = (x_pos >= 79 && x_pos <= 87) && (y_pos >= 55 && y_pos <= 63);
    assign number_9_border = (x_pos >= 87 && x_pos <= 95) && (y_pos >= 55 && y_pos <= 63);
    assign clear_border = (x_pos >= 0 && x_pos <= 31) && (y_pos >= 31 && y_pos <= 49);
    assign del_border = (x_pos >= 31 && x_pos <= 55) && (y_pos >= 31 && y_pos <= 49);
    assign enter_border = (x_pos >= 55 && x_pos <= 79) && (y_pos >= 31 && y_pos <= 49);
    assign spacebar_border = (x_pos >= 79 && x_pos <= 95) && (y_pos >= 31 && y_pos <= 49);

    // Border of entire keyboard
    assign keyboard_border = (((x_pos >= 0 && x_pos <= 95) && y_pos == 31) || (x_pos == 0 && y_pos == 32) || (x_pos == 31 && y_pos == 32) || (x_pos == 55 && y_pos == 32) || (x_pos == 79 && y_pos == 32) || (x_pos == 0 && y_pos == 33) || (x_pos == 31 && y_pos == 33) || (x_pos == 55 && y_pos == 33) || (x_pos == 79 && y_pos == 33) || (x_pos == 0 && y_pos == 34) || (x_pos == 31 && y_pos == 34) || (x_pos == 55 && y_pos == 34) || (x_pos == 79 && y_pos == 34) || (x_pos == 0 && y_pos == 35) || (x_pos == 31 && y_pos == 35) || (x_pos == 55 && y_pos == 35) || (x_pos == 79 && y_pos == 35) || (x_pos == 0 && y_pos == 36) || (x_pos == 31 && y_pos == 36) || (x_pos == 55 && y_pos == 36) || (x_pos == 79 && y_pos == 36) || (x_pos == 0 && y_pos == 37) || (x_pos == 31 && y_pos == 37) || (x_pos == 55 && y_pos == 37) || (x_pos == 79 && y_pos == 37) || (x_pos == 0 && y_pos == 38) || (x_pos == 31 && y_pos == 38) || (x_pos == 55 && y_pos == 38) || (x_pos == 79 && y_pos == 38) || ((x_pos >= 0 && x_pos <= 95) && y_pos == 39) || (x_pos == 0 && y_pos == 40) || (x_pos == 8 && y_pos == 40) || (x_pos == 16 && y_pos == 40) || (x_pos == 23 && y_pos == 40) || (x_pos == 31 && y_pos == 40) || (x_pos == 39 && y_pos == 40) || (x_pos == 47 && y_pos == 40) || (x_pos == 55 && y_pos == 40) || (x_pos == 63 && y_pos == 40) || (x_pos == 71 && y_pos == 40) || (x_pos == 79 && y_pos == 40) || (x_pos == 87 && y_pos == 40) || (x_pos == 0 && y_pos == 41) || (x_pos == 8 && y_pos == 41) || (x_pos == 16 && y_pos == 41) || (x_pos == 23 && y_pos == 41) || (x_pos == 31 && y_pos == 41) || (x_pos == 39 && y_pos == 41) || (x_pos == 47 && y_pos == 41) || (x_pos == 55 && y_pos == 41) || (x_pos == 63 && y_pos == 41) || (x_pos == 71 && y_pos == 41) || (x_pos == 79 && y_pos == 41) || (x_pos == 87 && y_pos == 41) || (x_pos == 0 && y_pos == 42) || (x_pos == 8 && y_pos == 42) || (x_pos == 16 && y_pos == 42) || (x_pos == 23 && y_pos == 42) || (x_pos == 31 && y_pos == 42) || (x_pos == 39 && y_pos == 42) || (x_pos == 47 && y_pos == 42) || (x_pos == 55 && y_pos == 42) || (x_pos == 63 && y_pos == 42) || (x_pos == 71 && y_pos == 42) || (x_pos == 79 && y_pos == 42) || (x_pos == 87 && y_pos == 42) || (x_pos == 0 && y_pos == 43) || (x_pos == 8 && y_pos == 43) || (x_pos == 16 && y_pos == 43) || (x_pos == 23 && y_pos == 43) || (x_pos == 31 && y_pos == 43) || (x_pos == 39 && y_pos == 43) || (x_pos == 47 && y_pos == 43) || (x_pos == 55 && y_pos == 43) || (x_pos == 63 && y_pos == 43) || (x_pos == 71 && y_pos == 43) || (x_pos == 79 && y_pos == 43) || (x_pos == 87 && y_pos == 43) || (x_pos == 0 && y_pos == 44) || (x_pos == 8 && y_pos == 44) || (x_pos == 16 && y_pos == 44) || (x_pos == 23 && y_pos == 44) || (x_pos == 31 && y_pos == 44) || (x_pos == 39 && y_pos == 44) || (x_pos == 47 && y_pos == 44) || (x_pos == 55 && y_pos == 44) || (x_pos == 63 && y_pos == 44) || (x_pos == 71 && y_pos == 44) || (x_pos == 79 && y_pos == 44) || (x_pos == 87 && y_pos == 44) || (x_pos == 0 && y_pos == 45) || (x_pos == 8 && y_pos == 45) || (x_pos == 16 && y_pos == 45) || (x_pos == 23 && y_pos == 45) || (x_pos == 31 && y_pos == 45) || (x_pos == 39 && y_pos == 45) || (x_pos == 47 && y_pos == 45) || (x_pos == 55 && y_pos == 45) || (x_pos == 63 && y_pos == 45) || (x_pos == 71 && y_pos == 45) || (x_pos == 79 && y_pos == 45) || (x_pos == 87 && y_pos == 45) || (x_pos == 0 && y_pos == 46) || (x_pos == 8 && y_pos == 46) || (x_pos == 16 && y_pos == 46) || (x_pos == 23 && y_pos == 46) || (x_pos == 31 && y_pos == 46) || (x_pos == 39 && y_pos == 46) || (x_pos == 47 && y_pos == 46) || (x_pos == 55 && y_pos == 46) || (x_pos == 63 && y_pos == 46) || (x_pos == 71 && y_pos == 46) || (x_pos == 79 && y_pos == 46) || (x_pos == 87 && y_pos == 46) || ((x_pos >= 0 && x_pos <= 95) && y_pos == 47) || (x_pos == 0 && y_pos == 48) || (x_pos == 8 && y_pos == 48) || (x_pos == 16 && y_pos == 48) || (x_pos == 23 && y_pos == 48) || (x_pos == 31 && y_pos == 48) || (x_pos == 39 && y_pos == 48) || (x_pos == 47 && y_pos == 48) || (x_pos == 55 && y_pos == 48) || (x_pos == 63 && y_pos == 48) || (x_pos == 71 && y_pos == 48) || (x_pos == 79 && y_pos == 48) || (x_pos == 87 && y_pos == 48) || (x_pos == 0 && y_pos == 49) || (x_pos == 8 && y_pos == 49) || (x_pos == 16 && y_pos == 49) || (x_pos == 23 && y_pos == 49) || (x_pos == 31 && y_pos == 49) || (x_pos == 39 && y_pos == 49) || (x_pos == 47 && y_pos == 49) || (x_pos == 55 && y_pos == 49) || (x_pos == 63 && y_pos == 49) || (x_pos == 71 && y_pos == 49) || (x_pos == 79 && y_pos == 49) || (x_pos == 87 && y_pos == 49) || (x_pos == 0 && y_pos == 50) || (x_pos == 8 && y_pos == 50) || (x_pos == 16 && y_pos == 50) || (x_pos == 23 && y_pos == 50) || (x_pos == 31 && y_pos == 50) || (x_pos == 39 && y_pos == 50) || (x_pos == 47 && y_pos == 50) || (x_pos == 55 && y_pos == 50) || (x_pos == 63 && y_pos == 50) || (x_pos == 71 && y_pos == 50) || (x_pos == 79 && y_pos == 50) || (x_pos == 87 && y_pos == 50) || (x_pos == 0 && y_pos == 51) || (x_pos == 8 && y_pos == 51) || (x_pos == 16 && y_pos == 51) || (x_pos == 23 && y_pos == 51) || (x_pos == 31 && y_pos == 51) || (x_pos == 39 && y_pos == 51) || (x_pos == 47 && y_pos == 51) || (x_pos == 55 && y_pos == 51) || (x_pos == 63 && y_pos == 51) || (x_pos == 71 && y_pos == 51) || (x_pos == 79 && y_pos == 51) || (x_pos == 87 && y_pos == 51) || (x_pos == 0 && y_pos == 52) || (x_pos == 8 && y_pos == 52) || (x_pos == 16 && y_pos == 52) || (x_pos == 23 && y_pos == 52) || (x_pos == 31 && y_pos == 52) || (x_pos == 39 && y_pos == 52) || (x_pos == 47 && y_pos == 52) || (x_pos == 55 && y_pos == 52) || (x_pos == 63 && y_pos == 52) || (x_pos == 71 && y_pos == 52) || (x_pos == 79 && y_pos == 52) || (x_pos == 87 && y_pos == 52) || (x_pos == 0 && y_pos == 53) || (x_pos == 8 && y_pos == 53) || (x_pos == 16 && y_pos == 53) || (x_pos == 23 && y_pos == 53) || (x_pos == 31 && y_pos == 53) || (x_pos == 39 && y_pos == 53) || (x_pos == 47 && y_pos == 53) || (x_pos == 55 && y_pos == 53) || (x_pos == 63 && y_pos == 53) || (x_pos == 71 && y_pos == 53) || (x_pos == 79 && y_pos == 53) || (x_pos == 87 && y_pos == 53) || (x_pos == 0 && y_pos == 54) || (x_pos == 8 && y_pos == 54) || (x_pos == 16 && y_pos == 54) || (x_pos == 23 && y_pos == 54) || (x_pos == 31 && y_pos == 54) || (x_pos == 39 && y_pos == 54) || (x_pos == 47 && y_pos == 54) || (x_pos == 55 && y_pos == 54) || (x_pos == 63 && y_pos == 54) || (x_pos == 71 && y_pos == 54) || (x_pos == 79 && y_pos == 54) || (x_pos == 87 && y_pos == 54) || ((x_pos >= 0 && x_pos <= 95) && y_pos == 55) || (x_pos == 0 && y_pos == 56) || (x_pos == 8 && y_pos == 56) || (x_pos == 16 && y_pos == 56) || (x_pos == 23 && y_pos == 56) || (x_pos == 31 && y_pos == 56) || (x_pos == 39 && y_pos == 56) || (x_pos == 47 && y_pos == 56) || (x_pos == 55 && y_pos == 56) || (x_pos == 63 && y_pos == 56) || (x_pos == 71 && y_pos == 56) || (x_pos == 79 && y_pos == 56) || (x_pos == 87 && y_pos == 56) || (x_pos == 0 && y_pos == 57) || (x_pos == 8 && y_pos == 57) || (x_pos == 16 && y_pos == 57) || (x_pos == 23 && y_pos == 57) || (x_pos == 31 && y_pos == 57) || (x_pos == 39 && y_pos == 57) || (x_pos == 47 && y_pos == 57) || (x_pos == 55 && y_pos == 57) || (x_pos == 63 && y_pos == 57) || (x_pos == 71 && y_pos == 57) || (x_pos == 79 && y_pos == 57) || (x_pos == 87 && y_pos == 57) || (x_pos == 0 && y_pos == 58) || (x_pos == 8 && y_pos == 58) || (x_pos == 16 && y_pos == 58) || (x_pos == 23 && y_pos == 58) || (x_pos == 31 && y_pos == 58) || (x_pos == 39 && y_pos == 58) || (x_pos == 47 && y_pos == 58) || (x_pos == 55 && y_pos == 58) || (x_pos == 63 && y_pos == 58) || (x_pos == 71 && y_pos == 58) || (x_pos == 79 && y_pos == 58) || (x_pos == 87 && y_pos == 58) || (x_pos == 0 && y_pos == 59) || (x_pos == 8 && y_pos == 59) || (x_pos == 16 && y_pos == 59) || (x_pos == 23 && y_pos == 59) || (x_pos == 31 && y_pos == 59) || (x_pos == 39 && y_pos == 59) || (x_pos == 47 && y_pos == 59) || (x_pos == 55 && y_pos == 59) || (x_pos == 63 && y_pos == 59) || (x_pos == 71 && y_pos == 59) || (x_pos == 79 && y_pos == 59) || (x_pos == 87 && y_pos == 59) || (x_pos == 0 && y_pos == 60) || (x_pos == 8 && y_pos == 60) || (x_pos == 16 && y_pos == 60) || (x_pos == 23 && y_pos == 60) || (x_pos == 31 && y_pos == 60) || (x_pos == 39 && y_pos == 60) || (x_pos == 47 && y_pos == 60) || (x_pos == 55 && y_pos == 60) || (x_pos == 63 && y_pos == 60) || (x_pos == 71 && y_pos == 60) || (x_pos == 79 && y_pos == 60) || (x_pos == 87 && y_pos == 60) || (x_pos == 0 && y_pos == 61) || (x_pos == 8 && y_pos == 61) || (x_pos == 16 && y_pos == 61) || (x_pos == 23 && y_pos == 61) || (x_pos == 31 && y_pos == 61) || (x_pos == 39 && y_pos == 61) || (x_pos == 47 && y_pos == 61) || (x_pos == 55 && y_pos == 61) || (x_pos == 63 && y_pos == 61) || (x_pos == 71 && y_pos == 61) || (x_pos == 79 && y_pos == 61) || (x_pos == 87 && y_pos == 61) || (x_pos == 0 && y_pos == 62) || (x_pos == 8 && y_pos == 62) || (x_pos == 16 && y_pos == 62) || (x_pos == 23 && y_pos == 62) || (x_pos == 31 && y_pos == 62) || (x_pos == 39 && y_pos == 62) || (x_pos == 47 && y_pos == 62) || (x_pos == 55 && y_pos == 62) || (x_pos == 63 && y_pos == 62) || (x_pos == 71 && y_pos == 62) || (x_pos == 79 && y_pos == 62) || (x_pos == 87 && y_pos == 62) || ((x_pos >= 0 && x_pos <= 95) && y_pos == 63));

    // Keyboard hovers
    assign letter_A_hover = (letter_A_border && (cursor_x > 0 && cursor_x < 8) && (cursor_y > 39 && cursor_y < 47)) ? 1: 0;
    assign letter_B_hover = (letter_B_border && (cursor_x > 8 && cursor_x < 16) && (cursor_y > 39 && cursor_y < 47)) ? 1: 0;
    assign letter_C_hover = (letter_C_border && (cursor_x > 16 && cursor_x < 23) && (cursor_y > 39 && cursor_y < 47)) ? 1: 0;
    assign letter_D_hover = (letter_D_border && (cursor_x > 23 && cursor_x < 31) && (cursor_y > 39 && cursor_y < 47)) ? 1: 0;
    assign letter_E_hover = (letter_E_border && (cursor_x > 31 && cursor_x < 39) && (cursor_y > 39 && cursor_y < 47)) ? 1: 0;
    assign letter_F_hover = (letter_F_border && (cursor_x > 39 && cursor_x < 47) && (cursor_y > 39 && cursor_y < 47)) ? 1: 0;
    assign letter_G_hover = (letter_G_border && (cursor_x > 47 && cursor_x < 55) && (cursor_y > 39 && cursor_y < 47)) ? 1: 0;
    assign letter_H_hover = (letter_H_border && (cursor_x > 55 && cursor_x < 63) && (cursor_y > 39 && cursor_y < 47)) ? 1: 0;
    assign letter_I_hover = (letter_I_border && (cursor_x > 63 && cursor_x < 71) && (cursor_y > 39 && cursor_y < 47)) ? 1: 0;
    assign letter_J_hover = (letter_J_border && (cursor_x > 71 && cursor_x < 79) && (cursor_y > 39 && cursor_y < 47)) ? 1: 0;
    assign letter_K_hover = (letter_K_border && (cursor_x > 79 && cursor_x < 87) && (cursor_y > 39 && cursor_y < 47)) ? 1: 0;
    assign letter_L_hover = (letter_L_border && (cursor_x > 87 && cursor_x < 95) && (cursor_y > 39 && cursor_y < 47)) ? 1: 0;
    assign letter_M_hover = (letter_M_border && (cursor_x > 0 && cursor_x < 8) && (cursor_y > 47 && cursor_y < 55)) ? 1: 0;
    assign letter_N_hover = (letter_N_border && (cursor_x > 8 && cursor_x < 16) && (cursor_y > 47 && cursor_y < 55)) ? 1: 0;
    assign letter_O_hover = (letter_O_border && (cursor_x > 16 && cursor_x < 23) && (cursor_y > 47 && cursor_y < 55)) ? 1: 0;
    assign letter_P_hover = (letter_P_border && (cursor_x > 23 && cursor_x < 31) && (cursor_y > 47 && cursor_y < 55)) ? 1: 0;
    assign letter_Q_hover = (letter_Q_border && (cursor_x > 31 && cursor_x < 39) && (cursor_y > 47 && cursor_y < 55)) ? 1: 0;
    assign letter_R_hover = (letter_R_border && (cursor_x > 39 && cursor_x < 47) && (cursor_y > 47 && cursor_y < 55)) ? 1: 0;
    assign letter_S_hover = (letter_S_border && (cursor_x > 47 && cursor_x < 55) && (cursor_y > 47 && cursor_y < 55)) ? 1: 0;
    assign letter_T_hover = (letter_T_border && (cursor_x > 55 && cursor_x < 63) && (cursor_y > 47 && cursor_y < 55)) ? 1: 0;
    assign letter_U_hover = (letter_U_border && (cursor_x > 63 && cursor_x < 71) && (cursor_y > 47 && cursor_y < 55)) ? 1: 0;
    assign letter_V_hover = (letter_V_border && (cursor_x > 71 && cursor_x < 79) && (cursor_y > 47 && cursor_y < 55)) ? 1: 0;
    assign letter_W_hover = (letter_W_border && (cursor_x > 79 && cursor_x < 87) && (cursor_y > 47 && cursor_y < 55)) ? 1: 0;
    assign letter_X_hover = (letter_X_border && (cursor_x > 87 && cursor_x < 95) && (cursor_y > 47 && cursor_y < 55)) ? 1: 0;
    assign letter_Y_hover = (letter_Y_border && (cursor_x > 0 && cursor_x < 8) && (cursor_y > 55 && cursor_y < 63)) ? 1: 0;
    assign letter_Z_hover = (letter_Z_border && (cursor_x > 8 && cursor_x < 16) && (cursor_y > 55 && cursor_y < 63)) ? 1: 0;
    assign number_0_hover = (number_0_border && (cursor_x > 16 && cursor_x < 23) && (cursor_y > 55 && cursor_y < 63)) ? 1: 0;
    assign number_1_hover = (number_1_border && (cursor_x > 23 && cursor_x < 31) && (cursor_y > 55 && cursor_y < 63)) ? 1: 0;
    assign number_2_hover = (number_2_border && (cursor_x > 31 && cursor_x < 39) && (cursor_y > 55 && cursor_y < 63)) ? 1: 0;
    assign number_3_hover = (number_3_border && (cursor_x > 39 && cursor_x < 47) && (cursor_y > 55 && cursor_y < 63)) ? 1: 0;
    assign number_4_hover = (number_4_border && (cursor_x > 47 && cursor_x < 55) && (cursor_y > 55 && cursor_y < 63)) ? 1: 0;
    assign number_5_hover = (number_5_border && (cursor_x > 55 && cursor_x < 63) && (cursor_y > 55 && cursor_y < 63)) ? 1: 0;
    assign number_6_hover = (number_6_border && (cursor_x > 63 && cursor_x < 71) && (cursor_y > 55 && cursor_y < 63)) ? 1: 0;
    assign number_7_hover = (number_7_border && (cursor_x > 71 && cursor_x < 79) && (cursor_y > 55 && cursor_y < 63)) ? 1: 0;
    assign number_8_hover = (number_8_border && (cursor_x > 79 && cursor_x < 87) && (cursor_y > 55 && cursor_y < 63)) ? 1: 0;
    assign number_9_hover = (number_9_border && (cursor_x > 87 && cursor_x < 95) && (cursor_y > 55 && cursor_y < 63)) ? 1: 0;
    assign clear_hover = (clear_border && (cursor_x > 0 && cursor_x < 31) && (cursor_y > 31 && cursor_y < 39)) ? 1: 0;
    assign del_hover = (del_border && (cursor_x > 31 && cursor_x < 55) && (cursor_y > 31 && cursor_y < 39)) ? 1: 0;
    assign enter_hover = (enter_border && (cursor_x > 55 && cursor_x < 79) && (cursor_y > 31 && cursor_y < 39)) ? 1: 0;
    assign spacebar_hover = (spacebar_border && (cursor_x > 79 && cursor_x < 95) && (cursor_y > 31 && cursor_y < 39)) ? 1: 0;

    // For individual keys
    assign letter_A = (((x_pos >= 0 && x_pos <= 8) && y_pos == 39) || (x_pos == 0 && y_pos == 40) || (x_pos == 8 && y_pos == 40) || (x_pos == 0 && y_pos == 41) || ((x_pos >= 2 && x_pos <= 6) && y_pos == 41) || (x_pos == 8 && y_pos == 41) || (x_pos == 0 && y_pos == 42) || (x_pos == 2 && y_pos == 42) || (x_pos == 6 && y_pos == 42) || (x_pos == 8 && y_pos == 42) || (x_pos == 0 && y_pos == 43) || ((x_pos >= 2 && x_pos <= 6) && y_pos == 43) || (x_pos == 8 && y_pos == 43) || (x_pos == 0 && y_pos == 44) || (x_pos == 2 && y_pos == 44) || (x_pos == 6 && y_pos == 44) || (x_pos == 8 && y_pos == 44) || (x_pos == 0 && y_pos == 45) || (x_pos == 2 && y_pos == 45) || (x_pos == 6 && y_pos == 45) || (x_pos == 8 && y_pos == 45) || (x_pos == 0 && y_pos == 46) || (x_pos == 8 && y_pos == 46) || ((x_pos >= 0 && x_pos <= 8) && y_pos == 47));

    assign letter_B = (((x_pos >= 8 && x_pos <= 16) && y_pos == 39) || (x_pos == 8 && y_pos == 40) || (x_pos == 16 && y_pos == 40) || (x_pos == 8 && y_pos == 41) || ((x_pos >= 10 && x_pos <= 13) && y_pos == 41) || (x_pos == 16 && y_pos == 41) || (x_pos == 8 && y_pos == 42) || (x_pos == 10 && y_pos == 42) || (x_pos == 14 && y_pos == 42) || (x_pos == 16 && y_pos == 42) || (x_pos == 8 && y_pos == 43) || ((x_pos >= 10 && x_pos <= 14) && y_pos == 43) || (x_pos == 16 && y_pos == 43) || (x_pos == 8 && y_pos == 44) || (x_pos == 10 && y_pos == 44) || (x_pos == 14 && y_pos == 44) || (x_pos == 16 && y_pos == 44) || (x_pos == 8 && y_pos == 45) || ((x_pos >= 10 && x_pos <= 13) && y_pos == 45) || (x_pos == 16 && y_pos == 45) || (x_pos == 8 && y_pos == 46) || (x_pos == 16 && y_pos == 46) || ((x_pos >= 8 && x_pos <= 16) && y_pos == 47));

    assign letter_C = (((x_pos >= 16 && x_pos <= 23) && y_pos == 39) || (x_pos == 16 && y_pos == 40) || (x_pos == 23 && y_pos == 40) || (x_pos == 16 && y_pos == 41) || ((x_pos >= 18 && x_pos <= 21) && y_pos == 41) || (x_pos == 23 && y_pos == 41) || (x_pos == 16 && y_pos == 42) || (x_pos == 18 && y_pos == 42) || (x_pos == 23 && y_pos == 42) || (x_pos == 16 && y_pos == 43) || (x_pos == 18 && y_pos == 43) || (x_pos == 23 && y_pos == 43) || (x_pos == 16 && y_pos == 44) || (x_pos == 18 && y_pos == 44) || (x_pos == 23 && y_pos == 44) || (x_pos == 16 && y_pos == 45) || ((x_pos >= 18 && x_pos <= 21) && y_pos == 45) || (x_pos == 23 && y_pos == 45) || (x_pos == 16 && y_pos == 46) || (x_pos == 23 && y_pos == 46) || ((x_pos >= 16 && x_pos <= 23) && y_pos == 47));

    assign letter_D = (((x_pos >= 23 && x_pos <= 31) && y_pos == 39) || (x_pos == 23 && y_pos == 40) || (x_pos == 31 && y_pos == 40) || (x_pos == 23 && y_pos == 41) || ((x_pos >= 25 && x_pos <= 28) && y_pos == 41) || (x_pos == 31 && y_pos == 41) || (x_pos == 23 && y_pos == 42) || (x_pos == 25 && y_pos == 42) || (x_pos == 29 && y_pos == 42) || (x_pos == 31 && y_pos == 42) || (x_pos == 23 && y_pos == 43) || (x_pos == 25 && y_pos == 43) || (x_pos == 29 && y_pos == 43) || (x_pos == 31 && y_pos == 43) || (x_pos == 23 && y_pos == 44) || (x_pos == 25 && y_pos == 44) || (x_pos == 29 && y_pos == 44) || (x_pos == 31 && y_pos == 44) || (x_pos == 23 && y_pos == 45) || ((x_pos >= 25 && x_pos <= 28) && y_pos == 45) || (x_pos == 31 && y_pos == 45) || (x_pos == 23 && y_pos == 46) || (x_pos == 31 && y_pos == 46) || ((x_pos >= 23 && x_pos <= 31) && y_pos == 47));

    assign letter_E = (((x_pos >= 31 && x_pos <= 39) && y_pos == 39) || (x_pos == 31 && y_pos == 40) || (x_pos == 39 && y_pos == 40) || (x_pos == 31 && y_pos == 41) || ((x_pos >= 33 && x_pos <= 37) && y_pos == 41) || (x_pos == 39 && y_pos == 41) || (x_pos == 31 && y_pos == 42) || (x_pos == 33 && y_pos == 42) || (x_pos == 39 && y_pos == 42) || (x_pos == 31 && y_pos == 43) || ((x_pos >= 33 && x_pos <= 36) && y_pos == 43) || (x_pos == 39 && y_pos == 43) || (x_pos == 31 && y_pos == 44) || (x_pos == 33 && y_pos == 44) || (x_pos == 39 && y_pos == 44) || (x_pos == 31 && y_pos == 45) || ((x_pos >= 33 && x_pos <= 37) && y_pos == 45) || (x_pos == 39 && y_pos == 45) || (x_pos == 31 && y_pos == 46) || (x_pos == 39 && y_pos == 46) || ((x_pos >= 31 && x_pos <= 39) && y_pos == 47));

    assign letter_F = (((x_pos >= 39 && x_pos <= 47) && y_pos == 39) || (x_pos == 39 && y_pos == 40) || (x_pos == 47 && y_pos == 40) || (x_pos == 39 && y_pos == 41) || ((x_pos >= 41 && x_pos <= 45) && y_pos == 41) || (x_pos == 47 && y_pos == 41) || (x_pos == 39 && y_pos == 42) || (x_pos == 41 && y_pos == 42) || (x_pos == 47 && y_pos == 42) || (x_pos == 39 && y_pos == 43) || ((x_pos >= 41 && x_pos <= 44) && y_pos == 43) || (x_pos == 47 && y_pos == 43) || (x_pos == 39 && y_pos == 44) || (x_pos == 41 && y_pos == 44) || (x_pos == 47 && y_pos == 44) || (x_pos == 39 && y_pos == 45) || (x_pos == 41 && y_pos == 45) || (x_pos == 47 && y_pos == 45) || (x_pos == 39 && y_pos == 46) || (x_pos == 47 && y_pos == 46) || ((x_pos >= 39 && x_pos <= 47) && y_pos == 47));

    assign letter_G = (((x_pos >= 47 && x_pos <= 55) && y_pos == 39) || (x_pos == 47 && y_pos == 40) || (x_pos == 55 && y_pos == 40) || (x_pos == 47 && y_pos == 41) || ((x_pos >= 49 && x_pos <= 53) && y_pos == 41) || (x_pos == 55 && y_pos == 41) || (x_pos == 47 && y_pos == 42) || (x_pos == 49 && y_pos == 42) || (x_pos == 55 && y_pos == 42) || (x_pos == 47 && y_pos == 43) || (x_pos == 49 && y_pos == 43) || ((x_pos >= 51 && x_pos <= 53) && y_pos == 43) || (x_pos == 55 && y_pos == 43) || (x_pos == 47 && y_pos == 44) || (x_pos == 49 && y_pos == 44) || (x_pos == 53 && y_pos == 44) || (x_pos == 55 && y_pos == 44) || (x_pos == 47 && y_pos == 45) || ((x_pos >= 49 && x_pos <= 53) && y_pos == 45) || (x_pos == 55 && y_pos == 45) || (x_pos == 47 && y_pos == 46) || (x_pos == 55 && y_pos == 46) || ((x_pos >= 47 && x_pos <= 55) && y_pos == 47));

    assign letter_H = (((x_pos >= 55 && x_pos <= 63) && y_pos == 39) || (x_pos == 55 && y_pos == 40) || (x_pos == 63 && y_pos == 40) || (x_pos == 55 && y_pos == 41) || (x_pos == 57 && y_pos == 41) || (x_pos == 61 && y_pos == 41) || (x_pos == 63 && y_pos == 41) || (x_pos == 55 && y_pos == 42) || (x_pos == 57 && y_pos == 42) || (x_pos == 61 && y_pos == 42) || (x_pos == 63 && y_pos == 42) || (x_pos == 55 && y_pos == 43) || ((x_pos >= 57 && x_pos <= 61) && y_pos == 43) || (x_pos == 63 && y_pos == 43) || (x_pos == 55 && y_pos == 44) || (x_pos == 57 && y_pos == 44) || (x_pos == 61 && y_pos == 44) || (x_pos == 63 && y_pos == 44) || (x_pos == 55 && y_pos == 45) || (x_pos == 57 && y_pos == 45) || (x_pos == 61 && y_pos == 45) || (x_pos == 63 && y_pos == 45) || (x_pos == 55 && y_pos == 46) || (x_pos == 63 && y_pos == 46) || ((x_pos >= 55 && x_pos <= 63) && y_pos == 47));

    assign letter_I = (((x_pos >= 63 && x_pos <= 71) && y_pos == 39) || (x_pos == 63 && y_pos == 40) || (x_pos == 71 && y_pos == 40) || (x_pos == 63 && y_pos == 41) || ((x_pos >= 65 && x_pos <= 69) && y_pos == 41) || (x_pos == 71 && y_pos == 41) || (x_pos == 63 && y_pos == 42) || (x_pos == 67 && y_pos == 42) || (x_pos == 71 && y_pos == 42) || (x_pos == 63 && y_pos == 43) || (x_pos == 67 && y_pos == 43) || (x_pos == 71 && y_pos == 43) || (x_pos == 63 && y_pos == 44) || (x_pos == 67 && y_pos == 44) || (x_pos == 71 && y_pos == 44) || (x_pos == 63 && y_pos == 45) || ((x_pos >= 65 && x_pos <= 69) && y_pos == 45) || (x_pos == 71 && y_pos == 45) || (x_pos == 63 && y_pos == 46) || (x_pos == 71 && y_pos == 46) || ((x_pos >= 63 && x_pos <= 71) && y_pos == 47));

    assign letter_J = (((x_pos >= 71 && x_pos <= 79) && y_pos == 39) || (x_pos == 71 && y_pos == 40) || (x_pos == 79 && y_pos == 40) || (x_pos == 71 && y_pos == 41) || ((x_pos >= 73 && x_pos <= 77) && y_pos == 41) || (x_pos == 79 && y_pos == 41) || (x_pos == 71 && y_pos == 42) || (x_pos == 75 && y_pos == 42) || (x_pos == 79 && y_pos == 42) || (x_pos == 71 && y_pos == 43) || (x_pos == 75 && y_pos == 43) || (x_pos == 79 && y_pos == 43) || (x_pos == 71 && y_pos == 44) || (x_pos == 73 && y_pos == 44) || (x_pos == 75 && y_pos == 44) || (x_pos == 79 && y_pos == 44) || (x_pos == 71 && y_pos == 45) || ((x_pos >= 73 && x_pos <= 75) && y_pos == 45) || (x_pos == 79 && y_pos == 45) || (x_pos == 71 && y_pos == 46) || (x_pos == 79 && y_pos == 46) || ((x_pos >= 71 && x_pos <= 79) && y_pos == 47));

    assign letter_K = (((x_pos >= 79 && x_pos <= 87) && y_pos == 39) || (x_pos == 79 && y_pos == 40) || (x_pos == 87 && y_pos == 40) || (x_pos == 79 && y_pos == 41) || (x_pos == 81 && y_pos == 41) || (x_pos == 84 && y_pos == 41) || (x_pos == 87 && y_pos == 41) || (x_pos == 79 && y_pos == 42) || (x_pos == 81 && y_pos == 42) || (x_pos == 83 && y_pos == 42) || (x_pos == 87 && y_pos == 42) || (x_pos == 79 && y_pos == 43) || (x_pos == 81 && y_pos == 43) || (x_pos == 87 && y_pos == 43) || (x_pos == 79 && y_pos == 44) || (x_pos == 81 && y_pos == 44) || (x_pos == 83 && y_pos == 44) || (x_pos == 87 && y_pos == 44) || (x_pos == 79 && y_pos == 45) || (x_pos == 81 && y_pos == 45) || (x_pos == 84 && y_pos == 45) || (x_pos == 87 && y_pos == 45) || (x_pos == 79 && y_pos == 46) || (x_pos == 87 && y_pos == 46) || ((x_pos >= 79 && x_pos <= 87) && y_pos == 47));

    assign letter_L = (((x_pos >= 87 && x_pos <= 95) && y_pos == 39) || (x_pos == 87 && y_pos == 40) || (x_pos == 87 && y_pos == 41) || (x_pos == 89 && y_pos == 41) || (x_pos == 87 && y_pos == 42) || (x_pos == 89 && y_pos == 42) || (x_pos == 87 && y_pos == 43) || (x_pos == 89 && y_pos == 43) || (x_pos == 87 && y_pos == 44) || (x_pos == 89 && y_pos == 44) || (x_pos == 87 && y_pos == 45) || ((x_pos >= 89 && x_pos <= 93) && y_pos == 45) || (x_pos == 87 && y_pos == 46) || ((x_pos >= 87 && x_pos <= 95) && y_pos == 47));

    assign letter_M = (((x_pos >= 0 && x_pos <= 8) && y_pos == 47) || (x_pos == 0 && y_pos == 48) || (x_pos == 8 && y_pos == 48) || (x_pos == 0 && y_pos == 49) || (x_pos == 2 && y_pos == 49) || (x_pos == 6 && y_pos == 49) || (x_pos == 8 && y_pos == 49) || (x_pos == 0 && y_pos == 50) || (x_pos == 2 && y_pos == 50) || (x_pos == 5 && y_pos == 50) || (x_pos == 8 && y_pos == 50) || (x_pos == 0 && y_pos == 51) || (x_pos == 2 && y_pos == 51) || (x_pos == 4 && y_pos == 51) || (x_pos == 6 && y_pos == 51) || (x_pos == 8 && y_pos == 51) || (x_pos == 0 && y_pos == 52) || (x_pos == 2 && y_pos == 52) || (x_pos == 6 && y_pos == 52) || (x_pos == 8 && y_pos == 52) || (x_pos == 0 && y_pos == 53) || (x_pos == 2 && y_pos == 53) || (x_pos == 6 && y_pos == 53) || (x_pos == 8 && y_pos == 53) || (x_pos == 0 && y_pos == 54) || (x_pos == 8 && y_pos == 54) || ((x_pos >= 0 && x_pos <= 8) && y_pos == 55));

    assign letter_N = (((x_pos >= 8 && x_pos <= 16) && y_pos == 47) || (x_pos == 8 && y_pos == 48) || (x_pos == 16 && y_pos == 48) || (x_pos == 8 && y_pos == 49) || (x_pos == 10 && y_pos == 49) || (x_pos == 14 && y_pos == 49) || (x_pos == 16 && y_pos == 49) || (x_pos == 8 && y_pos == 50) || (x_pos == 10 && y_pos == 50) || (x_pos == 14 && y_pos == 50) || (x_pos == 16 && y_pos == 50) || (x_pos == 8 && y_pos == 51) || (x_pos == 10 && y_pos == 51) || (x_pos == 12 && y_pos == 51) || (x_pos == 14 && y_pos == 51) || (x_pos == 16 && y_pos == 51) || (x_pos == 8 && y_pos == 52) || (x_pos == 10 && y_pos == 52) || (x_pos == 13 && y_pos == 52) || (x_pos == 16 && y_pos == 52) || (x_pos == 8 && y_pos == 53) || (x_pos == 10 && y_pos == 53) || (x_pos == 14 && y_pos == 53) || (x_pos == 16 && y_pos == 53) || (x_pos == 8 && y_pos == 54) || (x_pos == 16 && y_pos == 54) || ((x_pos >= 8 && x_pos <= 16) && y_pos == 55));

    assign letter_O = (((x_pos >= 16 && x_pos <= 23) && y_pos == 47) || (x_pos == 16 && y_pos == 48) || (x_pos == 23 && y_pos == 48) || (x_pos == 16 && y_pos == 49) || ((x_pos >= 18 && x_pos <= 21) && y_pos == 49) || (x_pos == 23 && y_pos == 49) || (x_pos == 16 && y_pos == 50) || (x_pos == 18 && y_pos == 50) || (x_pos == 21 && y_pos == 50) || (x_pos == 23 && y_pos == 50) || (x_pos == 16 && y_pos == 51) || (x_pos == 18 && y_pos == 51) || (x_pos == 21 && y_pos == 51) || (x_pos == 23 && y_pos == 51) || (x_pos == 16 && y_pos == 52) || (x_pos == 18 && y_pos == 52) || (x_pos == 21 && y_pos == 52) || (x_pos == 23 && y_pos == 52) || (x_pos == 16 && y_pos == 53) || ((x_pos >= 18 && x_pos <= 21) && y_pos == 53) || (x_pos == 23 && y_pos == 53) || (x_pos == 16 && y_pos == 54) || (x_pos == 23 && y_pos == 54) || ((x_pos >= 16 && x_pos <= 23) && y_pos == 55));

    assign letter_P = (((x_pos >= 23 && x_pos <= 31) && y_pos == 47) || (x_pos == 23 && y_pos == 48) || (x_pos == 31 && y_pos == 48) || (x_pos == 23 && y_pos == 49) || ((x_pos >= 25 && x_pos <= 29) && y_pos == 49) || (x_pos == 31 && y_pos == 49) || (x_pos == 23 && y_pos == 50) || (x_pos == 25 && y_pos == 50) || (x_pos == 29 && y_pos == 50) || (x_pos == 31 && y_pos == 50) || (x_pos == 23 && y_pos == 51) || ((x_pos >= 25 && x_pos <= 29) && y_pos == 51) || (x_pos == 31 && y_pos == 51) || (x_pos == 23 && y_pos == 52) || (x_pos == 25 && y_pos == 52) || (x_pos == 31 && y_pos == 52) || (x_pos == 23 && y_pos == 53) || (x_pos == 25 && y_pos == 53) || (x_pos == 31 && y_pos == 53) || (x_pos == 23 && y_pos == 54) || (x_pos == 31 && y_pos == 54) || ((x_pos >= 23 && x_pos <= 31) && y_pos == 55));

    assign letter_Q = (((x_pos >= 31 && x_pos <= 39) && y_pos == 47) || (x_pos == 31 && y_pos == 48) || (x_pos == 39 && y_pos == 48) || (x_pos == 31 && y_pos == 49) || ((x_pos >= 33 && x_pos <= 37) && y_pos == 49) || (x_pos == 39 && y_pos == 49) || (x_pos == 31 && y_pos == 50) || (x_pos == 33 && y_pos == 50) || (x_pos == 37 && y_pos == 50) || (x_pos == 39 && y_pos == 50) || (x_pos == 31 && y_pos == 51) || (x_pos == 33 && y_pos == 51) || (x_pos == 37 && y_pos == 51) || (x_pos == 39 && y_pos == 51) || (x_pos == 31 && y_pos == 52) || (x_pos == 33 && y_pos == 52) || (x_pos == 36 && y_pos == 52) || (x_pos == 39 && y_pos == 52) || (x_pos == 31 && y_pos == 53) || ((x_pos >= 33 && x_pos <= 37) && y_pos == 53) || (x_pos == 39 && y_pos == 53) || (x_pos == 31 && y_pos == 54) || (x_pos == 39 && y_pos == 54) || ((x_pos >= 31 && x_pos <= 39) && y_pos == 55));

    assign letter_R = (((x_pos >= 39 && x_pos <= 47) && y_pos == 47) || (x_pos == 39 && y_pos == 48) || (x_pos == 47 && y_pos == 48) || (x_pos == 39 && y_pos == 49) || ((x_pos >= 41 && x_pos <= 45) && y_pos == 49) || (x_pos == 47 && y_pos == 49) || (x_pos == 39 && y_pos == 50) || (x_pos == 41 && y_pos == 50) || (x_pos == 45 && y_pos == 50) || (x_pos == 47 && y_pos == 50) || (x_pos == 39 && y_pos == 51) || ((x_pos >= 41 && x_pos <= 45) && y_pos == 51) || (x_pos == 47 && y_pos == 51) || (x_pos == 39 && y_pos == 52) || (x_pos == 41 && y_pos == 52) || (x_pos == 44 && y_pos == 52) || (x_pos == 47 && y_pos == 52) || (x_pos == 39 && y_pos == 53) || (x_pos == 41 && y_pos == 53) || (x_pos == 45 && y_pos == 53) || (x_pos == 47 && y_pos == 53) || (x_pos == 39 && y_pos == 54) || (x_pos == 47 && y_pos == 54) || ((x_pos >= 39 && x_pos <= 47) && y_pos == 55));

    assign letter_S = (((x_pos >= 47 && x_pos <= 55) && y_pos == 47) || (x_pos == 47 && y_pos == 48) || (x_pos == 55 && y_pos == 48) || (x_pos == 47 && y_pos == 49) || ((x_pos >= 49 && x_pos <= 53) && y_pos == 49) || (x_pos == 55 && y_pos == 49) || (x_pos == 47 && y_pos == 50) || (x_pos == 49 && y_pos == 50) || (x_pos == 55 && y_pos == 50) || (x_pos == 47 && y_pos == 51) || ((x_pos >= 49 && x_pos <= 53) && y_pos == 51) || (x_pos == 55 && y_pos == 51) || (x_pos == 47 && y_pos == 52) || (x_pos == 53 && y_pos == 52) || (x_pos == 55 && y_pos == 52) || (x_pos == 47 && y_pos == 53) || ((x_pos >= 49 && x_pos <= 53) && y_pos == 53) || (x_pos == 55 && y_pos == 53) || (x_pos == 47 && y_pos == 54) || (x_pos == 55 && y_pos == 54) || ((x_pos >= 47 && x_pos <= 55) && y_pos == 55));

    assign letter_T = (((x_pos >= 55 && x_pos <= 63) && y_pos == 47) || (x_pos == 55 && y_pos == 48) || (x_pos == 63 && y_pos == 48) || (x_pos == 55 && y_pos == 49) || ((x_pos >= 57 && x_pos <= 61) && y_pos == 49) || (x_pos == 63 && y_pos == 49) || (x_pos == 55 && y_pos == 50) || (x_pos == 59 && y_pos == 50) || (x_pos == 63 && y_pos == 50) || (x_pos == 55 && y_pos == 51) || (x_pos == 59 && y_pos == 51) || (x_pos == 63 && y_pos == 51) || (x_pos == 55 && y_pos == 52) || (x_pos == 59 && y_pos == 52) || (x_pos == 63 && y_pos == 52) || (x_pos == 55 && y_pos == 53) || (x_pos == 59 && y_pos == 53) || (x_pos == 63 && y_pos == 53) || (x_pos == 55 && y_pos == 54) || (x_pos == 63 && y_pos == 54) || ((x_pos >= 55 && x_pos <= 63) && y_pos == 55));

    assign letter_U = (((x_pos >= 63 && x_pos <= 71) && y_pos == 47) || (x_pos == 63 && y_pos == 48) || (x_pos == 71 && y_pos == 48) || (x_pos == 63 && y_pos == 49) || (x_pos == 65 && y_pos == 49) || (x_pos == 69 && y_pos == 49) || (x_pos == 71 && y_pos == 49) || (x_pos == 63 && y_pos == 50) || (x_pos == 65 && y_pos == 50) || (x_pos == 69 && y_pos == 50) || (x_pos == 71 && y_pos == 50) || (x_pos == 63 && y_pos == 51) || (x_pos == 65 && y_pos == 51) || (x_pos == 69 && y_pos == 51) || (x_pos == 71 && y_pos == 51) || (x_pos == 63 && y_pos == 52) || (x_pos == 65 && y_pos == 52) || (x_pos == 69 && y_pos == 52) || (x_pos == 71 && y_pos == 52) || (x_pos == 63 && y_pos == 53) || ((x_pos >= 65 && x_pos <= 69) && y_pos == 53) || (x_pos == 71 && y_pos == 53) || (x_pos == 63 && y_pos == 54) || (x_pos == 71 && y_pos == 54) || ((x_pos >= 63 && x_pos <= 71) && y_pos == 55));

    assign letter_V = (((x_pos >= 71 && x_pos <= 79) && y_pos == 47) || (x_pos == 71 && y_pos == 48) || (x_pos == 79 && y_pos == 48) || (x_pos == 71 && y_pos == 49) || (x_pos == 73 && y_pos == 49) || (x_pos == 77 && y_pos == 49) || (x_pos == 79 && y_pos == 49) || (x_pos == 71 && y_pos == 50) || (x_pos == 73 && y_pos == 50) || (x_pos == 77 && y_pos == 50) || (x_pos == 79 && y_pos == 50) || (x_pos == 71 && y_pos == 51) || (x_pos == 74 && y_pos == 51) || (x_pos == 76 && y_pos == 51) || (x_pos == 79 && y_pos == 51) || (x_pos == 71 && y_pos == 52) || (x_pos == 74 && y_pos == 52) || (x_pos == 76 && y_pos == 52) || (x_pos == 79 && y_pos == 52) || (x_pos == 71 && y_pos == 53) || (x_pos == 75 && y_pos == 53) || (x_pos == 79 && y_pos == 53) || (x_pos == 71 && y_pos == 54) || (x_pos == 79 && y_pos == 54) || ((x_pos >= 71 && x_pos <= 79) && y_pos == 55));

    assign letter_W = (((x_pos >= 79 && x_pos <= 87) && y_pos == 47) || (x_pos == 79 && y_pos == 48) || (x_pos == 87 && y_pos == 48) || (x_pos == 79 && y_pos == 49) || (x_pos == 81 && y_pos == 49) || (x_pos == 85 && y_pos == 49) || (x_pos == 87 && y_pos == 49) || (x_pos == 79 && y_pos == 50) || (x_pos == 81 && y_pos == 50) || (x_pos == 85 && y_pos == 50) || (x_pos == 87 && y_pos == 50) || (x_pos == 79 && y_pos == 51) || (x_pos == 81 && y_pos == 51) || (x_pos == 85 && y_pos == 51) || (x_pos == 87 && y_pos == 51) || (x_pos == 79 && y_pos == 52) || (x_pos == 81 && y_pos == 52) || (x_pos == 83 && y_pos == 52) || (x_pos == 85 && y_pos == 52) || (x_pos == 87 && y_pos == 52) || (x_pos == 79 && y_pos == 53) || (x_pos == 81 && y_pos == 53) || (x_pos == 84 && y_pos == 53) || (x_pos == 87 && y_pos == 53) || (x_pos == 79 && y_pos == 54) || (x_pos == 87 && y_pos == 54) || ((x_pos >= 79 && x_pos <= 87) && y_pos == 55));

    assign letter_X = (((x_pos >= 87 && x_pos <= 95) && y_pos == 47) || (x_pos == 87 && y_pos == 48) || (x_pos == 87 && y_pos == 49) || (x_pos == 89 && y_pos == 49) || (x_pos == 93 && y_pos == 49) || (x_pos == 87 && y_pos == 50) || (x_pos == 90 && y_pos == 50) || (x_pos == 92 && y_pos == 50) || (x_pos == 87 && y_pos == 51) || (x_pos == 91 && y_pos == 51) || (x_pos == 87 && y_pos == 52) || (x_pos == 90 && y_pos == 52) || (x_pos == 92 && y_pos == 52) || (x_pos == 87 && y_pos == 53) || (x_pos == 89 && y_pos == 53) || (x_pos == 93 && y_pos == 53) || (x_pos == 87 && y_pos == 54) || ((x_pos >= 87 && x_pos <= 95) && y_pos == 55));

    assign letter_Y = (((x_pos >= 0 && x_pos <= 8) && y_pos == 55) || (x_pos == 0 && y_pos == 56) || (x_pos == 8 && y_pos == 56) || (x_pos == 0 && y_pos == 57) || (x_pos == 2 && y_pos == 57) || (x_pos == 6 && y_pos == 57) || (x_pos == 8 && y_pos == 57) || (x_pos == 0 && y_pos == 58) || (x_pos == 3 && y_pos == 58) || (x_pos == 5 && y_pos == 58) || (x_pos == 8 && y_pos == 58) || (x_pos == 0 && y_pos == 59) || (x_pos == 4 && y_pos == 59) || (x_pos == 8 && y_pos == 59) || (x_pos == 0 && y_pos == 60) || (x_pos == 4 && y_pos == 60) || (x_pos == 8 && y_pos == 60) || (x_pos == 0 && y_pos == 61) || (x_pos == 4 && y_pos == 61) || (x_pos == 8 && y_pos == 61) || (x_pos == 0 && y_pos == 62) || (x_pos == 8 && y_pos == 62) || ((x_pos >= 0 && x_pos <= 8) && y_pos == 63));

    assign letter_Z = (((x_pos >= 8 && x_pos <= 16) && y_pos == 55) || (x_pos == 8 && y_pos == 56) || (x_pos == 16 && y_pos == 56) || (x_pos == 8 && y_pos == 57) || ((x_pos >= 10 && x_pos <= 14) && y_pos == 57) || (x_pos == 16 && y_pos == 57) || (x_pos == 8 && y_pos == 58) || (x_pos == 13 && y_pos == 58) || (x_pos == 16 && y_pos == 58) || (x_pos == 8 && y_pos == 59) || (x_pos == 12 && y_pos == 59) || (x_pos == 16 && y_pos == 59) || (x_pos == 8 && y_pos == 60) || (x_pos == 11 && y_pos == 60) || (x_pos == 16 && y_pos == 60) || (x_pos == 8 && y_pos == 61) || ((x_pos >= 10 && x_pos <= 14) && y_pos == 61) || (x_pos == 16 && y_pos == 61) || (x_pos == 8 && y_pos == 62) || (x_pos == 16 && y_pos == 62) || ((x_pos >= 8 && x_pos <= 16) && y_pos == 63));

    assign number_0 = (((x_pos >= 16 && x_pos <= 23) && y_pos == 55) || (x_pos == 16 && y_pos == 56) || (x_pos == 23 && y_pos == 56) || (x_pos == 16 && y_pos == 57) || (x_pos == 19 && y_pos == 57) || (x_pos == 23 && y_pos == 57) || (x_pos == 16 && y_pos == 58) || (x_pos == 18 && y_pos == 58) || (x_pos == 21 && y_pos == 58) || (x_pos == 23 && y_pos == 58) || (x_pos == 16 && y_pos == 59) || (x_pos == 18 && y_pos == 59) || (x_pos == 21 && y_pos == 59) || (x_pos == 23 && y_pos == 59) || (x_pos == 16 && y_pos == 60) || (x_pos == 18 && y_pos == 60) || (x_pos == 21 && y_pos == 60) || (x_pos == 23 && y_pos == 60) || (x_pos == 16 && y_pos == 61) || (x_pos == 19 && y_pos == 61) || (x_pos == 23 && y_pos == 61) || (x_pos == 16 && y_pos == 62) || (x_pos == 23 && y_pos == 62) || ((x_pos >= 16 && x_pos <= 23) && y_pos == 63));

    assign number_1 = (((x_pos >= 23 && x_pos <= 31) && y_pos == 55) || (x_pos == 23 && y_pos == 56) || (x_pos == 31 && y_pos == 56) || (x_pos == 23 && y_pos == 57) || (x_pos == 26 && y_pos == 57) || (x_pos == 31 && y_pos == 57) || (x_pos == 23 && y_pos == 58) || (x_pos == 27 && y_pos == 58) || (x_pos == 31 && y_pos == 58) || (x_pos == 23 && y_pos == 59) || (x_pos == 27 && y_pos == 59) || (x_pos == 31 && y_pos == 59) || (x_pos == 23 && y_pos == 60) || (x_pos == 27 && y_pos == 60) || (x_pos == 31 && y_pos == 60) || (x_pos == 23 && y_pos == 61) || (x_pos == 27 && y_pos == 61) || (x_pos == 31 && y_pos == 61) || (x_pos == 23 && y_pos == 62) || (x_pos == 31 && y_pos == 62) || ((x_pos >= 23 && x_pos <= 31) && y_pos == 63));

    assign number_2 = (((x_pos >= 31 && x_pos <= 39) && y_pos == 55) || (x_pos == 31 && y_pos == 56) || (x_pos == 39 && y_pos == 56) || (x_pos == 31 && y_pos == 57) || (x_pos == 34 && y_pos == 57) || (x_pos == 39 && y_pos == 57) || (x_pos == 31 && y_pos == 58) || (x_pos == 33 && y_pos == 58) || (x_pos == 36 && y_pos == 58) || (x_pos == 39 && y_pos == 58) || (x_pos == 31 && y_pos == 59) || (x_pos == 35 && y_pos == 59) || (x_pos == 39 && y_pos == 59) || (x_pos == 31 && y_pos == 60) || (x_pos == 34 && y_pos == 60) || (x_pos == 39 && y_pos == 60) || (x_pos == 31 && y_pos == 61) || ((x_pos >= 33 && x_pos <= 36) && y_pos == 61) || (x_pos == 39 && y_pos == 61) || (x_pos == 31 && y_pos == 62) || (x_pos == 39 && y_pos == 62) || ((x_pos >= 31 && x_pos <= 39) && y_pos == 63));

    assign number_3 = (((x_pos >= 39 && x_pos <= 47) && y_pos == 55) || (x_pos == 39 && y_pos == 56) || (x_pos == 47 && y_pos == 56) || (x_pos == 39 && y_pos == 57) || ((x_pos >= 41 && x_pos <= 45) && y_pos == 57) || (x_pos == 47 && y_pos == 57) || (x_pos == 39 && y_pos == 58) || (x_pos == 45 && y_pos == 58) || (x_pos == 47 && y_pos == 58) || (x_pos == 39 && y_pos == 59) || ((x_pos >= 42 && x_pos <= 45) && y_pos == 59) || (x_pos == 47 && y_pos == 59) || (x_pos == 39 && y_pos == 60) || (x_pos == 45 && y_pos == 60) || (x_pos == 47 && y_pos == 60) || (x_pos == 39 && y_pos == 61) || ((x_pos >= 41 && x_pos <= 45) && y_pos == 61) || (x_pos == 47 && y_pos == 61) || (x_pos == 39 && y_pos == 62) || (x_pos == 47 && y_pos == 62) || ((x_pos >= 39 && x_pos <= 47) && y_pos == 63));

    assign number_4 = (((x_pos >= 47 && x_pos <= 55) && y_pos == 55) || (x_pos == 47 && y_pos == 56) || (x_pos == 55 && y_pos == 56) || (x_pos == 47 && y_pos == 57) || (x_pos == 49 && y_pos == 57) || (x_pos == 53 && y_pos == 57) || (x_pos == 55 && y_pos == 57) || (x_pos == 47 && y_pos == 58) || (x_pos == 49 && y_pos == 58) || (x_pos == 53 && y_pos == 58) || (x_pos == 55 && y_pos == 58) || (x_pos == 47 && y_pos == 59) || ((x_pos >= 49 && x_pos <= 53) && y_pos == 59) || (x_pos == 55 && y_pos == 59) || (x_pos == 47 && y_pos == 60) || (x_pos == 53 && y_pos == 60) || (x_pos == 55 && y_pos == 60) || (x_pos == 47 && y_pos == 61) || (x_pos == 53 && y_pos == 61) || (x_pos == 55 && y_pos == 61) || (x_pos == 47 && y_pos == 62) || (x_pos == 55 && y_pos == 62) || ((x_pos >= 47 && x_pos <= 55) && y_pos == 63));

    assign number_5 = (((x_pos >= 55 && x_pos <= 63) && y_pos == 55) || (x_pos == 55 && y_pos == 56) || (x_pos == 63 && y_pos == 56) || (x_pos == 55 && y_pos == 57) || ((x_pos >= 58 && x_pos <= 61) && y_pos == 57) || (x_pos == 63 && y_pos == 57) || (x_pos == 55 && y_pos == 58) || (x_pos == 57 && y_pos == 58) || (x_pos == 63 && y_pos == 58) || (x_pos == 55 && y_pos == 59) || ((x_pos >= 57 && x_pos <= 61) && y_pos == 59) || (x_pos == 63 && y_pos == 59) || (x_pos == 55 && y_pos == 60) || (x_pos == 61 && y_pos == 60) || (x_pos == 63 && y_pos == 60) || (x_pos == 55 && y_pos == 61) || ((x_pos >= 57 && x_pos <= 61) && y_pos == 61) || (x_pos == 63 && y_pos == 61) || (x_pos == 55 && y_pos == 62) || (x_pos == 63 && y_pos == 62) || ((x_pos >= 55 && x_pos <= 63) && y_pos == 63));

    assign number_6 = (((x_pos >= 63 && x_pos <= 71) && y_pos == 55) || (x_pos == 63 && y_pos == 56) || (x_pos == 71 && y_pos == 56) || (x_pos == 63 && y_pos == 57) || ((x_pos >= 65 && x_pos <= 69) && y_pos == 57) || (x_pos == 71 && y_pos == 57) || (x_pos == 63 && y_pos == 58) || (x_pos == 65 && y_pos == 58) || (x_pos == 71 && y_pos == 58) || (x_pos == 63 && y_pos == 59) || ((x_pos >= 65 && x_pos <= 69) && y_pos == 59) || (x_pos == 71 && y_pos == 59) || (x_pos == 63 && y_pos == 60) || (x_pos == 65 && y_pos == 60) || (x_pos == 69 && y_pos == 60) || (x_pos == 71 && y_pos == 60) || (x_pos == 63 && y_pos == 61) || ((x_pos >= 65 && x_pos <= 69) && y_pos == 61) || (x_pos == 71 && y_pos == 61) || (x_pos == 63 && y_pos == 62) || (x_pos == 71 && y_pos == 62) || ((x_pos >= 63 && x_pos <= 71) && y_pos == 63));

    assign number_7 = (((x_pos >= 71 && x_pos <= 79) && y_pos == 55) || (x_pos == 71 && y_pos == 56) || (x_pos == 79 && y_pos == 56) || (x_pos == 71 && y_pos == 57) || ((x_pos >= 73 && x_pos <= 77) && y_pos == 57) || (x_pos == 79 && y_pos == 57) || (x_pos == 71 && y_pos == 58) || (x_pos == 77 && y_pos == 58) || (x_pos == 79 && y_pos == 58) || (x_pos == 71 && y_pos == 59) || (x_pos == 76 && y_pos == 59) || (x_pos == 79 && y_pos == 59) || (x_pos == 71 && y_pos == 60) || (x_pos == 75 && y_pos == 60) || (x_pos == 79 && y_pos == 60) || (x_pos == 71 && y_pos == 61) || (x_pos == 74 && y_pos == 61) || (x_pos == 79 && y_pos == 61) || (x_pos == 71 && y_pos == 62) || (x_pos == 79 && y_pos == 62) || ((x_pos >= 71 && x_pos <= 79) && y_pos == 63));

    assign number_8 = (((x_pos >= 79 && x_pos <= 87) && y_pos == 55) || (x_pos == 79 && y_pos == 56) || (x_pos == 87 && y_pos == 56) || (x_pos == 79 && y_pos == 57) || ((x_pos >= 81 && x_pos <= 85) && y_pos == 57) || (x_pos == 87 && y_pos == 57) || (x_pos == 79 && y_pos == 58) || (x_pos == 81 && y_pos == 58) || (x_pos == 85 && y_pos == 58) || (x_pos == 87 && y_pos == 58) || (x_pos == 79 && y_pos == 59) || ((x_pos >= 82 && x_pos <= 84) && y_pos == 59) || (x_pos == 87 && y_pos == 59) || (x_pos == 79 && y_pos == 60) || (x_pos == 81 && y_pos == 60) || (x_pos == 85 && y_pos == 60) || (x_pos == 87 && y_pos == 60) || (x_pos == 79 && y_pos == 61) || ((x_pos >= 81 && x_pos <= 85) && y_pos == 61) || (x_pos == 87 && y_pos == 61) || (x_pos == 79 && y_pos == 62) || (x_pos == 87 && y_pos == 62) || ((x_pos >= 79 && x_pos <= 87) && y_pos == 63));

    assign number_9 = (((x_pos >= 87 && x_pos <= 95) && y_pos == 55) || (x_pos == 87 && y_pos == 56) || (x_pos == 87 && y_pos == 57) || ((x_pos >= 89 && x_pos <= 93) && y_pos == 57) || (x_pos == 87 && y_pos == 58) || (x_pos == 89 && y_pos == 58) || (x_pos == 93 && y_pos == 58) || (x_pos == 87 && y_pos == 59) || ((x_pos >= 89 && x_pos <= 93) && y_pos == 59) || (x_pos == 87 && y_pos == 60) || (x_pos == 93 && y_pos == 60) || (x_pos == 87 && y_pos == 61) || ((x_pos >= 89 && x_pos <= 93) && y_pos == 61) || (x_pos == 87 && y_pos == 62) || ((x_pos >= 87 && x_pos <= 95) && y_pos == 63));

    assign clear = (((x_pos >= 0 && x_pos <= 31) && y_pos == 31) || (x_pos == 0 && y_pos == 32) || (x_pos == 31 && y_pos == 32) || (x_pos == 0 && y_pos == 33) || ((x_pos >= 2 && x_pos <= 5) && y_pos == 33) || (x_pos == 7 && y_pos == 33) || ((x_pos >= 12 && x_pos <= 16) && y_pos == 33) || ((x_pos >= 18 && x_pos <= 22) && y_pos == 33) || ((x_pos >= 25 && x_pos <= 29) && y_pos == 33) || (x_pos == 31 && y_pos == 33) || (x_pos == 0 && y_pos == 34) || (x_pos == 2 && y_pos == 34) || (x_pos == 7 && y_pos == 34) || (x_pos == 12 && y_pos == 34) || (x_pos == 18 && y_pos == 34) || (x_pos == 22 && y_pos == 34) || (x_pos == 25 && y_pos == 34) || (x_pos == 29 && y_pos == 34) || (x_pos == 31 && y_pos == 34) || (x_pos == 0 && y_pos == 35) || (x_pos == 2 && y_pos == 35) || (x_pos == 7 && y_pos == 35) || ((x_pos >= 12 && x_pos <= 15) && y_pos == 35) || ((x_pos >= 18 && x_pos <= 22) && y_pos == 35) || ((x_pos >= 25 && x_pos <= 29) && y_pos == 35) || (x_pos == 31 && y_pos == 35) || (x_pos == 0 && y_pos == 36) || (x_pos == 2 && y_pos == 36) || (x_pos == 7 && y_pos == 36) || (x_pos == 12 && y_pos == 36) || (x_pos == 18 && y_pos == 36) || (x_pos == 22 && y_pos == 36) || (x_pos == 25 && y_pos == 36) || (x_pos == 28 && y_pos == 36) || (x_pos == 31 && y_pos == 36) || (x_pos == 0 && y_pos == 37) || ((x_pos >= 2 && x_pos <= 5) && y_pos == 37) || ((x_pos >= 7 && x_pos <= 10) && y_pos == 37) || ((x_pos >= 12 && x_pos <= 16) && y_pos == 37) || (x_pos == 18 && y_pos == 37) || (x_pos == 22 && y_pos == 37) || (x_pos == 25 && y_pos == 37) || (x_pos == 29 && y_pos == 37) || (x_pos == 31 && y_pos == 37) || (x_pos == 0 && y_pos == 38) || (x_pos == 31 && y_pos == 38) || ((x_pos >= 0 && x_pos <= 31) && y_pos == 39));

    assign del = (((x_pos >= 31 && x_pos <= 55) && y_pos == 31) || (x_pos == 31 && y_pos == 32) || (x_pos == 55 && y_pos == 32) || (x_pos == 31 && y_pos == 33) || ((x_pos >= 36 && x_pos <= 39) && y_pos == 33) || ((x_pos >= 42 && x_pos <= 46) && y_pos == 33) || (x_pos == 48 && y_pos == 33) || (x_pos == 55 && y_pos == 33) || (x_pos == 31 && y_pos == 34) || (x_pos == 36 && y_pos == 34) || (x_pos == 40 && y_pos == 34) || (x_pos == 42 && y_pos == 34) || (x_pos == 48 && y_pos == 34) || (x_pos == 55 && y_pos == 34) || (x_pos == 31 && y_pos == 35) || (x_pos == 36 && y_pos == 35) || (x_pos == 40 && y_pos == 35) || ((x_pos >= 42 && x_pos <= 45) && y_pos == 35) || (x_pos == 48 && y_pos == 35) || (x_pos == 55 && y_pos == 35) || (x_pos == 31 && y_pos == 36) || (x_pos == 36 && y_pos == 36) || (x_pos == 40 && y_pos == 36) || (x_pos == 42 && y_pos == 36) || (x_pos == 48 && y_pos == 36) || (x_pos == 55 && y_pos == 36) || (x_pos == 31 && y_pos == 37) || ((x_pos >= 36 && x_pos <= 39) && y_pos == 37) || ((x_pos >= 42 && x_pos <= 46) && y_pos == 37) || ((x_pos >= 48 && x_pos <= 51) && y_pos == 37) || (x_pos == 55 && y_pos == 37) || (x_pos == 31 && y_pos == 38) || (x_pos == 55 && y_pos == 38) || ((x_pos >= 31 && x_pos <= 55) && y_pos == 39));

    assign enter = (((x_pos >= 55 && x_pos <= 79) && y_pos == 31) || (x_pos == 55 && y_pos == 32) || (x_pos == 79 && y_pos == 32) || (x_pos == 55 && y_pos == 33) || (x_pos == 59 && y_pos == 33) || (x_pos == 76 && y_pos == 33) || (x_pos == 79 && y_pos == 33) || (x_pos == 55 && y_pos == 34) || ((x_pos >= 58 && x_pos <= 60) && y_pos == 34) || (x_pos == 76 && y_pos == 34) || (x_pos == 79 && y_pos == 34) || (x_pos == 55 && y_pos == 35) || ((x_pos >= 57 && x_pos <= 76) && y_pos == 35) || (x_pos == 79 && y_pos == 35) || (x_pos == 55 && y_pos == 36) || ((x_pos >= 58 && x_pos <= 60) && y_pos == 36) || (x_pos == 79 && y_pos == 36) || (x_pos == 55 && y_pos == 37) || (x_pos == 59 && y_pos == 37) || (x_pos == 79 && y_pos == 37) || (x_pos == 55 && y_pos == 38) || (x_pos == 79 && y_pos == 38) || ((x_pos >= 55 && x_pos <= 79) && y_pos == 39));

    assign spacebar = (((x_pos >= 79 && x_pos <= 95) && y_pos == 31) || (x_pos == 79 && y_pos == 32) || (x_pos == 79 && y_pos == 33) || ((x_pos >= 81 && x_pos <= 93) && y_pos == 33) || (x_pos == 79 && y_pos == 34) || ((x_pos >= 81 && x_pos <= 93) && y_pos == 34) || (x_pos == 79 && y_pos == 35) || ((x_pos >= 81 && x_pos <= 93) && y_pos == 35) || (x_pos == 79 && y_pos == 36) || ((x_pos >= 81 && x_pos <= 93) && y_pos == 36) || (x_pos == 79 && y_pos == 37) || ((x_pos >= 81 && x_pos <= 93) && y_pos == 37) || (x_pos == 79 && y_pos == 38) || ((x_pos >= 79 && x_pos <= 95) && y_pos == 39));

    // Controlling of OLED display
    always @ (*) begin
        if (mouse_pos) begin
            pixel_data = RED;
        end

        else if (keyboard_border) begin
            pixel_data = KEYBOARD_COLOUR;
        end

        else if (letter_A) begin
            pixel_data = letter_A_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_B) begin
            pixel_data = letter_B_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_C) begin
            pixel_data = letter_C_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_D) begin
            pixel_data = letter_D_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_E) begin
            pixel_data = letter_E_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_F) begin
            pixel_data = letter_F_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_G) begin
            pixel_data = letter_G_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_H) begin
            pixel_data = letter_H_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_I) begin
            pixel_data = letter_I_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_J) begin
            pixel_data = letter_J_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_K) begin
            pixel_data = letter_K_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_L) begin
            pixel_data = letter_L_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_M) begin
            pixel_data = letter_M_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_N) begin
            pixel_data = letter_N_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_O) begin
            pixel_data = letter_O_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_P) begin
            pixel_data = letter_P_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_Q) begin
            pixel_data = letter_Q_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_R) begin
            pixel_data = letter_R_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_S) begin
            pixel_data = letter_S_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_T) begin
            pixel_data = letter_T_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_U) begin
            pixel_data = letter_U_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_V) begin
            pixel_data = letter_V_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_W) begin
            pixel_data = letter_W_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_X) begin
            pixel_data = letter_X_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_Y) begin
            pixel_data = letter_Y_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_Z) begin
            pixel_data = letter_Z_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_0) begin
            pixel_data = number_0_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_1) begin
            pixel_data = number_1_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_2) begin
            pixel_data = number_2_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_3) begin
            pixel_data = number_3_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_4) begin
            pixel_data = number_4_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_5) begin
            pixel_data = number_5_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_6) begin
            pixel_data = number_6_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_7) begin
            pixel_data = number_7_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_8) begin
            pixel_data = number_8_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_9) begin
            pixel_data = number_9_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (spacebar) begin
            pixel_data = spacebar_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (del) begin
            pixel_data = del_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (enter) begin
            pixel_data = enter_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (clear) begin
            pixel_data = clear_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else begin
            pixel_data = BLACK;
        end
    end
endmodule
