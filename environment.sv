// environment.sv
class Environment;
    Generator gen;
    Driver drv;
    Monitor mon;
    Scoreboard sb;
    virtual intf vif;

    function new(virtual intf vif);
        this.vif = vif;
        gen = new(vif);
        drv = new(vif);
        mon = new(vif);
        sb = new();
    endfunction

    task run();
        fork
            gen.gen_task(); // Call the updated task name
            drv.drive();
            mon.monitor();
        join_none
    endtask
endclass
