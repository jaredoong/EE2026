`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2023 22:05:34
// Design Name: 
// Module Name: stage_selector
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


module stage_selector(
    input [15:0] sw,
    output reg [3:0] stage = 4'b0000
    );

    always @ (*) begin
        if (sw[10] == 1) begin
            stage = 1;
        end
        else if (sw[11] == 1) begin
            stage = 2;
        end
        else if (sw[12] == 1) begin
            stage = 3;
        end
        else if (sw[13] == 1) begin
            stage = 4;
        end
        else if (sw[14] == 1) begin
            stage = 5;
        end
        else begin
            stage = 4'b1111;
        end
    end
endmodule
