module environment (
    input logic clock,
    input logic reset,
    input logic start,
    input logic [7:0] video_frame_data,
    input logic [7:0] control_signals,
    output logic [3:0] motionX,
    output logic [3:0] motionY,
    output logic [7:0] BestDist,
    output logic completed,
    output logic [7:0] AddressR,
    output logic [9:0] AddressS1,
    output logic [9:0] AddressS2,
    input logic [7:0] R,
    input logic [7:0] S1,
    input logic [7:0] S2
);

    // Declare the DUT (top module)
    top dut(
        .clock(clock),
        .reset(reset),
        .start(start),
        .video_frame_data(video_frame_data),
        .control_signals(control_signals),
        .motionX(motionX),
        .motionY(motionY),
        .BestDist(BestDist),
        .completed(completed),
        .AddressR(AddressR),
        .AddressS1(AddressS1),
        .AddressS2(AddressS2),
        .R(R),
        .S1(S1),
        .S2(S2)
    );

    // Instantiate the environment class
    Environment env;

    initial begin
        env = new(dut);
        env.run();
    end

endmodule

class Environment;
    Generator gen;
    Driver drv;
    Monitor mon;
    Scoreboard sb;
    top dut;

    function new(top dut);
        this.dut = dut;
        gen = new(dut);
        drv = new(dut);
        mon = new(dut);
        sb = new();
    endfunction

    task run();
        fork
            gen.gen_task(); // Corrected task name
            drv.drive();
            mon.monitor();
        join_none
    endtask
endclass
