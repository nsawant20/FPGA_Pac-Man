//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  pacman ( input Reset, frame_clk, game_over,
					input [7:0] keycode,
					output logic play,
               output [9:0]  BallX, BallY, Ball_X_Motion, Ball_Y_Motion
					);
    
    logic [9:0] Ball_X_Pos, Ball_Y_Pos, Ball_Size;
	 logic left, right, up, down;
	 
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=320;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=180;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=460;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=85;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=395;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

    assign Ball_Size = 16;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
	 
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 0; //Ball_Y_Step;
				Ball_X_Motion <= 0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
				play = 0;
        end

           
        else 
        begin 
				 left = 1;
				 right = 1;
				 down = 1;
				 up = 1;
				 if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max) //&& Ball_Y_Motion == 11'd1)  // Ball is at the bottom edge, BOUNCE!
					  begin
					  Ball_Y_Motion <= 0;  // 2's complement.
					  down = 0;
					  end
				 if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min) //&& Ball_Y_Motion > 11'd10)  // Ball is at the top edge, BOUNCE!
					  begin
					  Ball_Y_Motion <= 0;
					  up = 0;
					  end
				 if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					  begin
					  Ball_X_Motion <= 0;  // 2's complement.
					  right = 0;
					  end
				 if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min)// && Ball_X_Motion > 11'd10)  // Ball is at the Left edge, BOUNCE!
					  begin
					  Ball_X_Motion <= 0;  
					  left = 0;
					  end
				if((Ball_X_Pos + Ball_Size) == 459 && (Ball_Y_Pos - 8) >= 220 && (Ball_Y_Pos + 8) <= 240)
					Ball_X_Pos = 198;
				if((Ball_X_Pos - Ball_Size) == 181 && (Ball_Y_Pos - 8) >= 220 && (Ball_Y_Pos + 8) <= 240)
					Ball_X_Pos = 442;
					/*
									RIGHT WALLS (moving left)
					*/
					// ALLEYS START LEFT RIGHT
				  if ( (Ball_X_Pos - Ball_Size) <= 435 && (Ball_X_Pos + Ball_Size) >= 405 && (Ball_Y_Pos + 8) >= 110 && (Ball_Y_Pos - 8) <= 130 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 385 && (Ball_X_Pos + Ball_Size) >= 345 && (Ball_Y_Pos + 8) >= 110 && (Ball_Y_Pos - 8) <= 130 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 315 && (Ball_X_Pos + Ball_Size) >= 325 && (Ball_Y_Pos + 8) >= 110 && (Ball_Y_Pos - 8) <= 130 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 295 && (Ball_X_Pos + Ball_Size) >= 255 && (Ball_Y_Pos + 8) >= 110 && (Ball_Y_Pos - 8) <= 130 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 235 && (Ball_X_Pos + Ball_Size) >= 205 && (Ball_Y_Pos + 8) >= 110 && (Ball_Y_Pos - 8) <= 130 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 235 && (Ball_X_Pos + Ball_Size) >= 205 && (Ball_Y_Pos + 8) >= 150 && (Ball_Y_Pos - 8) <= 160 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 265 && (Ball_X_Pos + Ball_Size) >= 255 && (Ball_Y_Pos + 8) >= 150 && (Ball_Y_Pos - 8) <= 160 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 355 && (Ball_X_Pos + Ball_Size) >= 285 && (Ball_Y_Pos + 8) >= 150 && (Ball_Y_Pos - 8) <= 160 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 385 && (Ball_X_Pos + Ball_Size) >= 375 && (Ball_Y_Pos + 8) >= 150 && (Ball_Y_Pos - 8) <= 160 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 435 && (Ball_X_Pos + Ball_Size) >= 405 && (Ball_Y_Pos + 8) >= 150 && (Ball_Y_Pos - 8) <= 160 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 295 && (Ball_X_Pos + Ball_Size) >= 255 && (Ball_Y_Pos + 8) >= 180 && (Ball_Y_Pos - 8) <= 190 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 325 && (Ball_X_Pos + Ball_Size) >= 315 && (Ball_Y_Pos + 8) >= 180 && (Ball_Y_Pos - 8) <= 190 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 385 && (Ball_X_Pos + Ball_Size) >= 345 && (Ball_Y_Pos + 8) >= 180 && (Ball_Y_Pos - 8) <= 190 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 265 && (Ball_X_Pos + Ball_Size) >= 255 && (Ball_Y_Pos + 8) >= 210 && (Ball_Y_Pos - 8) <= 220 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 355 && (Ball_X_Pos + Ball_Size) >= 285 && (Ball_Y_Pos + 8) >= 210 && (Ball_Y_Pos - 8) <= 220 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 385 && (Ball_X_Pos + Ball_Size) >= 375 && (Ball_Y_Pos + 8) >= 210 && (Ball_Y_Pos - 8) <= 220 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 265 && (Ball_X_Pos + Ball_Size) >= 255 && (Ball_Y_Pos + 8) >= 240 && (Ball_Y_Pos - 8) <= 250 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 355 && (Ball_X_Pos + Ball_Size) >= 285 && (Ball_Y_Pos + 8) >= 240 && (Ball_Y_Pos - 8) <= 250 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 385 && (Ball_X_Pos + Ball_Size) >= 375 && (Ball_Y_Pos + 8) >= 240 && (Ball_Y_Pos - 8) <= 250 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - 8) >= 235 && (Ball_X_Pos + 8) <= 255 && (Ball_Y_Pos - 8) >= 180 && (Ball_Y_Pos + 8) <= 220)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
						right = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 235 && (Ball_X_Pos + 8) <= 255 && (Ball_Y_Pos - 8) >= 240 && (Ball_Y_Pos + 8) <= 280)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
						right = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 385 && (Ball_X_Pos + 8) <= 405 && (Ball_Y_Pos - 8) >= 180 && (Ball_Y_Pos + 8) <= 220)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
						right = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 385 && (Ball_X_Pos + 8) <= 405 && (Ball_Y_Pos - 8) >= 240 && (Ball_Y_Pos + 8) <= 280)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
						right = 0;
					   end
						
						if ( (Ball_X_Pos - Ball_Size) <= 265 && (Ball_X_Pos + Ball_Size) >= 255 && (Ball_Y_Pos + 8) >= 270 && (Ball_Y_Pos - 8) <= 280 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 355 && (Ball_X_Pos + Ball_Size) >= 285 && (Ball_Y_Pos + 8) >= 270 && (Ball_Y_Pos - 8) <= 280 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 385 && (Ball_X_Pos + Ball_Size) >= 375 && (Ball_Y_Pos + 8) >= 270 && (Ball_Y_Pos - 8) <= 280 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 235 && (Ball_X_Pos + Ball_Size) >= 205 && (Ball_Y_Pos + 8) >= 300 && (Ball_Y_Pos - 8) <= 310 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 295 && (Ball_X_Pos + Ball_Size) >= 255 && (Ball_Y_Pos + 8) >= 300 && (Ball_Y_Pos - 8) <= 310 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 325 && (Ball_X_Pos + Ball_Size) >= 315 && (Ball_Y_Pos + 8) >= 300 && (Ball_Y_Pos - 8) <= 310 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 385 && (Ball_X_Pos + Ball_Size) >= 345 && (Ball_Y_Pos + 8) >= 300 && (Ball_Y_Pos - 8) <= 310 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 435 && (Ball_X_Pos + Ball_Size) >= 405 && (Ball_Y_Pos + 8) >= 300 && (Ball_Y_Pos - 8) <= 310 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 205 && (Ball_X_Pos + Ball_Size) >= 185 && (Ball_Y_Pos + 8) >= 330 && (Ball_Y_Pos - 8) <= 340 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 235 && (Ball_X_Pos + Ball_Size) >= 225 && (Ball_Y_Pos + 8) >= 330 && (Ball_Y_Pos - 8) <= 340 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 355 && (Ball_X_Pos + Ball_Size) >= 285 && (Ball_Y_Pos + 8) >= 330 && (Ball_Y_Pos - 8) <= 340 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 385 && (Ball_X_Pos + Ball_Size) >= 375 && (Ball_Y_Pos + 8) >= 330 && (Ball_Y_Pos - 8) <= 340 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 415 && (Ball_X_Pos + Ball_Size) >= 405 && (Ball_Y_Pos + 8) >= 330 && (Ball_Y_Pos - 8) <= 340 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 455 && (Ball_X_Pos + Ball_Size) >= 435 && (Ball_Y_Pos + 8) >= 330 && (Ball_Y_Pos - 8) <= 340 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 455 && (Ball_X_Pos + Ball_Size) >= 435 && (Ball_Y_Pos + 8) >= 330 && (Ball_Y_Pos - 8) <= 340 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 295 && (Ball_X_Pos + Ball_Size) >= 205 && (Ball_Y_Pos + 8) >= 360 && (Ball_Y_Pos - 8) <= 370 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 325 && (Ball_X_Pos + Ball_Size) >= 315 && (Ball_Y_Pos + 8) >= 360 && (Ball_Y_Pos - 8) <= 370 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						
						if ( (Ball_X_Pos - Ball_Size) <= 435 && (Ball_X_Pos + Ball_Size) >= 345 && (Ball_Y_Pos + 8) >= 360 && (Ball_Y_Pos - 8) <= 370 )  // Ball is at the Left edge, BOUNCE!
						begin
						Ball_X_Motion <= 0;
						left = 0;
						right = 0;
						end
						// ALLEYS END LEFT RIGHT
						
						// ****TOP DICK CHECK THIS AGAIN****
						if ( (Ball_X_Pos + 8) <= 319 && (Ball_X_Pos - 8) >= 296 && (Ball_Y_Pos - 8) >= 90 && (Ball_Y_Pos + 8) <= 110)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   right = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 322 && (Ball_X_Pos + 8) <= 345 && (Ball_Y_Pos - 8) >= 90 && (Ball_Y_Pos + 8) <= 110)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
					   end
						
//						if ( (Ball_X_Pos - Ball_Size) <= 235 && (Ball_X_Pos + Ball_Size) >= 205 && (Ball_Y_Pos + 8) >= 130 && (Ball_Y_Pos - 8) <= 150 )  // Ball is at the Left edge, BOUNCE!
//						begin
//						Ball_X_Motion <= 0;
//						left = 0;
//						right = 0;
//						end
						
						if ( (Ball_X_Pos + 8) <= 319 && (Ball_X_Pos - 8) >= 295 && (Ball_Y_Pos - 8) >= 160 && (Ball_Y_Pos + 8) <= 190)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   right = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 322 && (Ball_X_Pos + 8) <= 345 && (Ball_Y_Pos - 8) >= 160 && (Ball_Y_Pos + 8) <= 190)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 358 && (Ball_X_Pos + 8) <= 378 && (Ball_Y_Pos - 8) >= 160 && (Ball_Y_Pos + 8) <= 190)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   right = 0;
					   end
						
						
						if ( (Ball_X_Pos - 8) >= 264 && (Ball_X_Pos + 8) <= 284 && (Ball_Y_Pos - 8) >= 160 && (Ball_Y_Pos + 8) <= 190)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 375 && (Ball_X_Pos + 8) <= 405 && (Ball_Y_Pos - 8) >= 160 && (Ball_Y_Pos + 8) <= 190)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 236 && (Ball_X_Pos + 8) <= 256 && (Ball_Y_Pos - 8) >= 160 && (Ball_Y_Pos + 8) <= 190)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   right = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 358 && (Ball_X_Pos + 8) <= 378 && (Ball_Y_Pos - 8) >= 190 && (Ball_Y_Pos + 8) <= 210)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   right = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 264 && (Ball_X_Pos + 8) <= 284 && (Ball_Y_Pos - 8) >= 190 && (Ball_Y_Pos + 8) <= 210)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 355 && (Ball_X_Pos + 8) <= 375 && (Ball_Y_Pos - 8) >= 210 && (Ball_Y_Pos + 8) <= 250)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 265 && (Ball_X_Pos + 8) <= 285 && (Ball_Y_Pos - 8) >= 210 && (Ball_Y_Pos + 8) <= 250)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   right = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 355 && (Ball_X_Pos + 8) <= 375 && (Ball_Y_Pos - 8) >= 250 && (Ball_Y_Pos + 8) <= 270)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   right = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 265 && (Ball_X_Pos + 8) <= 285 && (Ball_Y_Pos - 8) >= 250 && (Ball_Y_Pos + 8) <= 270)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 295 && (Ball_X_Pos + 8) <= 315 && (Ball_Y_Pos - 8) >= 280 && (Ball_Y_Pos + 8) <= 300)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   right = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 325 && (Ball_X_Pos + 8) <= 345 && (Ball_Y_Pos - 8) >= 280 && (Ball_Y_Pos + 8) <= 300)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 205 && (Ball_X_Pos + 8) <= 225 && (Ball_Y_Pos - 8) >= 310 && (Ball_Y_Pos + 8) <= 330)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   right = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 235 && (Ball_X_Pos + 8) <= 255 && (Ball_Y_Pos - 8) >= 310 && (Ball_Y_Pos + 8) <= 330)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 385 && (Ball_X_Pos + 8) <= 405 && (Ball_Y_Pos - 8) >= 310 && (Ball_Y_Pos + 8) <= 330)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   right = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 415 && (Ball_X_Pos + 8) <= 435 && (Ball_Y_Pos - 8) >= 310 && (Ball_Y_Pos + 8) <= 330)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 235 && (Ball_X_Pos + 8) <= 255 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   right = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 295 && (Ball_X_Pos + 8) <= 315 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   right = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 265 && (Ball_X_Pos + 8) <= 285 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 355 && (Ball_X_Pos + 8) <= 375 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   right = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 325 && (Ball_X_Pos + 8) <= 345 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
					   end
						
						if ( (Ball_X_Pos - 8) >= 385 && (Ball_X_Pos + 8) <= 405 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_X_Motion <= 0;  // 2's complement.
					   left = 0;
					   end
						/*
									DOWN WALLS (moving DOWN)
					*/
					// ALLEYS START UP DOWN
						if ( (Ball_X_Pos + 8) >= 285 && (Ball_X_Pos - 8) <= 355 && (Ball_Y_Pos - 8) >= 250 && (Ball_Y_Pos + 8) <= 270)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
						up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 405 && (Ball_X_Pos - 8) <= 460 && (Ball_Y_Pos - 8) >= 220 && (Ball_Y_Pos + 8) <= 240)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
						up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 375 && (Ball_X_Pos - 8) <= 385 && (Ball_Y_Pos - 8) >= 220 && (Ball_Y_Pos + 8) <= 240)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
						up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 255 && (Ball_X_Pos - 8) <= 265 && (Ball_Y_Pos - 8) >= 220 && (Ball_Y_Pos + 8) <= 240)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
						up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 180 && (Ball_X_Pos - 8) <= 235 && (Ball_Y_Pos - 8) >= 220 && (Ball_Y_Pos + 8) <= 240)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
						up = 0;
					   end
						
						
						
						
					// ALLEYS START UP DOWN

											
						if ( (Ball_X_Pos + 8) >= 345 && (Ball_X_Pos - 8) <= 385 && (Ball_Y_Pos - 8) >= 90 && (Ball_Y_Pos + 8) <= 110)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 405 && (Ball_X_Pos - 8) <= 435 && (Ball_Y_Pos - 8) >= 90 && (Ball_Y_Pos + 8) <= 110)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 255 && (Ball_X_Pos - 8) < 295 && (Ball_Y_Pos - 8) >= 90 && (Ball_Y_Pos + 8) <= 110)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 205 && (Ball_X_Pos - 8) <= 235 && (Ball_Y_Pos - 8) >= 90 && (Ball_Y_Pos + 8) <= 110)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 285 && (Ball_X_Pos - 8) <= 355 && (Ball_Y_Pos - 8) >= 130 && (Ball_Y_Pos + 8) <= 150)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 405 && (Ball_X_Pos - 8) <= 435 && (Ball_Y_Pos - 8) >= 130 && (Ball_Y_Pos + 8) <= 150)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 205 && (Ball_X_Pos - 8) <= 235 && (Ball_Y_Pos - 8) >= 130 && (Ball_Y_Pos + 8) <= 150)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 375 && (Ball_X_Pos - 8) <= 385 && (Ball_Y_Pos - 8) >= 130 && (Ball_Y_Pos + 8) <= 150)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 255 && (Ball_X_Pos - 8) <= 265 && (Ball_Y_Pos - 8) >= 130 && (Ball_Y_Pos + 8) <= 150)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 405 && (Ball_X_Pos - 8) <= 455 && (Ball_Y_Pos - 8) >= 160 && (Ball_Y_Pos + 8) <= 190)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 185 && (Ball_X_Pos - 8) <= 235 && (Ball_Y_Pos - 8) >= 160 && (Ball_Y_Pos + 8) <= 190)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 345 && (Ball_X_Pos - 8) <= 375 && (Ball_Y_Pos - 8) >= 160 && (Ball_Y_Pos + 8) <= 190)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 265 && (Ball_X_Pos - 8) <= 295 && (Ball_Y_Pos - 8) >= 160 && (Ball_Y_Pos + 8) <= 190)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 285 && (Ball_X_Pos - 8) <= 355 && (Ball_Y_Pos - 8) >= 190 && (Ball_Y_Pos + 8) <= 210)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 405 && (Ball_X_Pos - 8) <= 435 && (Ball_Y_Pos - 8) >= 280 && (Ball_Y_Pos + 8) <= 300)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 345 && (Ball_X_Pos - 8) <= 385 && (Ball_Y_Pos - 8) >= 280 && (Ball_Y_Pos + 8) <= 300)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 255 && (Ball_X_Pos - 8) <= 295 && (Ball_Y_Pos - 8) >= 280 && (Ball_Y_Pos + 8) <= 300)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 205 && (Ball_X_Pos - 8) <= 235 && (Ball_Y_Pos - 8) >= 280 && (Ball_Y_Pos + 8) <= 300)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 435 && (Ball_X_Pos - 8) <= 455 && (Ball_Y_Pos - 8) >= 310 && (Ball_Y_Pos + 8) <= 330)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 375 && (Ball_X_Pos - 8) <= 385 && (Ball_Y_Pos - 8) >= 310 && (Ball_Y_Pos + 8) <= 330)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 285 && (Ball_X_Pos - 8) <= 355 && (Ball_Y_Pos - 8) >= 310 && (Ball_Y_Pos + 8) <= 330)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 185 && (Ball_X_Pos - 8) <= 205 && (Ball_Y_Pos - 8) >= 310 && (Ball_Y_Pos + 8) <= 330)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 255 && (Ball_X_Pos - 8) <= 265 && (Ball_Y_Pos - 8) >= 310 && (Ball_Y_Pos + 8) <= 330)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 205 && (Ball_X_Pos - 8) <= 255 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 265 && (Ball_X_Pos - 8) <= 295 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 345 && (Ball_X_Pos - 8) <= 375 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 385 && (Ball_X_Pos - 8) <= 435 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   down = 0;
					   end
						
						
//						if ( (Ball_X_Pos + 8) >= 285 && (Ball_X_Pos - 8) <= 355 && (Ball_Y_Pos - 8) >= 290 && (Ball_Y_Pos + 8) <= 310)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
//					   begin
//					   Ball_Y_Motion <= 0;  // 2's complement.
//					   down = 0;
//					   end
						
					/*	
						UP WALLS (moving UP)
					*/
											
						if ( (Ball_X_Pos + 8) >= 345 && (Ball_X_Pos - 8) <= 385 && (Ball_Y_Pos - 8) >= 130 && (Ball_Y_Pos + 8) <= 150)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 405 && (Ball_X_Pos - 8) <= 435 && (Ball_Y_Pos - 8) >= 130 && (Ball_Y_Pos + 8) <= 150)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 255 && (Ball_X_Pos - 8) <= 295 && (Ball_Y_Pos - 8) >= 130 && (Ball_Y_Pos + 8) <= 150)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 205 && (Ball_X_Pos - 8) <= 235 && (Ball_Y_Pos - 8) >= 130 && (Ball_Y_Pos + 8) <= 150)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 315 && (Ball_X_Pos - 8) <= 325 && (Ball_Y_Pos - 8) >= 130 && (Ball_Y_Pos + 8) <= 150)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 285 && (Ball_X_Pos - 8) <= 315 && (Ball_Y_Pos - 8) >= 160 && (Ball_Y_Pos + 8) <= 180)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 325 && (Ball_X_Pos - 8) <= 355 && (Ball_Y_Pos - 8) >= 160 && (Ball_Y_Pos + 8) <= 180)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 405 && (Ball_X_Pos - 8) <= 435 && (Ball_Y_Pos - 8) >= 160 && (Ball_Y_Pos + 8) <= 180)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 205 && (Ball_X_Pos - 8) <= 235 && (Ball_Y_Pos - 8) >= 160 && (Ball_Y_Pos + 8) <= 180)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 265 && (Ball_X_Pos - 8) <= 295 && (Ball_Y_Pos - 8) >= 190 && (Ball_Y_Pos + 8) <= 210)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 345 && (Ball_X_Pos - 8) <= 375 && (Ball_Y_Pos - 8) >= 190 && (Ball_Y_Pos + 8) <= 210)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 315 && (Ball_X_Pos - 8) <= 325 && (Ball_Y_Pos - 8) >= 190 && (Ball_Y_Pos + 8) <= 210)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 185 && (Ball_X_Pos - 8) <= 235 && (Ball_Y_Pos - 8) >= 280 && (Ball_Y_Pos + 8) <= 300)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 255 && (Ball_X_Pos - 8) <= 265 && (Ball_Y_Pos - 8) >= 280 && (Ball_Y_Pos + 8) <= 300)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 285 && (Ball_X_Pos - 8) <= 315 && (Ball_Y_Pos - 8) >= 280 && (Ball_Y_Pos + 8) <= 300)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 325 && (Ball_X_Pos - 8) <= 355 && (Ball_Y_Pos - 8) >= 280 && (Ball_Y_Pos + 8) <= 300)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 375 && (Ball_X_Pos - 8) <= 385 && (Ball_Y_Pos - 8) >= 280 && (Ball_Y_Pos + 8) <= 300)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 405 && (Ball_X_Pos - 8) <= 455 && (Ball_Y_Pos - 8) >= 280 && (Ball_Y_Pos + 8) <= 300)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 205 && (Ball_X_Pos - 8) <= 225 && (Ball_Y_Pos - 8) >= 310 && (Ball_Y_Pos + 8) <= 330)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 205 && (Ball_X_Pos - 8) <= 225 && (Ball_Y_Pos - 8) >= 310 && (Ball_Y_Pos + 8) <= 330)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 255 && (Ball_X_Pos - 8) <= 295 && (Ball_Y_Pos - 8) >= 310 && (Ball_Y_Pos + 8) <= 330)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 315 && (Ball_X_Pos - 8) <= 325 && (Ball_Y_Pos - 8) >= 310 && (Ball_Y_Pos + 8) <= 330)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 345 && (Ball_X_Pos - 8) <= 385 && (Ball_Y_Pos - 8) >= 310 && (Ball_Y_Pos + 8) <= 330)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 415 && (Ball_X_Pos - 8) <= 435 && (Ball_Y_Pos - 8) >= 310 && (Ball_Y_Pos + 8) <= 330)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 435 && (Ball_X_Pos - 8) <= 455 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 405 && (Ball_X_Pos - 8) <= 415 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 325 && (Ball_X_Pos - 8) <= 355 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 285 && (Ball_X_Pos - 8) <= 315 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 225 && (Ball_X_Pos - 8) <= 235 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 185 && (Ball_X_Pos - 8) <= 205 && (Ball_Y_Pos - 8) >= 340 && (Ball_Y_Pos + 8) <= 360)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 205 && (Ball_X_Pos - 8) <= 295 && (Ball_Y_Pos - 8) >= 370 && (Ball_Y_Pos + 8) <= 390)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 345 && (Ball_X_Pos - 8) <= 435 && (Ball_Y_Pos - 8) >= 370 && (Ball_Y_Pos + 8) <= 390)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
						if ( (Ball_X_Pos + 8) >= 315 && (Ball_X_Pos - 8) <= 325 && (Ball_Y_Pos - 8) >= 370 && (Ball_Y_Pos + 8) <= 390)// && Ball_X_Motion == 1)  // Ball is at the Right edge, BOUNCE!
					   begin
					   Ball_Y_Motion <= 0;  // 2's complement.
					   up = 0;
					   end
						
//				 else 
//					  Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
//					
					if(game_over == 1'b1)
					begin
						Ball_X_Motion <= 0;
						Ball_Y_Motion<= 0;
					end
				 
						  case (keycode)
					8'h2c : begin
								play = 1;
							  end
					8'h04 : begin
								if (left != 0 && play && game_over == 1'b0)  begin
									Ball_X_Motion <= -1;//A
									Ball_Y_Motion<= 0;
									end
							   end
					        
					8'h07 : begin
							  if (right != 0 && play && game_over == 1'b0) begin
									Ball_X_Motion <= 1;//D
									Ball_Y_Motion <= 0;
									end
							  end

							  
					8'h16 : begin
							  if(down != 0 && play && game_over == 1'b0) begin
									Ball_Y_Motion <= 1;//S
									Ball_X_Motion <= 0;
									end
							 end
							  
					8'h1A : begin
							  if(up != 0 && play && game_over == 1'b0) begin
									Ball_Y_Motion <= -1;//W
									Ball_X_Motion <= 0;
									end
							 end	  
					default: ;
			   endcase
				 
				 
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
			
			
	  /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #2/2:
          Note that Ball_Y_Motion in the above statement may have been changed at the same clock edge
          that is causing the assignment of Ball_Y_pos.  Will the new value of Ball_Y_Motion be used,
          or the old?  How will this impact behavior of the ball during a bounce, and how might that 
          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
      **************************************************************************************/
      
			
		end  
    end
       
    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;
   
    

endmodule
