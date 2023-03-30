`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2023 11:33:53
// Design Name: 
// Module Name: bpm_controller
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


module bpm_controller(
    input clock,
    input inc_button, dec_button,
    output reg [7:0] bpm = 100
    );
    
    reg[4:0] hold_counter = 0;
     
    always @ (posedge clock) begin
        if (inc_button == 1) begin
            hold_counter <= (hold_counter == 31) ? 31: hold_counter + 1;
            if (hold_counter == 31) begin
                bpm <= (bpm > 251) ? 255 : bpm + 4;
            end
            else if (hold_counter >= 15) begin
                bpm <= (bpm > 253) ? 255 : bpm + 2;
            end
            else begin
                bpm <= (bpm == 255) ? 255 : bpm + 1;
            end
        end
        else if (dec_button == 1) begin
            hold_counter <= (hold_counter == 31) ? 31: hold_counter + 1;
            if (hold_counter == 31) begin
                bpm <= (bpm < 5) ? 1 : bpm - 4;
            end
            else if (hold_counter >= 15) begin
                bpm <= (bpm < 3) ? 1 : bpm - 2;
            end
            else begin
                bpm <= (bpm == 1) ? 1 : bpm - 1;
            end
        end
        else begin
            hold_counter <= 0;
        end
    end
    
endmodule
