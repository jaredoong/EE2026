`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2023 08:00:46 PM
// Design Name: 
// Module Name: segment_disp
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


module segment_disp(
    input CLOCK_381HZ,
    input [6:0] first,
    input [6:0] second,
    input [6:0] third,
    input [6:0] fourth,
    output reg [3:0] an,
    output reg [6:0] seg

    );

    reg[1:0] count = 2'b0;

    always @ (posedge CLOCK_381HZ)
    begin
        count <= count + 1;
        case(count)
            2'b00: 
            begin
                an <= 4'b0111;
                seg <= first;
            end
            2'b01:
            begin
                an <= 4'b1011;
                seg <= second;
            end
            2'b10:
            begin
                an <= 4'b1101;
                seg <= third;
            end
            2'b11:
            begin
                an <= 4'b1110;
                seg <= fourth;
            end
        endcase
    end
endmodule
