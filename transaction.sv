class Transaction;
    rand bit [7:0] video_frame_data;
    rand bit [7:0] control_signals;

    function void display();
        $display("Transaction: video_frame_data=%0d, control_signals=%0d", video_frame_data, control_signals);
    endfunction
endclass
