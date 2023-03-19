`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2023 17:45:42
// Design Name: 
// Module Name: individual_b
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


module individual_b (
    input basys3_clock,
    input clk_190Hz,
    input clk_380Hz,
    input btnC_debounce,
    input sw,
    output reg [11:0] audio_out = 12'b0000_0000_0000
    );

    reg [31:0] counter = 0;
    reg [31:0] threshold_1s = 100000000;

    always @ (posedge basys3_clock) begin
        if (counter == 0) begin
            if (btnC_debounce) begin
                counter <= counter + 1;
            end
        end else if (counter < threshold_1s) begin
            counter <= counter + 1;
            if (sw) begin
                audio_out[10:0] <= 11'b1111_1111_111;
                audio_out[11] <= clk_190Hz;
            end else begin
                audio_out[10:0] <= 11'b0000_0000_000;
                audio_out[11] <= clk_380Hz;
            end
        end 
        if (counter == threshold_1s) begin
            audio_out [11:0] <= 12'b0000_0000_0000;
            if (!btnC_debounce) begin
                counter <= 0;
            end
        end
    end
endmodule
