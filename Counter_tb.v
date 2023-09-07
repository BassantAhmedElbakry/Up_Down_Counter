`timescale 1ns/1ns

module Up_Down_Count_tb();

// Design TB signals
reg [4:0] in_tb;
reg clk_tb;
reg load_tb, down_tb, up_tb;
wire [4:0] counter_tb;
wire low_tb, high_tb;

// Instantiate module
Up_Down_Count my_count
(.in(in_tb),
 .clk(clk_tb),
 .load(load_tb),
 .down(down_tb),
 .up(up_tb),
 .counter(counter_tb),
 .low(low_tb),
 .high(high_tb)
);

// Generate clock
always #5 clk_tb = ~clk_tb ;

initial begin

    $dumpfile ("Up_Down_Count.vcd");
    $dumpvars;

    // Initial values
    in_tb = 5'b00111;
    load_tb = 1'b0;
    down_tb = 1'b0;
    up_tb = 1'b0;
    clk_tb = 1'b0;

    // TEST 1 --> counter = in value when load signal is high.
    #10 load_tb = 5'b00001;

    #10 if(counter_tb == 5'b111) begin
        $display ("TEST 1 IS PASSED");
    end 
    else begin
        $display ("TEST 1 IS FAILED");
    end

    //TEST 2 --> counter = counter - 1 ,when load = 0 and down = 1
    load_tb = 1'b0;
    down_tb = 1'b1;

    #10 if(counter_tb == 5'b110) begin
        $display ("TEST 2 IS PASSED");
    end 
    else begin
        $display ("TEST 2 IS FAILED");
    end

    //TEST 3 --> counter = counter + 1 ,when load & down are equal 0 and up = 1 
    down_tb = 1'b0;
    up_tb = 1'b1;

    #10 if(counter_tb == 5'b111) begin
        $display ("TEST 3 IS PASSED");
    end 
    else begin
        $display ("TEST 3 IS FAILED");
    end

    //TEST 4 --> Priority between down and up signals
     down_tb = 1'b1;

     #10 if(counter_tb == 5'b110) begin
        $display ("TEST 4 IS PASSED");
    end 
    else begin
        $display ("TEST 4 IS FAILED");
    end

    //TEST 5 --> Signal low is active when counter = 0 
    up_tb = 1'b0;

    #70 if(counter_tb == 5'b0 && low_tb) begin
        $display ("TEST 5 IS PASSED");
    end 
    else begin
        $display ("TEST 5 IS FAILED");
    end

    //TEST 6 --> Signal high is active when counter = 31
    down_tb = 5'b0;
    up_tb = 5'b1;

    #320 if(counter_tb == 5'b11111 && high_tb) begin
        $display ("TEST 6 IS PASSED");
    end 
    else begin
        $display ("TEST 6 IS FAILED");
    end
    
$finish;

end

endmodule
