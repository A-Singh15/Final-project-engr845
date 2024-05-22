class Environment;
    Generator gen;
    Driver drv;
    Monitor mon;
    Scoreboard sb;
    virtual intf vif;
    top dut; // Add the DUT instance

    function new(virtual intf vif);
        this.vif = vif;
        gen = new(vif);
        drv = new(vif);
        mon = new(vif);
        sb = new();
        dut = new();
    endfunction

    task run();
        fork
            gen.gen_task(); // Corrected task name
            drv.drive();
            mon.monitor();
        join_none
    endtask
endclass
