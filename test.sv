module test;
    intf intf0();
    Environment env;

    // Internal signals for testbench
    reg [7:0] Rmem[0:255]; 
    reg [7:0] Smem[0:1023];
    integer Expected_motionX, Expected_motionY;
    integer i;
    integer signed x, y;

    // Instantiate the DUT (top module)
    top dut (
        .clock(intf0.clock),
        .reset(intf0.reset),
        .start(intf0.start),
        .video_frame_data(intf0.video_frame_data),
        .control_signals(intf0.control_signals),
        .motionX(intf0.motionX),
        .motionY(intf0.motionY),
        .BestDist(intf0.BestDist),
        .completed(intf0.completed),
        .AddressR(intf0.AddressR),
        .AddressS1(intf0.AddressS1),
        .AddressS2(intf0.AddressS2),
        .R(intf0.R),
        .S1(intf0.S1),
        .S2(intf0.S2)
    );

    initial begin
        env = new(intf0);
        env.run();

        // Initialize memories and other signals
        $vcdpluson;
        // First setup up to monitor all inputs and outputs
        $monitor("time=%5d ns, clock=%b, start=%b, BestDist=%b, motionX=%d, motionY=%d, count=%d", 
                 $time, intf0.clock, intf0.start, intf0.BestDist, intf0.motionX, intf0.motionY, dut.ctl_u.count[12:0]);

        // Randomize Smem
        foreach (Smem[i]) begin
            Smem[i] = $urandom_range(0, 255);
        end

        // Randomize expected motionX and motionY
        Expected_motionX = $urandom_range(0, 15) - 8;    
        Expected_motionY = $urandom_range(0, 15) - 8;

        // Extract Rmem from Smem for Expected_motionX and Expected_motionY
        foreach (Rmem[i]) begin
            Rmem[i] = Smem[32*8 + 8 + (((i/16) + Expected_motionY)*32) + ((i%16) + Expected_motionX)];
        end

        // Initialize memories
        foreach (Rmem[i]) begin
            dut.memR_u.Rmem[i] = Rmem[i];
        end
        foreach (Smem[i]) begin
            dut.memS_u.Smem[i] = Smem[i];
        end

        // Initialize all registers
        // $readmemh("ref.txt", dut.memR_u.Rmem);
        // $readmemh("search.txt", dut.memS_u.Smem);
        intf0.clock = 1'b0;
        intf0.start = 1'b0;

        @(posedge intf0.clock); #10;
        intf0.start = 1'b1;

        for (i = 0; i < 4112; i = i + 1) begin
            if (dut.comp_u.newBest == 1'b1) begin
                $display("New Result Coming!");
            end
            @(posedge intf0.clock); #10;
        end

        intf0.start = 1'b0;

        @(posedge intf0.clock); #10;

        if (intf0.motionX >= 8)
            x = intf0.motionX - 16;
        else
            x = intf0.motionX;

        if (intf0.motionY >= 8)
            y = intf0.motionY - 16;
        else
            y = intf0.motionY;

        // Print memory content
        $display("Reference Memory content:");
        foreach (Rmem[i]) begin
            if (i % 16 == 0) $display("  ");
            $write("%h  ", Rmem[i]);
            if (i == 255) $display("  ");
        end

        $display("Search Memory content:");
        foreach (Smem[i]) begin
            if (i % 32 == 0) $display("  ");
            $write("%h  ", Smem[i]);
            if (i == 1023) $display("  ");
        end

        // Print test results
        if (intf0.BestDist == 8'b11111111)
            $display("Reference Memory Not Found in the Search Window!");
        else begin
            if (intf0.BestDist == 8'b00000000)
                $display("Perfect Match Found for Reference Memory in the Search Window: BestDist = %d, motionX = %d , motionY = %d, Expected motionX = %d , Expected motionY = %d", intf0.BestDist, x, y, Expected_motionX, Expected_motionY);
            else
                $display("Non-perfect Match Found for Reference Memory in the Search Window: BestDist = %d, motionX = %d , motionY = %d, Expected motionX = %d , Expected motionY = %d", intf0.BestDist, x, y, Expected_motionX, Expected_motionY);
        end

        if (x == Expected_motionX && y == Expected_motionY) begin
            $display("DUT motion outputs match expected motions: DUT motionX = %d DUT motionY = %d Expected_motionX = %d Expected_motionY = %d", x, y, Expected_motionX, Expected_motionY);
        end else begin
            $display("DUT motion outputs DO NOT match expected motions: DUT motionX = %d DUT motionY = %d Expected_motionX = %d Expected_motionY = %d", x, y, Expected_motionX, Expected_motionY);
        end

        $display("All tests completed\n\n");

        $finish;
    end

    // This is to create a dump file for offline viewing.
    initial begin
        $dumpfile("top.dump");
        $dumpvars(0, test);
    end 

endmodule
