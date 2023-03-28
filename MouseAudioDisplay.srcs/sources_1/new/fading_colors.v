`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2023 03:54:54
// Design Name: 
// Module Name: fading_colors
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


module fading_colors(
    input wire clk,
    output wire [15:0] pixel_data
);

    localparam COLOR0STATE = 0; // BLACK
    localparam COLOR1STATE = 1; // RED
    localparam COLOR2STATE = 2; // YELLOW
    localparam COLOR3STATE = 3; // GREEN
    localparam COLOR4STATE = 4; // LIGHT BLUE
    localparam COLOR5STATE = 5; // BLUE
    localparam COLOR6STATE = 6; // PINK

    localparam COLORMAX = 31;

    reg [2:0] color_state = COLOR1STATE;

    reg[4:0] color_1_counter = 0;
    reg[5:0] color_2_counter = 0;
    reg[4:0] color_3_counter = 0;

    // Clock divider
    reg [23:0] clock_divider; // Increase the divider value for slower transitions
    reg clk_divided;

    always @ (posedge clk) begin
        clock_divider <= clock_divider + 1;
        clk_divided <= clock_divider[16]; // Change the bit position to adjust the clock division ratio
    end

    always @ (posedge clk_divided) begin
        if (color_state == COLOR0STATE) begin
            if (color_1_counter < COLORMAX) begin
                color_1_counter <= (color_1_counter) + 1;
            end else begin
                color_state <= COLOR1STATE;
            end
        end

        else if (color_state == COLOR1STATE) begin
            if (color_2_counter < COLORMAX) begin
                color_2_counter <= (color_2_counter) + 1;
            end else begin
                color_state <= COLOR2STATE;
            end
        end

        else if (color_state == COLOR2STATE) begin
            if (color_1_counter > 0) begin
                color_1_counter <= (color_1_counter) - 1;
            end else begin
                color_state <= COLOR3STATE;
            end
        end

        else if (color_state == COLOR3STATE) begin
            if (color_3_counter < COLORMAX) begin
                color_3_counter <= (color_3_counter) + 1;
            end else begin
                color_state <= COLOR4STATE;
            end
        end

        else if (color_state == COLOR4STATE) begin
            if (color_2_counter > 0) begin
                color_2_counter <= (color_2_counter) - 1;
            end else begin
                color_state <= COLOR5STATE;
            end
        end

        else if (color_state == COLOR5STATE) begin
            if (color_1_counter < COLORMAX) begin
                color_1_counter <= (color_1_counter) + 1;
            end else begin
                color_state <= COLOR6STATE;
            end
        end

        else if (color_state == COLOR6STATE) begin
            if (color_3_counter > 0) begin
                color_3_counter <= (color_3_counter) - 1;
            end else begin
                color_state <= COLOR1STATE;
            end
        end
    end

    assign pixel_data = {color_1_counter, (color_2_counter << 1), color_3_counter};
endmodule
