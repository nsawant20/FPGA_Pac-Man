/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frameRAMpacOR
(
		input [4:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:255];
logic [4:0] data_Out_Pallete;

initial
begin
	 $readmemh("sprites/pacman_openR.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	 data_Out_Pallete<= mem[read_address];
	 case(data_Out_Pallete)
		5'b00000: 
			data_Out = 24'h000000;
		5'b00001: 
			data_Out = 24'hFFFB01;	
		default:
			data_Out = 24'h000000;
	 endcase
end

endmodule

module  frameRAMpacCR
(
		input [4:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:255];
logic [4:0] data_Out_Pallete;

initial
begin
	 $readmemh("sprites/pacman_closeR.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	 data_Out_Pallete<= mem[read_address];
	 case(data_Out_Pallete)
		5'b00000: 
			data_Out = 24'h000000;
		5'b00001: 
			data_Out = 24'hFFFB01;	
		default:
			data_Out = 24'h000000;
	 endcase
end

endmodule

module  frameRAMpacOL
(
		input [4:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:255];
logic [4:0] data_Out_Pallete;

initial
begin
	 $readmemh("sprites/pacman_openL.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	 data_Out_Pallete<= mem[read_address];
	 case(data_Out_Pallete)
		5'b00000: 
			data_Out = 24'h000000;
		5'b00001: 
			data_Out = 24'hFFFB01;	
		default:
			data_Out = 24'h000000;
	 endcase
end

endmodule

module  frameRAMpacCL
(
		input [4:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:255];
logic [4:0] data_Out_Pallete;

initial
begin
	 $readmemh("sprites/pacman_closeL.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	 data_Out_Pallete<= mem[read_address];
	 case(data_Out_Pallete)
		5'b00000: 
			data_Out = 24'h000000;
		5'b00001: 
			data_Out = 24'hFFFB01;	
		default:
			data_Out = 24'h000000;
	 endcase
end

endmodule


module  frameRAMpacOU
(
		input [4:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:255];
logic [4:0] data_Out_Pallete;

initial
begin
	 $readmemh("sprites/pacman_openU.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	 data_Out_Pallete<= mem[read_address];
	 case(data_Out_Pallete)
		5'b00000: 
			data_Out = 24'h000000;
		5'b00001: 
			data_Out = 24'hFFFB01;	
		default:
			data_Out = 24'h000000;
	 endcase
end

endmodule

module  frameRAMpacCU
(
		input [4:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:255];
logic [4:0] data_Out_Pallete;

initial
begin
	 $readmemh("sprites/pacman_closeU.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	 data_Out_Pallete<= mem[read_address];
	 case(data_Out_Pallete)
		5'b00000: 
			data_Out = 24'h000000;
		5'b00001: 
			data_Out = 24'hFFFB01;	
		default:
			data_Out = 24'h000000;
	 endcase
end

endmodule

module  frameRAMpacOD
(
		input [4:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:255];
logic [4:0] data_Out_Pallete;

initial
begin
	 $readmemh("sprites/pacman_openD.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	 data_Out_Pallete<= mem[read_address];
	 case(data_Out_Pallete)
		5'b00000: 
			data_Out = 24'h000000;
		5'b00001: 
			data_Out = 24'hFFFB01;	
		default:
			data_Out = 24'h000000;
	 endcase
end

endmodule

module  frameRAMpacCD
(
		input [4:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:255];
logic [4:0] data_Out_Pallete;

initial
begin
	 $readmemh("sprites/pacman_closeD.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	 data_Out_Pallete<= mem[read_address];
	 case(data_Out_Pallete)
		5'b00000: 
			data_Out = 24'h000000;
		5'b00001: 
			data_Out = 24'hFFFB01;	
		default:
			data_Out = 24'h000000;
	 endcase
end

endmodule





module  frameRAMbac
(
		input [4:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [4:0] mem [0:86799];
logic [4:0] data_Out_Pallete;

initial
begin
	 $readmemh("sprites/boardDotsResized.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out_Pallete<= mem[read_address];
	 case(data_Out_Pallete)
		5'b00000: 
			data_Out = 24'h000000;
		5'b00001: 
			data_Out = 24'hFFB7FF;
      5'b00010:
			data_Out = 24'h2033FF;	
		5'b00011:
			data_Out = 24'hFFB7AE;		
		default:
			data_Out = 24'h000000;
	 endcase
end

endmodule




module  frameRAMrghost
(
		input [4:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:255];
logic [4:0] data_Out_Pallete;

initial
begin
	 $readmemh("sprites/rghost16x16.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out_Pallete<= mem[read_address];
	 case(data_Out_Pallete)
		5'b00000: 
			data_Out = 24'h000000;
		5'b00001: 
			data_Out = 24'hDEDEFF;
      5'b00010:
			data_Out = 24'hFF2500;		
		5'b00011:
			data_Out = 24'h2033FF;
		default:
			data_Out = 24'h000000;
	 endcase
end

endmodule





module  frameRAMbghost
(
		input [4:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:255];
logic [23:0] data_Out_Pallete;

initial
begin
	 $readmemh("sprites/bghost16x16.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
data_Out_Pallete<= mem[read_address];
	 case(data_Out_Pallete)
		5'b00000: 
			data_Out = 24'h000000;
		5'b00001: 
			data_Out = 24'hDEDEFF;
      5'b00010:
			data_Out = 24'h02FDFF;		
		5'b00011:
			data_Out = 24'h2033FF;
		default:
			data_Out = 24'h000000;
	 endcase
end
endmodule





module  frameRAMoghost
(
		input [4:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:255];
logic [4:0] data_Out_Pallete;

initial
begin
	 $readmemh("sprites/oghost16x16.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out_Pallete<= mem[read_address];
	 case(data_Out_Pallete)
		5'b00000: 
			data_Out = 24'h000000;
		5'b00001: 
			data_Out = 24'hDEDEFF;
      5'b00010:
			data_Out = 24'hFFB751;		
		5'b00011:
			data_Out = 24'h2033FF;
		default:
			data_Out = 24'h000000;
	 endcase
end

endmodule







module  frameRAMpghost
(
		input [4:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:255];
logic [4:0] data_Out_Pallete;

initial
begin
	 $readmemh("sprites/pghost16x16.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out_Pallete<= mem[read_address];
	 case(data_Out_Pallete)
		5'b00000: 
			data_Out = 24'h000000;
		5'b00001: 
			data_Out = 24'hDEDEFF;
      5'b00010:
			data_Out = 24'hFFB7FF;
		5'b00011:
			data_Out = 24'h2033FF;
		default:
			data_Out = 24'h000000;
	 endcase
end

endmodule

module  frameRAMcherry
(
		input [4:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:255];
logic [4:0] data_Out_Pallete;

initial
begin
	 $readmemh("sprites/cherry.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out_Pallete<= mem[read_address];

	case(data_Out_Pallete)
		5'b00000: 
			data_Out = 24'h000000;
		5'b00001: 
			data_Out = 24'hDEDEFF;
      5'b00010:
			data_Out = 24'hFF2500;
		5'b00011:
			data_Out = 24'hDE9751;
		default:
			data_Out = 24'h000000;
	 endcase
end

endmodule


