`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2023 18:27:28
// Design Name: 
// Module Name: rng
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


module rng(
    input wire clk_190Hz, //
    output reg [5:0] random_number // 6-bit output, random number between 1 and 36
    );

    reg [7:0] lfsr; // 8-bit Linear Feedback Shift Register (LFSR) for pseudo-random generation

    // LFSR feedback polynomial for 8-bit maximal-length sequence:
    // x^8 + x^6 + x^5 + x^4 + 1
    wire feedback = lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ lfsr[3];

    always @ (posedge clk_190Hz) begin
        lfsr <= {lfsr[6:0], feedback}; // Shift LFSR and apply feedback
        
        // Get a random number between 1 and 36, inclusive
        random_number <= (lfsr[5:0] % 36) + 1;
    end
endmodule
