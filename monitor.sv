// monitor.sv
class Monitor;
    virtual intf vif;

    function new(virtual intf vif);
        this.vif = vif;
    endfunction

    task monitor();
        forever begin
            @(posedge vif.clock);
            $display("Time: %0t, motionX: %0d, motionY: %0d, BestDist: %0d", $time, vif.motionX, vif.motionY, vif.BestDist);
        end
    endtask
endclass
