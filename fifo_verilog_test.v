module fifo_verilog_test;

	// Inputs
	reg clk;
	reg reset;
	reg write_enb;
	reg read_enb;
	reg [7:0] datain;

	// Outputs
	wire empty;
	wire full;
	wire [7:0] dataout;

	// Instantiate the Unit Under Test (UUT)
	fifo_verilog uut (
		.clk(clk), 
		.reset(reset), 
		.write_enb(write_enb), 
		.read_enb(read_enb), 
		.full(full),
		.empty(empty),
		.datain(datain), 
		.dataout(dataout)
	);
	
	always
	begin
	clk=1'b1;
	#10;
	clk=1'b0;
	#10;
	end
	
	initial
	begin
	reset=1'b1;
	datain<=8'd3;
	write_enb=1'b1;
	@(negedge clk)
	@(negedge clk)
	
	//@(negedge clk)
	reset=1'b0;
	//@(negedge clk)
	write_enb=1'b1;
	//2nd byte writing
	@(negedge clk)
	write_enb=1'b1;
	datain<=8'd3;
	//3rd byte writing
	@(negedge clk)
	write_enb=1'b1;
	datain<=8'd3;
	//4th byte writing
	@(negedge clk)
	write_enb=1'b1;
	datain<=8'd3;
	//5th byte writing
	@(negedge clk)
	write_enb=1'b1;
	datain<=8'd3;
	//6th byte writing
	@(negedge clk)
	write_enb=1'b1;
	datain<=8'd3;
	
	// reading the data 
	@(negedge clk)
	@(negedge clk)
	read_enb=1'b1;
	@(negedge clk)
	@(negedge clk)
	#10;
	$finish;
	end
endmodule
