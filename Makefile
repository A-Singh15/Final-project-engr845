# Makefile for compiling and running the SystemVerilog testbench

default: compile run

compile:
    vcs -sverilog -debug_all \
        top.sv \
        interface.sv \
        transaction.sv \
        generator.sv \
        driver.sv \
        monitor.sv \
        scoreboard.sv \
        environment.sv \
        test.sv \
        -o simv

run:
    ./simv

clean:
    rm -rf simv* csrc* ucli.key vc_hdrs.h *.vpd *.vcd DVEfiles AN.DB

help:
    @echo "Usage:"
    @echo "  make        - compile and run the simulation"
    @echo "  make clean  - remove all generated files"
    @echo "  make help   - display this help message"
