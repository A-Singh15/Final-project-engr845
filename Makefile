# Makefile for compiling and running the SystemVerilog testbench

default: compile run

compile:
    vcs -sverilog -debug_all top.sv interface.sv transaction.sv generator.sv driver.sv monitor.sv scoreboard.sv environment.sv test.sv -o simv

run:
    ./simv
