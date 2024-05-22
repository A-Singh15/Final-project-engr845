interface intf;
    logic clock;
    logic reset;
    logic start;
    logic [7:0] video_frame_data;
    logic [7:0] control_signals;
    logic [3:0] motionX, motionY;
    logic [7:0] BestDist;
    logic completed;
endinterface
