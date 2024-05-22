interface intf();
    logic clock;
    logic reset;
    logic start;
    logic [7:0] video_frame_data;
    logic [7:0] control_signals;
    logic [3:0] motionX;
    logic [3:0] motionY;
    logic [7:0] BestDist;
    logic completed;
    logic [7:0] AddressR;
    logic [9:0] AddressS1;
    logic [9:0] AddressS2;
    logic [7:0] R;
    logic [7:0] S1;
    logic [7:0] S2;
endinterface
