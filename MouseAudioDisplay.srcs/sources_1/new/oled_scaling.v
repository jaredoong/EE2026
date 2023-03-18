`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2023 19:23:29
// Design Name: 
// Module Name: oled_scaling
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


module oled_scaling(
    input[12:0] pixel_index,
    input[11:0] mouse_xpos, mouse_ypos,
    input[3:0] cursor_size,
    output[6:0] pixel_x, pixel_y, cursor_x, cursor_y, diff_x, diff_y
    );
    
    assign pixel_x = pixel_index % 96;
    assign pixel_y = pixel_index / 96;
    assign cursor_x = (mouse_xpos / 10 > 96 - cursor_size) ? 96 - cursor_size: mouse_xpos / 10;
    assign cursor_y = (mouse_ypos / 10 > 64 - cursor_size) ? 64 - cursor_size: mouse_ypos / 10;
    assign diff_x = (pixel_x - cursor_x > 0) ? pixel_x - cursor_x: 0;
    assign diff_y = (pixel_y - cursor_y > 0) ? pixel_y - cursor_y: 0;
endmodule
