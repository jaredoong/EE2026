`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2023 16:37:08
// Design Name: 
// Module Name: piano_display
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


module piano_display(
    input CLOCK, input [12:0] pixel_index, input [6:0] diff_x, diff_y, cursor_x, cursor_y, input left_click, output reg [15:0] pixel_data, output reg [3:0] cursor_size = 2,
    output reg [11:0] keyboard
    );
    wire  A_key;
    wire B_flat_key;
    wire B_key;
    wire C_key;
    wire C_sharp_key;
    wire D_key;
    wire E_flat_key;
    wire E_key;
    wire F_key;
    wire F_sharp_key;
    wire G_key;
    wire G_sharp_key;
    wire  A_key_mouse;
    wire B_flat_key_mouse;
    wire B_key_mouse;
    wire C_key_mouse;
    wire C_sharp_key_mouse;
    wire D_key_mouse;
    wire E_flat_key_mouse;
    wire E_key_mouse;
    wire F_key_mouse;
    wire F_sharp_key_mouse;
    wire G_key_mouse;
    wire G_sharp_key_mouse;
    wire [6:0] x_pos;
    wire [5:0] y_pos;
    wire [6:0] mouse_pos;
    localparam WHITE = 16'hFFFF;
    localparam BLACK = 16'h0000;
    localparam RED = 16'hF800;
    localparam GREY = 16'b10000_010000_10000;
    localparam cursor_color = RED;
    assign x_pos = pixel_index % 96;
    assign y_pos = pixel_index / 96;
    assign mouse_pos = (diff_x < cursor_size) && (diff_y < cursor_size);
    
    assign C_key = ((x_pos >= 0 && x_pos <= 12) && (y_pos >= 37 && y_pos <= 63))||((x_pos >= 0 && x_pos <= 9) && (y_pos >= 0 && y_pos <= 36));
    assign C_sharp_key = ((x_pos >= 10 && x_pos <= 16) && (y_pos >= 0 && y_pos <= 36));
    assign D_key = ((x_pos >= 14 && x_pos <= 26) && (y_pos >= 37 && y_pos <= 63)) || ((x_pos >= 17 && x_pos <= 23) && (y_pos >= 0 && y_pos <= 36));
    assign E_flat_key = ((x_pos >= 24 && x_pos <= 30) && (y_pos >= 0 && y_pos <= 36));
    assign E_key = ((x_pos >= 28 && x_pos <= 40) && (y_pos >= 37 && y_pos <= 63)) || ((x_pos >= 31 && x_pos <= 40) && (y_pos >= 0 && y_pos <= 36));
    assign F_key = ((x_pos >= 42 && x_pos <= 54) && (y_pos >= 37 && y_pos <= 63)) || ((x_pos >= 42 && x_pos <= 51) && (y_pos >= 0 && y_pos <= 36));
    assign F_sharp_key = ((x_pos >= 52 && x_pos <= 58) && (y_pos >= 0 && y_pos <= 36));
    assign G_key = ((x_pos >= 56 && x_pos <= 68) && (y_pos >= 37 && y_pos <= 63)) || ((x_pos >= 59 && x_pos <= 65) && (y_pos >= 0 && y_pos <= 36));
    assign G_sharp_key = ((x_pos >= 66 && x_pos <= 72) && (y_pos >= 0 && y_pos <= 36));
    assign A_key = ((x_pos >= 70 && x_pos <= 82) && (y_pos >= 37 && y_pos <= 63)) || ((x_pos >= 73 && x_pos <= 79) && (y_pos >= 0 && y_pos <= 36));
    assign B_flat_key = ((x_pos >= 80 && x_pos <= 86) && (y_pos >= 0 && y_pos <= 36));
    assign B_key = ((x_pos >= 84 && x_pos <= 95) && (y_pos >= 37 && y_pos <= 63)) || ((x_pos >= 87 && x_pos <= 95) && (y_pos >= 0 && y_pos <= 36));
    
    assign C_key_mouse = C_key && ((cursor_x >= 0 && cursor_x <= 12) && (cursor_y >= 37 && cursor_y <= 63))||((cursor_x >= 0 && cursor_x <= 9) && (cursor_y >= 0 && cursor_y <= 36));
    assign C_sharp_key_mouse = C_sharp_key && ((cursor_x >= 10 && cursor_x <= 16) && (cursor_y >= 0 && cursor_y <= 36));
    assign D_key_mouse = D_key && ((cursor_x >= 14 && cursor_x <= 26) && (cursor_y >= 37 && cursor_y <= 63)) || ((cursor_x >= 17 && cursor_x <= 23) && (cursor_y >= 0 && cursor_y <= 36));
    assign E_flat_key_mouse = E_flat_key && ((cursor_x >= 24 && cursor_x <= 30) && (cursor_y >= 0 && cursor_y <= 36));
    assign E_key_mouse = E_key && ((cursor_x >= 28 && cursor_x <= 40) && (cursor_y >= 37 && cursor_y <= 63)) || ((cursor_x >= 31 && cursor_x <= 40) && (cursor_y >= 0 && cursor_y <= 36));
    assign F_key_mouse = F_key && ((cursor_x >= 42 && cursor_x <= 54) && (cursor_y >= 37 && cursor_y <= 63)) || ((cursor_x >= 42 && cursor_x <= 51) && (cursor_y >= 0 && cursor_y <= 36));
    assign F_sharp_key_mouse = F_sharp_key && ((cursor_x >= 52 && cursor_x <= 58) && (cursor_y >= 0 && cursor_y <= 36));
    assign G_key_mouse = G_key && ((cursor_x >= 56 && cursor_x <= 68) && (cursor_y >= 37 && cursor_y <= 63)) || ((cursor_x >= 59 && cursor_x <= 65) && (cursor_y >= 0 && cursor_y <= 36));
    assign G_sharp_key_mouse = G_sharp_key && ((cursor_x >= 66 && cursor_x <= 72) && (cursor_y >= 0 && cursor_y <= 36));
    assign A_key_mouse = A_key && ((cursor_x >= 70 && cursor_x <= 82) && (cursor_y >= 37 && cursor_y <= 63)) || ((cursor_x >= 73 && cursor_x <= 79) && (cursor_y >= 0 && cursor_y <= 36));
    assign B_flat_key_mouse = B_flat_key && ((cursor_x >= 80 && cursor_x <= 86) && (cursor_y >= 0 && cursor_y <= 36));
    assign B_key_mouse = B_key && ((cursor_x >= 84 && cursor_x <= 95) && (cursor_y >= 37 && y_pos <= 63)) || ((cursor_x >= 87 && cursor_x <= 95) && (cursor_y >= 0 && cursor_y <= 36));
    
    always @ (posedge CLOCK) begin
        keyboard <= 0;
        if (A_key_mouse) begin
            keyboard[0] <= (left_click)? 1 : 0;
        end else if (B_flat_key_mouse) begin
            keyboard[1] <= (left_click)? 1 : 0;
        end else if (B_key_mouse) begin
            keyboard[2] <= (left_click)? 1 : 0;
        end else if (C_key_mouse) begin
            keyboard[3] <= (left_click)? 1 : 0;
        end else if (C_sharp_key_mouse) begin
            keyboard[4] <= (left_click)? 1 : 0;
        end else if (D_key_mouse) begin
            keyboard[5] <= (left_click)? 1 : 0;
        end else if (E_flat_key_mouse) begin
            keyboard[6] <= (left_click)? 1 : 0;
        end else if (E_key_mouse) begin
            keyboard[7] <= (left_click)? 1 : 0;
        end else if (F_key_mouse) begin
            keyboard[8] <= (left_click)? 1 : 0;
        end else if (F_sharp_key_mouse) begin
            keyboard[9] <= (left_click)? 1 : 0;
        end else if (G_key_mouse) begin
            keyboard[10] <= (left_click)? 1 : 0;
        end else if (G_sharp_key_mouse) begin
            keyboard[11] <= (left_click)? 1 : 0;
        end
        
        if (mouse_pos) begin
            pixel_data <= cursor_color;
        end else if (A_key) begin
            pixel_data <= (keyboard[0])? GREY : WHITE;
        end else if (B_flat_key) begin 
            pixel_data <= (keyboard[1])? GREY : BLACK;
        end else if (B_key) begin
            pixel_data <= (keyboard[2])? GREY : WHITE;
        end else if (C_key) begin
            pixel_data <= (keyboard[3])? GREY : WHITE;
        end else if (C_sharp_key) begin
            pixel_data <= (keyboard[4])? GREY : BLACK;
        end else if (D_key) begin
            pixel_data <= (keyboard[5])? GREY : WHITE;
        end else if (E_flat_key) begin
            pixel_data <= (keyboard[6])? GREY : BLACK;
        end else if (E_key) begin
            pixel_data <= (keyboard[7])? GREY : WHITE;
        end else if (F_key) begin
            pixel_data <= (keyboard[8])? GREY : WHITE;
        end else if (F_sharp_key) begin
            pixel_data <= (keyboard[9])? GREY : BLACK;
        end else if (G_key) begin
            pixel_data <= (keyboard[10])? GREY : WHITE;
        end else if (G_sharp_key) begin 
            pixel_data <= (keyboard[11])? GREY : BLACK;
        end else begin
            pixel_data <= BLACK;
        end
    end
endmodule
