// scoreboard.sv
class Scoreboard;
    function void compare(logic [3:0] exp_motionX, logic [3:0] exp_motionY, logic [7:0] exp_BestDist, logic [3:0] motionX, logic [3:0] motionY, logic [7:0] BestDist);
        if (motionX != exp_motionX || motionY != exp_motionY || BestDist != exp_BestDist) begin
            $display("Mismatch: Expected (motionX: %0d, motionY: %0d, BestDist: %0d), Got (motionX: %0d, motionY: %0d, BestDist: %0d)", exp_motionX, exp_motionY, exp_BestDist, motionX, motionY, BestDist);
        end else begin
            $display("Match: (motionX: %0d, motionY: %0d, BestDist: %0d)", motionX, motionY, BestDist);
        end
    endfunction
endclass
