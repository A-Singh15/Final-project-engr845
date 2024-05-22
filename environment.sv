class Environment;
    Generator gen;
    Driver drv;
    Monitor mon;
    Scoreboard sb;
    virtual intf vif;

    // Instantiate the DUT as a module
    top dut(
        .clock(vif.clock),
        .reset(vif.reset),
        .start(vif.start),
        .video_frame_data(vif.video_frame_data),
        .control_signals(vif.control_signals),
        .motionX(vif.motionX),
        .motionY(vif.motionY),
        .BestDist(vif.BestDist),
        .completed(vif.completed),
        .AddressR(vif.AddressR),
        .AddressS1(vif.AddressS1),
        .AddressS2(vif.AddressS2),
        .R(vif.R),
        .S1(vif.S1),
        .S2(vif.S2)
    );

    function new(virtual intf vif);
        this.vif = vif;
        gen = new(vif);
        drv = new(vif);
        mon = new(vif);
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
