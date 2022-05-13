module start (input logic Clk, Reset, keycode,
						output logic play);
						
always_ff @ (posedge Reset or posedge Clk)
begin
		case (keycode)
					8'h2c : begin
								play <= 1;
							  end
		endcase
		
end
							 
endmodule