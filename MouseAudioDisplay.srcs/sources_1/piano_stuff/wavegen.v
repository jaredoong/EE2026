`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2023 21:20:52
// Design Name: 
// Module Name: wavegen
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


module wavegen(
    input CLOCK, input [31:0] DIV, output reg signal = 0
    );
    reg [31:0] counter = 0;
    always @ (posedge CLOCK) begin
        counter <= (counter == DIV)? 0 : counter + 1;
        signal <= (counter == DIV)? ~signal : signal;
    end
endmodule
