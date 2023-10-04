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
    input clock,
    input clock_1Hz,
    input btnC_debounce,
    output reg [1:0] debug_led = 0,
    input [15:0] sw,
    input [12:0] pixel_index,
    input left_click,
    input right_click,
    input [6:0] cursor_x,
    input [6:0] cursor_y,
    input [6:0] diff_x,
    input [6:0] diff_y,
    input [5:0] rand_num,
    input [15:0] rgb_lights,
    output reg [3:0] cursor_size = 2,
    output reg [15:0] pixel_data = 0
    );

    localparam MANUAL_MODE = 0;
    localparam AUTO_MODE = 1;
    reg [5:0] prev_test_char = 0;
    reg [5:0] curr_test_char = 0;
    reg state = MANUAL_MODE;
    reg [11:0] rand_num_counter = 0;
    reg auto_init = 0;

    // For selecting the 2 modes
    always @ (posedge clock) begin
        case(sw[0])
            1'b0: state <= MANUAL_MODE;
            1'b1: state <= AUTO_MODE;
        endcase
    end

    localparam CHARDISPLAY_A = 1;
    localparam CHARDISPLAY_B = 2;
    localparam CHARDISPLAY_C = 3;
    localparam CHARDISPLAY_D = 4;
    localparam CHARDISPLAY_E = 5;
    localparam CHARDISPLAY_F = 6;
    localparam CHARDISPLAY_G = 7;
    localparam CHARDISPLAY_H = 8;
    localparam CHARDISPLAY_I = 9;
    localparam CHARDISPLAY_J = 10;
    localparam CHARDISPLAY_K = 11;
    localparam CHARDISPLAY_L = 12;
    localparam CHARDISPLAY_M = 13;
    localparam CHARDISPLAY_N = 14;
    localparam CHARDISPLAY_O = 15;
    localparam CHARDISPLAY_P = 16;
    localparam CHARDISPLAY_Q = 17;
    localparam CHARDISPLAY_R = 18;
    localparam CHARDISPLAY_S = 19;
    localparam CHARDISPLAY_T = 20;
    localparam CHARDISPLAY_U = 21;
    localparam CHARDISPLAY_V = 22;
    localparam CHARDISPLAY_W = 23;
    localparam CHARDISPLAY_X = 24;
    localparam CHARDISPLAY_Y = 25;
    localparam CHARDISPLAY_Z = 26;
    localparam CHARDISPLAY_0 = 27;
    localparam CHARDISPLAY_1 = 28;
    localparam CHARDISPLAY_2 = 29;
    localparam CHARDISPLAY_3 = 30;
    localparam CHARDISPLAY_4 = 31;
    localparam CHARDISPLAY_5 = 32;
    localparam CHARDISPLAY_6 = 33;
    localparam CHARDISPLAY_7 = 34;
    localparam CHARDISPLAY_8 = 35;
    localparam CHARDISPLAY_9 = 36;
    localparam CHARDISPLAY_CLEAR = 37;
    localparam CHARDISPLAY_BACKSPACE = 38;
    localparam CHARDISPLAY_ENTER = 39;
    localparam CHARDISPLAY_SPACEBAR = 40;
    localparam CHARDISPLAY_WAITING = 41;
    localparam CHARDISPLAY_NULL = 0;

    localparam WHITE = 16'hFFFF;
    localparam BLACK = 16'h0000;
    localparam GREEN = 16'h07E0;
    localparam RED = 16'hF800;
    localparam BLUE = 16'h001F;
    localparam YELLOW = 16'hFFE0;
    localparam CYAN = 16'h07FF;
    localparam MAGENTA = 16'hF81F;
    localparam ORANGE = 16'hFC00;

    wire [15:0] KEYBOARD_COLOUR;
    assign KEYBOARD_COLOUR = (sw[2]) ? rgb_lights : WHITE;

    parameter HOVER_COLOURED = GREEN;
    parameter HOVER_NOT_COLOURED = WHITE;
    parameter DISPLAYCHAR_COLOUR = WHITE;
    parameter BACKGROUND_COLOR = BLACK;

    reg [5:0] char_pos = 0;

    wire [6:0] x_pos;
    wire [5:0] y_pos;

    wire reset_left_click;
    assign reset_left_click = ~left_click ? 1 : 0;
    
    assign x_pos = pixel_index % 96;
    assign y_pos = pixel_index / 96;

    // For displaying mouse
    assign mouse_pos = (diff_x < cursor_size) && (diff_y < cursor_size);
    
    // Separate the OLED screen into two halves
    assign topHalf = (y_pos < 31);
    assign bottomHalf = (y_pos >= 31);

    // For checking if each position is filled
    reg [15:0] screen_pos_display0_0 = CHARDISPLAY_WAITING;
    reg [15:0] screen_pos_display0_1 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display0_2 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display0_3 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display0_4 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display0_5 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display0_6 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display0_7 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display0_8 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display0_9 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display0_10 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display0_11 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display0_12 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display1_0 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display1_1 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display1_2 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display1_3 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display1_4 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display1_5 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display1_6 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display1_7 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display1_8 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display1_9 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display1_10 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display1_11 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display1_12 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display2_0 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display2_1 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display2_2 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display2_3 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display2_4 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display2_5 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display2_6 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display2_7 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display2_8 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display2_9 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display2_10 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display2_11 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display2_12 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display3_0 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display3_1 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display3_2 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display3_3 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display3_4 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display3_5 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display3_6 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display3_7 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display3_8 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display3_9 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display3_10 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display3_11 = CHARDISPLAY_NULL;
    reg [15:0] screen_pos_display3_12 = CHARDISPLAY_NULL;

    // For checking if each position is filled
    assign screen_pos_0_0_border = (x_pos >= 3 && x_pos <= 7) && (y_pos >= 1 && y_pos <= 5);
    assign screen_pos_0_1_border = (x_pos >= 10 && x_pos <= 14) && (y_pos >= 1 && y_pos <= 5);
    assign screen_pos_0_2_border = (x_pos >= 17 && x_pos <= 21) && (y_pos >= 1 && y_pos <= 5);
    assign screen_pos_0_3_border = (x_pos >= 24 && x_pos <= 28) && (y_pos >= 1 && y_pos <= 5);
    assign screen_pos_0_4_border = (x_pos >= 31 && x_pos <= 35) && (y_pos >= 1 && y_pos <= 5);
    assign screen_pos_0_5_border = (x_pos >= 38 && x_pos <= 42) && (y_pos >= 1 && y_pos <= 5);
    assign screen_pos_0_6_border = (x_pos >= 45 && x_pos <= 49) && (y_pos >= 1 && y_pos <= 5);
    assign screen_pos_0_7_border = (x_pos >= 52 && x_pos <= 56) && (y_pos >= 1 && y_pos <= 5);
    assign screen_pos_0_8_border = (x_pos >= 59 && x_pos <= 63) && (y_pos >= 1 && y_pos <= 5);
    assign screen_pos_0_9_border = (x_pos >= 66 && x_pos <= 70) && (y_pos >= 1 && y_pos <= 5);
    assign screen_pos_0_10_border = (x_pos >= 73 && x_pos <= 77) && (y_pos >= 1 && y_pos <= 5);
    assign screen_pos_0_11_border = (x_pos >= 80 && x_pos <= 84) && (y_pos >= 1 && y_pos <= 5);
    assign screen_pos_0_12_border = (x_pos >= 87 && x_pos <= 91) && (y_pos >= 1 && y_pos <= 5);
    assign screen_pos_1_0_border = (x_pos >= 3 && x_pos <= 7) && (y_pos >= 8 && y_pos <= 12);
    assign screen_pos_1_1_border = (x_pos >= 10 && x_pos <= 14) && (y_pos >= 8 && y_pos <= 12);
    assign screen_pos_1_2_border = (x_pos >= 17 && x_pos <= 21) && (y_pos >= 8 && y_pos <= 12);
    assign screen_pos_1_3_border = (x_pos >= 24 && x_pos <= 28) && (y_pos >= 8 && y_pos <= 12);
    assign screen_pos_1_4_border = (x_pos >= 31 && x_pos <= 35) && (y_pos >= 8 && y_pos <= 12);
    assign screen_pos_1_5_border = (x_pos >= 38 && x_pos <= 42) && (y_pos >= 8 && y_pos <= 12);
    assign screen_pos_1_6_border = (x_pos >= 45 && x_pos <= 49) && (y_pos >= 8 && y_pos <= 12);
    assign screen_pos_1_7_border = (x_pos >= 52 && x_pos <= 56) && (y_pos >= 8 && y_pos <= 12);
    assign screen_pos_1_8_border = (x_pos >= 59 && x_pos <= 63) && (y_pos >= 8 && y_pos <= 12);
    assign screen_pos_1_9_border = (x_pos >= 66 && x_pos <= 70) && (y_pos >= 8 && y_pos <= 12);
    assign screen_pos_1_10_border = (x_pos >= 73 && x_pos <= 77) && (y_pos >= 8 && y_pos <= 12);
    assign screen_pos_1_11_border = (x_pos >= 80 && x_pos <= 84) && (y_pos >= 8 && y_pos <= 12);
    assign screen_pos_1_12_border = (x_pos >= 87 && x_pos <= 91) && (y_pos >= 8 && y_pos <= 12);
    assign screen_pos_2_0_border = (x_pos >= 3 && x_pos <= 7) && (y_pos >= 15 && y_pos <= 19);
    assign screen_pos_2_1_border = (x_pos >= 10 && x_pos <= 14) && (y_pos >= 15 && y_pos <= 19);
    assign screen_pos_2_2_border = (x_pos >= 17 && x_pos <= 21) && (y_pos >= 15 && y_pos <= 19);
    assign screen_pos_2_3_border = (x_pos >= 24 && x_pos <= 28) && (y_pos >= 15 && y_pos <= 19);
    assign screen_pos_2_4_border = (x_pos >= 31 && x_pos <= 35) && (y_pos >= 15 && y_pos <= 19);
    assign screen_pos_2_5_border = (x_pos >= 38 && x_pos <= 42) && (y_pos >= 15 && y_pos <= 19);
    assign screen_pos_2_6_border = (x_pos >= 45 && x_pos <= 49) && (y_pos >= 15 && y_pos <= 19);
    assign screen_pos_2_7_border = (x_pos >= 52 && x_pos <= 56) && (y_pos >= 15 && y_pos <= 19);
    assign screen_pos_2_8_border = (x_pos >= 59 && x_pos <= 63) && (y_pos >= 15 && y_pos <= 19);
    assign screen_pos_2_9_border = (x_pos >= 66 && x_pos <= 70) && (y_pos >= 15 && y_pos <= 19);
    assign screen_pos_2_10_border = (x_pos >= 73 && x_pos <= 77) && (y_pos >= 15 && y_pos <= 19);
    assign screen_pos_2_11_border = (x_pos >= 80 && x_pos <= 84) && (y_pos >= 15 && y_pos <= 19);
    assign screen_pos_2_12_border = (x_pos >= 87 && x_pos <= 91) && (y_pos >= 15 && y_pos <= 19);
    assign screen_pos_3_0_border = (x_pos >= 3 && x_pos <= 7) && (y_pos >= 22 && y_pos <= 26);
    assign screen_pos_3_1_border = (x_pos >= 10 && x_pos <= 14) && (y_pos >= 22 && y_pos <= 26);
    assign screen_pos_3_2_border = (x_pos >= 17 && x_pos <= 21) && (y_pos >= 22 && y_pos <= 26);
    assign screen_pos_3_3_border = (x_pos >= 24 && x_pos <= 28) && (y_pos >= 22 && y_pos <= 26);
    assign screen_pos_3_4_border = (x_pos >= 31 && x_pos <= 35) && (y_pos >= 22 && y_pos <= 26);
    assign screen_pos_3_5_border = (x_pos >= 38 && x_pos <= 42) && (y_pos >= 22 && y_pos <= 26);
    assign screen_pos_3_6_border = (x_pos >= 45 && x_pos <= 49) && (y_pos >= 22 && y_pos <= 26);
    assign screen_pos_3_7_border = (x_pos >= 52 && x_pos <= 56) && (y_pos >= 22 && y_pos <= 26);
    assign screen_pos_3_8_border = (x_pos >= 59 && x_pos <= 63) && (y_pos >= 22 && y_pos <= 26);
    assign screen_pos_3_9_border = (x_pos >= 66 && x_pos <= 70) && (y_pos >= 22 && y_pos <= 26);
    assign screen_pos_3_10_border = (x_pos >= 73 && x_pos <= 77) && (y_pos >= 22 && y_pos <= 26);
    assign screen_pos_3_11_border = (x_pos >= 80 && x_pos <= 84) && (y_pos >= 22 && y_pos <= 26);
    assign screen_pos_3_12_border = (x_pos >= 87 && x_pos <= 91) && (y_pos >= 22 && y_pos <= 26);
    assign screen_pos_4_0_border = (x_pos >= 3 && x_pos <= 7) && (y_pos >= 29 && y_pos <= 33);
    assign screen_pos_4_1_border = (x_pos >= 10 && x_pos <= 14) && (y_pos >= 29 && y_pos <= 33);
    assign screen_pos_4_2_border = (x_pos >= 17 && x_pos <= 21) && (y_pos >= 29 && y_pos <= 33);
    assign screen_pos_4_3_border = (x_pos >= 24 && x_pos <= 28) && (y_pos >= 29 && y_pos <= 33);
    assign screen_pos_4_4_border = (x_pos >= 31 && x_pos <= 35) && (y_pos >= 29 && y_pos <= 33);
    assign screen_pos_4_5_border = (x_pos >= 38 && x_pos <= 42) && (y_pos >= 29 && y_pos <= 33);
    assign screen_pos_4_6_border = (x_pos >= 45 && x_pos <= 49) && (y_pos >= 29 && y_pos <= 33);
    assign screen_pos_4_7_border = (x_pos >= 52 && x_pos <= 56) && (y_pos >= 29 && y_pos <= 33);
    assign screen_pos_4_8_border = (x_pos >= 59 && x_pos <= 63) && (y_pos >= 29 && y_pos <= 33);
    assign screen_pos_4_9_border = (x_pos >= 66 && x_pos <= 70) && (y_pos >= 29 && y_pos <= 33);
    assign screen_pos_4_10_border = (x_pos >= 73 && x_pos <= 77) && (y_pos >= 29 && y_pos <= 33);
    assign screen_pos_4_11_border = (x_pos >= 80 && x_pos <= 84) && (y_pos >= 29 && y_pos <= 33);
    assign screen_pos_4_12_border = (x_pos >= 87 && x_pos <= 91) && (y_pos >= 29 && y_pos <= 33);

    // Keyboard borders
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

    function [15:0] displayChar(input[5:0] char, input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            case (char)
                CHARDISPLAY_WAITING: displayChar = displayWaiting(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_A: displayChar = displayA(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_B: displayChar = displayB(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_C: displayChar = displayC(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_D: displayChar = displayD(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_E: displayChar = displayE(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_F: displayChar = displayF(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_G: displayChar = displayG(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_H: displayChar = displayH(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_I: displayChar = displayI(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_J: displayChar = displayJ(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_K: displayChar = displayK(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_L: displayChar = displayL(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_M: displayChar = displayM(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_N: displayChar = displayN(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_O: displayChar = displayO(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_P: displayChar = displayP(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_Q: displayChar = displayQ(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_R: displayChar = displayR(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_S: displayChar = displayS(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_T: displayChar = displayT(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_U: displayChar = displayU(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_V: displayChar = displayV(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_W: displayChar = displayW(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_X: displayChar = displayX(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_Y: displayChar = displayY(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_Z: displayChar = displayZ(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_0: displayChar = display0(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_1: displayChar = display1(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_2: displayChar = display2(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_3: displayChar = display3(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_4: displayChar = display4(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_5: displayChar = display5(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_6: displayChar = display6(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_7: displayChar = display7(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_8: displayChar = display8(botleft_x, botleft_y, curr_x, curr_y);
                CHARDISPLAY_9: displayChar = display9(botleft_x, botleft_y, curr_x, curr_y);
            default: displayChar = BACKGROUND_COLOR;    
            endcase
        end

    endfunction

    function [15:0] displayWaiting (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)==0) && clock_1Hz) begin
                    displayWaiting = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayWaiting = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==0) && clock_1Hz) begin
                    displayWaiting = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayWaiting = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)==0) && clock_1Hz) begin
                    displayWaiting = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayWaiting = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==0) && clock_1Hz) begin
                    displayWaiting = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayWaiting = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)==0) && clock_1Hz) begin
                    displayWaiting = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayWaiting = BACKGROUND_COLOR;
                end
            end
            else begin
                displayWaiting = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayA (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayA = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayA = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayA = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayA = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayA = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayA = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayA = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayA = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=5)) begin
                    displayA = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayA = BACKGROUND_COLOR;
                end
            end
            else begin
                displayA = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayB (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayB = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayB = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayB = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayB = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayB = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayB = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayB = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayB = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)>=1) && ((botleft_y - curr_y)<=3)) begin
                    displayB = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayB = BACKGROUND_COLOR;
                end
            end
            else begin
                displayB = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayC (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayC = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayC = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayC = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayC = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayC = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayC = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayC = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayC = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayC = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayC = BACKGROUND_COLOR;
                end
            end
            else begin
                displayC = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayD (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayD = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayD = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayD = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayD = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayD = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayD = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayD = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayD = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)>=1) && ((botleft_y - curr_y)<=3)) begin
                    displayD = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayD = BACKGROUND_COLOR;
                end
            end
            else begin
                displayD = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayE (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayE = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayE = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayE = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayE = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayE = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayE = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayE = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayE = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayE = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayE = BACKGROUND_COLOR;
                end
            end
            else begin
                displayE = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayF (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayF = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayF = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayF = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayF = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayF = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayF = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayF = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayF = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if ((botleft_y - curr_y)==4) begin
                    displayF = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayF = BACKGROUND_COLOR;
                end
            end
            else begin
                displayF = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayG (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayG = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayG = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayG = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayG = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayG = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayG = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayG = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayG = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if ((botleft_y - curr_y)!=3) begin
                    displayG = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayG = BACKGROUND_COLOR;
                end
            end
            else begin
                displayG = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayH (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayH = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayH = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==2) begin
                    displayH = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayH = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==2) begin
                    displayH = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayH = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==2) begin
                    displayH = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayH = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayH = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayH = BACKGROUND_COLOR;
                end
            end
            else begin
                displayH = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayI (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayI = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayI = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayI = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayI = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayI = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayI = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayI = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayI = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayI = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayI = BACKGROUND_COLOR;
                end
            end
            else begin
                displayI = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayJ (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==1) || ((botleft_y - curr_y)==4)) begin
                    displayJ = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayJ = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayJ = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayJ = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayJ = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayJ = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==4) begin
                    displayJ = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayJ = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if ((botleft_y - curr_y)==4) begin
                    displayJ = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayJ = BACKGROUND_COLOR;
                end
            end
            else begin
                displayJ = BACKGROUND_COLOR;
            end
        end
    endfunction   

    function [15:0] displayK (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayK = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayK= BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==2) begin
                    displayK = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayK = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)==1) || ((botleft_y - curr_y)==3)) begin
                    displayK = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayK = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayK = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayK = BACKGROUND_COLOR;
                end
            end
            else begin
                displayK = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayL (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayL = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayL = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==0) begin
                    displayL = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayL = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==0) begin
                    displayL = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayL = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==0) begin
                    displayL = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayL = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if ((botleft_y - curr_y)==0) begin
                    displayL = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayL = BACKGROUND_COLOR;
                end
            end
            else begin
                displayL = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayM (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayM = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayM = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==3) begin
                    displayM = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayM = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==2) begin
                    displayM = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayM = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==3) begin
                    displayM = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayM = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayM = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayM = BACKGROUND_COLOR;
                end
            end
            else begin
                displayM = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayN (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayN = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayN = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==3) begin
                    displayN = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayN = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==2) begin
                    displayN = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayN = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==3) begin
                    displayN = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayN = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayN = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayN = BACKGROUND_COLOR;
                end
            end
            else begin
                displayN = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayO (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayO = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayO = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayO = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayO = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayO = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayO = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayO = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayO = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayO = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayO = BACKGROUND_COLOR;
                end
            end
            else begin
                displayO = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayP (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayP = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayP = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayP = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayP = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayP = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayP = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayP = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayP = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)>=2) && ((botleft_y - curr_y)<=4)) begin
                    displayP = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayP = BACKGROUND_COLOR;
                end
            end
            else begin
                displayP = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayQ (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayQ = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayQ = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayQ = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayQ = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayQ = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayQ = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==1) || ((botleft_y - curr_y)==4)) begin
                    displayQ = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayQ = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayQ = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayQ = BACKGROUND_COLOR;
                end
            end
            else begin
                displayQ = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayR (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayR = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayR = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayR = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayR = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayR = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayR = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==1) || ((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayR = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayR = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==3) || ((botleft_y - curr_y)==4)) begin
                    displayR = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayR = BACKGROUND_COLOR;
                end
            end
            else begin
                displayR = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayS (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==3) || ((botleft_y - curr_y)==4)) begin
                    displayS = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayS = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayS = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayS = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayS = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayS = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayS = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayS = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==1) || ((botleft_y - curr_y)==2) || ((botleft_y - curr_y)==4)) begin
                    displayS = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayS = BACKGROUND_COLOR;
                end
            end
            else begin
                displayS = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayT (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if ((botleft_y - curr_y)==4) begin
                    displayT = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayT = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==4) begin
                    displayT = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayT = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayT = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayT = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==4) begin
                    displayT = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayT = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if ((botleft_y - curr_y)==4) begin
                    displayT = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayT = BACKGROUND_COLOR;
                end
            end
            else begin
                displayT = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayU (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayU = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayU = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==0) begin
                    displayU = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayU = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==0) begin
                    displayU = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayU = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==0) begin
                    displayU = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayU = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayU = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayU = BACKGROUND_COLOR;
                end
            end
            else begin
                displayU = BACKGROUND_COLOR;
            end
        end
    endfunction
    
    function [15:0] displayV (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)==3) || ((botleft_y - curr_y)==4)) begin
                    displayV = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayV = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==1) || ((botleft_y - curr_y)==2)) begin
                    displayV = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayV = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==0) begin
                    displayV = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayV = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==1) || ((botleft_y - curr_y)==2)) begin
                    displayV = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayV = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)==3) || ((botleft_y - curr_y)==4)) begin
                    displayV = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayV = BACKGROUND_COLOR;
                end
            end
            else begin
                displayV = BACKGROUND_COLOR;
            end
        end
    endfunction
    
    function [15:0] displayW (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayW = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayW = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==0) begin
                    displayW = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayW = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==1) begin
                    displayW = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayW = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==0) begin
                    displayW = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayW = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)>=0) && ((botleft_y - curr_y)<=4)) begin
                    displayW = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayW = BACKGROUND_COLOR;
                end
            end
            else begin
                displayW = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayX (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayX = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayX = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if (((botleft_y - curr_y)==1) || ((botleft_y - curr_y)==3)) begin
                    displayX = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayX = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==2) begin
                    displayX = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayX = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if (((botleft_y - curr_y)==1) || ((botleft_y - curr_y)==3)) begin
                    displayX = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayX = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if (((botleft_y - curr_y)==0) || ((botleft_y - curr_y)==4)) begin
                    displayX = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayX = BACKGROUND_COLOR;
                end
            end
            else begin
                displayX = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayY (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if ((botleft_y - curr_y)==4) begin
                    displayY = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayY = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==3) begin
                    displayY = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayY = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==1 || (botleft_y - curr_y)==2) begin
                    displayY = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayY = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==3) begin
                    displayY = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayY = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if ((botleft_y - curr_y)==4) begin
                    displayY = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayY = BACKGROUND_COLOR;
                end
            end
            else begin
                displayY = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] displayZ (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==4) begin
                    displayZ = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayZ = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==1 || (botleft_y - curr_y)==4) begin
                    displayZ = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayZ = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 || (botleft_y - curr_y)==4) begin
                    displayZ = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayZ = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==3 || (botleft_y - curr_y)==4) begin
                    displayZ = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayZ = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==4) begin
                    displayZ = DISPLAYCHAR_COLOUR;
                end
                else begin
                    displayZ = BACKGROUND_COLOR;
                end
            end
            else begin
                displayZ = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] display0 (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if ((botleft_y - curr_y)>=1 && (botleft_y - curr_y)<=3) begin
                    display0 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display0 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==4) begin
                    display0 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display0 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==4) begin
                    display0 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display0 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==4) begin
                    display0 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display0 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if ((botleft_y - curr_y)>=1 && (botleft_y - curr_y)<=3) begin
                    display0 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display0 = BACKGROUND_COLOR;
                end
            end
            else begin
                display0 = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] display1 (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==4) begin
                    display1 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display1 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)>=0 && (botleft_y - curr_y)<=4) begin
                    display1 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display1 = BACKGROUND_COLOR;
                end
            end
            else begin
                display1 = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] display2 (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==3) begin
                    display2 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display2 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==1 || (botleft_y - curr_y)==4) begin
                    display2 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display2 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 || (botleft_y - curr_y)==4) begin
                    display2 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display2 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==3) begin
                    display2 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display2 = BACKGROUND_COLOR;
                end
            end
            else begin
                display2 = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] display3 (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==4) begin
                    display3 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display3 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 || (botleft_y - curr_y)==4) begin
                    display3 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display3 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 || (botleft_y - curr_y)==4) begin
                    display3 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display3 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 || (botleft_y - curr_y)==4) begin
                    display3 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display3 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if ((botleft_y - curr_y)>=0 && (botleft_y - curr_y)<=4) begin
                    display3 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display3 = BACKGROUND_COLOR;
                end
            end
            else begin
                display3 = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] display4 (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if ((botleft_y - curr_y)>=2 && (botleft_y - curr_y)<=4) begin
                    display4 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display4 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==2) begin
                    display4 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display4 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==2) begin
                    display4 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display4 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==2) begin
                    display4 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display4 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if ((botleft_y - curr_y)>=0 && (botleft_y - curr_y)<=4) begin
                    display4 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display4 = BACKGROUND_COLOR;
                end
            end
            else begin
                display4 = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] display5 (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 || (botleft_y - curr_y)==3) begin
                    display5 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display5 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 || (botleft_y - curr_y)==4) begin
                    display5 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display5 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 || (botleft_y - curr_y)==4) begin
                    display5 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display5 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 || (botleft_y - curr_y)==4) begin
                    display5 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display5 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==1 || (botleft_y - curr_y)==2 || (botleft_y - curr_y)==4) begin
                    display5 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display5 = BACKGROUND_COLOR;
                end
            end
            else begin
                display5 = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] display6 (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if ((botleft_y - curr_y)>=0 && (botleft_y - curr_y)<=4) begin
                    display6 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display6 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 || (botleft_y - curr_y)==4) begin
                    display6 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display6 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 || (botleft_y - curr_y)==4) begin
                    display6 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display6 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 || (botleft_y - curr_y)==4) begin
                    display6 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display6 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==1 || (botleft_y - curr_y)==2 || (botleft_y - curr_y)==4) begin
                    display6 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display6 = BACKGROUND_COLOR;
                end
            end
            else begin
                display6 = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] display7 (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if ((botleft_y - curr_y)==4) begin
                    display7 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display7 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==4) begin
                    display7 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display7 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==1 || (botleft_y - curr_y)==4) begin
                    display7 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display7 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==2 || (botleft_y - curr_y)==4) begin
                    display7 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display7 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if ((botleft_y - curr_y)==3 || (botleft_y - curr_y)==4) begin
                    display7 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display7 = BACKGROUND_COLOR;
                end
            end
            else begin
                display7 = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] display8 (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==1 || (botleft_y - curr_y)==3 ||(botleft_y - curr_y)==4) begin
                    display8 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display8 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 ||(botleft_y - curr_y)==4) begin
                    display8 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display8 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 ||(botleft_y - curr_y)==4) begin
                    display8 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display8 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 ||(botleft_y - curr_y)==4) begin
                    display8 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display8 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==1 || (botleft_y - curr_y)==3 ||(botleft_y - curr_y)==4) begin
                    display8 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display8 = BACKGROUND_COLOR;
                end
            end
            else begin
                display8 = BACKGROUND_COLOR;
            end
        end
    endfunction

    function [15:0] display9 (input[6:0] botleft_x, input[6:0] botleft_y, input[6:0] curr_x, input[6:0] curr_y);
        begin
            if (botleft_x == curr_x) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 || (botleft_y - curr_y)==3 ||(botleft_y - curr_y)==4) begin
                    display9 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display9 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 1) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 ||(botleft_y - curr_y)==4) begin
                    display9 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display9 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 2) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 ||(botleft_y - curr_y)==4) begin
                    display9 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display9 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 3) begin
                if ((botleft_y - curr_y)==0 || (botleft_y - curr_y)==2 ||(botleft_y - curr_y)==4) begin
                    display9 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display9 = BACKGROUND_COLOR;
                end
            end
            else if ((curr_x-botleft_x) == 4) begin
                if ((botleft_y - curr_y)>=0 && (botleft_y - curr_y)<=4) begin
                    display9 = DISPLAYCHAR_COLOUR;
                end
                else begin
                    display9 = BACKGROUND_COLOR;
                end
            end
            else begin
                display9 = BACKGROUND_COLOR;
            end
        end
    endfunction

    // Registering of mouse clicks
    reg canDisplay = 1;
    reg [5:0] charDisplay = CHARDISPLAY_WAITING;

    always @ (posedge clock) begin
        if (sw[15]) begin
            charDisplay <= CHARDISPLAY_CLEAR;
        end
        else if (state == MANUAL_MODE) begin // manual typing mode
            if (~left_click) begin 
                canDisplay <= 1;
            end

            if ((charDisplay != CHARDISPLAY_WAITING) && (charDisplay != CHARDISPLAY_NULL)) begin
                case (charDisplay)
                    CHARDISPLAY_BACKSPACE: begin
                        if (char_pos > 0) begin
                            char_pos <= char_pos - 1;
                        end else begin
                            char_pos <= 51;
                        end
                    end

                    CHARDISPLAY_ENTER : begin
                        if (char_pos <= 38) begin
                            char_pos <= char_pos + 13;
                        end else begin
                            char_pos <= char_pos - 39;
                        end
                    end

                    CHARDISPLAY_CLEAR : begin
                        char_pos <= 0;
                    end

                    default : begin
                        if (char_pos < 51) begin
                            char_pos <= char_pos + 1;
                        end
                        else begin
                            char_pos <= 0;
                        end
                    end
                endcase

                charDisplay <= CHARDISPLAY_WAITING; 
            end

            if (letter_A_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_A;
            end
            else if (letter_B_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_B;
            end
            else if (letter_C_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_C;
            end
            else if (letter_D_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_D;
            end
            else if (letter_E_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_E;
            end
            else if (letter_F_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_F;
            end
            else if (letter_G_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_G;
            end
            else if (letter_H_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_H;
            end
            else if (letter_I_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_I;
            end
            else if (letter_J_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_J;
            end
            else if (letter_K_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_K;
            end
            else if (letter_L_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_L;
            end
            else if (letter_M_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_M;
            end
            else if (letter_N_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_N;
            end
            else if (letter_O_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_O;
            end
            else if (letter_P_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_P;
            end
            else if (letter_Q_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_Q;
            end
            else if (letter_R_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_R;
            end
            else if (letter_S_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_S;
            end
            else if (letter_T_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_T;
            end
            else if (letter_U_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_U;
            end
            else if (letter_V_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_V;
            end
            else if (letter_W_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_W;
            end
            else if (letter_X_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_X;
            end
            else if (letter_Y_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_Y;
            end
            else if (letter_Z_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_Z;
            end
            else if (number_0_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_0;
            end
            else if (number_1_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_1;
            end
            else if (number_2_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_2;
            end
            else if (number_3_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_3;
            end
            else if (number_4_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_4;
            end
            else if (number_5_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_5;
            end
            else if (number_6_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_6;
            end
            else if (number_7_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_7;
            end
            else if (number_8_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_8;
            end
            else if (number_9_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_9;
            end
            else if (spacebar_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_SPACEBAR;
            end
            else if (del_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_BACKSPACE;
            end
            else if (enter_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_ENTER;
            end
            else if (clear_hover && left_click && canDisplay) begin
                canDisplay <= 0;
                charDisplay <= CHARDISPLAY_CLEAR;
            end
        end
        
        else if (state == AUTO_MODE) begin
            rand_num_counter <= (rand_num_counter < 4000) ? rand_num_counter + 1 : 0;
            if ((rand_num_counter == 0) && (btnC_debounce || sw[1])) begin
                charDisplay <= rand_num;
                
                if (charDisplay == CHARDISPLAY_WAITING) begin
                    char_pos <= char_pos;
                end
                else begin
                    char_pos <= (char_pos < 51) ? char_pos + 1 : 0;
                end
            end
        end
    end

    // Registering current position of screen display cursor
    always @ (posedge clock) begin
        if (charDisplay == CHARDISPLAY_CLEAR) begin
            screen_pos_display0_0 <= CHARDISPLAY_WAITING;
            screen_pos_display0_1 <= CHARDISPLAY_NULL;
            screen_pos_display0_2 <= CHARDISPLAY_NULL;
            screen_pos_display0_3 <= CHARDISPLAY_NULL;
            screen_pos_display0_4 <= CHARDISPLAY_NULL;
            screen_pos_display0_5 <= CHARDISPLAY_NULL;
            screen_pos_display0_6 <= CHARDISPLAY_NULL;
            screen_pos_display0_7 <= CHARDISPLAY_NULL;
            screen_pos_display0_8 <= CHARDISPLAY_NULL;
            screen_pos_display0_9 <= CHARDISPLAY_NULL;
            screen_pos_display0_10 <= CHARDISPLAY_NULL;
            screen_pos_display0_11 <= CHARDISPLAY_NULL;
            screen_pos_display0_12 <= CHARDISPLAY_NULL;

            screen_pos_display1_0 <= CHARDISPLAY_NULL;
            screen_pos_display1_1 <= CHARDISPLAY_NULL;
            screen_pos_display1_2 <= CHARDISPLAY_NULL;
            screen_pos_display1_3 <= CHARDISPLAY_NULL;
            screen_pos_display1_4 <= CHARDISPLAY_NULL;
            screen_pos_display1_5 <= CHARDISPLAY_NULL;
            screen_pos_display1_6 <= CHARDISPLAY_NULL;
            screen_pos_display1_7 <= CHARDISPLAY_NULL;
            screen_pos_display1_8 <= CHARDISPLAY_NULL;
            screen_pos_display1_9 <= CHARDISPLAY_NULL;
            screen_pos_display1_10 <= CHARDISPLAY_NULL;
            screen_pos_display1_11 <= CHARDISPLAY_NULL;
            screen_pos_display1_12 <= CHARDISPLAY_NULL;
            
            screen_pos_display2_0 <= CHARDISPLAY_NULL;
            screen_pos_display2_1 <= CHARDISPLAY_NULL;
            screen_pos_display2_2 <= CHARDISPLAY_NULL;
            screen_pos_display2_3 <= CHARDISPLAY_NULL;
            screen_pos_display2_4 <= CHARDISPLAY_NULL;
            screen_pos_display2_5 <= CHARDISPLAY_NULL;
            screen_pos_display2_6 <= CHARDISPLAY_NULL;
            screen_pos_display2_7 <= CHARDISPLAY_NULL;
            screen_pos_display2_8 <= CHARDISPLAY_NULL;
            screen_pos_display2_9 <= CHARDISPLAY_NULL;
            screen_pos_display2_10 <= CHARDISPLAY_NULL;
            screen_pos_display2_11 <= CHARDISPLAY_NULL;
            screen_pos_display2_12 <= CHARDISPLAY_NULL;

            screen_pos_display3_0 <= CHARDISPLAY_NULL;
            screen_pos_display3_1 <= CHARDISPLAY_NULL;
            screen_pos_display3_2 <= CHARDISPLAY_NULL;
            screen_pos_display3_3 <= CHARDISPLAY_NULL;
            screen_pos_display3_4 <= CHARDISPLAY_NULL;
            screen_pos_display3_5 <= CHARDISPLAY_NULL;
            screen_pos_display3_6 <= CHARDISPLAY_NULL;
            screen_pos_display3_7 <= CHARDISPLAY_NULL;
            screen_pos_display3_8 <= CHARDISPLAY_NULL;
            screen_pos_display3_9 <= CHARDISPLAY_NULL;
            screen_pos_display3_10 <= CHARDISPLAY_NULL;
            screen_pos_display3_11 <= CHARDISPLAY_NULL;
            screen_pos_display3_12 <= CHARDISPLAY_NULL;
        end

        case (char_pos)
            // First row
            0 : screen_pos_display0_0 <= charDisplay;
            1 : screen_pos_display0_1 <= charDisplay;
            2 : screen_pos_display0_2 <= charDisplay;
            3 : screen_pos_display0_3 <= charDisplay;
            4 : screen_pos_display0_4 <= charDisplay;
            5 : screen_pos_display0_5 <= charDisplay;
            6 : screen_pos_display0_6 <= charDisplay;
            7 : screen_pos_display0_7 <= charDisplay;
            8 : screen_pos_display0_8 <= charDisplay;
            9 : screen_pos_display0_9 <= charDisplay;
            10 : screen_pos_display0_10 <= charDisplay;
            11 : screen_pos_display0_11 <= charDisplay;
            12 : screen_pos_display0_12 <= charDisplay;

            // Second row
            13 : screen_pos_display1_0 <= charDisplay;
            14 : screen_pos_display1_1 <= charDisplay;
            15 : screen_pos_display1_2 <= charDisplay;
            16 : screen_pos_display1_3 <= charDisplay;
            17 : screen_pos_display1_4 <= charDisplay;
            18 : screen_pos_display1_5 <= charDisplay;
            19 : screen_pos_display1_6 <= charDisplay;
            20 : screen_pos_display1_7 <= charDisplay;
            21 : screen_pos_display1_8 <= charDisplay;
            22 : screen_pos_display1_9 <= charDisplay;
            23 : screen_pos_display1_10 <= charDisplay;
            24 : screen_pos_display1_11 <= charDisplay;
            25 : screen_pos_display1_12 <= charDisplay;

            // Third row
            26 : screen_pos_display2_0 <= charDisplay;
            27 : screen_pos_display2_1 <= charDisplay;
            28 : screen_pos_display2_2 <= charDisplay;
            29 : screen_pos_display2_3 <= charDisplay;
            30 : screen_pos_display2_4 <= charDisplay;
            31 : screen_pos_display2_5 <= charDisplay;
            32 : screen_pos_display2_6 <= charDisplay;
            33 : screen_pos_display2_7 <= charDisplay;
            34 : screen_pos_display2_8 <= charDisplay;
            35 : screen_pos_display2_9 <= charDisplay;
            36 : screen_pos_display2_10 <= charDisplay;
            37 : screen_pos_display2_11 <= charDisplay;
            38 : screen_pos_display2_12 <= charDisplay;
            
            // Fourth row
            39 : screen_pos_display3_0 <= charDisplay;
            40 : screen_pos_display3_1 <= charDisplay;
            41 : screen_pos_display3_2 <= charDisplay;
            42 : screen_pos_display3_3 <= charDisplay;
            43 : screen_pos_display3_4 <= charDisplay;
            44 : screen_pos_display3_5 <= charDisplay;
            45 : screen_pos_display3_6 <= charDisplay;
            46 : screen_pos_display3_7 <= charDisplay;
            47 : screen_pos_display3_8 <= charDisplay;
            48 : screen_pos_display3_9 <= charDisplay;
            49 : screen_pos_display3_10 <= charDisplay;
            50 : screen_pos_display3_11 <= charDisplay;
            51 : screen_pos_display3_12 <= charDisplay;
        endcase
    end

    // For display screen on top half of OLED
    reg[15:0] topHalfDisplay = 0;
    always @ (*) begin
        if (screen_pos_0_0_border) begin
            topHalfDisplay = displayChar(screen_pos_display0_0,3,5,x_pos,y_pos);
        end
        else if (screen_pos_0_1_border) begin
            topHalfDisplay = displayChar(screen_pos_display0_1,10,5,x_pos,y_pos);
        end
        else if (screen_pos_0_2_border) begin
            topHalfDisplay = displayChar(screen_pos_display0_2,17,5,x_pos,y_pos);
        end
        else if (screen_pos_0_3_border) begin
            topHalfDisplay = displayChar(screen_pos_display0_3,24,5,x_pos,y_pos);
        end
        else if (screen_pos_0_4_border) begin
            topHalfDisplay = displayChar(screen_pos_display0_4,31,5,x_pos,y_pos);
        end
        else if (screen_pos_0_5_border) begin
            topHalfDisplay = displayChar(screen_pos_display0_5,38,5,x_pos,y_pos);
        end
        else if (screen_pos_0_6_border) begin
            topHalfDisplay = displayChar(screen_pos_display0_6,45,5,x_pos,y_pos);
        end
        else if (screen_pos_0_7_border) begin
            topHalfDisplay = displayChar(screen_pos_display0_7,52,5,x_pos,y_pos);
        end
        else if (screen_pos_0_8_border) begin
            topHalfDisplay = displayChar(screen_pos_display0_8,59,5,x_pos,y_pos);
        end
        else if (screen_pos_0_9_border) begin
            topHalfDisplay = displayChar(screen_pos_display0_9,66,5,x_pos,y_pos);
        end
        else if (screen_pos_0_10_border) begin
            topHalfDisplay = displayChar(screen_pos_display0_10,73,5,x_pos,y_pos);
        end
        else if (screen_pos_0_11_border) begin
            topHalfDisplay = displayChar(screen_pos_display0_11,80,5,x_pos,y_pos);
        end
        else if (screen_pos_0_12_border) begin
            topHalfDisplay = displayChar(screen_pos_display0_12,87,5,x_pos,y_pos);
        end

        else if (screen_pos_1_0_border) begin
            topHalfDisplay = displayChar(screen_pos_display1_0,3,12,x_pos,y_pos);
        end
        else if (screen_pos_1_1_border) begin
            topHalfDisplay = displayChar(screen_pos_display1_1,10,12,x_pos,y_pos);
        end
        else if (screen_pos_1_2_border) begin
            topHalfDisplay = displayChar(screen_pos_display1_2,17,12,x_pos,y_pos);
        end
        else if (screen_pos_1_3_border) begin
            topHalfDisplay = displayChar(screen_pos_display1_3,24,12,x_pos,y_pos);
        end
        else if (screen_pos_1_4_border) begin
            topHalfDisplay = displayChar(screen_pos_display1_4,31,12,x_pos,y_pos);
        end
        else if (screen_pos_1_5_border) begin
            topHalfDisplay = displayChar(screen_pos_display1_5,38,12,x_pos,y_pos);
        end
        else if (screen_pos_1_6_border) begin
            topHalfDisplay = displayChar(screen_pos_display1_6,45,12,x_pos,y_pos);
        end
        else if (screen_pos_1_7_border) begin
            topHalfDisplay = displayChar(screen_pos_display1_7,52,12,x_pos,y_pos);
        end
        else if (screen_pos_1_8_border) begin
            topHalfDisplay = displayChar(screen_pos_display1_8,59,12,x_pos,y_pos);
        end
        else if (screen_pos_1_9_border) begin
            topHalfDisplay = displayChar(screen_pos_display1_9,66,12,x_pos,y_pos);
        end
        else if (screen_pos_1_10_border) begin
            topHalfDisplay = displayChar(screen_pos_display1_10,73,12,x_pos,y_pos);
        end
        else if (screen_pos_1_11_border) begin
            topHalfDisplay = displayChar(screen_pos_display1_11,80,12,x_pos,y_pos);
        end
        else if (screen_pos_1_12_border) begin
            topHalfDisplay = displayChar(screen_pos_display1_12,87,12,x_pos,y_pos);
        end

        else if (screen_pos_2_0_border) begin
            topHalfDisplay = displayChar(screen_pos_display2_0,3,19,x_pos,y_pos);
        end
        else if (screen_pos_2_1_border) begin
            topHalfDisplay = displayChar(screen_pos_display2_1,10,19,x_pos,y_pos);
        end
        else if (screen_pos_2_2_border) begin
            topHalfDisplay = displayChar(screen_pos_display2_2,17,19,x_pos,y_pos);
        end
        else if (screen_pos_2_3_border) begin
            topHalfDisplay = displayChar(screen_pos_display2_3,24,19,x_pos,y_pos);
        end
        else if (screen_pos_2_4_border) begin
            topHalfDisplay = displayChar(screen_pos_display2_4,31,19,x_pos,y_pos);
        end
        else if (screen_pos_2_5_border) begin
            topHalfDisplay = displayChar(screen_pos_display2_5,38,19,x_pos,y_pos);
        end
        else if (screen_pos_2_6_border) begin
            topHalfDisplay = displayChar(screen_pos_display2_6,45,19,x_pos,y_pos);
        end
        else if (screen_pos_2_7_border) begin
            topHalfDisplay = displayChar(screen_pos_display2_7,52,19,x_pos,y_pos);
        end
        else if (screen_pos_2_8_border) begin
            topHalfDisplay = displayChar(screen_pos_display2_8,59,19,x_pos,y_pos);
        end
        else if (screen_pos_2_9_border) begin
            topHalfDisplay = displayChar(screen_pos_display2_9,66,19,x_pos,y_pos);
        end
        else if (screen_pos_2_10_border) begin
            topHalfDisplay = displayChar(screen_pos_display2_10,73,19,x_pos,y_pos);
        end
        else if (screen_pos_2_11_border) begin
            topHalfDisplay = displayChar(screen_pos_display2_11,80,19,x_pos,y_pos);
        end
        else if (screen_pos_2_12_border) begin
            topHalfDisplay = displayChar(screen_pos_display2_12,87,19,x_pos,y_pos);
        end

        else if (screen_pos_3_0_border) begin
            topHalfDisplay = displayChar(screen_pos_display3_0,3,26,x_pos,y_pos);
        end
        else if (screen_pos_3_1_border) begin
            topHalfDisplay = displayChar(screen_pos_display3_1,10,26,x_pos,y_pos);
        end
        else if (screen_pos_3_2_border) begin
            topHalfDisplay = displayChar(screen_pos_display3_2,17,26,x_pos,y_pos);
        end
        else if (screen_pos_3_3_border) begin
            topHalfDisplay = displayChar(screen_pos_display3_3,24,26,x_pos,y_pos);
        end
        else if (screen_pos_3_4_border) begin
            topHalfDisplay = displayChar(screen_pos_display3_4,31,26,x_pos,y_pos);
        end
        else if (screen_pos_3_5_border) begin
            topHalfDisplay = displayChar(screen_pos_display3_5,38,26,x_pos,y_pos);
        end
        else if (screen_pos_3_6_border) begin
            topHalfDisplay = displayChar(screen_pos_display3_6,45,26,x_pos,y_pos);
        end
        else if (screen_pos_3_7_border) begin
            topHalfDisplay = displayChar(screen_pos_display3_7,52,26,x_pos,y_pos);
        end
        else if (screen_pos_3_8_border) begin
            topHalfDisplay = displayChar(screen_pos_display3_8,59,26,x_pos,y_pos);
        end
        else if (screen_pos_3_9_border) begin
            topHalfDisplay = displayChar(screen_pos_display3_9,66,26,x_pos,y_pos);
        end
        else if (screen_pos_3_10_border) begin
            topHalfDisplay = displayChar(screen_pos_display3_10,73,26,x_pos,y_pos);
        end
        else if (screen_pos_3_11_border) begin
            topHalfDisplay = displayChar(screen_pos_display3_11,80,26,x_pos,y_pos);
        end
        else if (screen_pos_3_12_border) begin
            topHalfDisplay = displayChar(screen_pos_display3_12,87,26,x_pos,y_pos);
        end

        else begin
            topHalfDisplay = BACKGROUND_COLOR;
        end
    end
    
    // For display keyboard on bottom half of OLED
    reg [15:0] bottomHalfDisplay = 0;
    always @ (*) begin
        if (keyboard_border) begin
            bottomHalfDisplay = KEYBOARD_COLOUR;
        end

        else if (letter_A) begin
            bottomHalfDisplay = letter_A_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_B) begin
            bottomHalfDisplay = letter_B_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_C) begin
            bottomHalfDisplay = letter_C_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_D) begin
            bottomHalfDisplay = letter_D_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_E) begin
            bottomHalfDisplay = letter_E_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_F) begin
            bottomHalfDisplay = letter_F_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_G) begin
            bottomHalfDisplay = letter_G_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_H) begin
            bottomHalfDisplay = letter_H_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_I) begin
            bottomHalfDisplay = letter_I_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_J) begin
            bottomHalfDisplay = letter_J_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_K) begin
            bottomHalfDisplay = letter_K_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_L) begin
            bottomHalfDisplay = letter_L_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_M) begin
            bottomHalfDisplay = letter_M_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_N) begin
            bottomHalfDisplay = letter_N_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_O) begin
            bottomHalfDisplay = letter_O_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_P) begin
            bottomHalfDisplay = letter_P_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_Q) begin
            bottomHalfDisplay = letter_Q_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_R) begin
            bottomHalfDisplay = letter_R_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_S) begin
            bottomHalfDisplay = letter_S_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_T) begin
            bottomHalfDisplay = letter_T_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_U) begin
            bottomHalfDisplay = letter_U_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_V) begin
            bottomHalfDisplay = letter_V_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_W) begin
            bottomHalfDisplay = letter_W_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_X) begin
            bottomHalfDisplay = letter_X_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_Y) begin
            bottomHalfDisplay = letter_Y_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (letter_Z) begin
            bottomHalfDisplay = letter_Z_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_0) begin
            bottomHalfDisplay = number_0_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_1) begin
            bottomHalfDisplay = number_1_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_2) begin
            bottomHalfDisplay = number_2_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_3) begin
            bottomHalfDisplay = number_3_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_4) begin
            bottomHalfDisplay = number_4_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_5) begin
            bottomHalfDisplay = number_5_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_6) begin
            bottomHalfDisplay = number_6_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_7) begin
            bottomHalfDisplay = number_7_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_8) begin
            bottomHalfDisplay = number_8_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (number_9) begin
            bottomHalfDisplay = number_9_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (spacebar) begin
            bottomHalfDisplay = spacebar_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (del) begin
            bottomHalfDisplay = del_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (enter) begin
            bottomHalfDisplay = enter_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else if (clear) begin
            bottomHalfDisplay = clear_hover ? HOVER_COLOURED : HOVER_NOT_COLOURED;
        end

        else begin
            bottomHalfDisplay = BLACK;
        end
    end

    // Controlling of OLED display
    always @ (*) begin
        if (mouse_pos) begin
            pixel_data = RED;
        end

        else if (topHalf) begin
            pixel_data <= topHalfDisplay;
        end

        else if (bottomHalf) begin
            pixel_data <= bottomHalfDisplay;
        end
    end
endmodule
