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
    input sw0,
    input [11:0] curr_Audio,
    output reg [11:0] led = 12'b000000000000,
    output reg [3:0] an = 4'b1110,
    output reg [6:0] seg = 7'b1111111
    );

    reg [31:0] count = 0;
    reg [11:0] max_Audio = 0;
    
    reg [6:0] low = 7'b1000111; // display L on anode
    reg [6:0] med = 7'b1101010; // display m on anode
    reg [6:0] high = 7'b0001001; // display H on anode
    
    reg [6:0] zero = 7'b1000000; // display 0 on anode
    reg [6:0] one = 7'b1111001; // display 1 on anode
    reg [6:0] two = 7'b0100100; // display 2 on anode
    reg [6:0] three = 7'b0110000; // display 3 on anode
    reg [6:0] four = 7'b0011001; // display 4 on anode
    reg [6:0] five = 7'b0010010; // display 5 on anode
    reg [6:0] six = 7'b0000010; // display 6 on anode
    reg [6:0] seven = 7'b1111000; // display 7 on anode
    reg [6:0] eight = 7'b0000000; // display 8 on anode
    reg [6:0] nine = 7'b0010000; // display 9 on anode

    always @ (posedge clk_20kHz) begin
        count <= count + 1;
        if (max_Audio < curr_Audio) begin
            max_Audio = curr_Audio;
        end
        if (count == 2000) begin
            if (max_Audio < 2200)
            begin
                led[8:0] <= 9'b0000_00000;
                an <= 4'b1110;
                seg <= zero; // 0
                if (sw0)
                begin
                    led[8:0] <= 9'b0;
                    an <= 4'b0111;
                    seg <= low;
                end
            end
            else if (max_Audio < 2400)
            begin
                led[8:0] <= 9'b0000_00001;
                an <= 4'b1110;
                seg <= one; // 1
                if (sw0)
                begin
                    led[8:0] <= 9'b1;
                    an <= 4'b0111;
                    seg <= low; 
                end
            end
            else if (max_Audio < 2600)
            begin
                led[8:0] <= 9'b0000_00011;
                an <= 4'b1110;
                seg <= two; // 2
                if (sw0)
                begin
                    led[8:0] <= 9'b11;
                    an <= 4'b0111;
                    seg <= low;
                end
            end
            else if (max_Audio < 2800)
            begin
                led[8:0] <= 9'b0000_00111;
                an <= 4'b1110;
                seg <= three; // 3
                if (sw0)
                begin
                    led[8:0] <= 9'b111;
                    an <= 4'b0111;
                    seg <= low;
                end
            end
            else if (max_Audio < 3000)
            begin
                led[8:0] <= 9'b0000_01111;  
                an <= 4'b1110;
                seg <= four; // 4
                if (sw0)
                begin
                     led[8:0] <= 9'b1111;
                     an <= 4'b0111;
                     seg <= med;
                 end
            end                                              
            else if (max_Audio < 3200)
            begin
                led[8:0] <= 9'b0000_11111;
                an <= 4'b1110;
                seg <= five; // 5
                if (sw0)
                begin
                    led[8:0] <= 9'b11111;
                    an <= 4'b0111;
                    seg <= med;
                end
            end
            else if (max_Audio < 3400)
            begin
                led[8:0] <= 9'b000_111111;
                an <= 4'b1110;
                seg <= six;// 6
                if (sw0)
                begin
                    led[8:0] <= 9'b111111;
                    an <= 4'b0111;
                    seg <= med;
                end 
            end
            else if (max_Audio < 3600)
            begin
                led[8:0] <= 9'b00_1111111;
                an <= 4'b1110;
                seg <= seven; // 7
                if (sw0)
                begin
                    led[8:0] <= 9'b1111111;
                    an <= 4'b0111;
                    seg <= high;
                end
            end
            else if (max_Audio < 3800)
            begin
                led[8:0] <= 9'b0_11111111;
                an <= 4'b1110;
                seg <= eight; // 8
                if (sw0)
                begin
                    led[8:0] <= 9'b11111111;
                    an <= 4'b0111;
                    seg <= high; 
                end 
            end
            else if (max_Audio > 4000)
            begin 
                led[8:0] <= 9'b111111111;
                an <= 4'b1110;
                seg <= nine; // 9
                if(sw0)
                begin
                    led[8:0] <= 9'b111111111;
                    an <= 4'b0111;
                    seg <= high;
                    
                end
            end
            max_Audio <= curr_Audio;
            count <= 0;                
        end
    end
endmodule
