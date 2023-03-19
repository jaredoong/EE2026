`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2023 17:46:08
// Design Name: 
// Module Name: group_g
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


module group_g(
    input [15:0] sw,
    input [12:0] pixel_index,
    input left_click,
    input right_click,
    input [6:0] diff_x,
    input [6:0] diff_y,
    output reg [3:0] cursor_size = 1,
    output reg [15:0] pixel_data = 0,
    output reg [11:0] led = 12'b000000000000,
    output reg [3:0] an = 4'b1111,
    output reg [6:0] seg = 7'b1111111,
    output reg dp = 1'b1,
    output reg valid_number = 0
    );

    localparam RED = 16'hF800;
    localparam GREEN = 16'h07E0;
    localparam WHITE = 16'hFFFF;
    localparam BLACK = 16'h0000;

    localparam cursor_color = RED;

    wire [6:0] x_pos;
    wire [5:0] y_pos;

    reg showGreenBorder = 0;
    reg seg_a_filled = 0;
    reg seg_b_filled = 0;
    reg seg_c_filled = 0;
    reg seg_d_filled = 0;
    reg seg_e_filled = 0;
    reg seg_f_filled = 0;
    reg seg_g_filled = 0;
    reg topLeftBox_filled = 0;
    reg midLeftBox_filled = 0;
    reg botLeftBox_filled = 0;
    reg topRightBox_filled = 0;
    reg midRightBox_filled = 0;
    reg botRightBox_filled = 0;

    assign mouse_pos = (diff_x < cursor_size) && (diff_y < cursor_size);

    assign x_pos = pixel_index % 96;
    assign y_pos = pixel_index / 96;

    assign greenBorder = (((x_pos == 56 || x_pos == 57 || x_pos == 58) && (y_pos <= 58)) || ((y_pos == 56 || y_pos == 57 || y_pos == 58) && (x_pos <= 58)));

    assign seg_a = ((x_pos >= 20 && x_pos <= 40) && (y_pos >= 4 && y_pos <= 7));

    assign seg_b = ((x_pos >= 42 && x_pos <= 45) && (y_pos >= 9 && y_pos <= 21));

    assign seg_c = ((x_pos >= 42 && x_pos <= 45) && (y_pos >= 28 && y_pos <= 41));

    assign seg_d = ((x_pos >= 20 && x_pos <= 40) && (y_pos >= 43 && y_pos <= 46));

    assign seg_e = ((x_pos >= 15 && x_pos <= 18) && (y_pos >= 28 && y_pos <= 41));

    assign seg_f = ((x_pos >= 15 && x_pos <= 18) && (y_pos >= 9 && y_pos <= 21));

    assign seg_g = ((x_pos >= 20 && x_pos <= 40) && (y_pos >= 23 && y_pos <= 26));

    assign topLeftBox = ((x_pos >= 15 && x_pos <= 18) && (y_pos >= 4 && y_pos <= 7));

    assign midLeftBox = ((x_pos >= 15 && x_pos <= 18) && (y_pos >= 23 && y_pos <= 26));

    assign botLeftBox = ((x_pos >= 15 && x_pos <= 18) && (y_pos >= 43 && y_pos <= 46));

    assign topRightBox = ((x_pos >= 42 && x_pos <= 45) && (y_pos >= 4 && y_pos <= 7));

    assign midRightBox = ((x_pos >= 42 && x_pos <= 45) && (y_pos >= 23 && y_pos <= 26));

    assign botRightBox = ((x_pos >= 42 && x_pos <= 45) && (y_pos >= 43 && y_pos <= 46));

    assign valid0 = seg_a_filled && seg_b_filled && seg_c_filled && seg_d_filled && seg_e_filled && seg_f_filled && ~seg_g_filled && topLeftBox_filled && midLeftBox_filled && botLeftBox_filled && topRightBox_filled && midRightBox_filled && botRightBox_filled;

    assign valid1 = ~seg_a_filled && seg_b_filled && seg_c_filled && ~seg_d_filled && ~seg_e_filled && ~seg_f_filled && ~seg_g_filled && topRightBox_filled && midRightBox_filled && botRightBox_filled;

    assign valid2 = seg_a_filled && seg_b_filled && ~seg_c_filled && seg_d_filled && seg_e_filled && ~seg_f_filled && seg_g_filled && topLeftBox_filled && midLeftBox_filled && botLeftBox_filled && topRightBox_filled && midRightBox_filled && botRightBox_filled;

    assign valid3 = seg_a_filled && seg_b_filled && seg_c_filled && seg_d_filled && ~seg_e_filled && ~seg_f_filled && seg_g_filled && topLeftBox_filled && midLeftBox_filled && botLeftBox_filled && topRightBox_filled && midRightBox_filled && botRightBox_filled;

    assign valid4 = ~seg_a_filled && seg_b_filled && seg_c_filled && ~seg_d_filled && ~seg_e_filled && seg_f_filled && seg_g_filled && topLeftBox_filled && midLeftBox_filled && ~botLeftBox_filled && topRightBox_filled && midRightBox_filled && botRightBox_filled;

    assign valid5 = seg_a_filled && ~seg_b_filled && seg_c_filled && seg_d_filled && ~seg_e_filled && seg_f_filled && seg_g_filled && topLeftBox_filled && midLeftBox_filled && botLeftBox_filled && topRightBox_filled && midRightBox_filled && botRightBox_filled;

    assign valid6 = seg_a_filled && ~seg_b_filled && seg_c_filled && seg_d_filled && seg_e_filled && seg_f_filled && seg_g_filled && topLeftBox_filled && midLeftBox_filled && botLeftBox_filled && topRightBox_filled && midRightBox_filled && botRightBox_filled;

    assign valid7 = seg_a_filled && seg_b_filled && seg_c_filled && ~seg_d_filled && ~seg_e_filled && ~seg_f_filled && ~seg_g_filled && topLeftBox_filled && ~midLeftBox_filled && ~botLeftBox_filled &&topRightBox_filled && midRightBox_filled && botRightBox_filled;

    assign valid8 = seg_a_filled && seg_b_filled && seg_c_filled && seg_d_filled && seg_e_filled && seg_f_filled && seg_g_filled && topLeftBox_filled && midLeftBox_filled && botLeftBox_filled && topRightBox_filled && midRightBox_filled && botRightBox_filled;

    assign valid9 = seg_a_filled && seg_b_filled && seg_c_filled && seg_d_filled && ~seg_e_filled && seg_f_filled && seg_g_filled && topLeftBox_filled && midLeftBox_filled && botLeftBox_filled && topRightBox_filled && midRightBox_filled && botRightBox_filled;

    assign topLeftOutline = (((x_pos >= 14 && x_pos <= 46) && y_pos == 3) || (x_pos == 14 && y_pos == 4) || (x_pos == 19 && y_pos == 4) || (x_pos == 41 && y_pos == 4) || (x_pos == 46 && y_pos == 4) || (x_pos == 14 && y_pos == 5) || (x_pos == 19 && y_pos == 5) || (x_pos == 41 && y_pos == 5) || (x_pos == 46 && y_pos == 5) || (x_pos == 14 && y_pos == 6) || (x_pos == 19 && y_pos == 6) || (x_pos == 41 && y_pos == 6) || (x_pos == 46 && y_pos == 6) || (x_pos == 14 && y_pos == 7) || (x_pos == 19 && y_pos == 7) || (x_pos == 41 && y_pos == 7) || (x_pos == 46 && y_pos == 7) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 8) || (x_pos == 14 && y_pos == 9) || (x_pos == 19 && y_pos == 9) || (x_pos == 41 && y_pos == 9) || (x_pos == 46 && y_pos == 9) || (x_pos == 14 && y_pos == 10) || (x_pos == 19 && y_pos == 10) || (x_pos == 41 && y_pos == 10) || (x_pos == 46 && y_pos == 10) || (x_pos == 14 && y_pos == 11) || (x_pos == 19 && y_pos == 11) || (x_pos == 41 && y_pos == 11) || (x_pos == 46 && y_pos == 11) || (x_pos == 14 && y_pos == 12) || (x_pos == 19 && y_pos == 12) || (x_pos == 41 && y_pos == 12) || (x_pos == 46 && y_pos == 12) || (x_pos == 14 && y_pos == 13) || (x_pos == 19 && y_pos == 13) || (x_pos == 41 && y_pos == 13) || (x_pos == 46 && y_pos == 13) || (x_pos == 14 && y_pos == 14) || (x_pos == 19 && y_pos == 14) || (x_pos == 41 && y_pos == 14) || (x_pos == 46 && y_pos == 14) || (x_pos == 14 && y_pos == 15) || (x_pos == 19 && y_pos == 15) || (x_pos == 41 && y_pos == 15) || (x_pos == 46 && y_pos == 15) || (x_pos == 14 && y_pos == 16) || (x_pos == 19 && y_pos == 16) || (x_pos == 41 && y_pos == 16) || (x_pos == 46 && y_pos == 16) || (x_pos == 14 && y_pos == 17) || (x_pos == 19 && y_pos == 17) || (x_pos == 41 && y_pos == 17) || (x_pos == 46 && y_pos == 17) || (x_pos == 14 && y_pos == 18) || (x_pos == 19 && y_pos == 18) || (x_pos == 41 && y_pos == 18) || (x_pos == 46 && y_pos == 18) || (x_pos == 14 && y_pos == 19) || (x_pos == 19 && y_pos == 19) || (x_pos == 41 && y_pos == 19) || (x_pos == 46 && y_pos == 19) || (x_pos == 14 && y_pos == 20) || (x_pos == 19 && y_pos == 20) || (x_pos == 41 && y_pos == 20) || (x_pos == 46 && y_pos == 20) || (x_pos == 14 && y_pos == 21) || (x_pos == 19 && y_pos == 21) || (x_pos == 41 && y_pos == 21) || (x_pos == 46 && y_pos == 21) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 22) || (x_pos == 14 && y_pos == 23) || (x_pos == 19 && y_pos == 23) || (x_pos == 41 && y_pos == 23) || (x_pos == 46 && y_pos == 23) || (x_pos == 14 && y_pos == 24) || (x_pos == 19 && y_pos == 24) || (x_pos == 41 && y_pos == 24) || (x_pos == 46 && y_pos == 24) || (x_pos == 14 && y_pos == 25) || (x_pos == 19 && y_pos == 25) || (x_pos == 41 && y_pos == 25) || (x_pos == 46 && y_pos == 25) || (x_pos == 14 && y_pos == 26) || (x_pos == 19 && y_pos == 26) || (x_pos == 41 && y_pos == 26) || (x_pos == 46 && y_pos == 26) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 27) || (x_pos == 14 && y_pos == 28) || (x_pos == 19 && y_pos == 28) || (x_pos == 41 && y_pos == 28) || (x_pos == 46 && y_pos == 28) || (x_pos == 14 && y_pos == 29) || (x_pos == 19 && y_pos == 29) || (x_pos == 41 && y_pos == 29) || (x_pos == 46 && y_pos == 29) || (x_pos == 14 && y_pos == 30) || (x_pos == 19 && y_pos == 30) || (x_pos == 41 && y_pos == 30) || (x_pos == 46 && y_pos == 30) || (x_pos == 14 && y_pos == 31) || (x_pos == 19 && y_pos == 31) || (x_pos == 41 && y_pos == 31) || (x_pos == 46 && y_pos == 31) || (x_pos == 14 && y_pos == 32) || (x_pos == 19 && y_pos == 32) || (x_pos == 41 && y_pos == 32) || (x_pos == 46 && y_pos == 32) || (x_pos == 14 && y_pos == 33) || (x_pos == 19 && y_pos == 33) || (x_pos == 41 && y_pos == 33) || (x_pos == 46 && y_pos == 33) || (x_pos == 14 && y_pos == 34) || (x_pos == 19 && y_pos == 34) || (x_pos == 41 && y_pos == 34) || (x_pos == 46 && y_pos == 34) || (x_pos == 14 && y_pos == 35) || (x_pos == 19 && y_pos == 35) || (x_pos == 41 && y_pos == 35) || (x_pos == 46 && y_pos == 35) || (x_pos == 14 && y_pos == 36) || (x_pos == 19 && y_pos == 36) || (x_pos == 41 && y_pos == 36) || (x_pos == 46 && y_pos == 36) || (x_pos == 14 && y_pos == 37) || (x_pos == 19 && y_pos == 37) || (x_pos == 41 && y_pos == 37) || (x_pos == 46 && y_pos == 37) || (x_pos == 14 && y_pos == 38) || (x_pos == 19 && y_pos == 38) || (x_pos == 41 && y_pos == 38) || (x_pos == 46 && y_pos == 38) || (x_pos == 14 && y_pos == 39) || (x_pos == 19 && y_pos == 39) || (x_pos == 41 && y_pos == 39) || (x_pos == 46 && y_pos == 39) || (x_pos == 14 && y_pos == 40) || (x_pos == 19 && y_pos == 40) || (x_pos == 41 && y_pos == 40) || (x_pos == 46 && y_pos == 40) || (x_pos == 14 && y_pos == 41) || (x_pos == 19 && y_pos == 41) || (x_pos == 41 && y_pos == 41) || (x_pos == 46 && y_pos == 41) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 42) || (x_pos == 14 && y_pos == 43) || (x_pos == 19 && y_pos == 43) || (x_pos == 41 && y_pos == 43) || (x_pos == 46 && y_pos == 43) || (x_pos == 14 && y_pos == 44) || (x_pos == 19 && y_pos == 44) || (x_pos == 41 && y_pos == 44) || (x_pos == 46 && y_pos == 44) || (x_pos == 14 && y_pos == 45) || (x_pos == 19 && y_pos == 45) || (x_pos == 41 && y_pos == 45) || (x_pos == 46 && y_pos == 45) || (x_pos == 14 && y_pos == 46) || (x_pos == 19 && y_pos == 46) || (x_pos == 41 && y_pos == 46) || (x_pos == 46 && y_pos == 46) || ((x_pos >= 14 && x_pos <= 46) && y_pos == 47));

    // Controll segment fill / unfill
    always @ (*) begin
        if (seg_a && mouse_pos) begin
            seg_a_filled <= (left_click) ? 1 : (right_click) ? 0 : seg_a_filled;
        end
        else if (seg_b && mouse_pos) begin
            seg_b_filled <= (left_click) ? 1 : (right_click) ? 0 : seg_b_filled;
        end
        else if (seg_c && mouse_pos) begin
            seg_c_filled <= (left_click) ? 1 : (right_click) ? 0 : seg_c_filled;
        end
        else if (seg_d && mouse_pos) begin
            seg_d_filled <= (left_click) ? 1 : (right_click) ? 0 : seg_d_filled;
        end
        else if (seg_e && mouse_pos) begin
            seg_e_filled <= (left_click) ? 1 : (right_click) ? 0 : seg_e_filled;
        end
        else if (seg_f && mouse_pos) begin
            seg_f_filled <= (left_click) ? 1 : (right_click) ? 0 : seg_f_filled;
        end
        else if (seg_g && mouse_pos) begin
            seg_g_filled <= (left_click) ? 1 : (right_click) ? 0 : seg_g_filled;
        end
        else if (topLeftBox && mouse_pos) begin
            topLeftBox_filled <= (left_click) ? 1 : (right_click) ? 0 : topLeftBox_filled;
        end
        else if (midLeftBox && mouse_pos) begin
            midLeftBox_filled <= (left_click) ? 1 : (right_click) ? 0 : midLeftBox_filled;
        end
        else if (botLeftBox && mouse_pos) begin
            botLeftBox_filled <= (left_click) ? 1 : (right_click) ? 0 : botLeftBox_filled;
        end
        else if (topRightBox && mouse_pos) begin
            topRightBox_filled <= (left_click) ? 1 : (right_click) ? 0 : topRightBox_filled;
        end
        else if (midRightBox && mouse_pos) begin
            midRightBox_filled <= (left_click) ? 1 : (right_click) ? 0 : midRightBox_filled;
        end
        else if (botRightBox && mouse_pos) begin
            botRightBox_filled <= (left_click) ? 1 : (right_click) ? 0 : botRightBox_filled;
        end
    end

    always @ (*) begin
        showGreenBorder = sw[0] ? 1 : 0;
    end

    always @ (*) begin
        valid_number = valid1 || valid2 || valid3 || valid4 || valid5 || valid6 || valid7 || valid8 || valid9 || valid0;
    end

    always @ (*) begin
        if (mouse_pos) begin
            pixel_data <= cursor_color;
        end
        else if (showGreenBorder == 1 && greenBorder) begin
            pixel_data <= GREEN;
        end
        else if (seg_a) begin
            pixel_data <= (seg_a_filled) ? WHITE : BLACK;
        end
        else if (seg_b) begin
            pixel_data <= (seg_b_filled) ? WHITE : BLACK;
        end
        else if (seg_c) begin
            pixel_data <= (seg_c_filled) ? WHITE : BLACK;
        end
        else if (seg_d) begin
            pixel_data <= (seg_d_filled) ? WHITE : BLACK;
        end
        else if (seg_e) begin
            pixel_data <= (seg_e_filled) ? WHITE : BLACK;
        end
        else if (seg_f) begin
            pixel_data <= (seg_f_filled) ? WHITE : BLACK;
        end
        else if (seg_g) begin
            pixel_data <= (seg_g_filled) ? WHITE : BLACK;
        end
        else if (topLeftBox) begin
            pixel_data <= (topLeftBox_filled) ? WHITE : BLACK;
        end
        else if (midLeftBox) begin
            pixel_data <= (midLeftBox_filled) ? WHITE : BLACK;
        end
        else if (botLeftBox) begin
            pixel_data <= (botLeftBox_filled) ? WHITE : BLACK;
        end
        else if (topRightBox) begin
            pixel_data <= (topRightBox_filled) ? WHITE : BLACK;
        end
        else if (midRightBox) begin
            pixel_data <= (midRightBox_filled) ? WHITE : BLACK;
        end
        else if (botRightBox) begin
            pixel_data <= (botRightBox_filled) ? WHITE : BLACK;
        end

        else begin
            pixel_data <= (topLeftOutline) ? WHITE : BLACK;
        end
    end
endmodule
