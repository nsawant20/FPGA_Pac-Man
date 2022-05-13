module  dots #(parameter PointX = 0, parameter PointY = 0)
							( input        [9:0] PacX, PacY,
							  input Clk, Reset,
                       output logic eaten);

	assign Ball_Size = 8;
	logic not_Eaten;
	initial 
		not_Eaten = 1'b1;
	
	always_ff @ (posedge Reset or posedge Clk)
	begin
		if (Reset)  // Asynchronous Reset
        begin 
            eaten = 1'b0;
				not_Eaten = 1'b1;
        end
//		else if(((PacX + Ball_Size) == PointX || (PacX + Ball_Size) == PointX + 1 || (PacX + Ball_Size) == PointX - 1) && ((PacY - Ball_Size) == PointY || (PacY - Ball_Size) == PointY + 1 || (PacY - Ball_Size) == PointY - 1) && not_Eaten)
//		begin
//			eaten = 1'b1;
//			not_Eaten = 1'b0;
//		end
//		else if(((PacX + Ball_Size) == PointX || (PacX + Ball_Size) == PointX + 1 || (PacX + Ball_Size) == PointX - 1) && ((PacY + Ball_Size) == PointY || (PacY + Ball_Size) == PointY + 1 || (PacY + Ball_Size) == PointY - 1) && not_Eaten)
//		begin
//			eaten = 1'b1;
//			not_Eaten = 1'b0;
//		end
//		else if(((PacX - Ball_Size) == PointX || (PacX - Ball_Size) == PointX + 1 || (PacX - Ball_Size) == PointX - 1) && ((PacY + Ball_Size) == PointY || (PacY + Ball_Size) == PointY + 1 || (PacY + Ball_Size) == PointY - 1) && not_Eaten)
//		begin
//			eaten = 1'b1;
//			not_Eaten = 1'b0;
//		end
//		else if(((PacX - Ball_Size) == PointX || (PacX - Ball_Size) == PointX + 1 || (PacX - Ball_Size) == PointX - 1) && ((PacY - Ball_Size) == PointY || (PacY - Ball_Size) == PointY + 1 || (PacY - Ball_Size) == PointY - 1) && not_Eaten)
//		begin
//			eaten = 1'b1;
//			not_Eaten = 1'b0;
//		end
		
		else if(((PacX + Ball_Size) <= (PointX + 4) && (PacX + Ball_Size) >= (PointX - 4)) && ((PacY - Ball_Size) >= (PointY - 4) && (PacY - Ball_Size) <= (PointY + 4)) && not_Eaten)
		begin
			eaten = 1'b1;
			not_Eaten = 1'b0;
		end
		else if(((PacX + Ball_Size) <= (PointX + 4) && (PacX + Ball_Size) >= (PointX - 4)) && ((PacY + Ball_Size) >= (PointY - 4) && (PacY + Ball_Size) <= (PointY + 4)) && not_Eaten)
		begin
			eaten = 1'b1;
			not_Eaten = 1'b0;
		end
		else if(((PacX - Ball_Size) <= (PointX + 4) && (PacX - Ball_Size) >= (PointX - 4)) && ((PacY + Ball_Size) >= (PointY - 4) && (PacY + Ball_Size) <= (PointY + 4)) && not_Eaten)
		begin
			eaten = 1'b1;
			not_Eaten = 1'b0;
		end
		else if(((PacX - Ball_Size) <= (PointX + 4) && (PacX - Ball_Size) >= (PointX - 4)) && ((PacY - Ball_Size) >= (PointY - 4) && (PacY - Ball_Size) <= (PointY + 4)) && not_Eaten)
		begin
			eaten = 1'b1;
			not_Eaten = 1'b0;
		end
		else if (not_Eaten == 1'b1)
			eaten = 1'b0;
	end
	
//	else if(((PacX + Ball_Size) == PointX || (PacX + Ball_Size) == PointX + 1 || (PacX + Ball_Size) == PointX - 1) && ((PacY - Ball_Size) == PointY || (PacY - Ball_Size) == PointY + 1 || (PacY - Ball_Size) == PointY - 1) && not_Eaten)
//		begin
//			eaten = 1'b1;
//			not_Eaten = 1'b0;
//		end
//		else if(((PacX + Ball_Size) == PointX || (PacX + Ball_Size) == PointX + 1 || (PacX + Ball_Size) == PointX - 1) && ((PacY + Ball_Size) == PointY || (PacY + Ball_Size) == PointY + 1 || (PacY + Ball_Size) == PointY - 1) && not_Eaten)
//		begin
//			eaten = 1'b1;
//			not_Eaten = 1'b0;
//		end
//		else if(((PacX - Ball_Size) == PointX || (PacX - Ball_Size) == PointX + 1 || (PacX - Ball_Size) == PointX - 1) && ((PacY + Ball_Size) == PointY || (PacY + Ball_Size) == PointY + 1 || (PacY + Ball_Size) == PointY - 1) && not_Eaten)
//		begin
//			eaten = 1'b1;
//			not_Eaten = 1'b0;
//		end
//		else if(((PacX - Ball_Size) == PointX || (PacX - Ball_Size) == PointX + 1 || (PacX - Ball_Size) == PointX - 1) && ((PacY - Ball_Size) == PointY || (PacY - Ball_Size) == PointY + 1 || (PacY - Ball_Size) == PointY - 1) && not_Eaten)
//		begin
//			eaten = 1'b1;
//			not_Eaten = 1'b0;
//		end


endmodule