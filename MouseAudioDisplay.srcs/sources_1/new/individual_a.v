`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2023 17:45:42
// Design Name: 
// Module Name: individual_a
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


module individual_a(
    input clk_20kHz,
    input [11:0] curr_Audio,
    output reg [11:0] led = 12'b000000000000,
    output reg an = 1'b0,
    output reg [6:0] seg = 7'b1111111
    );

    reg [31:0] count = 0;
    reg [11:0] max_Audio = 0;

    always @ (posedge clk_20kHz) begin
        count <= count + 1;
        if (max_Audio < curr_Audio) begin
            max_Audio = curr_Audio;
        end
        if (count == 2000) begin
            if (max_Audio < 2200)
            begin
                led[8:0] <= 9'b0000_00000;
                an <= 1'b0;
                seg <= 7'b1000000; // 0
            end
            else if (max_Audio < 2400)
            begin
                led[8:0] <= 9'b0000_00001;
                an <= 1'b0;
                seg <= 7'b1111001; // 1
            end
            else if (max_Audio < 2600)
            begin
                led[8:0] <= 9'b0000_00011;
                an <= 1'b0;
                seg <= 7'b0100100; // 2
            end
            else if (max_Audio < 2800)
            begin
                led[8:0] <= 9'b0000_00111;
                an <= 1'b0;
                seg <= 7'b0110000; // 3
            end
            else if (max_Audio < 3000)
            begin
                led[8:0] <= 9'b0000_01111;  
                an <= 1'b0;
                seg <= 7'b0011001; // 4
            end                                              
            else if (max_Audio < 3200)
            begin
                led[8:0] <= 9'b0000_11111;
                an <= 1'b0;
                seg <= 7'b0010010; // 5
            end
            else if (max_Audio < 3400)
            begin
                led[8:0] <= 9'b000_111111;
                an <= 1'b0;
                seg <= 7'b0000010;// 6
            end
            else if (max_Audio < 3600)
            begin
                led[8:0] <= 9'b00_1111111;
                an <= 1'b0;
                seg <= 7'b1111000; // 7
            end
            else if (max_Audio < 3800)
            begin
                led[8:0] <= 9'b0_11111111;
                an <= 1'b0;
                seg <= 7'b0000000; // 8
            end
            else
            begin 
                led[8:0] <= 9'b111111111;
                an <= 1'b0;
                seg <= 7'b0010000; // 9
            end
            
            max_Audio <= curr_Audio;
            count <= 0;                
        end
    end
endmodule
