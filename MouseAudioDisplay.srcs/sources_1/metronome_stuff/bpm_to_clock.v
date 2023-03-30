`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2023 09:04:07
// Design Name: 
// Module Name: bpm_to_clock
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


module bpm_to_clock(
    input basys3_clock,
    input [7:0] bpm,
    output reg clock_bpm = 0
    );
    
    reg [31:0] counter = 0;
    
    always @ (posedge basys3_clock) begin
        counter <= (counter >= (100_000_000 * 15 / bpm)) ? 0 : counter + 1;
        clock_bpm <= (counter == 0) ? ~clock_bpm : clock_bpm;
    end
endmodule