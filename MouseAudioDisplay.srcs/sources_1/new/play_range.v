`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2023 14:36:41
// Design Name: 
// Module Name: play_range
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


module play_range(
    input [5:0] selector, 
    input clk, 
    output audio_signal
    );
    reg [4:0] now = 0;
    reg dir = 0;
    reg [13:0] start_freq = 0;
    reg [13:0] threshold_freq = 0;
    reg [13:0] freq_now = 0;
    wire [13:0] freq_in;
    wire update_freq;
    
    always @ (posedge clk) begin
        case(selector) 
        0 : start_freq <= 0;
        1: start_freq <= 1;
        2: start_freq <= 489;
        3: start_freq <= 977;
        4: start_freq <= 1465;
        5: start_freq <= 1954;
        6: start_freq <= 2442;
        7: start_freq <= 2930;
        8: start_freq <= 3418;
        9: start_freq <= 3907;
        10: start_freq <= 4395;
        11: start_freq <= 4883;
        12: start_freq <= 5372;
        13: start_freq <= 5860;
        14: start_freq <= 6348;
        15: start_freq <= 6836;
        16: start_freq <= 7325;
        17: start_freq <= 7813;
        18: start_freq <= 8301;
        19: start_freq <= 8790;
        20: start_freq <= 9278;
        endcase
        threshold_freq <= start_freq + 487;
    end
    always @ (posedge update_freq) begin
        if (start_freq == 0) begin
            freq_now <= 0;
        end else if (freq_now == start_freq) begin
            dir <= 0;
            freq_now <= freq_now + 1;
        end else if (freq_now == threshold_freq) begin
            dir <= 1;
            freq_now <= freq_now - 1;
        end else if (freq_now < start_freq || freq_now > threshold_freq) begin
            freq_now <= start_freq;
        end else begin
            freq_now <= (dir)? freq_now - 1 : freq_now + 1;
        end
    end
    
    fft_clock_divider updater(clk, 244, update_freq);
    fft_clock_divider oscillator(clk, freq_now, audio_signal);
endmodule
