`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.03.2023 15:55:11
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    input basys3_clock,
    input [31:0] frequency,
    output reg slow_clock = 0
    );
    
    reg [31:0] count = 0;
    wire [31:0] divisor;
    
    assign divisor = (100_000_000 / (frequency << 1)) - 1;
    
    always @ (posedge basys3_clock) begin
        count <= (count == divisor) ? 0 : count + 1;
        slow_clock <= (count == 0) ? ~slow_clock : slow_clock;
    end
endmodule
