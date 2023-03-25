`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2023 12:26:23
// Design Name: 
// Module Name: single_mouse_click
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


module single_mouse_click(
    input basys3_clock,
    input mouse_click,
    output reg pressed = 0
    );

    reg [31:0] counter = 0;
    reg [31:0] threshold_0p1s = 10_000_000;

    always @ (posedge basys3_clock) begin
        if (counter == 0) begin
            if (mouse_click) begin
                counter <= counter + 1;
            end
        end else if (counter < threshold_0p1s) begin
            counter <= counter + 1;
            pressed <= 1;
        end 
        if (counter == threshold_0p1s) begin
            pressed <= 0;
            if (!mouse_click) begin
                counter <= 0;
            end
        end
    end
endmodule
