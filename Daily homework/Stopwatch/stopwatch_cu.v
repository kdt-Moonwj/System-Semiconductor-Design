`timescale 1ns / 1ps


module stopwatch_controller (
    input clk,
    input rst,
    input i_clear,
    input i_runstop,
    output reg o_clear,
    output reg o_runstop
);

    parameter STOP = 2'b00, RUN = 2'b01, CLEAR = 2'b10;

    reg [1:0] c_state, n_state;

    // output logic 에서 assign 형태와 case문은 결과에 차이가 없음음
    //assign o_clear = (c_state==CLEAR)? 1:0;           //assign 형태는 신호가 적고 단순할 때 작성함
    //assign o_runstop = (c_state == RUN)? 1:0;


    // SL state resister
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            c_state <= STOP;
        end else begin
            c_state <= n_state;
        end
    end

    always @(*) begin
        n_state = c_state;
        case (c_state)
            STOP: begin
                if (i_runstop == 1) begin
                    n_state = RUN;
                end else if (i_clear == 1) begin
                    n_state = CLEAR;
                end else n_state = c_state;
            end
            RUN: begin
                if (i_runstop == 1) begin
                    n_state = STOP;
                end
            end
            CLEAR: begin
                if (i_clear == 1) begin
                    n_state = STOP;
                end
            end
        endcase
    end


    //case문은 신호가 많거나 동시에 여러 출력 신호에 대해 할당이 필요한 경우 사용
    // 직관적으로 이해하는 것과 유지보수에 유리함.
    always @(*) begin
        o_clear   = 0;
        o_runstop = 0;
        case (c_state)
            STOP: begin
                o_clear   = 0;
                o_runstop = 0;
            end
            RUN : begin
                o_clear   = 0;
                o_runstop = 1;
            end
            CLEAR : begin
                o_clear   = 1;
                o_runstop = 0;
            end
        endcase
    end



endmodule
 