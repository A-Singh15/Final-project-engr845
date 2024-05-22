// interface.sv
interface intf;
    logic clock;
    logic start;
    logic [7:0] video_frame_data;
    logic [7:0] control_signals;
    logic [3:0] motionX, motionY;
    logic [7:0] BestDist;
    logic completed;
    logic [7:0] AddressR;
    logic [9:0] AddressS1, AddressS2;
    logic [7:0] R;
    logic [7:0] S1;
    logic [7:0] S2;
endinterface
