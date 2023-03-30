`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2023 11:46:16
// Design Name: 
// Module Name: freq_calibration
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


module freq_callibration(
    input CLOCK_100MHZ,
    input CLOCK_20KHZ,
    input callibration_mode,
    input [11:0] MIC_in,
    output reg freq_abv = 0
//    output reg [15:0] led
    );
    
    reg[31:0] count_limit = 14;
    
    reg[11:0] curr_audio = 1;
    reg[11:0] prev_audio = 0;
    
    reg[31:0] curr_audio_time = 0;
    reg[31:0] prev_audio_time = 0;
    
    reg[31:0] last_time_count = 0;
    
    always @ (posedge CLOCK_20KHZ)
    begin
        prev_audio <= curr_audio;
        curr_audio <= MIC_in;
        
//        prev_audio_time <= curr_audio_time;
        curr_audio_time <= curr_audio_time + 1;
        
        if(prev_audio <= 2175 & curr_audio > 2175)
        begin
            last_time_count <= curr_audio_time;
            prev_audio_time <= 0;
            curr_audio_time <= 1;
        end
     end
     always @ (posedge CLOCK_20KHZ)
     begin
        if (callibration_mode)
        begin
            freq_abv <= 0;
            count_limit <= last_time_count;
        end
        else
        begin
            if (last_time_count <= count_limit)
                freq_abv <= 1;
            else
                freq_abv <= 0;
        end
        end
    
endmodule
