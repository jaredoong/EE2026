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
    input clk,
    input reset,
    output wire [15:0] pixel_data
    );

    localparam ClkFreq = 6250000; // Hz
    localparam FadeDiv = 1024;
    localparam FadeDivWidth = $clog2(FadeDiv);
    localparam FadeSteps = 256;
    localparam FadeStepsWidth = $clog2(FadeSteps);

    reg [FadeDivWidth-1:0] fade_counter;
    reg [FadeStepsWidth-1:0] fade_step;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            fade_counter <= 0;
            fade_step <= 0;
        end else begin
            if (fade_counter == FadeDiv-1) begin
                fade_counter <= 0;
                fade_step <= (fade_step == FadeSteps-1) ? 0 : fade_step + 1;
            end else begin
                fade_counter <= fade_counter + 1;
            end
        end
    end

    function [7:0] sine_wave;
        input [FadeStepsWidth-1:0] x;
        reg [15:0] angle;
        begin
            angle = (x * 32'h6487) >> 8; // Scale to [0, 2*pi)
            sine_wave = 8'h80 + (angle <= 16'h8000 ? (angle >> 8) : (16'hFF00 - angle) >> 8);
        end
    endfunction

    assign pixel_data[15:8] = sine_wave(fade_step);
    assign pixel_data[7:0] = sine_wave(fade_step + 85); // Phase shift for color fading
endmodule
