module test;
    intf intf0();
    Environment env;

    initial begin
        env = new(intf0);
        env.run();
        #1000 $finish;
    end
endmodule
