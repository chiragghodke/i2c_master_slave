`timescale 1000ns / 1ps

module i2c_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [6:0] addr;
	reg [7:0] data_in;
	reg enable;
	reg rw;

	// Outputs
	wire [7:0] data_out;
	wire ready;

	// Bidirs
	wire i2c_sda;
	wire i2c_scl;

	// Instantiate the Unit Under Test (UUT)
	i2c_controller master (
		.clk(clk), 
		.rst(rst), 
		.addr(addr), 
		.data_in(data_in), 
		.enable(enable), 
		.rw(rw), 
		.data_out(data_out), 
		.ready(ready), 
		.i2c_sda(i2c_sda), 
		.i2c_scl(i2c_scl)
	);
	
		
	i2c_slave_controller slave (
    .sda(i2c_sda), 
    .scl(i2c_scl)
    );
	
	initial begin
		clk = 0;
		forever begin
			clk = #1 ~clk;
		end		
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 0;		
		addr = 7'b0101010;
		data_in = 8'b10101010;
		//write operation
		rw = 0;
			
		enable = 1;
		#10;
		enable = 0;
		#1000;
		enable = 1;
		//read operation
		rw = 1;
		
		#10;
		enable = 0;
		#200;
		addr = 7'b1010101;
		data_in = 8'b01010101;
		rw = 0;
		enable = 1;
		#10;
		enable = 0;
		#1000;
		enable = 1;
		rw = 1;
		#10;
		enable = 0;
				
		#500
		$finish;
		
	end      
endmodule
