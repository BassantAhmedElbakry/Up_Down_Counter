module Up_Down_Count(
    input clk,
    input [4:0] in, 
    input load, down, up,
    output reg [4:0] counter,
    output wire low, high
);

reg [4:0] value; 

always @(*) begin
    if (load) begin
        value = in;
    end
    else if (down && !low) begin
        value = counter - 5'b00001;
    end
    else if (up && !high) begin
        value = counter + 5'b00001;
    end
    else begin
        value = counter ;
    end    
end

always @(posedge clk ) begin
    counter <= value ;
end

assign low  = (counter == 5'b00000);
assign high = (counter == 5'b11111);

endmodule
