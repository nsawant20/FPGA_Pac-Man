module  counter
(
		input Clk,
		output logic open_close
);

logic [27:0] counter;
logic [27:0] divisor = 25000000;


always_ff @ (posedge Clk) begin
	counter <= counter + 1;
	if(counter >= (divisor - 1))
		counter <= 0;
	else
		open_close <= (counter < divisor/2) ? 1'b1 : 1'b0;

end

endmodule

//Source: https://www.fpga4student.com/2017/08/verilog-code-for-clock-divider-on-fpga.html