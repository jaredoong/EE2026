`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2023 00:25:51
// Design Name: 
// Module Name: metronome
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


module metronome(
    input basys3_clock,
    input btnU, btnD, left_click,
    input [6:0] pixel_x, pixel_y, cursor_x, cursor_y,
    input [15:0] sw,
    output reg [15:0] pixel_data,
    output reg [11:0] audio_out,
    output [3:0] an,
    output [6:0] seg,
    output[3:0] cursor_size
    );
    
    //pixel data colours
    localparam BACKGROUND = 16'b00101_000111_00110;
    localparam METRONOME_OFF = 16'b00111_001111_01110;
    localparam WHITE = 16'b11111_111111_11111;
    localparam YELLOW = 16'b11011_111111_01111;
    localparam BLACK = 16'b00000_000000_00000;
    
    localparam BUTTON = 16'b00011_000011_00110;
    localparam BUTTON_PUSHED = 16'b00001_000010_00010;
    localparam CURSOR = 16'b01011_001011_11110;
    localparam ICON = 16'b11101_101111_11101;
    
    //oled coords
    localparam BUTTON_HEIGHT = 19;
    localparam BUTTON_WIDTH = 19;
    localparam PLAY_BUTTON_X = 4;
    localparam UP_BUTTON_X = 27;
    localparam DOWN_BUTTON_X = 50;
    localparam NOTE_BUTTON_X = 73;
    localparam BUTTON_Y = 37;
    
    //duration of note
    localparam note_threshold = 200;
    
    //clocks
    wire clock_10hz, clock_196hz, clock_440hz;
    clock_divider clk10hz(basys3_clock, 10, clock_10hz);
    clock_divider clk196hz(basys3_clock, 196, clock_196hz);
    clock_divider clk440hz(basys3_clock, 440, clock_440hz);
    
    //metronome
    wire [7:0] bpm;
    wire clock_bpm;
    
    
    reg oled_up = 0;
    reg oled_down = 0;
    
    wire [2:0] stage;
    reg [2:0] prev_stage = 7;
    wire [2:0] beats_in_bar;
    //0: high, 1: low, 2: mute
    reg [1:0] metronome_state [3:0];
    reg metronome_state_reset = 1;
    reg play = 1;
    reg play_reset = 1;
    //1 - crotchet, 2 - quaver
    reg note = 1;
    reg note_reset = 0;
    reg [7:0] note_counter = 0;
    
    assign cursor_size = 3;
    
    //bpm clock
    bpm_to_clock bpm_clock(.basys3_clock(basys3_clock), .bpm(bpm), .clock_bpm(clock_bpm));
    
    //switch stage based on bpm
    metronome_stage_selector stage_switcher(.bpm_clock(clock_bpm), .play(play), .sw(sw), .stage(stage), .beats_in_bar(beats_in_bar));
   
    //adjust bpm
    bpm_controller bpm_control(.clock(clock_10hz), .inc_button(btnU || oled_up), .dec_button(btnD || oled_down), .bpm(bpm));
    
    //display bpm on 7 seg display
    num_to_seg display_bpm(.basys3_clock(basys3_clock), .num(bpm), .an(an), .seg(seg));
    
    //cursor location
    assign cursor = (pixel_x >= cursor_x && pixel_x < cursor_x + cursor_size) && (pixel_y >= cursor_y && pixel_y < cursor_y + cursor_size);
    assign cursor_on_play = (cursor_x >= PLAY_BUTTON_X && cursor_x <= PLAY_BUTTON_X + BUTTON_WIDTH) && (cursor_y >= BUTTON_Y && cursor_y <= BUTTON_Y + BUTTON_HEIGHT);
    assign cursor_on_up = (cursor_x >= UP_BUTTON_X && cursor_x <= UP_BUTTON_X + BUTTON_WIDTH) && (cursor_y >= BUTTON_Y && cursor_y <= BUTTON_Y + BUTTON_HEIGHT);
    assign cursor_on_down = (cursor_x >= DOWN_BUTTON_X && cursor_x <= DOWN_BUTTON_X + BUTTON_WIDTH) && (cursor_y >= BUTTON_Y && cursor_y <= BUTTON_Y + BUTTON_HEIGHT);
    assign cursor_on_note = (cursor_x >= NOTE_BUTTON_X && cursor_x <= NOTE_BUTTON_X + BUTTON_WIDTH) && (cursor_y >= BUTTON_Y && cursor_y <= BUTTON_Y + BUTTON_HEIGHT);
    assign cursor_on_first = (cursor_x > 4 && cursor_x < 22) && (cursor_y > 4 && cursor_y < 30);
    assign cursor_on_second = (cursor_x > 27 && cursor_x < 45) && (cursor_y > 4 && cursor_y < 30);
    assign cursor_on_third = (cursor_x > 50 && cursor_x < 68) && (cursor_y > 4 && cursor_y < 30);
    assign cursor_on_fourth = (cursor_x > 73 && cursor_x < 91) && (cursor_y > 4 && cursor_y < 30);
    
    //metronome display
    assign four_four_border = (((pixel_x >= 4 && pixel_x <= 22) || (pixel_x >= 27 && pixel_x <= 45) || (pixel_x >= 50 && pixel_x <= 68) || (pixel_x >= 73 && pixel_x <= 91)) && (pixel_y == 4 || pixel_y == 17 || pixel_y == 30))
                || ((pixel_y >= 5 && pixel_y <= 29) && (pixel_x == 4 || pixel_x == 22 || pixel_x == 27 || pixel_x == 45 || pixel_x == 50 || pixel_x == 68 || pixel_x == 73 || pixel_x == 91));
    
    assign four_four_first = (pixel_x > 4 && pixel_x < 22) && (pixel_y > 4 && pixel_y < 30);
    assign four_four_first_top = (pixel_x > 4 && pixel_x < 22) && (pixel_y > 4 && pixel_y < 17);
    assign four_four_first_bot = (pixel_x > 4 && pixel_x < 22) && (pixel_y > 17 && pixel_y < 30);
    
    assign four_four_second = (pixel_x > 27 && pixel_x < 45) && (pixel_y > 4 && pixel_y < 30);
    assign four_four_second_top = (pixel_x > 27 && pixel_x < 45) && (pixel_y > 4 && pixel_y < 17);
    assign four_four_second_bot = (pixel_x > 27 && pixel_x < 45) && (pixel_y > 17 && pixel_y < 30);
    
    assign four_four_third = (pixel_x > 50 && pixel_x < 68) && (pixel_y > 4 && pixel_y < 30);
    assign four_four_third_top = (pixel_x > 50 && pixel_x < 68) && (pixel_y > 4 && pixel_y < 17);
    assign four_four_third_bot = (pixel_x > 50 && pixel_x < 68) && (pixel_y > 17 && pixel_y < 30);
    
    assign four_four_fourth = (pixel_x > 73 && pixel_x < 91) && (pixel_y > 4 && pixel_y < 30);
    assign four_four_fourth_top = (pixel_x > 73 && pixel_x < 91) && (pixel_y > 4 && pixel_y < 17);
    assign four_four_fourth_bot = (pixel_x > 73 && pixel_x < 91) && (pixel_y > 17 && pixel_y < 30);
    
    //buttons display
    assign play_button = (pixel_x >= PLAY_BUTTON_X && pixel_x < PLAY_BUTTON_X + BUTTON_WIDTH) && (pixel_y >= BUTTON_Y && pixel_y < BUTTON_Y + BUTTON_HEIGHT);
    assign play_icon = ((pixel_x == 9) && (pixel_y >= 38 && pixel_y <= 54)) || ((pixel_x == 10) && (pixel_y >= 39 && pixel_y <= 53))
                   || ((pixel_x == 11) && (pixel_y >= 40 && pixel_y <= 52)) || ((pixel_x == 12) && (pixel_y >= 41 && pixel_y <= 51))
                   || ((pixel_x == 13) && (pixel_y >= 42 && pixel_y <= 50)) || ((pixel_x == 14) && (pixel_y >= 43 && pixel_y <= 49))
                   || ((pixel_x == 15) && (pixel_y >= 44 && pixel_y <= 48)) || ((pixel_x == 16) && (pixel_y >= 45 && pixel_y <= 47))
                   || (pixel_x == 17 && pixel_y == 46);
    assign pause_icon = (pixel_x == 10 || pixel_x == 11 || pixel_x == 15 || pixel_x == 16)
                       && (pixel_y >= 40 && pixel_y <= 52);
                       
    assign up_button = (pixel_x >= UP_BUTTON_X && pixel_x < UP_BUTTON_X + BUTTON_WIDTH) && (pixel_y >= BUTTON_Y && pixel_y < BUTTON_Y + BUTTON_HEIGHT);
    assign up_icon = ((pixel_y == 50) && (pixel_x >= 28 && pixel_x <= 44)) || ((pixel_y == 49) && (pixel_x >= 29 && pixel_x <= 43))
                   || ((pixel_y == 48) && (pixel_x >= 30 && pixel_x <= 42)) || ((pixel_y == 47) && (pixel_x >= 31 && pixel_x <= 41))
                   || ((pixel_y == 46) && (pixel_x >= 32 && pixel_x <= 40)) || ((pixel_y == 45) && (pixel_x >= 33 && pixel_x <= 39))
                   || ((pixel_y == 44) && (pixel_x >= 34 && pixel_x <= 38)) || ((pixel_y == 43) && (pixel_x >= 35 && pixel_x <= 37))
                   || (pixel_y == 42 && pixel_x == 36);
    
    assign down_button = (pixel_x >= DOWN_BUTTON_X && pixel_x < DOWN_BUTTON_X + BUTTON_WIDTH) && (pixel_y >= BUTTON_Y && pixel_y < BUTTON_Y + BUTTON_HEIGHT);
    assign down_icon = ((pixel_y == 42) && (pixel_x >= 51 && pixel_x <= 67)) || ((pixel_y == 43) && (pixel_x >= 52 && pixel_x <= 66))
                   || ((pixel_y == 44) && (pixel_x >= 53 && pixel_x <= 65)) || ((pixel_y == 45) && (pixel_x >= 54 && pixel_x <= 64))
                   || ((pixel_y == 46) && (pixel_x >= 55 && pixel_x <= 63)) || ((pixel_y == 47) && (pixel_x >= 56 && pixel_x <= 62))
                   || ((pixel_y == 48) && (pixel_x >= 57 && pixel_x <= 61)) || ((pixel_y == 49) && (pixel_x >= 58 && pixel_x <= 60))
                   || (pixel_y == 50 && pixel_x == 59);
    
    assign note_button = (pixel_x >= NOTE_BUTTON_X && pixel_x < NOTE_BUTTON_X + BUTTON_WIDTH) && (pixel_y >= BUTTON_Y && pixel_y < BUTTON_Y + BUTTON_HEIGHT);
    assign note_crotchet = (pixel_x == 83 && (pixel_y >= 39 && pixel_y <= 50))
           || ((pixel_y == 51 || pixel_y == 52) && (pixel_x >= 79 && pixel_x <= 83))
           || ((pixel_y == 50 || pixel_y == 53) && (pixel_x >= 80 && pixel_x <= 82));
    assign note_quaver = note_crotchet || (pixel_x == 84 && pixel_y == 39) || (pixel_x == 84 && pixel_y == 40) || (pixel_x == 85 && pixel_y == 40)
                   || (pixel_x == 86 && pixel_y == 40) || (pixel_x == 86 && pixel_y == 41) || (pixel_x == 87 && pixel_y == 41)
                   || (pixel_x == 87 && pixel_y == 42) || (pixel_x == 88 && pixel_y == 42) || (pixel_x == 88 && pixel_y == 43)
                   || (pixel_x == 86 && pixel_y == 44);
   
   initial begin
       metronome_state[0] = 0;
       metronome_state[1] = 0;
       metronome_state[2] = 0;
       metronome_state[3] = 0;
   end
   
    always @ (posedge basys3_clock) begin
       //cursor
       if (cursor) begin
           pixel_data <= CURSOR;
       end
       //metronome border
       else if (four_four_border) begin
           pixel_data <= BLACK;
       end
       //buttons & icons
       else if ((play_icon && ~play) || (pause_icon && play) || up_icon || down_icon || (note && note_crotchet) || (~note && note_quaver)) begin
           pixel_data <= ICON;
       end
       else if ((left_click == 1 && cursor_on_play) && play_reset) begin
           play <= ~play;
           play_reset <= 0;
       end
       else if (left_click == 1 && cursor_on_up && up_button) begin
           oled_up <= 1;
           pixel_data <= BUTTON_PUSHED;
       end
       else if (left_click == 1 && cursor_on_down && down_button) begin
           oled_down <= 1;
           pixel_data <= BUTTON_PUSHED;
       end
       else if (left_click == 1 && cursor_on_note && note_button && note_reset) begin
           note <= ~note;
           note_reset <= 0;
           pixel_data <= BUTTON_PUSHED;
       end
       else if (play_button && play) begin
           pixel_data <= BUTTON_PUSHED;
       end
       else if (play_button || up_button || down_button || note_button) begin
           pixel_data <= BUTTON;
       end
       else if (left_click == 1 && cursor_on_first && metronome_state_reset) begin
           metronome_state[0] <= (metronome_state[0] == 2) ? 0 : metronome_state[0] + 1;
           metronome_state_reset <= 0;
       end
       else if (left_click == 1 && cursor_on_second && metronome_state_reset) begin
           metronome_state[1] <= (metronome_state[1] == 2) ? 0 : metronome_state[1] + 1;
           metronome_state_reset <= 0;
       end
       else if (left_click == 1 && cursor_on_third && metronome_state_reset) begin
           metronome_state[2] <= (metronome_state[2] == 2) ? 0 : metronome_state[2] + 1;
           metronome_state_reset <= 0;
       end
       else if (left_click == 1 && cursor_on_fourth && metronome_state_reset) begin
           metronome_state[3] <= (metronome_state[3] == 2) ? 0 : metronome_state[3] + 1;
           metronome_state_reset <= 0;
       end
       //background
       else if (!four_four_first && !four_four_second && !four_four_third && !four_four_fourth) begin
           pixel_data <= BACKGROUND;
       end
       else if (stage == 0) begin
           if (four_four_first_top || four_four_first_bot) begin
               pixel_data <= WHITE;
           end
           
           if (note_counter < note_threshold && metronome_state[0] != 2) begin
               note_counter <= note_counter + 1;
               audio_out[10:0] <= 11'b1111_1111_111;
               if (metronome_state[0] == 1) begin
                   audio_out[11] <= clock_196hz;
               end
               else begin
                   audio_out[11] <= clock_440hz;
               end
           end
           else begin
               audio_out [11:0] <= 12'b0000_0000_0000;
           end
           
           case(beats_in_bar)
               1: begin
                   if (four_four_second_top || four_four_second_bot || four_four_third_top || four_four_third_bot || four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= BACKGROUND;
                   end
               end
               2: begin
                   if (four_four_third_top || four_four_third_bot || four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= BACKGROUND;
                   end
                   else if ((metronome_state[1] == 0 && (four_four_second_top || four_four_second_bot))
                       || (metronome_state[1] == 1 && four_four_second_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_second_top || four_four_second_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
               3: begin
                   if (four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= BACKGROUND;
                   end
                   else if ((metronome_state[1] == 0 && (four_four_second_top || four_four_second_bot))
                       || (metronome_state[1] == 1 && four_four_second_top)
                       || (metronome_state[2] == 0 && (four_four_third_top || four_four_third_bot))
                       || (metronome_state[2] == 1 && four_four_third_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_second_top || four_four_second_bot || four_four_third_top || four_four_third_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
               4: begin
                   if ((metronome_state[1] == 0 && (four_four_second_top || four_four_second_bot))
                       || (metronome_state[1] == 1 && four_four_second_top)
                       || (metronome_state[2] == 0 && (four_four_third_top || four_four_third_bot))
                       || (metronome_state[2] == 1 && four_four_third_top)
                       || (metronome_state[3] == 0 && (four_four_fourth_top || four_four_fourth_bot))
                       || (metronome_state[3] == 1 && four_four_fourth_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_second_top || four_four_second_bot || four_four_third_top || four_four_third_bot || four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
           endcase
       end
       else if (stage == 1) begin
           if ((four_four_first_top || four_four_first_bot) && ~note) begin
               pixel_data <= YELLOW;
           end
           else if ((metronome_state[0] == 0 && (four_four_first_top || four_four_first_bot))
               || (metronome_state[0] == 1 && four_four_first_top)) begin
               pixel_data <= BLACK;
           end
           else if (four_four_first_top || four_four_first_bot) begin
               pixel_data <= METRONOME_OFF;
           end
           
           if (note_counter < note_threshold && metronome_state[0] != 2 && ~note) begin
               note_counter <= note_counter + 1;
               audio_out[10:0] <= 11'b1111_1111_111;
               if (metronome_state[0] == 1) begin
                   audio_out[11] <= clock_196hz;
               end
               else begin
                   audio_out[11] <= clock_440hz;
               end
           end
           else begin
               audio_out [11:0] <= 12'b0000_0000_0000;
           end
           
           case(beats_in_bar)
               1: begin
                   if (four_four_second_top || four_four_second_bot || four_four_third_top || four_four_third_bot || four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= BACKGROUND;
                   end
               end
               2: begin
                   if (four_four_third_top || four_four_third_bot || four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= BACKGROUND;
                   end
                   else if ((metronome_state[1] == 0 && (four_four_second_top || four_four_second_bot))
                       || (metronome_state[1] == 1 && four_four_second_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_second_top || four_four_second_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
               3: begin
                   if (four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= BACKGROUND;
                   end
                   else if ((metronome_state[1] == 0 && (four_four_second_top || four_four_second_bot))
                       || (metronome_state[1] == 1 && four_four_second_top)
                       || (metronome_state[2] == 0 && (four_four_third_top || four_four_third_bot))
                       || (metronome_state[2] == 1 && four_four_third_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_second_top || four_four_second_bot || four_four_third_top || four_four_third_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
               4: begin
                   if ((metronome_state[1] == 0 && (four_four_second_top || four_four_second_bot))
                       || (metronome_state[1] == 1 && four_four_second_top)
                       || (metronome_state[2] == 0 && (four_four_third_top || four_four_third_bot))
                       || (metronome_state[2] == 1 && four_four_third_top)
                       || (metronome_state[3] == 0 && (four_four_fourth_top || four_four_fourth_bot))
                       || (metronome_state[3] == 1 && four_four_fourth_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_second_top || four_four_second_bot || four_four_third_top || four_four_third_bot || four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
           endcase
       end
       else if (stage == 2) begin
           if (four_four_second_top || four_four_second_bot) begin
               pixel_data <= WHITE;
           end
           
           if (note_counter < note_threshold && metronome_state[1] != 2) begin
               note_counter <= note_counter + 1;
               audio_out[10:0] <= 11'b1111_1111_111;
               if (metronome_state[1] == 1) begin
                   audio_out[11] <= clock_196hz;
               end
               else begin
                   audio_out[11] <= clock_440hz;
               end
           end
           else begin
               audio_out [11:0] <= 12'b0000_0000_0000;
           end
                       
           case(beats_in_bar)
               2: begin
                   if (four_four_third_top || four_four_third_bot || four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= BACKGROUND;
                   end
                   else if ((metronome_state[0] == 0 && (four_four_first_top || four_four_first_bot))
                       || (metronome_state[0] == 1 && four_four_first_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_first_top || four_four_first_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
               3: begin
                   if (four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= BACKGROUND;
                   end
                   else if ((metronome_state[0] == 0 && (four_four_first_top || four_four_first_bot))
                       || (metronome_state[0] == 1 && four_four_first_top)
                       || (metronome_state[2] == 0 && (four_four_third_top || four_four_third_bot))
                       || (metronome_state[2] == 1 && four_four_third_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_first_top || four_four_first_bot || four_four_third_top || four_four_third_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
               4: begin
                   if ((metronome_state[0] == 0 && (four_four_first_top || four_four_first_bot))
                       || (metronome_state[0] == 1 && four_four_first_top)
                       || (metronome_state[2] == 0 && (four_four_third_top || four_four_third_bot))
                       || (metronome_state[2] == 1 && four_four_third_top)
                       || (metronome_state[3] == 0 && (four_four_fourth_top || four_four_fourth_bot))
                       || (metronome_state[3] == 1 && four_four_fourth_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_first_top || four_four_first_bot || four_four_third_top || four_four_third_bot || four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
           endcase
       end
       else if (stage == 3) begin
           if ((four_four_second_top || four_four_second_bot) && ~note) begin
               pixel_data <= YELLOW;
           end
           else if ((metronome_state[1] == 0 && (four_four_second_top || four_four_second_bot))
               || (metronome_state[1] == 1 && four_four_second_top)) begin
               pixel_data <= BLACK;
           end
           else if (four_four_second_top || four_four_second_bot) begin
               pixel_data <= METRONOME_OFF;
           end
           
           if (note_counter < note_threshold && metronome_state[1] != 2 && ~note) begin
               note_counter <= note_counter + 1;
               audio_out[10:0] <= 11'b1111_1111_111;
               if (metronome_state[1] == 1) begin
                   audio_out[11] <= clock_196hz;
               end
               else begin
                   audio_out[11] <= clock_440hz;
               end
           end
           else begin
               audio_out [11:0] <= 12'b0000_0000_0000;
           end
                       
           case(beats_in_bar)
               2: begin
                   if (four_four_third_top || four_four_third_bot || four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= BACKGROUND;
                   end
                   else if ((metronome_state[0] == 0 && (four_four_first_top || four_four_first_bot))
                       || (metronome_state[0] == 1 && four_four_first_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_first_top || four_four_first_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
               3: begin
                   if (four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= BACKGROUND;
                   end
                   else if ((metronome_state[0] == 0 && (four_four_first_top || four_four_first_bot))
                       || (metronome_state[0] == 1 && four_four_first_top)
                       || (metronome_state[2] == 0 && (four_four_third_top || four_four_third_bot))
                       || (metronome_state[2] == 1 && four_four_third_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_first_top || four_four_first_bot || four_four_third_top || four_four_third_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
               4: begin
                   if ((metronome_state[0] == 0 && (four_four_first_top || four_four_first_bot))
                       || (metronome_state[0] == 1 && four_four_first_top)
                       || (metronome_state[2] == 0 && (four_four_third_top || four_four_third_bot))
                       || (metronome_state[2] == 1 && four_four_third_top)
                       || (metronome_state[3] == 0 && (four_four_fourth_top || four_four_fourth_bot))
                       || (metronome_state[3] == 1 && four_four_fourth_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_first_top || four_four_first_bot || four_four_third_top || four_four_third_bot || four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
           endcase
       end
       else if (stage == 4) begin
           if (four_four_third_top || four_four_third_bot) begin
               pixel_data <= WHITE;
           end
           
           if (note_counter < note_threshold && metronome_state[2] != 2) begin
               note_counter <= note_counter + 1;
               audio_out[10:0] <= 11'b1111_1111_111;
               if (metronome_state[2] == 1) begin
                   audio_out[11] <= clock_196hz;
               end
               else begin
                   audio_out[11] <= clock_440hz;
               end
           end
           else begin
               audio_out [11:0] <= 12'b0000_0000_0000;
           end
                       
           case(beats_in_bar)
               3: begin
                   if (four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= BACKGROUND;
                   end
                   else if ((metronome_state[0] == 0 && (four_four_first_top || four_four_first_bot))
                       || (metronome_state[0] == 1 && four_four_first_top)
                       || (metronome_state[1] == 0 && (four_four_second_top || four_four_second_bot))
                       || (metronome_state[1] == 1 && four_four_second_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_first_top || four_four_first_bot || four_four_second_top || four_four_second_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
               4: begin
                   if ((metronome_state[0] == 0 && (four_four_first_top || four_four_first_bot))
                       || (metronome_state[0] == 1 && four_four_first_top)
                       || (metronome_state[1] == 0 && (four_four_second_top || four_four_second_bot))
                       || (metronome_state[1] == 1 && four_four_second_top)
                       || (metronome_state[3] == 0 && (four_four_fourth_top || four_four_fourth_bot))
                       || (metronome_state[3] == 1 && four_four_fourth_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_first_top || four_four_first_bot || four_four_second_top || four_four_second_bot || four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
           endcase
       end
       else if (stage == 5) begin
           if ((four_four_third_top || four_four_third_bot) && ~note) begin
               pixel_data <= YELLOW;
           end
           else if ((metronome_state[2] == 0 && (four_four_third_top || four_four_third_bot))
               || (metronome_state[2] == 1 && four_four_third_top)) begin
               pixel_data <= BLACK;
           end
           else if (four_four_third_top || four_four_third_bot) begin
               pixel_data <= METRONOME_OFF;
           end
           
           if (note_counter < note_threshold && metronome_state[2] != 2 && ~note) begin
               note_counter <= note_counter + 1;
               audio_out[10:0] <= 11'b1111_1111_111;
               if (metronome_state[2] == 1) begin
                   audio_out[11] <= clock_196hz;
               end
               else begin
                   audio_out[11] <= clock_440hz;
               end
           end
           else begin
               audio_out [11:0] <= 12'b0000_0000_0000;
           end
                       
           case(beats_in_bar)
               3: begin
                   if (four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= BACKGROUND;
                   end
                   else if ((metronome_state[0] == 0 && (four_four_first_top || four_four_first_bot))
                       || (metronome_state[0] == 1 && four_four_first_top)
                       || (metronome_state[1] == 0 && (four_four_second_top || four_four_second_bot))
                       || (metronome_state[1] == 1 && four_four_second_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_first_top || four_four_first_bot || four_four_second_top || four_four_second_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
               4: begin
                   if ((metronome_state[0] == 0 && (four_four_first_top || four_four_first_bot))
                       || (metronome_state[0] == 1 && four_four_first_top)
                       || (metronome_state[1] == 0 && (four_four_second_top || four_four_second_bot))
                       || (metronome_state[1] == 1 && four_four_second_top)
                       || (metronome_state[3] == 0 && (four_four_fourth_top || four_four_fourth_bot))
                       || (metronome_state[3] == 1 && four_four_fourth_top)) begin
                       pixel_data <= BLACK;
                   end
                   else if (four_four_first_top || four_four_first_bot || four_four_second_top || four_four_second_bot || four_four_fourth_top || four_four_fourth_bot) begin
                       pixel_data <= METRONOME_OFF;
                   end
               end
           endcase
       end
       else if (stage == 6) begin
           if (four_four_fourth_top || four_four_fourth_bot) begin
               pixel_data <= WHITE;
           end
           
           if (note_counter < note_threshold && metronome_state[3] != 2) begin
               note_counter <= note_counter + 1;
               audio_out[10:0] <= 11'b1111_1111_111;
               if (metronome_state[3] == 1) begin
                   audio_out[11] <= clock_196hz;
               end
               else begin
                   audio_out[11] <= clock_440hz;
               end
           end
           else begin
               audio_out [11:0] <= 12'b0000_0000_0000;
           end
                       
           if ((metronome_state[0] == 0 && (four_four_first_top || four_four_first_bot))
               || (metronome_state[0] == 1 && four_four_first_top)
               || (metronome_state[1] == 0 && (four_four_second_top || four_four_second_bot))
               || (metronome_state[1] == 1 && four_four_second_top)
               || (metronome_state[2] == 0 && (four_four_third_top || four_four_third_bot))
               || (metronome_state[2] == 1 && four_four_third_top)) begin
               pixel_data <= BLACK;
           end
           else if (four_four_first_top || four_four_first_bot || four_four_second_top || four_four_second_bot || four_four_third_top || four_four_third_bot) begin
               pixel_data <= METRONOME_OFF;
           end
       end
       else if (stage == 7) begin
           if ((four_four_fourth_top || four_four_fourth_bot) && ~note) begin
               pixel_data <= YELLOW;
           end
           else if ((metronome_state[3] == 0 && (four_four_fourth_top || four_four_fourth_bot))
               || (metronome_state[3] == 1 && four_four_fourth_top)) begin
               pixel_data <= BLACK;
           end
           else if (four_four_fourth_top || four_four_fourth_bot) begin
               pixel_data <= METRONOME_OFF;
           end
           
           if (note_counter < note_threshold && metronome_state[3] != 2 && ~note) begin
               note_counter <= note_counter + 1;
               audio_out[10:0] <= 11'b1111_1111_111;
               if (metronome_state[3] == 1) begin
                   audio_out[11] <= clock_196hz;
               end
               else begin
                   audio_out[11] <= clock_440hz;
               end
           end
           else begin
               audio_out [11:0] <= 12'b0000_0000_0000;
           end
                       
           if ((metronome_state[0] == 0 && (four_four_first_top || four_four_first_bot))
               || (metronome_state[0] == 1 && four_four_first_top)
               || (metronome_state[1] == 0 && (four_four_second_top || four_four_second_bot))
               || (metronome_state[1] == 1 && four_four_second_top)
               || (metronome_state[2] == 0 && (four_four_third_top || four_four_third_bot))
               || (metronome_state[2] == 1 && four_four_third_top)) begin
               pixel_data <= BLACK;
           end
           else if (four_four_first_top || four_four_first_bot || four_four_second_top || four_four_second_bot || four_four_third_top || four_four_third_bot) begin
               pixel_data <= METRONOME_OFF;
           end
       end
       
       if (left_click == 0) begin
           oled_up <= 0;
           oled_down <= 0;
           play_reset <= 1;
           note_reset <= 1;
           metronome_state_reset <= 1;
       end
       
       if (prev_stage != stage) begin
           note_counter <= 0;
           prev_stage <= stage;
       end
   end
endmodule