`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input basys3_clock,
    input btnC, btnU, btnD, btnL, btnR,
    input [15:0] sw,
    output [7:0] JB,
    output reg [15:0] led = 0,
    output reg [3:0] an = 4'b1110,
    output reg [6:0] seg = 7'b1111111,
    inout PS2Clk, PS2Data
    );

    localparam RED = 16'b11111_000000_00000;
    localparam GREEN = 16'b00000_111111_00000;
    localparam BLUE = 16'b00000_000000_11111;
    localparam WHITE = 16'b11111_111111_11111;
    localparam BLACK = 16'b00000_000000_00000;

    localparam task_A = 4'b0000;
    localparam task_B = 4'b0001;
    localparam task_C = 4'b0010;
    localparam task_D = 4'b0011;
    localparam task_G = 4'b0100;

    // Individual C - Mouse control
    wire [15:0] task_C_pixel_data;
    
    // Individual D - OLED display
    wire [15:0] task_D_pixel_data;

    // Common Mouse control
    wire[11:0] mouse_x, mouse_y;
    wire[3:0] mouse_z;
    wire [3:0] cursor_size;
    wire mouse_event, middle_click, left_click, right_click;

    // Common OLED display
    reg [15:0] pixel_data;
    wire [12:0] pixel_index;
    wire[6:0] pixel_x, pixel_y, cursor_x, cursor_y, diff_x, diff_y;
    wire frame_begin, sending_pixels, sample_pixel, freq_6p25;
    reg reset_signal;

    // Others
    wire [4:0] stage;
    reg [4:0] curr_task;

    clock_divider clk10Hz(basys3_clock,10, clk_10Hz);
    clock_divider clk20kHz(basys3_clock,20_000, clk_20kHz);
    clock_divider clk190Hz(basys3_clock,190, clk_190Hz);
    clock_divider clk380Hz(basys3_clock,380, clk_380Hz);
    clock_divider clk6p25m(basys3_clock,6_250_000, freq_6p25);

    // Stage selector
    stage_selector stage_select(sw,stage);

    // Individual C - Mouse control
    individual_c mouse_control_c(
        .clock_6p25mhz(freq_6p25),
        .middle_click(middle_click),
        .diff_x(diff_x),
        .diff_y(diff_y),
        .cursor_size(cursor_size),
        .pixel_data(task_C_pixel_data)
    );

    // Individual D - OLED display
    individual_d oled_display_d(
        .sw(sw), 
        .curr_task(curr_task), 
        .pixel_index(pixel_index),
        .pixel_data(task_D_pixel_data)
    );

    // Common OLED display    
    Oled_Display oled(
        .clk(freq_6p25),
        .reset(0),
        .frame_begin(frame_begin),
        .sending_pixels(sending_pixels),
        .sample_pixel(sample_pixel),
        .pixel_index(pixel_index),
        .pixel_data(pixel_data),
        .cs(JB[0]),
        .sdin(JB[1]),
        .sclk(JB[3]),
        .d_cn(JB[4]),
        .resn(JB[5]),
        .vccen(JB[6]),
        .pmoden(JB[7])
    );

    // Common Mouse control
    MouseCtl mouse(
        .clk(basys3_clock),
        .rst(0),
        .xpos(mouse_x),
        .ypos(mouse_y),
        .zpos(mouse_z),
        .left(left_click),
        .middle(middle_click),
        .right(right_click),
        .new_event(mouse_event),
        .value(0),
        .setx(0),
        .sety(0),
        .setmax_x(0),
        .setmax_y(0),
        .ps2_clk(PS2Clk),
        .ps2_data(PS2Data)
    );

    // Common mouse to OLED scaling
    oled_scaling cursor_control(
        .pixel_index(pixel_index), 
        .mouse_xpos(mouse_x), .mouse_ypos(mouse_y),
        .pixel_x(pixel_x), 
        .pixel_y(pixel_y), 
        .cursor_x(cursor_x), 
        .cursor_y(cursor_y), 
        .cursor_size(cursor_size),
        .diff_x(diff_x), 
        .diff_y(diff_y)
    );

    always @ (*) begin
        case (stage)
            0 : curr_task = task_A;
            1 : curr_task = task_B;
            2 : curr_task = task_C;
            3 : curr_task = task_D;
            4 : curr_task = task_G;
        endcase

        // Control OLED display based on current task
        case (curr_task)
            task_A : pixel_data = BLUE;
            task_B : pixel_data = GREEN;
            task_C : pixel_data = task_C_pixel_data;
            task_D : pixel_data = task_D_pixel_data;
            task_G : pixel_data = WHITE;
        endcase

        case (curr_task)
            task_C : begin
                        led[15] = left_click;
                        led[13] = right_click;
                    end
        endcase
    end
endmodule