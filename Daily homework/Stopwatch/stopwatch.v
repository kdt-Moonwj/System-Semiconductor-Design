`timescale 1ns / 1ps


module stopwatch (
    input clk,
    input rst,
    input sw,
    input btnL_Clear,
    input btnR_RunStop,
    output [7:0] fnd_data,
    output [3:0] fnd_com
);

    wire [6:0] w_msec;
    wire [5:0] w_sec;
    wire w_clear, w_runstop;
    wire [5:0] w_min;
    wire [4:0] w_hour;


    wire w_btnL_clear,w_btnR_run;

    fnd_controller U_FND (
        .clk     (clk),
        .reset   (rst),
        .sw      (sw),
        .msec    (w_msec),
        .sec     (w_sec),
        .min     (w_min),
        .hour    (w_hour),
        .fnd_data(fnd_data),
        .fnd_com (fnd_com)
    );


    stopwatch_dp U_Stopwatch_DP (
        .clk(clk),
        .rst(rst),
        .run_stop(w_runstop),
        .clear(w_clear),
        .msec(w_msec),
        .sec(w_sec),
        .min(w_min),
        .hour(w_hour)
    );
    stopwatch_controller U_StopWatch_CU (
        .clk(clk),
        .rst(rst),
        .i_clear(w_btnL_clear),
        .i_runstop(w_btnR_run),
        .o_clear(w_clear),
        .o_runstop(w_runstop)
    );

    btn_debounce U_BtnL_Clear (
        .clk  (clk),
        .rst  (rst),
        .i_btn(btnL_Clear),
        .o_btn(w_btnL_clear)
    );

    btn_debounce U_BtnR_Runstop (
        .clk  (clk),
        .rst  (rst),
        .i_btn(btnR_RunStop),
        .o_btn(w_btnR_run)
    );




endmodule


