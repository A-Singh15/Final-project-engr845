// generator.sv
class Generator;
    virtual intf vif;

    function new(virtual intf vif);
        this.vif = vif;
    endfunction

    task generate();
        Transaction tr = new();
        forever begin
            if (!$urandom_range(0, 5)) begin
                assert(tr.randomize()) else $fatal("Randomization failed");
                vif.video_frame_data = tr.video_frame_data;
                vif.control_signals = tr.control_signals;
                tr.display();
                #10;
            end
        end
    endtask
endclass
