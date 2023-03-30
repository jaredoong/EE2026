`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2023 09:06:44
// Design Name: 
// Module Name: metronome_stage_selector
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


module metronome_stage_selector(
    input bpm_clock, play,
    input [15:0] sw,
    output reg [2:0] stage = 0,
    output reg [2:0] beats_in_bar = 4 
    );

    reg [2:0] max_stage = 0;
    
    always @ (posedge bpm_clock) begin
        case(sw)
            16'b0000_0000_0001_0000: begin
                max_stage <= 7;
                beats_in_bar <= 4;
            end
            16'b0000_0000_0000_1000: begin
                max_stage <= 5;
                beats_in_bar <= 3;
            end
            16'b0000_0000_0000_0100: begin
                max_stage <= 3;
                beats_in_bar <= 2;
            end
            16'b0000_0000_0000_0010: begin
                max_stage <= 1;
                beats_in_bar <= 1;
            end
            default: max_stage <= 0;
        endcase
        
        if (play == 1) begin
            stage <= (stage >= max_stage) ? 0 : stage + 1;
        end
    end
endmodule
