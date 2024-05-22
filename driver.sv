class Driver;
    virtual intf vif;

    function new(virtual intf vif);
        this.vif = vif;
    endfunction

    task drive();
        vif.start = 0;
        #20;
        vif.start = 1;
        vif.clock = 0;
        forever begin
            #5 vif.clock = ~vif.clock;
        end
    endtask
endclass
