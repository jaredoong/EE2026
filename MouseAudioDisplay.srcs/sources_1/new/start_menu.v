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
    input [15:0] sw,
    input [12:0] pixel_index,
    input left_click,
    input right_click,
    input [6:0] cursor_x,
    input [6:0] cursor_y,
    input [6:0] diff_x,
    input [6:0] diff_y,
    output reg [3:0] cursor_size = 2,
    output reg [15:0] pixel_data = 0,
    output reg [3:0] stage = 4'b1111
    );

    localparam WHITE = 16'b11111_111111_11111;
    localparam BLACK = 16'b00000_000000_00000;
    localparam GREEN = 16'h07E0;
    localparam RED = 16'hF800;

    wire [6:0] x_pos;
    wire [5:0] y_pos;

    
    assign x_pos = pixel_index % 96;
    assign y_pos = pixel_index / 96;

    assign mouse_pos = (diff_x < cursor_size) && (diff_y < cursor_size);

    assign option_A_border = (x_pos >= 2 && x_pos <= 16) && (y_pos >= 4 && y_pos <= 18);
    assign option_B_border = (x_pos >= 21 && x_pos <= 35) && (y_pos >= 4 && y_pos <= 18);
    assign option_C_border = (x_pos >= 40 && x_pos <= 54) && (y_pos >= 4 && y_pos <= 18);
    assign option_D_border = (x_pos >= 59 && x_pos <= 73) && (y_pos >= 4 && y_pos <= 18);
    assign option_G_border = (x_pos >= 78 && x_pos <= 92) && (y_pos >= 4 && y_pos <= 18);

    assign option_A_hover = (option_A_border && (cursor_x >= 2 && cursor_x <= 16) && (cursor_y >= 4 && cursor_y <= 18)) ? 1: 0;
    assign option_B_hover = (option_B_border && (cursor_x >= 21 && cursor_x <= 35) && (cursor_y >= 4 && cursor_y <= 18)) ? 1: 0;
    assign option_C_hover = (option_C_border && (cursor_x >= 40 && cursor_x <= 54) && (cursor_y >= 4 && cursor_y <= 18)) ? 1: 0;
    assign option_D_hover = (option_D_border && (cursor_x >= 59 && cursor_x <= 73) && (cursor_y >= 4 && cursor_y <= 18)) ? 1: 0;
    assign option_G_hover = (option_G_border && (cursor_x >= 78 && cursor_x <= 92) && (cursor_y >= 4 && cursor_y <= 18)) ? 1: 0;

    assign option_A = (((x_pos >= 2 && x_pos <= 16) && y_pos == 4) || (x_pos == 2 && y_pos == 5) || (x_pos == 16 && y_pos == 5) || (x_pos == 2 && y_pos == 6) || (x_pos == 16 && y_pos == 6) || (x_pos == 2 && y_pos == 7) || ((x_pos >= 8 && x_pos <= 10) && y_pos == 7) || (x_pos == 16 && y_pos == 7) || (x_pos == 2 && y_pos == 8) || (x_pos == 7 && y_pos == 8) || (x_pos == 11 && y_pos == 8) || (x_pos == 16 && y_pos == 8) || (x_pos == 2 && y_pos == 9) || (x_pos == 6 && y_pos == 9) || (x_pos == 12 && y_pos == 9) || (x_pos == 16 && y_pos == 9) || (x_pos == 2 && y_pos == 10) || (x_pos == 5 && y_pos == 10) || (x_pos == 13 && y_pos == 10) || (x_pos == 16 && y_pos == 10) || (x_pos == 2 && y_pos == 11) || (x_pos == 5 && y_pos == 11) || (x_pos == 13 && y_pos == 11) || (x_pos == 16 && y_pos == 11) || (x_pos == 2 && y_pos == 12) || ((x_pos >= 5 && x_pos <= 13) && y_pos == 12) || (x_pos == 16 && y_pos == 12) || (x_pos == 2 && y_pos == 13) || (x_pos == 5 && y_pos == 13) || (x_pos == 13 && y_pos == 13) || (x_pos == 16 && y_pos == 13) || (x_pos == 2 && y_pos == 14) || (x_pos == 5 && y_pos == 14) || (x_pos == 13 && y_pos == 14) || (x_pos == 16 && y_pos == 14) || (x_pos == 2 && y_pos == 15) || (x_pos == 5 && y_pos == 15) || (x_pos == 13 && y_pos == 15) || (x_pos == 16 && y_pos == 15) || (x_pos == 2 && y_pos == 16) || (x_pos == 16 && y_pos == 16) || (x_pos == 2 && y_pos == 17) || (x_pos == 16 && y_pos == 17) || ((x_pos >= 2 && x_pos <= 16) && y_pos == 18));

    assign option_B = (((x_pos >= 21 && x_pos <= 35) && y_pos == 4) || (x_pos == 21 && y_pos == 5) || (x_pos == 35 && y_pos == 5) || (x_pos == 21 && y_pos == 6) || (x_pos == 35 && y_pos == 6) || (x_pos == 21 && y_pos == 7) || ((x_pos >= 24 && x_pos <= 31) && y_pos == 7) || (x_pos == 35 && y_pos == 7) || (x_pos == 21 && y_pos == 8) || (x_pos == 24 && y_pos == 8) || (x_pos == 32 && y_pos == 8) || (x_pos == 35 && y_pos == 8) || (x_pos == 21 && y_pos == 9) || (x_pos == 24 && y_pos == 9) || (x_pos == 32 && y_pos == 9) || (x_pos == 35 && y_pos == 9) || (x_pos == 21 && y_pos == 10) || (x_pos == 24 && y_pos == 10) || (x_pos == 32 && y_pos == 10) || (x_pos == 35 && y_pos == 10) || (x_pos == 21 && y_pos == 11) || ((x_pos >= 24 && x_pos <= 31) && y_pos == 11) || (x_pos == 35 && y_pos == 11) || (x_pos == 21 && y_pos == 12) || (x_pos == 24 && y_pos == 12) || (x_pos == 32 && y_pos == 12) || (x_pos == 35 && y_pos == 12) || (x_pos == 21 && y_pos == 13) || (x_pos == 24 && y_pos == 13) || (x_pos == 32 && y_pos == 13) || (x_pos == 35 && y_pos == 13) || (x_pos == 21 && y_pos == 14) || (x_pos == 24 && y_pos == 14) || (x_pos == 32 && y_pos == 14) || (x_pos == 35 && y_pos == 14) || (x_pos == 21 && y_pos == 15) || ((x_pos >= 24 && x_pos <= 31) && y_pos == 15) || (x_pos == 35 && y_pos == 15) || (x_pos == 21 && y_pos == 16) || (x_pos == 35 && y_pos == 16) || (x_pos == 21 && y_pos == 17) || (x_pos == 35 && y_pos == 17) || ((x_pos >= 21 && x_pos <= 35) && y_pos == 18));

    assign option_C = (((x_pos >= 40 && x_pos <= 54) && y_pos == 4) || (x_pos == 40 && y_pos == 5) || (x_pos == 54 && y_pos == 5) || (x_pos == 40 && y_pos == 6) || (x_pos == 54 && y_pos == 6) || (x_pos == 40 && y_pos == 7) || ((x_pos >= 44 && x_pos <= 50) && y_pos == 7) || (x_pos == 54 && y_pos == 7) || (x_pos == 40 && y_pos == 8) || (x_pos == 43 && y_pos == 8) || (x_pos == 51 && y_pos == 8) || (x_pos == 54 && y_pos == 8) || (x_pos == 40 && y_pos == 9) || (x_pos == 43 && y_pos == 9) || (x_pos == 54 && y_pos == 9) || (x_pos == 40 && y_pos == 10) || (x_pos == 43 && y_pos == 10) || (x_pos == 54 && y_pos == 10) || (x_pos == 40 && y_pos == 11) || (x_pos == 43 && y_pos == 11) || (x_pos == 54 && y_pos == 11) || (x_pos == 40 && y_pos == 12) || (x_pos == 43 && y_pos == 12) || (x_pos == 54 && y_pos == 12) || (x_pos == 40 && y_pos == 13) || (x_pos == 43 && y_pos == 13) || (x_pos == 54 && y_pos == 13) || (x_pos == 40 && y_pos == 14) || (x_pos == 43 && y_pos == 14) || (x_pos == 51 && y_pos == 14) || (x_pos == 54 && y_pos == 14) || (x_pos == 40 && y_pos == 15) || ((x_pos >= 44 && x_pos <= 50) && y_pos == 15) || (x_pos == 54 && y_pos == 15) || (x_pos == 40 && y_pos == 16) || (x_pos == 54 && y_pos == 16) || (x_pos == 40 && y_pos == 17) || (x_pos == 54 && y_pos == 17) || ((x_pos >= 40 && x_pos <= 54) && y_pos == 18));

    assign option_D = (((x_pos >= 59 && x_pos <= 73) && y_pos == 4) || (x_pos == 59 && y_pos == 5) || (x_pos == 73 && y_pos == 5) || (x_pos == 59 && y_pos == 6) || (x_pos == 73 && y_pos == 6) || (x_pos == 59 && y_pos == 7) || ((x_pos >= 62 && x_pos <= 68) && y_pos == 7) || (x_pos == 73 && y_pos == 7) || (x_pos == 59 && y_pos == 8) || (x_pos == 62 && y_pos == 8) || (x_pos == 69 && y_pos == 8) || (x_pos == 73 && y_pos == 8) || (x_pos == 59 && y_pos == 9) || (x_pos == 62 && y_pos == 9) || (x_pos == 70 && y_pos == 9) || (x_pos == 73 && y_pos == 9) || (x_pos == 59 && y_pos == 10) || (x_pos == 62 && y_pos == 10) || (x_pos == 70 && y_pos == 10) || (x_pos == 73 && y_pos == 10) || (x_pos == 59 && y_pos == 11) || (x_pos == 62 && y_pos == 11) || (x_pos == 70 && y_pos == 11) || (x_pos == 73 && y_pos == 11) || (x_pos == 59 && y_pos == 12) || (x_pos == 62 && y_pos == 12) || (x_pos == 70 && y_pos == 12) || (x_pos == 73 && y_pos == 12) || (x_pos == 59 && y_pos == 13) || (x_pos == 62 && y_pos == 13) || (x_pos == 70 && y_pos == 13) || (x_pos == 73 && y_pos == 13) || (x_pos == 59 && y_pos == 14) || (x_pos == 62 && y_pos == 14) || (x_pos == 69 && y_pos == 14) || (x_pos == 73 && y_pos == 14) || (x_pos == 59 && y_pos == 15) || ((x_pos >= 62 && x_pos <= 68) && y_pos == 15) || (x_pos == 73 && y_pos == 15) || (x_pos == 59 && y_pos == 16) || (x_pos == 73 && y_pos == 16) || (x_pos == 59 && y_pos == 17) || (x_pos == 73 && y_pos == 17) || ((x_pos >= 59 && x_pos <= 73) && y_pos == 18));

    assign option_G = (((x_pos >= 78 && x_pos <= 92) && y_pos == 4) || (x_pos == 78 && y_pos == 5) || (x_pos == 92 && y_pos == 5) || (x_pos == 78 && y_pos == 6) || (x_pos == 92 && y_pos == 6) || (x_pos == 78 && y_pos == 7) || ((x_pos >= 81 && x_pos <= 89) && y_pos == 7) || (x_pos == 92 && y_pos == 7) || (x_pos == 78 && y_pos == 8) || (x_pos == 81 && y_pos == 8) || (x_pos == 92 && y_pos == 8) || (x_pos == 78 && y_pos == 9) || (x_pos == 81 && y_pos == 9) || (x_pos == 92 && y_pos == 9) || (x_pos == 78 && y_pos == 10) || (x_pos == 81 && y_pos == 10) || (x_pos == 92 && y_pos == 10) || (x_pos == 78 && y_pos == 11) || (x_pos == 81 && y_pos == 11) || (x_pos == 92 && y_pos == 11) || (x_pos == 78 && y_pos == 12) || (x_pos == 81 && y_pos == 12) || ((x_pos >= 87 && x_pos <= 89) && y_pos == 12) || (x_pos == 92 && y_pos == 12) || (x_pos == 78 && y_pos == 13) || (x_pos == 81 && y_pos == 13) || (x_pos == 89 && y_pos == 13) || (x_pos == 92 && y_pos == 13) || (x_pos == 78 && y_pos == 14) || (x_pos == 81 && y_pos == 14) || (x_pos == 89 && y_pos == 14) || (x_pos == 92 && y_pos == 14) || (x_pos == 78 && y_pos == 15) || ((x_pos >= 81 && x_pos <= 89) && y_pos == 15) || (x_pos == 92 && y_pos == 15) || (x_pos == 78 && y_pos == 16) || (x_pos == 92 && y_pos == 16) || (x_pos == 78 && y_pos == 17) || (x_pos == 92 && y_pos == 17) || ((x_pos >= 78 && x_pos <= 92) && y_pos == 18));

    // Controlling of OLED display
    always @ (*) begin
        if (mouse_pos) begin
            pixel_data = RED;
        end

        else if (option_A_border) begin
            if (option_A) begin
                pixel_data = (option_A_hover) ? GREEN : WHITE;
            end
            else begin
                pixel_data = BLACK;
            end
        end
        else if (option_B_border) begin
            if (option_B) begin
                pixel_data = (option_B_hover) ? GREEN : WHITE;
            end
            else begin
                pixel_data = BLACK;
            end
        end
        else if (option_C_border) begin
            if (option_C) begin
                pixel_data = (option_C_hover) ? GREEN : WHITE;
            end
            else begin
                pixel_data = BLACK;
            end
        end
        else if (option_D_border) begin
            if (option_D) begin
                pixel_data = (option_D_hover) ? GREEN : WHITE;
            end
            else begin
                pixel_data = BLACK;
            end
        end
        else if (option_G_border) begin
            if (option_G) begin
                pixel_data = (option_G_hover) ? GREEN : WHITE;
            end
            else begin
                pixel_data = BLACK;
            end
        end
        
        else begin
            pixel_data = BLACK;
        end
    end

    // Selecting of option
    always @ (posedge basys3_clock) begin
        // For resetting back to the main menu
        if (sw[15] && sw[14] && sw[13]) begin
            stage <= 4'b1111;
        end

        else if (option_A_hover && left_click) begin
            stage <= 4'b0001;
        end
        else if (option_B_hover && left_click) begin
            stage <= 4'b0010;
        end
        else if (option_C_hover && left_click) begin
            stage <= 4'b0011;
        end
        else if (option_D_hover && left_click) begin
            stage <= 4'b0100;
        end
        else if (option_G_hover && left_click) begin
            stage <= 4'b0101;
        end
    end

endmodule
