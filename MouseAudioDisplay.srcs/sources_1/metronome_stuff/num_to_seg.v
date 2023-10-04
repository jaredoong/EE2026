`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2023 09:21:25
// Design Name: 
// Module Name: num_to_seg
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


module num_to_seg(
    input basys3_clock,
    input [7:0] num,
    output reg [3:0] an = 4'b1110,
    output reg [6:0] seg
    );
    
    reg [6:0] digits [9:0];
    reg [2:0] an_sel = 0;
    reg [2:0] max = 0;
    reg [12:0] anode_clock = 0;
    
    initial begin
        digits[0] = 7'b1000000;
        digits[1] = 7'b1111001;
        digits[2] = 7'b0100100;
        digits[3] = 7'b0110000;
        digits[4] = 7'b0011001;
        digits[5] = 7'b0010010;
        digits[6] = 7'b0000010;
        digits[7] = 7'b1111000;
        digits[8] = 7'b0000000;
        digits[9] = 7'b0010000;
    end
    
    always @ (posedge basys3_clock) begin
        anode_clock <= (anode_clock == 8191) ? 0: anode_clock + 1; 
        
        if (num >= 100) begin
            max <= 2;
        end
        else if (num >= 10) begin
            max <= 1;
        end
        else begin
            max <= 0;
        end
        
        if (anode_clock == 0) begin
            an_sel <= (an_sel >= max) ? 0: an_sel + 1;
        end
        
        case (an_sel)
            0: begin
                an = 4'b1110;
                seg <= digits[num % 10];
            end
            1: begin
                an = 4'b1101;
                seg <= digits[(num % 100) / 10];
            end
            2: begin
                an = 4'b1011;
                seg <= digits[num / 100];
            end
        endcase
    end
endmodule

