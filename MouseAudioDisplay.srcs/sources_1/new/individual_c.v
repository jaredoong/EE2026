`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2023 17:45:57
// Design Name: 
// Module Name: individual_c
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


module individual_c(
    input clock_6p25mhz,
    input middle_click,
    input [6:0] diff_x,
    input [6:0] diff_y,
    output reg [3:0] cursor_size = 1,
    output reg [15:0] pixel_data
    );

    reg cursor_change = 0;
    reg [15:0] cursor_colour = 16'b11111_000000_00000;

    localparam LARGE = 8;
    localparam SMALL = 1;

    localparam RED = 16'b11111_000000_00000;
    localparam GREEN = 16'b00000_111111_00000;

    always @ (posedge clock_6p25mhz) begin
        if (middle_click == 1 && cursor_change == 0) begin
            cursor_size <= (cursor_size == LARGE) ? SMALL : LARGE;
            cursor_colour <= (cursor_colour == RED) ? GREEN: RED;
            cursor_change <= 1;
        end
        else if (middle_click == 0) begin
            cursor_change <= 0;
        end
        
        if ((diff_x < cursor_size) && (diff_y < cursor_size)) begin
            pixel_data <= cursor_colour;
        end
        else begin
            pixel_data <= 16'b00000_000000_00000;
        end
    end
endmodule
