module  collisions #(parameter PointX = 0, parameter PointY = 0)
							( input        [9:0] PacX, PacY,
							  input Clk, Reset,
                       output logic collided);

	assign Ball_Size = 8;
	assign offset = 4;
	logic not_collided;
	initial 
		not_collided = 1'b1;
	
	always_ff @ (posedge Reset or posedge Clk)
	begin
		if (Reset)  // Asynchronous Reset
        begin 
            collided = 1'b0;
				not_collided = 1'b1;
        end

		else if(((PacX + Ball_Size) <= (PointX + offset) && (PacX + Ball_Size) >= (PointX - offset)) && ((PacY - Ball_Size) >= (PointY - offset) && (PacY - Ball_Size) <= (PointY + offset)) && not_collided)
		begin
			collided = 1'b1;
			not_collided = 1'b0;
		end
		else if(((PacX + Ball_Size) <= (PointX + offset) && (PacX + Ball_Size) >= (PointX - offset)) && ((PacY + Ball_Size) >= (PointY - offset) && (PacY + Ball_Size) <= (PointY + offset)) && not_collided)
		begin
			collided = 1'b1;
			not_collided = 1'b0;
		end
		else if(((PacX - Ball_Size) <= (PointX + offset) && (PacX - Ball_Size) >= (PointX - offset)) && ((PacY + Ball_Size) >= (PointY - offset) && (PacY + Ball_Size) <= (PointY + offset)) && not_collided)
		begin
			collided = 1'b1;
			not_collided = 1'b0;
		end
		else if(((PacX - Ball_Size) <= (PointX + offset) && (PacX - Ball_Size) >= (PointX - offset)) && ((PacY - Ball_Size) >= (PointY - offset) && (PacY - Ball_Size) <= (PointY + offset)) && not_collided)
		begin
			collided = 1'b1;
			not_collided = 1'b0;
		end

	end


endmodule