`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.03.2023 14:24:13
// Design Name: 
// Module Name: sim20kHzclock
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


module sim20kHzclock();
    reg CLOCK;
    wire SLOW_CLOCK;
    
    initial begin
        CLOCK = 0;
    end
    
    clock_divider clk_20kHz(CLOCK, 20000, SLOW_CLOCK);
    always begin
        #5 CLOCK = ~CLOCK;
    end
endmodule
