module state (	input logic Clk, Reset, keycode
						output logic start, stop);
    // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., F as the state values
	 // Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
    enum logic [4:0] {S, play, A3, A4, A5, A6, A7, A8, S1, S2, S3, S4, S5, S6, S7, S8, H1, S, H2}   curr_state, next_state; 

	//updates flip flop, current state is the only one
	always_ff @ (posedge Clk or posedge Reset ) 
		begin
				if (Reset)
					curr_state <= S; 
				else
					curr_state <= next_state;
		end

    // Assign outputs based on state
	always_comb
    begin
        
		  next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            S :    if(keycode == 2'h2c)
							next_state = play;
				play:	 if(
							  

           
        case (curr_state) 
	   	   A1: 
	         begin
                Add = Mvar;
					 Ld_A = Mvar;
		      end
	   	   default:  //default case, can also have default assignments for Ld_A and Ld_B before case
		      begin 
                Shift_En = 1'b1;
		      end
        endcase
    end

endmodule

