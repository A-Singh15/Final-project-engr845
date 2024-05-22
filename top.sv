module top (
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

    // Declare internal signals
    wire [15:0] S1S2mux, newDist, PEready;
    wire CompStart;
    wire [3:0] VectorX, VectorY;
    wire [127:0] Accumulate;
    wire [7:0] Rpipe;

    // Instantiate control, PEtotal, and Comparator
    control ctl_u (
        .clock(clock),
        .start(start),
        .S1S2mux(S1S2mux),
        .newDist(newDist),
        .CompStart(CompStart),
        .PEready(PEready),
        .VectorX(VectorX),
        .VectorY(VectorY),
        .AddressR(AddressR),
        .AddressS1(AddressS1),
        .AddressS2(AddressS2),
        .completed(completed)
    );

    PEtotal pe_u (
        .clock(clock),
        .R(R),
        .S1(S1),
        .S2(S2),
        .S1S2mux(S1S2mux),
        .newDist(newDist),
        .Accumulate(Accumulate)
    );

    Comparator comp_u (
        .clock(clock),
        .CompStart(CompStart),
        .Accumulate(Accumulate),
        .PEready(PEready),
        .VectorX(VectorX),
        .VectorY(VectorY),
        .BestDist(BestDist),
        .motionX(motionX),
        .motionY(motionY)
    );

    // Instantiate memories
    ROM_R memR_u (
        .clock(clock),
        .AddressR(AddressR),
        .R(R)
    );

    ROM_S memS_u (
        .clock(clock),
        .AddressS1(AddressS1),
        .AddressS2(AddressS2),
        .S1(S1),
        .S2(S2)
    );

endmodule
