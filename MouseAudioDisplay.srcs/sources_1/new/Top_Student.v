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
    input J_MIC_PIN3,
    input btnC, btnU, btnD, btnL, btnR,
    input [15:0] sw,
    output J_MIC_PIN1, J_MIC_PIN4,
    output [7:0] JB,
    output [3:0] JXADC,
    output reg [15:0] led = 0,
    output reg dp = 1,
    output reg [3:0] an = 4'b1111,
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
    localparam menu = 4'b1111;

    // Clk signals
    wire clk_20kHz;
    wire clk_190Hz;
    wire clk_380Hz;
    wire clock_6p25mhz;

    // Btn debounced
    wire btnC_debounce;
    wire btnU_debounce;
    wire btnD_debounce;
    wire btnL_debounce;
    wire btnR_debounce;
    wire left_click_debounce;
    wire right_click_debounce;

    // Individual A - Audio input
    wire [11:0] task_A_led;
    wire task_A_an;
    wire [6:0] task_A_seg;
    
    // Individual B - Audio output
    wire [11:0] task_B_audio_out;

    // Individual C - Mouse control
    wire [3:0] task_C_cursor_size;
    wire [15:0] task_C_pixel_data;
    
    // Individual D - OLED display
    wire [15:0] task_D_pixel_data;

    // Group task
    wire [15:0] task_G_pixel_data;
    wire [11:0] task_G_led;
    wire [3:0] task_G_an;
    wire [6:0] task_G_seg;
    wire valid_number;
    wire [3:0] task_G_cursor_size;
    wire task_G_dp;

    // Startup menu display
    wire [15:0] startup_menu_pixel_data;

    // Common Mouse control
    wire[11:0] mouse_x, mouse_y;
    wire[3:0] mouse_z;
    reg [3:0] cursor_size;
    wire mouse_event, middle_click, left_click, right_click;

    // Common OLED display
    reg [15:0] pixel_data;
    wire [12:0] pixel_index;
    wire[6:0] pixel_x, pixel_y, cursor_x, cursor_y, diff_x, diff_y;
    wire frame_begin, sending_pixels, sample_pixel;
    reg reset_signal;

    // Common Audio input
    wire [11:0] curr_Audio;

    // Common audio output
    reg [11:0] audio_out;

    // Others
    wire [3:0] stage;
    reg [3:0] curr_task = 0;

    clock_divider clk20kHz(basys3_clock,20_000, clk_20kHz);
    clock_divider clk190Hz(basys3_clock,190, clk_190Hz);
    clock_divider clk380Hz(basys3_clock,380, clk_380Hz);
    clock_divider clk6p25m(basys3_clock,6_250_000, clock_6p25mhz);

    // Stage selector
    stage_selector stage_select(sw,stage);

    // Debouncer for btns
    debouncer btnC_debouncer(basys3_clock, btnC, btnC_debounce);
    debouncer btnU_debouncer(basys3_clock, btnU, btnU_debounce);
    debouncer btnD_debouncer(basys3_clock, btnD, btnD_debounce);
    debouncer btnL_debouncer(basys3_clock, btnL, btnL_debounce);
    debouncer btnR_debouncer(basys3_clock, btnR, btnR_debounce);
    debouncer left_click_debouncer(basys3_clock, left_click, left_click_debounce);
    debouncer right_click_debouncer(basys3_clock, right_click, right_click_debounce);

    // Individual A - Audio input
    individual_a audio_input_a(
        .clk_20kHz(clk_20kHz),
        .curr_Audio(curr_Audio),
        .led(task_A_led),
        .an(task_A_an),
        .seg(task_A_seg)
    );

    // Individual B - Audio output
    individual_b audio_output_b(
        .basys3_clock(basys3_clock),
        .clk_190Hz(clk_190Hz),
        .clk_380Hz(clk_380Hz),
        .btnC_debounce(btnC_debounce),
        .sw(sw[0]),
        .audio_out(task_B_audio_out)
    );

    // Individual C - Mouse control
    individual_c mouse_control_c(
        .clock_6p25mhz(clock_6p25mhz),
        .middle_click(middle_click),
        .diff_x(diff_x),
        .diff_y(diff_y),
        .cursor_size(task_C_cursor_size),
        .pixel_data(task_C_pixel_data)
    );

    // Individual D - OLED display
    individual_d oled_display_d(
        .sw(sw), 
        .pixel_index(pixel_index),
        .pixel_data(task_D_pixel_data)
    );

    // Group task
    group_g group_task_g(
        .sw(sw),
        .pixel_index(pixel_index),
        .left_click(left_click_debounce),
        .right_click(right_click_debounce),
        .diff_x(diff_x),
        .diff_y(diff_y),
        .cursor_size(task_G_cursor_size),
        .pixel_data(task_G_pixel_data),
        .led(task_G_led),
        .an(task_G_an),
        .seg(task_G_seg),
        .dp(task_G_dp),
        .valid_number(valid_number)
    );
 
    // Startup menu display
    start_menu startup_menu_display(
        .basys3_clock(basys3_clock),
        .pixel_index(pixel_index),
        .pixel_data(startup_menu_pixel_data)
    );

    // Common OLED display    
    Oled_Display oled(
        .clk(clock_6p25mhz),
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

    // Common audio input
    Audio_Input my_Audio_Input(
        .CLK(basys3_clock),        // 100MHz clock
        .cs(clk_20kHz),            // sampling clock, 20kHz
        .MISO(J_MIC_PIN3),         // J_MIC3_Pin3, serial mic input
        .clk_samp(J_MIC_PIN1),     // J_MIC3_Pin1
        .sclk(J_MIC_PIN4),         // J_MIC3_Pin4, MIC3 serial clock
        .sample(curr_Audio)
    );

    // Common audio output
    Audio_Output speaker(
        .CLK(basys3_clock), 
        .START(clk_20kHz), 
        .DATA1(audio_out), 
        .RST(1'b0), 
        .nSYNC(JXADC[0]), 
        .D1(JXADC[1]),
        .D2(JXADC[2]), 
        .CLK_OUT(JXADC[3]), 
        .DATA2()
    );

    always @ (*) begin
        case (stage)
            4'b1111 : curr_task = menu;
            4'b0001 : curr_task = task_A;
            4'b0010 : curr_task = task_B;
            4'b0011 : curr_task = task_C;
            4'b0100 : curr_task = task_D;
            4'b0101 : curr_task = task_G;
        endcase

        // Control OLED display based on current task
        case (curr_task)
            menu : pixel_data = startup_menu_pixel_data;
            task_C : pixel_data = task_C_pixel_data;
            task_D : pixel_data = task_D_pixel_data;
            task_G : pixel_data = task_G_pixel_data;
        default : pixel_data = BLACK;
        endcase

        // Control LEDs based on current task
        case (curr_task)
            menu : led[15:0] = 16'b0000000000000000;
            task_A: begin
                        led[11:0] = task_A_led;
                        led[15:12] = 4'b0000;
                    end
            task_C : begin
                        led[15] = left_click;
                        led[13] = right_click;
                        led[14] = 0;
                        led[12:0] = 13'b0000000000000;
                    end
            task_G : begin
                        led[15] = valid_number;
                        led[11:0] = task_A_led;
                        led[14:12] = 3'b000;

                    end
        default : led[15:0] = 16'b0000000000000000;
        endcase

        // Control 7-segment display based on current task
        case (curr_task)
            menu : begin
                an = 4'b1111;
                seg = 7'b1111111;
                dp = 1'b1;
            end

            task_A : begin
                an[0] = task_A_an;
                an[3:1] = 3'b111;
            end

            task_G : begin
                an = task_G_an;
                seg = task_G_seg;
                dp = task_G_dp;
            end

        default : begin
            an = 4'b1111;
            seg = 7'b1111111;
            dp = 1'b1;
            end
        endcase

        // Control audio output based on current task
        case (curr_task)
            task_B : audio_out = task_B_audio_out;
        default : audio_out = 0;
        endcase

        // Control cursor size based on current task
        case (curr_task)
            task_C : cursor_size = task_C_cursor_size;
            task_G : cursor_size = task_G_cursor_size;
        endcase
    end
endmodule