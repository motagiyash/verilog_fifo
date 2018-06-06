module fifo_verilog(clk,reset,write_enb,read_enb,full,empty,datain,dataout);

input clk,reset,write_enb,read_enb;
output full,empty;
input [7:0]datain;
output reg [7:0]dataout;

reg [7:0]fifo[31:0];
reg [5:0]read_ptr,write_ptr;
integer i;
//full and empty assignments
assign full = ((read_ptr[5]!=write_ptr[5]) && (read_ptr[4:0]==write_ptr[4:0]))?1'b1:1'b0;
assign empty = (write_ptr[5:0]==read_ptr[5:0])?1'b1:1'b0;


//write block
always@(posedge clk)
begin
	if(reset)
		begin
			for(i=0;i<32;i=i+1)
				fifo[i]<=8'd0;
		end
	else
		begin
			if(write_enb && ~full)
				fifo[write_ptr[4:0]]<=datain;
		end
end

//read block
always@(posedge clk)
begin
	if(reset)
		dataout<=8'd0;
	else
		begin
			if(read_enb && ~empty)
					dataout<=fifo[read_ptr[4:0]];
		end
end

//Pointer updating always block
always@(posedge clk)
begin
	if(reset)
		begin
		write_ptr<=6'b000000;
		read_ptr<=6'b000000;
		end
	else 
		begin
			if(write_enb && ~full)
				write_ptr<=write_ptr+1;
			if (read_enb && ~empty)
				read_ptr<=read_enb+1;
		end
end




endmodule
