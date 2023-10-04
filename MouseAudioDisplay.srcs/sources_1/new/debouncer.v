`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2023 23:30:29
// Design Name: 
// Module Name: debouncer
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


module debouncer(
    input clk,
    input btn, 
    output reg db_signal = 1'b0
    );

    reg [31:0] threshold = 100000;
    reg [31:0] counter_up = 0;
    reg [31:0] counter_down = 0;
    
    always @ (posedge clk)
    begin
        if (btn && counter_up == 0) begin
            db_signal <= 1'b1;
            counter_up <= counter_up + 1;
        end else if (counter_up < threshold) begin
            counter_up <= counter_up + 1;
        end else if (counter_up == threshold) begin
            if (!btn && counter_down == 0) begin
                counter_down <= counter_down + 1;
            end else if (!btn && counter_down < threshold) begin
                counter_down <= counter_down + 1;
            end else if (!btn && counter_down == threshold) begin
                counter_up <= 0;
                counter_down <= 0;
                db_signal <= 1'b0;
            end else begin
                db_signal <= 1'b1;
            end
        end
    end
endmodule
