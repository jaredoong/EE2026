`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2023 07:56:10 PM
// Design Name: 
// Module Name: freq_detector
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


module freq_detector(
    input CLOCK_20KHZ,
    input [11:0] curr_audio,
//    input callibration_mode,
    output reg [15:0] led = 0,
    output reg[31:0] freq = 0,
    input [31:0] M,
    output reg [2:0] freq_range = 0
    );

    reg [31:0] counter = 0;
    reg period = 0;
    reg [12:0] sound_count = 0;
    reg reset = 0;

    always @ (posedge CLOCK_20KHZ)
    begin
        counter <= counter + 1;
        reset = 0;

        if (curr_audio > 2175)
            period <= 1;
        else   
            period <= 0;

        if (counter == M)
        begin
            counter <= 0;
            freq = 5 * sound_count;
            reset = 1;

//            if (freq < 100)
//                led = 16'b0;
//            else if (freq < 200)
//                led = 16'b1;
            if (freq < 300) 
                led = 16'b0;
            else if (freq < 400)
                led = 16'b11;
            else if (freq < 500) 
                led = 16'b111;
            else if (freq < 600) 
                led = 16'b1111;
            else if (freq < 700)
                led = 16'b1111_1;
            else if (freq < 800)
                led = 16'b1111_11;
            else if (freq < 900) 
                led = 16'b1111_111;
            else if (freq < 1000)
                led = 16'b1111_1111;
            else if (freq < 1100)
                led = 16'b1111_1111_1;
            else if (freq < 1200) 
                led = 16'b1111_1111_11;
            else if (freq < 1300)
                led = 16'b1111_1111_111;
            else if (freq < 1400)
                led = 16'b1111_1111_1111;
            else if (freq < 1500)
                led = 16'b1111_1111_1111_1;
            else if (freq < 1600)
                led = 16'b1111_1111_1111_11;
            else if (freq < 1800)
                led = 16'b1111_1111_1111_111;
            else 
                led = 16'b1111_1111_1111_1111;

            if (freq > 9999) freq = 9999;
        end 
    end

    always @ (posedge period, posedge reset)
    begin
        if (reset == 1)
            sound_count <= 0;
        else
            sound_count <= sound_count + 1;
    end
endmodule
