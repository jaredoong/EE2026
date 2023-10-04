`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2023 17:04:53
// Design Name: 
// Module Name: fft_clk_divider
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



module fft_clock_divider(
        input basys3_clock,
        input [31:0] frequency,
        output reg slow_clock = 0
        );
        
        reg [31:0] count = 0;
        wire [31:0] divisor;
        
        assign divisor = (100_000_000 / (frequency << 1)) - 1;
        
        always @ (posedge basys3_clock) begin
            count <= (count >= divisor) ? 0 : count + 1;
            slow_clock <= (frequency == 0)? 0 : (count == 0) ? ~slow_clock : slow_clock;
        end
endmodule
