`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2023 12:45:20
// Design Name: 
// Module Name: audio_output_improved
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


module audio_output_improved(
    input CLOCK, 
    input clk_20kHz, 
    output reg [6:0] seg, 
    output reg [3:0]an, 
    input btnL_debounce, 
    input btnR_debounce, 
    input btnU_debounce, 
    input btnD_debounce, 
    output reg [11:0] audio_out = 0,
    input [12:0] pixel_index, 
    input [6:0] diff_x, diff_y, cursor_x, cursor_y, 
    input left_click, 
    output [15:0] pixel_data,
    output [3:0] cursor_size
    );

    reg reset;
    reg reset2;
    reg [31:0] counter = 0;

    wire [11:0] kb;
    reg [2:0] octave = 4;
    reg [2:0] shift;
    reg[31:0] A = 32'd6377;
    reg[31:0] Bf = 32'd6757;
    reg[31:0] B = 32'd7159;
    reg[31:0] C = 32'd7584;
    reg[31:0] Cs = 32'd8035;
    reg[31:0] D = 32'd8513;
    reg[31:0] Ef = 32'd9019;
    reg[31:0] E = 32'd9556;
    reg[31:0] F = 32'd5062;
    reg[31:0] Fs = 32'd5363;
    reg[31:0] G = 32'd5682;
    reg[31:0] Gs = 32'd6020;

    reg [11:0] note_final;
    reg [11:0] note_volume;
    reg [31:0] note1 = 0;
    reg [2:0] volume = 3;

    wire A_fundamental;
    wire Bf_fundamental;
    wire B_fundamental;
    wire C_fundamental;
    wire Cs_fundamental;
    wire D_fundamental;
    wire Ef_fundamental;
    wire E_fundamental;
    wire F_fundamental;
    wire Fs_fundamental;
    wire G_fundamental;
    wire Gs_fundamental;
    wire fifth_octave;
    wire fourth_octave;
    wire third_octave;
    wire second_octave;
    wire first_octave;
    
    reg [2:0] seg_state;
    reg [3:0] digit;
    localparam ZERO = 7'b1000000;
    localparam ONE = 7'b1111001;
    localparam TWO = 7'b0100100;
    localparam THREE = 7'b0110000;
    localparam FOUR = 7'b0011001;
    localparam FIVE = 7'b0010010;
    localparam SIX = 7'b0000010;
    localparam SEVEN = 7'b1111000;
    localparam EIGHT = 7'b0000000;
    localparam NINE = 7'b0010000;
    localparam L = 7'b1000111;
    
    always @ (posedge CLOCK) begin
        if (kb != 0) begin
   
            audio_out <= note_volume;
        end else begin
            audio_out [11:0] <= 12'b0000_0000_0000;
        end
        case (kb)
            12'b0000_0000_0001 : note1 <= Gs_fundamental;
            12'b0000_0000_0010 : note1 <= G_fundamental; 
            12'b0000_0000_0100 : note1 <= Fs_fundamental;
            12'b0000_0000_1000 : note1 <= F_fundamental; 
            12'b0000_0001_0000 : note1 <= E_fundamental; 
            12'b0000_0010_0000 : note1 <= Ef_fundamental;
            12'b0000_0100_0000 : note1 <= D_fundamental; 
            12'b0000_1000_0000 : note1 <= Cs_fundamental;
            12'b0001_0000_0000 : note1 <= C_fundamental; 
            12'b0010_0000_0000 : note1 <= B_fundamental; 
            12'b0100_0000_0000 : note1 <= Bf_fundamental;
            12'b1000_0000_0000 : note1 <= A_fundamental; 
        endcase
        
        if (octave == 1 && reset) begin
            octave <= (btnL_debounce)? octave : (btnR_debounce)? octave + 1 : octave;
            reset <= (btnL_debounce || btnR_debounce)? 0 : 1; 
        end else if (octave == 6 && reset) begin
            octave <= (btnR_debounce)? octave : (btnL_debounce)? octave - 1 : octave;
            reset <= (btnL_debounce || btnR_debounce)? 0 : 1; 
        end else if (reset) begin
            octave <= (btnL_debounce)? octave - 1 : (btnR_debounce)? octave + 1 : octave;
            reset <= (btnL_debounce || btnR_debounce)? 0 : 1; 
        end else begin
            reset <= (~btnL_debounce && ~btnR_debounce)? 1 : 0;
        end
        
        if (volume == 1 && reset2) begin
                volume <= (btnD_debounce)? volume : (btnU_debounce)? volume + 1 : volume;
                reset2 <= (btnD_debounce || btnU_debounce)? 0 : 1; 
            end else if (volume == 5 && reset2) begin
                volume <= (btnU_debounce)? volume : (btnD_debounce)? volume - 1 : volume;
                reset2 <= (btnD_debounce || btnU_debounce)? 0 : 1; 
            end else if (reset2) begin
                volume <= (btnD_debounce)? volume - 1 : (btnU_debounce)? volume + 1 : volume;
                reset2 <= (btnD_debounce || btnU_debounce)? 0 : 1; 
            end else begin
                reset2 <= (~btnD_debounce && ~btnU_debounce)? 1 : 0;
            end
            shift <= 5 - volume;
            note_final [11] <= (octave == 1)? first_octave : (octave == 2)? second_octave : (octave == 3)? third_octave : (octave == 4)? fourth_octave : (octave == 5)? fifth_octave : (octave == 6)? note1 : 0;
            note_volume <= (note_final >> shift);
    end
    
    always @ (posedge clk_20kHz) begin
        seg_state <= seg_state + 1;
        case (digit)
            0: seg <= ZERO;
            1: seg <= ONE;
            2: seg <= TWO;
            3: seg <= THREE;
            4: seg <= FOUR;
            5: seg <= FIVE;
            6: seg <= SIX;
            7: seg <= SEVEN;
            8: seg <= EIGHT;
            9: seg <= NINE;
            10: seg <= L;
        endcase
        if (seg_state == 0) begin
            an <= 4'b0111;
            digit <= volume;
        end else if (seg_state == 2) begin
            an <= 4'b1110;
            digit <= 10;
        end else if (seg_state == 4) begin
            an <= 4'b1101;
            digit <= octave;
        end else if (seg_state == 6) begin
            an <= 4'b1011;
            digit <= 0;
        end else begin
            an <= 4'b1111;
            seg <= 7'b1111111;
        end
    end

    
    
    wavegen square_A(.CLOCK(CLOCK), .DIV(A), .signal(A_fundamental));
    wavegen square_Bf(.CLOCK(CLOCK), .DIV(Bf), .signal(Bf_fundamental));
    wavegen square_B(.CLOCK(CLOCK), .DIV(B), .signal(B_fundamental));
    wavegen square_C(.CLOCK(CLOCK), .DIV(C), .signal(C_fundamental));
    wavegen square_Cs(.CLOCK(CLOCK), .DIV(Cs), .signal(Cs_fundamental));
    wavegen square_D(.CLOCK(CLOCK), .DIV(D), .signal(D_fundamental));
    wavegen square_Ef(.CLOCK(CLOCK), .DIV(Ef), .signal(Ef_fundamental));
    wavegen square_E(.CLOCK(CLOCK), .DIV(E), .signal(E_fundamental));
    wavegen square_F(.CLOCK(CLOCK), .DIV(F), .signal(F_fundamental));
    wavegen square_Fs(.CLOCK(CLOCK), .DIV(Fs), .signal(Fs_fundamental));
    wavegen square_G(.CLOCK(CLOCK), .DIV(G), .signal(G_fundamental));
    wavegen square_Gs(.CLOCK(CLOCK), .DIV(Gs), .signal(Gs_fundamental));
    
    wavegen pitch_down(.CLOCK(note1), .DIV(1), .signal(fifth_octave));
    wavegen pitch_down2(.CLOCK(note1), .DIV(2), .signal(fourth_octave));
    wavegen pitch_down3(.CLOCK(note1), .DIV(4), .signal(third_octave));
    wavegen pitch_down4(.CLOCK(note1), .DIV(8), .signal(second_octave));
    wavegen pitch_down5(.CLOCK(note1), .DIV(16), .signal(first_octave));
    
    piano_display display(.CLOCK(CLOCK), .pixel_index(pixel_index), .pixel_data(pixel_data), .diff_x(diff_x), .diff_y(diff_y), .cursor_x(cursor_x), 
            .cursor_y(cursor_y), .left_click(left_click), .cursor_size(cursor_size), .keyboard(kb));
    
endmodule
