/************************************************************************
Avalon-MM Interface VGA Text mode display

Register Map:
0x000-0x0257 : VRAM, 80x30 (2400 byte, 600 word) raster order (first column then row)
0x258        : control register

VRAM Format:
X->
[ 31  30-24][ 23  22-16][ 15  14-8 ][ 7    6-0 ]
[IV3][CODE3][IV2][CODE2][IV1][CODE1][IV0][CODE0]

IVn = Draw inverse glyph
CODEn = Glyph code from IBM codepage 437

Control Register Format:
[[31-25][24-21][20-17][16-13][ 12-9][ 8-5 ][ 4-1 ][   0    ] 
[[RSVD ][FGD_R][FGD_G][FGD_B][BKG_R][BKG_G][BKG_B][RESERVED]

VSYNC signal = bit which flips on every Vsync (time for new frame), used to synchronize software
BKG_R/G/B = Background color, flipped with foreground when IVn bit is set
FGD_R/G/B = Foreground color, flipped with background when Inv bit is set

************************************************************************/
`define NUM_REGS 601 //80*30 characters / 4 characters per register
`define CTRL_REG 600 //index of control register

module vga_text_avl_interface (
	// Avalon Clock Input, note this clock is also used for VGA, so this must be 50Mhz
	// We can put a clock divider here in the future to make this IP more generalizable
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,					// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,			// Avalon-MM Byte Enable
	input  logic [11:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,		// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,		// Avalon-MM Read Data
	
	// Exported Conduit (mapped to VGA port - make sure you export in Platform Designer)
	output logic [3:0]  red, green, blue,	// VGA color channels (mapped to output pins in top-level)
	output logic hs, vs						// VGA HS/VS
);

logic [31:0] LOCAL_REG       [`NUM_REGS]; // Registers
//put other local variables here

logic pixel_clk, blank, sync, invert_colors;
logic [10:0] addr, addr_index;
logic [7:0] data, char_vga, char_code;
logic [9:0] DrawX, DrawY;
logic [6:0] x_position;
logic [5:0] y_position;
logic [31:0] char_index, memory_out, vga_out, avl_out, palette [8];
logic [3:0] backGD_R, backGD_G, backGD_B;
logic [3:0] foreGD_R, foreGD_G, foreGD_B;


//Declare submodules..e.g. VGA controller, ROMS, etc

vga_controller ( 	
						.Clk(CLK),       // 50 MHz clock
						.Reset(RESET),     // reset signal
                  .hs,        // Horizontal sync pulse.  Active low
						.vs,        // Vertical sync pulse.  Active low
						.pixel_clk, // 25 MHz pixel clock output
						.blank,     // Blanking interval indicator.  Active low.
						.sync,      // Composite Sync signal.  Active low.  We don't use it in this lab, but the video DAC on the DE2 board requires an input for it.
						.DrawX,		// horizontal coordinate
						.DrawY		// vertical coordinate
					);
					
font_rom 		(			
						.addr,
						.data
					);	

ram_take4 ram0 (
						.clock(CLK),
						// AVALON
						.address_a(AVL_ADDR[10:0]),			
						.byteena_a(AVL_BYTE_EN),
						.data_a(AVL_WRITEDATA),
						.rden_a(AVL_READ & AVL_CS & ~AVL_ADDR[11]),
						.wren_a(AVL_WRITE & AVL_CS & ~AVL_ADDR[11]),
						.q_a(avl_out),
																	
						//VGA
						.address_b(addr_index),        // /4 = shift right 2, might need to be shift right 1
						.data_b(32'b0),      					// not needed
						.rden_b(1'b1),
						.wren_b(1'b0),
						.q_b(vga_out)
					);			
															     
// Read and write from AVL interface to register block, note that READ waitstate = 1, so this should be in always_ff
always_ff @(posedge CLK) begin
	if (RESET) begin
		for(int i = 0; i <= 7; i++) begin
			palette[i] = 32'h0000;
		end
	end
	else	begin
		if (AVL_READ & AVL_CS & AVL_ADDR[11]) 
			memory_out = palette[AVL_ADDR[2:0]];
		else begin
			if (AVL_WRITE & AVL_CS & AVL_BYTE_EN[0] & AVL_ADDR[11])
				palette[AVL_ADDR[2:0]][7:0] <= AVL_WRITEDATA[7:0];
			if (AVL_WRITE & AVL_CS & AVL_BYTE_EN[1] & AVL_ADDR[11])
				palette[AVL_ADDR[2:0]][15:8] <= AVL_WRITEDATA[15:8];
			if (AVL_WRITE & AVL_CS & AVL_BYTE_EN[2] & AVL_ADDR[11])
				palette[AVL_ADDR[2:0]][23:16] <= AVL_WRITEDATA[23:16];
			if (AVL_WRITE & AVL_CS & AVL_BYTE_EN[3] & AVL_ADDR[11])
				palette[AVL_ADDR[2:0]][31:24] <= AVL_WRITEDATA[31:24];
		end
	end
end

always_comb begin
	if(AVL_ADDR[11] )
		AVL_READDATA = memory_out;
	else
		AVL_READDATA = avl_out;
end

//handle drawing (may either be combinational or sequential - or both).
// fontrom    16 * character # (0-127) + 0ffset of front_rom (DrawY [3:0])
always_comb begin
	y_position = DrawY[9:4];
	x_position = DrawX[9:3];
	char_index = (y_position * 80 + x_position);
	addr_index = char_index / 2;
	
	unique case (char_index[0])
		1'b00 : begin
				  char_vga = vga_out[7:0];
				  char_code = vga_out[15:8];
				  end
				  
		1'b01 : begin
				  char_vga = vga_out[23:16];
		   	  char_code = vga_out[31:24];
				  end
	endcase
	addr = char_code[6:0] * 16 + DrawY[3:0];
	invert_colors = char_code[7];
	
	if(char_vga[4]) begin
		foreGD_R = palette[char_vga[7:5]][24:21];
		foreGD_G = palette[char_vga[7:5]][20:17];
		foreGD_B = palette[char_vga[7:5]][16:13];
	end
	else begin
		foreGD_R = palette[char_vga[7:5]][12:9];
		foreGD_G = palette[char_vga[7:5]][8:5];
		foreGD_B = palette[char_vga[7:5]][4:1];
	end
	if(char_vga[0]) begin
		backGD_R = palette[char_vga[3:1]][24:21];
		backGD_G = palette[char_vga[3:1]][20:17];
		backGD_B = palette[char_vga[3:1]][16:13];
	end
	else begin
		backGD_R = palette[char_vga[3:1]][12:9];
		backGD_G = palette[char_vga[3:1]][8:5];
		backGD_B = palette[char_vga[3:1]][4:1];
	end
end

always_ff @ (posedge pixel_clk) 
	begin:RGB_Display
	if (blank == 1'b0)
		begin
			red <= 4'h0;
			green <= 4'h0;
			blue <= 4'h0;
		end
	else if ((data[7 - DrawX[2:0]] ^ invert_colors) == 1'b1)
		begin
			red <= foreGD_R;
			green <= foreGD_G;
			blue <= foreGD_B;
		end
	else
		begin
			red <= backGD_R;
			green <= backGD_G;
			blue <= backGD_B;
		end
	end
endmodule
