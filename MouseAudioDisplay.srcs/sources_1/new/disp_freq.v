`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2023 11:46:16
// Design Name: 
// Module Name: disp_freq
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


module disp_freq(
    input CLOCK,
    input [31:0] sound_freq,
    input disp_mode,
    output [3:0] an,
    output [6:0] seg
    );

    wire clk_381hz;
    wire slow_clk;

    reg [6:0] NULL = 7'b1111_111;
    reg [6:0] zero = 7'b1000_000;
    reg [6:0] one = 7'b1111_001;
    reg [6:0] two = 7'b0100_100;
    reg [6:0] three = 7'b0110_000;
    reg [6:0] four = 7'b0011_001;
    reg [6:0] five = 7'b0010_010;
    reg [6:0] six = 7'b0000_010;
    reg [6:0] seven = 7'b1111_000;
    reg [6:0] eight = 7'b0;
    reg [6:0] nine = 7'b0010_000;

    wire [3:0] thousand = (sound_freq/1000) % 10;
    wire [3:0] hundred = (sound_freq/100) % 10;
    wire [3:0] tens = (sound_freq/10) % 10;
    wire [3:0] ones = (sound_freq) % 10;

    wire [6:0] first_digit = (disp_mode)?NULL:(thousand == 9)? nine : (thousand == 8)? eight : (thousand == 7)? seven :(thousand == 6)? six:(thousand == 5) ? five:(thousand == 4)? four:(thousand == 3)?three:(thousand == 2)? two: (thousand == 1)? one : zero;
    wire [6:0] second_digit = (disp_mode)? NULL: (hundred == 9)? nine: (hundred == 8)? eight : (hundred == 7)? seven :(hundred == 6)? six :(hundred == 5)? five : (hundred == 4)? four: (hundred == 3)? three: (hundred == 2) ? two: (hundred == 1)? one : zero;
    wire [6:0] third_digit = (disp_mode)? NULL: (tens == 9)? nine :(tens == 8)?eight :(tens == 7)? seven :(tens == 6)? six :(tens == 5)? five : (tens == 4)? four :(tens == 3)? three :(tens == 2)? two :(tens == 1)? one: zero;
    wire [6:0] fourth_digit = (disp_mode)? NULL: (ones == 9)? nine :(ones == 8)? eight:(ones == 7)? seven :(ones == 6)? six:(ones == 5)? five: (ones == 4)? four: (ones == 3)? three:(ones == 2)? two : (ones == 1)? one : zero;

    clock_divider clk381hz(.basys3_clock(CLOCK), .frequency(381), .slow_clock(clk_381hz));
    segment_disp segmentdisp(
        .CLOCK_381HZ(clk_381hz),
        .first(first_digit),
        .second(second_digit),
        .third(third_digit),
        .fourth(fourth_digit),
        .an(an),
        .seg(seg)
        );
        
   clock_divider slowclk(.basys3_clock(CLOCK), .frequency(8), .slow_clock(slow_clk));
    
endmodule
