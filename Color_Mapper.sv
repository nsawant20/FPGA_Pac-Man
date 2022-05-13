//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input        [9:0] PacX, PacY, DrawX, DrawY, rghostX, rghostY, bghostX, bghostY, oghostX, oghostY, pghostX, pghostY, PacXM, PacYM,
							  input Clk, Reset, play,
							  output logic game_over,
                       output logic [7:0]  Red, Green, Blue, scoreOnes, scoreTens, scoreHundreds);
    
    logic open_close, Pac_on, Rghost_on, Bghost_on, Oghost_on, Pghost_on, cherry_on, xline, xline2, yline, yline2, yline3;
	 logic scoreOnes_on, scoreTens_on, scoreHundreds_on, zero, cherry_collided, g_on, a_on, m_on, e_on;
	 logic o_on, v_on, e2_on, r_on;
	 
	 logic eaten1, eaten2, eaten3, eaten4, eaten5, eaten6, eaten7, eaten8, eaten9, eaten10, eaten11, eaten12, eaten13, eaten14;
	 logic eaten15, eaten16, eaten17, eaten18, eaten19, eaten20, eaten21, eaten22, eaten23, eaten24, eaten25, eaten26, eaten27;
	 logic eaten28, eaten29, eaten30, eaten31, eaten32, eaten33, eaten34, eaten35, eaten36, eaten37, eaten38, eaten39, eaten40;
	 logic eaten41, eaten42, eaten43, eaten44, eaten45, eaten46, eaten47, eaten48, eaten49, eaten50, eaten51, eaten52, eaten53;
	 logic eaten54, eaten55, eaten56, eaten57, eaten58, eaten59, eaten60, eaten61, eaten62, eaten63, eaten64, eaten65, eaten66;
	 logic eaten67, eaten68, eaten69, eaten70, eaten71, eaten72, eaten73, eaten74, eaten75, eaten76, eaten77, eaten78, eaten79;
	 logic eaten80, eaten81, eaten82, eaten83, eaten84, eaten85, eaten86, eaten87, eaten88, eaten89;
	 logic eaten90, eaten91, eaten92, eaten93, eaten94, eaten95, eaten96, eaten97, eaten98 , eaten99;
	 logic eaten100, eaten101, eaten102, eaten103, eaten104, eaten105, eaten106, eaten107, eaten108, eaten109;
	 logic eaten110, eaten111, eaten112, eaten113, eaten114, eaten115, eaten116, eaten117, eaten118, eaten119;
	 logic eaten120, eaten121, eaten122, eaten123, eaten124, eaten125, eaten126, eaten127, eaten128, eaten129;
	 logic eaten130, eaten131, eaten132, eaten133, eaten134, eaten135, eaten136, eaten137, eaten138, eaten139;
	 logic eaten140, eaten141, eaten142, eaten143, eaten144, eaten145, eaten146, eaten147, eaten148, eaten149;
	 logic eaten150, eaten151, eaten152, eaten153, eaten154, eaten155, eaten156, eaten157, eaten158, eaten159;
	 logic eaten160, eaten161, eaten162, eaten163, eaten164, eaten165, eaten166, eaten167, eaten168, eaten169;
	 logic eaten170, eaten171, eaten172, eaten173, eaten174, eaten175, eaten176, eaten177, eaten178, eaten179;
	 logic eaten180, eaten181, eaten182, eaten183, eaten184, eaten185, eaten186, eaten187, eaten188, eaten189;
	 logic eaten190, eaten191, eaten192, eaten193, eaten194, eaten195, eaten196, eaten197, eaten198, eaten199;
	 logic eaten200, eaten201, eaten202, eaten203, eaten204, eaten205, eaten206, eaten207, eaten208, eaten209;
	 logic eaten210, eaten211, eaten212, eaten213, eaten214, eaten215, eaten216, eaten217, eaten218, eaten219;
	 logic eaten220, eaten221, eaten222, eaten223, eaten224, eaten225, eaten226, eaten227, eaten228, eaten229;
	 logic eaten230, eaten231, eaten232, eaten233, eaten234, eaten235, eaten236, eaten237, eaten238, eaten239, eaten240, eaten241;

	 logic [10:0]	address_rom;
	 logic [7:0]	fontdata, score, eatenScore;
	 logic [23:0] pac_outR, pac_outCR, pac_outL, pac_outCL, pac_outU, pac_outCU, pac_outD, pac_outCD, oghost_out, back_out, rghost_out, bghost_out, pghost_out, cherry_out;	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*Ball_Size, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 12 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
    int SizeP, SizeG, SizeR;
	 assign SizeG = 9;
    assign SizeP = 8;
	 assign SizeR = 7;
	 
		counter counting(
		.Clk,
		.open_close(open_close)
		);
		
		frameRAMpacOR borad8(
			.read_address((DrawY - PacY - 8) * 16 + (DrawX - PacX - 7)), // try DrawX - PacX - 8
			.Clk,
			.we(0),
			.data_Out(pac_outR)
		);
		
		frameRAMpacCR borad12(
			.read_address((DrawY - PacY - 8) * 16 + (DrawX - PacX - 7)), // try DrawX - PacX - 8
			.Clk,
			.we(0),
			.data_Out(pac_outCR)
		);
		
		frameRAMpacOL borad9(
			.read_address((DrawY - PacY - 8) * 16 + (DrawX - PacX - 7)), // try DrawX - PacX - 8
			.Clk,
			.we(0),
			.data_Out(pac_outL)
		);
		
		frameRAMpacCL borad13(
			.read_address((DrawY - PacY - 8) * 16 + (DrawX - PacX - 7)), // try DrawX - PacX - 8
			.Clk,
			.we(0),
			.data_Out(pac_outCL)
		);
		
		frameRAMpacOD borad10(
			.read_address((DrawY - PacY - 8) * 16 + (DrawX - PacX - 7)), // try DrawX - PacX - 8
			.Clk,
			.we(0),
			.data_Out(pac_outD)
		);
		
		frameRAMpacCD borad14(
			.read_address((DrawY - PacY - 8) * 16 + (DrawX - PacX - 7)), // try DrawX - PacX - 8
			.Clk,
			.we(0),
			.data_Out(pac_outCD)
		);
		
		frameRAMpacOU borad11(
			.read_address((DrawY - PacY - 8) * 16 + (DrawX - PacX - 7)), // try DrawX - PacX - 8
			.Clk,
			.we(0),
			.data_Out(pac_outU)
		);
		
		frameRAMpacCU borad15(
			.read_address((DrawY - PacY - 8) * 16 + (DrawX - PacX - 7)), // try DrawX - PacX - 8
			.Clk,
			.we(0),
			.data_Out(pac_outCU)
		);
		
		frameRAMbac borad2(
			.read_address((DrawY - 85) * 280 + (DrawX - 180)),
			.Clk,
			.we(0),
			.data_Out(back_out)
		);
		
		frameRAMoghost borad4(
			.read_address((DrawY - oghostY - 8) * 16 + (DrawX - oghostX - 8)),
			.Clk,
			.we(0),
			.data_Out(oghost_out)
		);
		
		frameRAMpghost borad5(
			.read_address((DrawY - pghostY - 8) * 16 + (DrawX - pghostX - 8)),
			.Clk,
			.we(0),
			.data_Out(pghost_out)
		);
		
		frameRAMrghost borad6(
			.read_address((DrawY - rghostY - 8) * 16 + (DrawX - rghostX - 8)),
			.Clk,
			.we(0),
			.data_Out(rghost_out)
		);
		
		frameRAMbghost borad7(
			.read_address((DrawY - bghostY - 8) * 16 + (DrawX - bghostX - 8)),
			.Clk,
			.we(0),
			.data_Out(bghost_out)
		);
		
		frameRAMcherry borad16(
			.read_address((DrawY - 252) * 16 + (DrawX - 312)),
			.Clk,
			.we(0),
			.data_Out(cherry_out)
		);
		
		font_rom fontmap(.addr(address_rom),.data(fontdata));
		
		collisions #(320, 260) cherry_collisions (.*, .collided(cherry_collided));

	  dots #(334, 319) dot1 (.*, .eaten(eaten1));
	  dots #(344, 319) dot2 (.*, .eaten(eaten2));    
	  dots #(354, 319) dot3 (.*, .eaten(eaten3)); 
	  dots #(364, 319) dot4 (.*, .eaten(eaten4));    
	  dots #(374, 319) dot5 (.*, .eaten(eaten5));    
	  dots #(384, 319) dot6 (.*, .eaten(eaten6));    
	  dots #(394, 319) dot7 (.*, .eaten(eaten7));  
	  
	  dots #(394, 309) dot8 (.*, .eaten(eaten8));
	  dots #(394, 299) dot9 (.*, .eaten(eaten9));
	  dots #(394, 289) dot10 (.*, .eaten(eaten10));    
	  dots #(394, 279) dot11 (.*, .eaten(eaten11));
	  dots #(394, 269) dot12 (.*, .eaten(eaten12));    
	  dots #(394, 259) dot13 (.*, .eaten(eaten13));
	  dots #(394, 249) dot14 (.*, .eaten(eaten14));
	  dots #(394, 239) dot15 (.*, .eaten(eaten15));
	  dots #(394, 229) dot16 (.*, .eaten(eaten16));
	  dots #(394, 219) dot17 (.*, .eaten(eaten17));
	  dots #(394, 209) dot18 (.*, .eaten(eaten18));
	  dots #(394, 199) dot19 (.*, .eaten(eaten19));
	  dots #(394, 189) dot20 (.*, .eaten(eaten20));
	  dots #(394, 179) dot21 (.*, .eaten(eaten21));
	  dots #(394, 169) dot22 (.*, .eaten(eaten22));
	  dots #(394, 159) dot23 (.*, .eaten(eaten23));
	  dots #(394, 149) dot24 (.*, .eaten(eaten24));
	  dots #(394, 139) dot25 (.*, .eaten(eaten25));
	  dots #(394, 129) dot26 (.*, .eaten(eaten26));
	  dots #(394, 119) dot27 (.*, .eaten(eaten27));
	  dots #(394, 109) dot28 (.*, .eaten(eaten28));
	  dots #(394, 99) dot29 (.*, .eaten(eaten29));
	  dots #(394, 329) dot30 (.*, .eaten(eaten30)); 
	  dots #(394, 339) dot31 (.*, .eaten(eaten31)); 
	  dots #(394, 349) dot32 (.*, .eaten(eaten32)); 
	  
	  dots #(404, 349) dot33 (.*, .eaten(eaten33)); 
	  dots #(414, 349) dot34 (.*, .eaten(eaten34)); 
	  dots #(424, 349) dot35 (.*, .eaten(eaten35)); 
	  dots #(434, 349) dot36 (.*, .eaten(eaten36)); 
	  dots #(444, 349) dot37 (.*, .eaten(eaten37)); 
	  
	  dots #(444, 359) dot38 (.*, .eaten(eaten38)); 
	  dots #(444, 369) dot39 (.*, .eaten(eaten39)); 
	  dots #(444, 379) dot40 (.*, .eaten(eaten40)); 
	  
	  dots #(434, 379) dot41 (.*, .eaten(eaten41)); 
	  dots #(424, 379) dot42 (.*, .eaten(eaten42)); 
	  dots #(414, 379) dot43 (.*, .eaten(eaten43)); 
	  dots #(404, 379) dot44 (.*, .eaten(eaten44)); 
	  dots #(394, 379) dot45 (.*, .eaten(eaten45)); 
	  dots #(384, 379) dot46 (.*, .eaten(eaten46)); 
	  dots #(374, 379) dot47 (.*, .eaten(eaten47)); 
	  dots #(364, 379) dot48 (.*, .eaten(eaten48)); 
	  dots #(354, 379) dot49 (.*, .eaten(eaten49)); 
	  dots #(344, 379) dot50 (.*, .eaten(eaten50)); 
	  dots #(334, 379) dot51 (.*, .eaten(eaten51)); 
	  
	  dots #(334, 369) dot52 (.*, .eaten(eaten52)); 
	  dots #(334, 359) dot53 (.*, .eaten(eaten53)); 
	  dots #(334, 349) dot54 (.*, .eaten(eaten54)); 
	  
	  dots #(344, 349) dot55 (.*, .eaten(eaten55)); 
	  dots #(354, 349) dot56 (.*, .eaten(eaten56)); 
	  dots #(364, 349) dot57 (.*, .eaten(eaten57)); 
	  
	  dots #(364, 339) dot58 (.*, .eaten(eaten58)); 
	  dots #(364, 329) dot59 (.*, .eaten(eaten59)); 
	  
	  dots #(324, 379) dot60 (.*, .eaten(eaten60)); 
	  dots #(314, 379) dot61 (.*, .eaten(eaten61)); 
	  dots #(304, 379) dot62 (.*, .eaten(eaten62)); 

	  dots #(304, 369) dot63 (.*, .eaten(eaten63)); 
 	  dots #(304, 359) dot64 (.*, .eaten(eaten64)); 
	  dots #(304, 349) dot65 (.*, .eaten(eaten65)); 

	  dots #(294, 349) dot66 (.*, .eaten(eaten66)); 
	  dots #(284, 349) dot67 (.*, .eaten(eaten67)); 
	  dots #(274, 349) dot68 (.*, .eaten(eaten68)); 

	  dots #(274, 339) dot69 (.*, .eaten(eaten69)); 
	  dots #(274, 329) dot70 (.*, .eaten(eaten70)); 
	  dots #(274, 319) dot71 (.*, .eaten(eaten71)); 
	  
	  dots #(284, 319) dot72 (.*, .eaten(eaten72)); 
	  dots #(294, 319) dot73 (.*, .eaten(eaten73)); 
	  dots #(304, 319) dot74 (.*, .eaten(eaten74)); 
	  dots #(264, 319) dot75 (.*, .eaten(eaten75)); 
	  dots #(254, 319) dot76 (.*, .eaten(eaten76)); 
	  dots #(244, 319) dot77 (.*, .eaten(eaten77)); 
	  
	  dots #(294, 379) dot78 (.*, .eaten(eaten78)); 
	  dots #(284, 379) dot79 (.*, .eaten(eaten79)); 
	  dots #(274, 379) dot80 (.*, .eaten(eaten80)); 
	  dots #(264, 379) dot81 (.*, .eaten(eaten81)); 
	  dots #(254, 379) dot82 (.*, .eaten(eaten82)); 
	  dots #(244, 379) dot83 (.*, .eaten(eaten83)); 
	  dots #(234, 379) dot84 (.*, .eaten(eaten84)); 
	  dots #(224, 379) dot85 (.*, .eaten(eaten85)); 
	  dots #(214, 379) dot86 (.*, .eaten(eaten86)); 
	  dots #(204, 379) dot87 (.*, .eaten(eaten87)); 
	  dots #(194, 379) dot88 (.*, .eaten(eaten88)); 
	  
	  dots #(194, 369) dot89 (.*, .eaten(eaten89)); 
	  dots #(194, 359) dot90 (.*, .eaten(eaten90)); 
	  dots #(194, 349) dot91 (.*, .eaten(eaten91)); 

	  dots #(204, 349) dot92 (.*, .eaten(eaten92)); 
	  dots #(214, 349) dot93 (.*, .eaten(eaten93)); 
	  dots #(224, 349) dot94 (.*, .eaten(eaten94)); 
	  dots #(234, 349) dot95 (.*, .eaten(eaten95)); 
	  dots #(244, 349) dot96 (.*, .eaten(eaten96)); 

	  dots #(244, 339) dot97 (.*, .eaten(eaten97)); 
	  dots #(244, 329) dot98 (.*, .eaten(eaten98)); 
	  dots #(244, 309) dot99 (.*, .eaten(eaten99)); 
	  dots #(244, 299) dot100 (.*, .eaten(eaten100)); 

	  dots #(244, 289) dot101 (.*, .eaten(eaten101)); 	  
	  dots #(234, 289) dot102 (.*, .eaten(eaten102)); 
	  dots #(224, 289) dot103 (.*, .eaten(eaten103)); 
	  dots #(214, 289) dot104 (.*, .eaten(eaten104)); 
	  dots #(204, 289) dot105 (.*, .eaten(eaten105)); 
	  dots #(194, 289) dot106 (.*, .eaten(eaten106)); 
	  dots #(254, 289) dot107 (.*, .eaten(eaten107)); 	  
	  dots #(264, 289) dot108 (.*, .eaten(eaten108)); 	  
	  dots #(274, 289) dot109 (.*, .eaten(eaten109)); 	  
	  dots #(284, 289) dot110 (.*, .eaten(eaten110)); 	  
	  dots #(294, 289) dot111 (.*, .eaten(eaten111)); 	  
	  dots #(304, 289) dot112 (.*, .eaten(eaten112)); 	  

	  dots #(304, 299) dot113 (.*, .eaten(eaten113)); 	  
	  dots #(304, 309) dot114 (.*, .eaten(eaten114)); 	  
	  dots #(194, 299) dot115 (.*, .eaten(eaten115)); 
	  dots #(194, 309) dot116 (.*, .eaten(eaten116)); 
	  
	  dots #(204, 319) dot117 (.*, .eaten(eaten117)); 
	  dots #(214, 319) dot118 (.*, .eaten(eaten118));
	  
	  dots #(214, 329) dot119 (.*, .eaten(eaten119)); 
	  dots #(214, 339) dot120 (.*, .eaten(eaten120)); 
	  
	  dots #(244, 279) dot122 (.*, .eaten(eaten122)); 
	  dots #(244, 269) dot123 (.*, .eaten(eaten123)); 
	  dots #(244, 259) dot124 (.*, .eaten(eaten124)); 
	  dots #(244, 249) dot125 (.*, .eaten(eaten125)); 
	  dots #(244, 239) dot126 (.*, .eaten(eaten126)); 
	  dots #(244, 229) dot127 (.*, .eaten(eaten127)); 
	  dots #(244, 219) dot128 (.*, .eaten(eaten128)); 
	  dots #(244, 209) dot129 (.*, .eaten(eaten129)); 
	  dots #(244, 199) dot130 (.*, .eaten(eaten130)); 
	  dots #(244, 189) dot131 (.*, .eaten(eaten131)); 
	  dots #(244, 179) dot132 (.*, .eaten(eaten132)); 
	  dots #(244, 169) dot121 (.*, .eaten(eaten121)); 
	  dots #(244, 159) dot164 (.*, .eaten(eaten164)); 
	  dots #(244, 149) dot165 (.*, .eaten(eaten165)); 
	  dots #(244, 139) dot166 (.*, .eaten(eaten166)); 
	  dots #(244, 109) dot161 (.*, .eaten(eaten161)); 
	  dots #(244, 119) dot162 (.*, .eaten(eaten162)); 
	  dots #(244, 129) dot163 (.*, .eaten(eaten163)); 

	  dots #(234, 169) dot133 (.*, .eaten(eaten133)); 
	  dots #(224, 169) dot134 (.*, .eaten(eaten134)); 
	  dots #(214, 169) dot135 (.*, .eaten(eaten135)); 
	  dots #(204, 169) dot136 (.*, .eaten(eaten136)); 
	  dots #(194, 169) dot137 (.*, .eaten(eaten137)); 

	  dots #(194, 159) dot138 (.*, .eaten(eaten138)); 
	  dots #(194, 149) dot139 (.*, .eaten(eaten139)); 
	  dots #(194, 139) dot140 (.*, .eaten(eaten140)); 
	  dots #(194, 129) dot141 (.*, .eaten(eaten141)); 
	  dots #(194, 109) dot142 (.*, .eaten(eaten142)); 
	  dots #(194, 99) dot143 (.*, .eaten(eaten143)); 

	  dots #(204, 99) dot144 (.*, .eaten(eaten144)); 
	  dots #(214, 99) dot145 (.*, .eaten(eaten145)); 
	  dots #(224, 99) dot146 (.*, .eaten(eaten146)); 
	  dots #(234, 99) dot147 (.*, .eaten(eaten147)); 
	  dots #(244, 99) dot148 (.*, .eaten(eaten148)); 
	  dots #(254, 99) dot149 (.*, .eaten(eaten149)); 
	  dots #(264, 99) dot150 (.*, .eaten(eaten150)); 
	  dots #(274, 99) dot151 (.*, .eaten(eaten151)); 
	  dots #(284, 99) dot152 (.*, .eaten(eaten152)); 
	  dots #(294, 99) dot153 (.*, .eaten(eaten153)); 
	  dots #(304, 99) dot154 (.*, .eaten(eaten154)); 

	  dots #(304, 109) dot155 (.*, .eaten(eaten155)); 
	  dots #(304, 119) dot156 (.*, .eaten(eaten156)); 
	  dots #(304, 129) dot157 (.*, .eaten(eaten157)); 
	  
	  dots #(334, 109) dot158 (.*, .eaten(eaten158)); 
	  dots #(334, 119) dot159 (.*, .eaten(eaten159)); 
	  dots #(334, 129) dot160 (.*, .eaten(eaten160)); 
	  
	  dots #(234, 139) dot167 (.*, .eaten(eaten167)); 
	  dots #(224, 139) dot168 (.*, .eaten(eaten168)); 
	  dots #(214, 139) dot169 (.*, .eaten(eaten169)); 
	  dots #(204, 139) dot170 (.*, .eaten(eaten170)); 
	  dots #(254, 139) dot171 (.*, .eaten(eaten171)); 
	  dots #(264, 139) dot172 (.*, .eaten(eaten172)); 
	  dots #(274, 139) dot173 (.*, .eaten(eaten173)); 
	  dots #(284, 139) dot174 (.*, .eaten(eaten174)); 
	  dots #(294, 139) dot175 (.*, .eaten(eaten175)); 
	  dots #(304, 139) dot176 (.*, .eaten(eaten176)); 
	  dots #(314, 139) dot177 (.*, .eaten(eaten177)); 
	  dots #(324, 139) dot178 (.*, .eaten(eaten178)); 
	  dots #(334, 139) dot179 (.*, .eaten(eaten179)); 
	  dots #(344, 139) dot180 (.*, .eaten(eaten180)); 
	  dots #(354, 139) dot181 (.*, .eaten(eaten181)); 
	  dots #(364, 139) dot182 (.*, .eaten(eaten182)); 
	  dots #(374, 139) dot183 (.*, .eaten(eaten183)); 
	  dots #(384, 139) dot184 (.*, .eaten(eaten184)); 
	  dots #(404, 139) dot185 (.*, .eaten(eaten185)); 
	  dots #(414, 139) dot186 (.*, .eaten(eaten186)); 
	  dots #(424, 139) dot187 (.*, .eaten(eaten187)); 
	  dots #(434, 139) dot188 (.*, .eaten(eaten188)); 
	  dots #(444, 139) dot189 (.*, .eaten(eaten189)); 
	  
	  dots #(334, 99) dot190 (.*, .eaten(eaten190)); 
	  dots #(344, 99) dot191 (.*, .eaten(eaten191)); 
	  dots #(354, 99) dot192 (.*, .eaten(eaten192)); 
	  dots #(364, 99) dot193 (.*, .eaten(eaten193)); 
	  dots #(374, 99) dot194 (.*, .eaten(eaten194)); 
	  dots #(384, 99) dot195 (.*, .eaten(eaten195)); 
	  dots #(404, 99) dot196 (.*, .eaten(eaten196)); 
	  dots #(414, 99) dot197 (.*, .eaten(eaten197)); 
	  dots #(424, 99) dot198 (.*, .eaten(eaten198)); 
	  dots #(434, 99) dot199 (.*, .eaten(eaten199)); 
	  dots #(444, 99) dot200 (.*, .eaten(eaten200)); 

	  dots #(274, 149) dot201 (.*, .eaten(eaten201)); 
	  dots #(274, 159) dot202 (.*, .eaten(eaten202)); 
	  dots #(274, 169) dot203 (.*, .eaten(eaten203)); 

	  dots #(364, 149) dot204 (.*, .eaten(eaten204)); 
	  dots #(364, 159) dot205 (.*, .eaten(eaten205)); 
	  dots #(364, 169) dot206 (.*, .eaten(eaten206)); 

	  dots #(444, 149) dot207 (.*, .eaten(eaten207)); 
	  dots #(444, 159) dot208 (.*, .eaten(eaten208)); 
	  dots #(444, 169) dot209 (.*, .eaten(eaten209)); 
	  
	  dots #(444, 109) dot210 (.*, .eaten(eaten210)); 
	  dots #(444, 129) dot211 (.*, .eaten(eaten211)); 

	  dots #(284, 169) dot212 (.*, .eaten(eaten212)); 
	  dots #(294, 169) dot213 (.*, .eaten(eaten213)); 
	  dots #(304, 169) dot214 (.*, .eaten(eaten214)); 

	  dots #(334, 169) dot215 (.*, .eaten(eaten215)); 
	  dots #(344, 169) dot216 (.*, .eaten(eaten216)); 
	  dots #(354, 169) dot217 (.*, .eaten(eaten217)); 
	  
	  dots #(404, 169) dot218 (.*, .eaten(eaten218)); 
	  dots #(414, 169) dot219 (.*, .eaten(eaten219)); 
	  dots #(424, 169) dot220 (.*, .eaten(eaten220)); 
	  dots #(434, 169) dot221 (.*, .eaten(eaten221)); 
	
	  dots #(334, 309) dot222 (.*, .eaten(eaten222));
	  dots #(334, 299) dot223 (.*, .eaten(eaten223));
	  
	  dots #(444, 309) dot224 (.*, .eaten(eaten224));
	  dots #(444, 299) dot225 (.*, .eaten(eaten225));
	  
	  dots #(334, 289) dot237 (.*, .eaten(eaten237));
	  dots #(344, 289) dot226 (.*, .eaten(eaten226));
	  dots #(354, 289) dot227 (.*, .eaten(eaten227));
	  dots #(364, 289) dot228 (.*, .eaten(eaten228));
	  dots #(374, 289) dot229 (.*, .eaten(eaten229));
	  dots #(384, 289) dot230 (.*, .eaten(eaten230));
	  dots #(394, 289) dot231 (.*, .eaten(eaten231));

	  dots #(404, 289) dot232 (.*, .eaten(eaten232));
	  dots #(414, 289) dot233 (.*, .eaten(eaten233));
	  dots #(424, 289) dot234 (.*, .eaten(eaten234));
	  dots #(434, 289) dot235 (.*, .eaten(eaten235));
	  dots #(444, 289) dot236 (.*, .eaten(eaten236));
	  
	  dots #(424, 319) dot241 (.*, .eaten(eaten241));
	  dots #(434, 319) dot238 (.*, .eaten(eaten238));
	  dots #(424, 329) dot239 (.*, .eaten(eaten239));
	  dots #(424, 339) dot240 (.*, .eaten(eaten240));
	  
		
	 always_comb
	 begin
		if(scoreHundreds_on == 1'b1)
			address_rom = (48 + scoreHundreds) * 16 + DrawY - 68;
		else if(scoreTens_on == 1'b1)
			address_rom = (48 + scoreTens) * 16 + DrawY - 68;
		else if(scoreOnes_on == 1'b1)
			address_rom = (48 + scoreOnes) * 16 + DrawY - 68;
		else if(zero == 1'b1)
			address_rom = (8'h30) * 16 + DrawY - 68;
		else if(g_on == 1'b1)
			address_rom = (8'h47) * 16 + DrawY - 68;
		else if(a_on == 1'b1)
			address_rom = (8'h41) * 16 + DrawY - 68;
		else if(m_on == 1'b1)
			address_rom = (8'h4d) * 16 + DrawY - 68;
		else if(e_on == 1'b1)
			address_rom = (8'h45) * 16 + DrawY - 68;
		else if(o_on == 1'b1)
			address_rom = (8'h4f) * 16 + DrawY - 68;
		else if(v_on == 1'b1)
			address_rom = (8'h56) * 16 + DrawY - 68;
		else if(e2_on == 1'b1)
			address_rom = (8'h45) * 16 + DrawY - 68;
		else if(r_on == 1'b1)
			address_rom = (8'h52) * 16 + DrawY - 68;
		else
			address_rom = 11'b00000;
	 end
		
	  always_comb
    begin:Ball_on_proc
        if ((DrawX >= PacX - SizeP) && (DrawX <= PacX + SizeP) && (DrawY >= PacY - SizeP) && (DrawY <= PacY + SizeP))
            Pac_on = 1'b1;
			else
				Pac_on = 1'b0;
//				
//		  else if ((DrawX >= PacX - SizeP) && (DrawX <= PacX + SizeP) && (DrawY >= PacY - SizeP) && (DrawY <= PacY + SizeP) && PacXM == -1)
//            Pac_onL = 1'b1;
//				
//		  else if ((DrawX >= PacX - SizeP) && (DrawX <= PacX + SizeP) && (DrawY >= PacY - SizeP) && (DrawY <= PacY + SizeP) && PacYM == -1)
//            Pac_onU = 1'b1;
//      
//		  else if ((DrawX >= PacX - SizeP) && (DrawX <= PacX + SizeP) && (DrawY >= PacY - SizeP) && (DrawY <= PacY + SizeP) && PacYM == 1)
//            Pac_onD = 1'b1;
//      
//		  else ((DrawX >= PacX - SizeP) && (DrawX <= PacX + SizeP) && (DrawY >= PacY - SizeP) && (DrawY <= PacY + SizeP) && PacYM == 0 && PacXM == 0)
//				Pac_onR = 1'b1;
        if ((PacX + SizeP >= rghostX - SizeP) && (PacX - SizeP <= rghostX + SizeP) && (PacY + SizeP >= rghostY - SizeP) && (PacY - SizeP <= rghostY + SizeP))
            game_over = 1'b1;
			else if ((PacX + SizeP >= bghostX - SizeP) && (PacX - SizeP <= bghostX + SizeP) && (PacY + SizeP >= bghostY - SizeP) && (PacY - SizeP <= bghostY + SizeP))
            game_over = 1'b1;
			else if ((PacX + SizeP >= oghostX - SizeP) && (PacX - SizeP <= oghostX + SizeP) && (PacY + SizeP >= oghostY - SizeP) && (PacY - SizeP <= oghostY + SizeP))
            game_over = 1'b1;
			else if ((PacX + SizeP >= pghostX - SizeP) && (PacX - SizeP <= pghostX + SizeP) && (PacY + SizeP >= pghostY - SizeP) && (PacY - SizeP <= pghostY + SizeP))
            game_over = 1'b1;
        else 
            game_over = 1'b0;
				
		  if ((DrawX >= rghostX - SizeP) && (DrawX <= rghostX + SizeP) && (DrawY >= rghostY - SizeP) && (DrawY <= rghostY + SizeP))
            Rghost_on = 1'b1;
        else 
            Rghost_on = 1'b0;
				
			if ((DrawX >= bghostX - SizeP) && (DrawX <= bghostX + SizeP) && (DrawY >= bghostY - SizeP) && (DrawY <= bghostY + SizeP))
            Bghost_on = 1'b1;
        else 
            Bghost_on = 1'b0;
				
			if ((DrawX >= oghostX - SizeP) && (DrawX <= oghostX + SizeP) && (DrawY >= oghostY - SizeP) && (DrawY <= oghostY + SizeP))
            Oghost_on = 1'b1;
        else 
            Oghost_on = 1'b0;
				
			if ((DrawX >= pghostX - SizeP) && (DrawX <= pghostX + SizeP) && (DrawY >= pghostY - SizeP) && (DrawY <= pghostY + SizeP))
            Pghost_on = 1'b1;
        else 
            Pghost_on = 1'b0;
				
			if(DrawX >= 184 && DrawX <= 191 && DrawY >= 68 && DrawY <= 84)
				scoreHundreds_on = 1'b1; 
			else
				scoreHundreds_on = 1'b0; 
				
			if(DrawX >= 192 && DrawX <= 199 && DrawY >= 68 && DrawY <= 84)
				scoreTens_on = 1'b1; 
			else
				scoreTens_on = 1'b0; 
				
			if(DrawX >= 200 && DrawX <= 207 && DrawY >= 68 && DrawY <= 84)
				scoreOnes_on = 1'b1; 
			else
				scoreOnes_on = 1'b0; 

			if(DrawX >= 208 && DrawX <= 215 && DrawY >= 68 && DrawY <= 84)
				zero = 1'b1; 
			else
				zero = 1'b0; 
				 
			if(DrawX >= 288 && DrawX <= 295 && DrawY >= 68 && DrawY <= 84)
				g_on = 1'b1; 
			else
				g_on = 1'b0; 
			if(DrawX >= 296 && DrawX <= 303 && DrawY >= 68 && DrawY <= 84)
				a_on = 1'b1; 
			else
				a_on = 1'b0; 
			if(DrawX >= 304 && DrawX <= 311 && DrawY >= 68 && DrawY <= 84)
				m_on = 1'b1; 
			else
				m_on = 1'b0; 
			if(DrawX >= 312 && DrawX <= 319 && DrawY >= 68 && DrawY <= 84)
				e_on = 1'b1; 
			else
				e_on = 1'b0; 
			if(DrawX >= 320 && DrawX <= 327 && DrawY >= 68 && DrawY <= 84)
				o_on = 1'b1; 
			else
				o_on = 1'b0; 
			if(DrawX >= 328 && DrawX <= 335 && DrawY >= 68 && DrawY <= 84)
				v_on = 1'b1; 
			else
				v_on = 1'b0; 
			if(DrawX >= 336 && DrawX <= 343 && DrawY >= 68 && DrawY <= 84)
				e2_on = 1'b1; 
			else
				e2_on = 1'b0; 
			if(DrawX >= 344 && DrawX <= 351 && DrawY >= 68 && DrawY <= 84)
				r_on = 1'b1; 
			else
				r_on = 1'b0; 
		
			if((DrawX == PacX - 8))
					xline = 1'b1;
			else
				xline = 1'b0;
			if((DrawX == PacX + 8))
					xline2 = 1'b1;
			else
				xline2 = 1'b0;
			if((DrawY == PacY + 8))
					yline2 = 1'b1;
			else
				yline2 = 1'b0;
			if((DrawY == PacY - 8))
					yline3 = 1'b1;
			else
				yline3 = 1'b0;
			if(DrawY == 160)
				yline = 1'b1;
			else
				yline = 1'b0;
				
				
     end 
     
    always_comb
    begin:RGB_Display
		if(cherry_collided)
			score = eatenScore + 11'd50;
		else
			score = eatenScore;
			
		eatenScore = eaten1 + eaten2 + eaten3 + eaten4 + eaten5 + eaten6 + eaten7 + eaten8 + eaten9 + eaten10 + eaten11 + eaten12 + eaten13 + eaten14 
	  + eaten15 + eaten16 + eaten17 + eaten18 + eaten19 + eaten20 + eaten21 + eaten22 + eaten23 + eaten24 + eaten25 + eaten26 + eaten27
	  + eaten28 + eaten29 + eaten30 + eaten31 + eaten32 + eaten33 + eaten34 + eaten35 + eaten36 + eaten37 + eaten38 + eaten39 + eaten40
	  + eaten41 + eaten42 + eaten43 + eaten44 + eaten45 + eaten46 + eaten47 + eaten48 + eaten49 + eaten50 + eaten51 + eaten52 + eaten53
	  + eaten54 + eaten55 + eaten56 + eaten57 + eaten58 + eaten59 + eaten60 + eaten61 + eaten62 + eaten63 + eaten64 + eaten65 + eaten66
	  + eaten67 + eaten68 + eaten69 + eaten70 + eaten71 + eaten72 + eaten73 + eaten74 + eaten75 + eaten76 + eaten77 + eaten78 + eaten79
	  + eaten80 + eaten81 + eaten82 + eaten83 + eaten84 + eaten85 + eaten86 + eaten87 + eaten88 + eaten89
	  + eaten90 + eaten91 + eaten92 + eaten93 + eaten94 + eaten95 + eaten96 + eaten97 + eaten98  + eaten99
	  + eaten100 + eaten101 + eaten102 + eaten103 + eaten104 + eaten105 + eaten106 + eaten107 + eaten108 + eaten109
	  + eaten110 + eaten111 + eaten112 + eaten113 + eaten114 + eaten115 + eaten116 + eaten117 + eaten118 + eaten119
	  + eaten120 + eaten121 + eaten122 + eaten123 + eaten124 + eaten125 + eaten126 + eaten127 + eaten128 + eaten129
	  + eaten130 + eaten131 + eaten132 + eaten133 + eaten134 + eaten135 + eaten136 + eaten137 + eaten138 + eaten139
	  + eaten140 + eaten141 + eaten142 + eaten143 + eaten144 + eaten145 + eaten146 + eaten147 + eaten148 + eaten149
	  + eaten150 + eaten151 + eaten152 + eaten153 + eaten154 + eaten155 + eaten156 + eaten157 + eaten158 + eaten159
	  + eaten160 + eaten161 + eaten162 + eaten163 + eaten164 + eaten165 + eaten166 + eaten167 + eaten168 + eaten169
	  + eaten170 + eaten171 + eaten172 + eaten173 + eaten174 + eaten175 + eaten176 + eaten177 + eaten178 + eaten179
	  + eaten180 + eaten181 + eaten182 + eaten183 + eaten184 + eaten185 + eaten186 + eaten187 + eaten188 + eaten189
	  + eaten190 + eaten191 + eaten192 + eaten193 + eaten194 + eaten195 + eaten196 + eaten197 + eaten198 + eaten199
	  + eaten200 + eaten201 + eaten202 + eaten203 + eaten204 + eaten205 + eaten206 + eaten207 + eaten208 + eaten209
	  + eaten210 + eaten211 + eaten212 + eaten213 + eaten214 + eaten215 + eaten216 + eaten217 + eaten218 + eaten219
	  + eaten220 + eaten221 + eaten222 + eaten223 + eaten224 + eaten225 + eaten226 + eaten227 + eaten228 + eaten229
	  + eaten230 + eaten231 + eaten232 + eaten233 + eaten234 + eaten235 + eaten236 + eaten237 + eaten238 + eaten239 + eaten240 + eaten241;

	   scoreOnes = score % 10;
		scoreTens = (score / 10) % 10;
		scoreHundreds = score / 100;
		
//	if(game_over == 1'b0)
//		begin
			  if ((Pac_on == 1'b1))
			  begin
					if(PacXM > 11'd10)
					begin
						if(open_close && game_over == 1'b0)
						  begin 
								Red = pac_outL[23:16];
								Green = pac_outL[15:8];
								Blue = pac_outL[7:0];
						  end
						 else
							begin
								Red = pac_outCL[23:16];
								Green = pac_outCL[15:8];
								Blue = pac_outCL[7:0];
							end
					end
					else if(PacYM > 11'd10)
					begin
						if(open_close && game_over == 1'b0)
						  begin 
								Red = pac_outU[23:16];
								Green = pac_outU[15:8];
								Blue = pac_outU[7:0];
						  end
						  else
							begin
								Red = pac_outCU[23:16];
								Green = pac_outCU[15:8];
								Blue = pac_outCU[7:0];
							end
					end
					else if(PacYM == 11'd1)
					begin
						if(open_close && game_over == 1'b0)
						  begin 
								Red = pac_outD[23:16];
								Green = pac_outD[15:8];
								Blue = pac_outD[7:0];
						  end
						  else
							begin
								Red = pac_outCD[23:16];
								Green = pac_outCD[15:8];
								Blue = pac_outCD[7:0];
							end
					end
					else 
					begin 
						if(open_close && game_over == 1'b0 && play == 1'b1)
						begin
							Red = pac_outR[23:16];
							Green = pac_outR[15:8];
							Blue = pac_outR[7:0];
						end
						else
						begin
							Red = pac_outCR[23:16];
							Green = pac_outCR[15:8];
							Blue = pac_outCR[7:0];
						end
					end
				end
				else if(scoreHundreds_on == 1'b1)
						begin
							if(fontdata[191 - DrawX] == 1'b1)
							begin
								Red = 8'hff;
								Green = 8'hff;
								Blue = 8'hff;
							end
							else
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h00;
							end
						end
				else if(scoreTens_on == 1'b1)
						begin
							if(fontdata[199 - DrawX] == 1'b1)
							begin
								Red = 8'hff;
								Green = 8'hff;
								Blue = 8'hff;
							end
							else
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h00;
							end
						end
				else if(scoreOnes_on == 1'b1)
						begin
							if(fontdata[207 - DrawX] == 1'b1)
							begin
								Red = 8'hff;
								Green = 8'hff;
								Blue = 8'hff;
							end
							else
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h00;
							end
						end
				else if(zero == 1'b1)
						begin
							if(fontdata[215 - DrawX] == 1'b1)
							begin
								Red = 8'hff;
								Green = 8'hff;
								Blue = 8'hff;
							end
							else
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h00;
							end
						end
				else if(g_on == 1'b1 && game_over)
						begin
							if(fontdata[295 - DrawX] == 1'b1 && open_close)
							begin
								Red = 8'hff;
								Green = 8'hff;
								Blue = 8'hff;
							end
							else
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h00;
							end
						end
				else if(a_on == 1'b1 && game_over)
						begin
							if(fontdata[303 - DrawX] == 1'b1 && open_close)
							begin
								Red = 8'hff;
								Green = 8'hff;
								Blue = 8'hff;
							end
							else
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h00;
							end
						end
				else if(m_on == 1'b1 && game_over)
						begin
							if(fontdata[311 - DrawX] == 1'b1 && open_close)
							begin
								Red = 8'hff;
								Green = 8'hff;
								Blue = 8'hff;
							end
							else
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h00;
							end
						end
				else if(e_on == 1'b1 && game_over)
						begin
							if(fontdata[319 - DrawX] == 1'b1 && open_close)
							begin
								Red = 8'hff;
								Green = 8'hff;
								Blue = 8'hff;
							end
							else
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h00;
							end
						end
				else if(o_on == 1'b1 && game_over)
						begin
							if(fontdata[327 - DrawX] == 1'b1 && open_close)
							begin
								Red = 8'hff;
								Green = 8'hff;
								Blue = 8'hff;
							end
							else
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h00;
							end
						end
				else if(v_on == 1'b1 && game_over)
						begin
							if(fontdata[335 - DrawX] == 1'b1 && open_close)
							begin
								Red = 8'hff;
								Green = 8'hff;
								Blue = 8'hff;
							end
							else
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h00;
							end
						end
				else if(e2_on == 1'b1 && game_over)
						begin
							if(fontdata[343 - DrawX] == 1'b1 && open_close)
							begin
								Red = 8'hff;
								Green = 8'hff;
								Blue = 8'hff;
							end
							else
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h00;
							end
						end
				else if(r_on == 1'b1 && game_over)
						begin
							if(fontdata[351 - DrawX] == 1'b1 && open_close)
							begin
								Red = 8'hff;
								Green = 8'hff;
								Blue = 8'hff;
							end
							else
							begin
								Red = 8'h00;
								Green = 8'h00;
								Blue = 8'h00;
							end
						end

	//		  else if ((Pac_onL == 1'b1)) 
	//        begin 
	//				Red = pac_outL[23:16];
	//				Green = pac_outL[15:8];
	//				Blue = pac_outL[7:0];
	//        end
	//		  else if ((Pac_onU== 1'b1)) 
	//        begin 
	//				Red = pac_outU[23:16];
	//				Green = pac_outU[15:8];
	//				Blue = pac_outU[7:0];
	//        end
	//		  else if ((Pac_onD == 1'b1)) 
	//        begin 
	//				Red = pac_outD[23:16];
	//				Green = pac_outD[15:8];
	//				Blue = pac_outD[7:0];
	//        end

	// *** GHOSTS SHIT START ***
			  else if ((Rghost_on == 1'b1)) 
			  begin 
					Red = rghost_out[23:16];
					Green = rghost_out[15:8];
					Blue = rghost_out[7:0];
			  end
			  else if ((Bghost_on == 1'b1)) 
			  begin 
					Red = bghost_out[23:16];
					Green = bghost_out[15:8];
					Blue = bghost_out[7:0];
			  end
			  else if ((Oghost_on == 1'b1)) 
			  begin 
					Red = oghost_out[23:16];
					Green = oghost_out[15:8];
					Blue = oghost_out[7:0];
			  end
			  else if ((Pghost_on == 1'b1)) 
			  begin 
					Red = pghost_out[23:16];
					Green = pghost_out[15:8];
					Blue = pghost_out[7:0];
			  end
	// *** GHOSTS SHIT END ***

	//		  else if (DrawX >= 5 & DrawX < 21 & DrawY >= 5 & DrawY < 21) 
	//		  begin
	//				Red = pac_out[23:16];
	//				Green = pac_out[16:8];
	//				Blue = pac_out[7:0];		  
	//			
	//		  end
//				else if (DrawX == 100 && game_over) 
//	        begin 
//					Red = 8'b11111111;
//					Green = 0;
//					Blue = 0;
//	        end
	//		  else if ((yline2 == 1'b1)) 
	//        begin 
	//				Red = 0;
	//				Green = 8'b11111111;
	//				Blue = 0;
	//        end
	//		  else if ((yline3 == 1'b1)) 
	//        begin 
	//				Red = 0;
	//				Green = 8'b11111111;
	//				Blue = 0;
	//        end
	//		  else if ((yline == 1'b1)) 
	//        begin 
	//				Red =  8'b11111111;
	//				Green = 0;
	//				Blue = 0;
	//        end
				else if(eaten1 && DrawX >= 334 && DrawX <= (334 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten2 && DrawX >= 344 && DrawX <= (344 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten3 && DrawX >= 354 && DrawX <= (354 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten4 && DrawX >= 364 && DrawX <= (364 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten5 && DrawX >= 374 && DrawX <= (374 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten6 && DrawX >= 384 && DrawX <= (384 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten7 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten8 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 309 && DrawY <= (309 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten9 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 299 && DrawY <= (299 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten10 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten11 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 279 && DrawY <= (279 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten12 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 269 && DrawY <= (269 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten13 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 259 && DrawY <= (259 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten14 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 249 && DrawY <= (249 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten15 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 239 && DrawY <= (239 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten16 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 229 && DrawY <= (229 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten17 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 219 && DrawY <= (219 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten18 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 209 && DrawY <= (209 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten19 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 199 && DrawY <= (199 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten20 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 189 && DrawY <= (189 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten21 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 179 && DrawY <= (179 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten22 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten23 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 159 && DrawY <= (159 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten24 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 149 && DrawY <= (149 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten25 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten26 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 129 && DrawY <= (129 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten27 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 119 && DrawY <= (119 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten28 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 109 && DrawY <= (109 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten29 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten30 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 329 && DrawY <= (329 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten31 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 339 && DrawY <= (339 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten32 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten33 && DrawX >= 404 && DrawX <= (404 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten34 && DrawX >= 414 && DrawX <= (414 + 3) && DrawY >= 349 && DrawY <= (349 + 3)) // 414 + 4
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten35 && DrawX >= 424 && DrawX <= (424 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten36 && DrawX >= 434 && DrawX <= (434 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten37 && DrawX >= 444 && DrawX <= (444 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten38 && DrawX >= 444 && DrawX <= (444 + 3) && DrawY >= 359 && DrawY <= (359 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten39 && DrawX >= 444 && DrawX <= (444 + 3) && DrawY >= 369 && DrawY <= (369 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten40 && DrawX >= 444 && DrawX <= (444 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten41 && DrawX >= 434 && DrawX <= (434 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten42 && DrawX >= 424 && DrawX <= (424 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten43 && DrawX >= 414 && DrawX <= (414 + 3) && DrawY >= 379 && DrawY <= (379 + 3)) // 414 + 4
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten44 && DrawX >= 404 && DrawX <= (404 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten45 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten46 && DrawX >= 384 && DrawX <= (384 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten47 && DrawX >= 374 && DrawX <= (374 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten48 && DrawX >= 364 && DrawX <= (364 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten49 && DrawX >= 354 && DrawX <= (354 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten50 && DrawX >= 344 && DrawX <= (344 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten51 && DrawX >= 334 && DrawX <= (334 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten52 && DrawX >= 334 && DrawX <= (334 + 3) && DrawY >= 369 && DrawY <= (369 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten53 && DrawX >= 334 && DrawX <= (334 + 3) && DrawY >= 359 && DrawY <= (359 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten54 && DrawX >= 334 && DrawX <= (334 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten55 && DrawX >= 344 && DrawX <= (344 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten56 && DrawX >= 354 && DrawX <= (354 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten57 && DrawX >= 364 && DrawX <= (364 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten58 && DrawX >= 364 && DrawX <= (364 + 3) && DrawY >= 339 && DrawY <= (339 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten59 && DrawX >= 364 && DrawX <= (364 + 3) && DrawY >= 329 && DrawY <= (329 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten60 && DrawX >= 324 && DrawX <= (324 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten61 && DrawX >= 314 && DrawX <= (314 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten62 && DrawX >= 304 && DrawX <= (304 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten63 && DrawX >= 304 && DrawX <= (304 + 3) && DrawY >= 369 && DrawY <= (369 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten64 && DrawX >= 304 && DrawX <= (304 + 3) && DrawY >= 359 && DrawY <= (359 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten65 && DrawX >= 304 && DrawX <= (304 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten66 && DrawX >= 294 && DrawX <= (294 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten67 && DrawX >= 284 && DrawX <= (284 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten68 && DrawX >= 274 && DrawX <= (274 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten69 && DrawX >= 274 && DrawX <= (274 + 3) && DrawY >= 339 && DrawY <= (339 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten70 && DrawX >= 274 && DrawX <= (274 + 3) && DrawY >= 329 && DrawY <= (329 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten71 && DrawX >= 274 && DrawX <= (274 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten72 && DrawX >= 284 && DrawX <= (284 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten73 && DrawX >= 294 && DrawX <= (294 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten74 && DrawX >= 304 && DrawX <= (304 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten75 && DrawX >= 264 && DrawX <= (264 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten76 && DrawX >= 254 && DrawX <= (254 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten77 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten78 && DrawX >= 294 && DrawX <= (294 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten79 && DrawX >= 284 && DrawX <= (284 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten80 && DrawX >= 274 && DrawX <= (274 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten81 && DrawX >= 264 && DrawX <= (264 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten82 && DrawX >= 254 && DrawX <= (254 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten83 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten84 && DrawX >= 234 && DrawX <= (234 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten85 && DrawX >= 224 && DrawX <= (224 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten86 && DrawX >= 214 && DrawX <= (214 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten87 && DrawX >= 204 && DrawX <= (204 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten88 && DrawX >= 194 && DrawX <= (194 + 3) && DrawY >= 379 && DrawY <= (379 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten89 && DrawX >= 194 && DrawX <= (194 + 3) && DrawY >= 369 && DrawY <= (369 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten90 && DrawX >= 194 && DrawX <= (194 + 3) && DrawY >= 359 && DrawY <= (359 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten91 && DrawX >= 194 && DrawX <= (194 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten92 && DrawX >= 204 && DrawX <= (204 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten93 && DrawX >= 214 && DrawX <= (214 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten94 && DrawX >= 224 && DrawX <= (224 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten95 && DrawX >= 234 && DrawX <= (234 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten96 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 349 && DrawY <= (349 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten97 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 339 && DrawY <= (339 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten98 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 329 && DrawY <= (329 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten99 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 309 && DrawY <= (309 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten100 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 299 && DrawY <= (299 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten101 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten102 && DrawX >= 234 && DrawX <= (234 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten103 && DrawX >= 224 && DrawX <= (224 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten104 && DrawX >= 214 && DrawX <= (214 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten105 && DrawX >= 204 && DrawX <= (204 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten106 && DrawX >= 194 && DrawX <= (194 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten107 && DrawX >= 254 && DrawX <= (254 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten108 && DrawX >= 264 && DrawX <= (264 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten109 && DrawX >= 274 && DrawX <= (274 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten110 && DrawX >= 284 && DrawX <= (284 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten111 && DrawX >= 294 && DrawX <= (294 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten112 && DrawX >= 304 && DrawX <= (304 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten113 && DrawX >= 304 && DrawX <= (304 + 3) && DrawY >= 299 && DrawY <= (299 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten114 && DrawX >= 304 && DrawX <= (304 + 3) && DrawY >= 309 && DrawY <= (309 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten115 && DrawX >= 194 && DrawX <= (194 + 3) && DrawY >= 299 && DrawY <= (299 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten116 && DrawX >= 194 && DrawX <= (194 + 3) && DrawY >= 309 && DrawY <= (309 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten117 && DrawX >= 204 && DrawX <= (204 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten118 && DrawX >= 214 && DrawX <= (214 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten119 && DrawX >= 214 && DrawX <= (214 + 3) && DrawY >= 329 && DrawY <= (329 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten120 && DrawX >= 214 && DrawX <= (214 + 3) && DrawY >= 339 && DrawY <= (339 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten121 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten122 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 279 && DrawY <= (279 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten123 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 269 && DrawY <= (269 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten124 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 259 && DrawY <= (259 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten125 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 249 && DrawY <= (249 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten126 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 239 && DrawY <= (239 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten127 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 229 && DrawY <= (229 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten128 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 219 && DrawY <= (219 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten129 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 209 && DrawY <= (209 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten130 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 199 && DrawY <= (199 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten131 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 189 && DrawY <= (189 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten132 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 179 && DrawY <= (179 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten133 && DrawX >= 234 && DrawX <= (234 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten134 && DrawX >= 224 && DrawX <= (224 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten135 && DrawX >= 214 && DrawX <= (214 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten136 && DrawX >= 204 && DrawX <= (204 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten137 && DrawX >= 194 && DrawX <= (194 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten138 && DrawX >= 194 && DrawX <= (194 + 3) && DrawY >= 159 && DrawY <= (159 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten139 && DrawX >= 194 && DrawX <= (194 + 3) && DrawY >= 149 && DrawY <= (149 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten140 && DrawX >= 194 && DrawX <= (194 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten141 && DrawX >= 194 && DrawX <= (194 + 3) && DrawY >= 129 && DrawY <= (129 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten142 && DrawX >= 194 && DrawX <= (194 + 3) && DrawY >= 109 && DrawY <= (109 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten143 && DrawX >= 194 && DrawX <= (194 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten144 && DrawX >= 204 && DrawX <= (204 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten145 && DrawX >= 214 && DrawX <= (214 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten146 && DrawX >= 224 && DrawX <= (224 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten147 && DrawX >= 234 && DrawX <= (234 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten148 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten149 && DrawX >= 254 && DrawX <= (254 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten150 && DrawX >= 264 && DrawX <= (264 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten151 && DrawX >= 274 && DrawX <= (274 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten152 && DrawX >= 284 && DrawX <= (284 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten153 && DrawX >= 294 && DrawX <= (294 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten154 && DrawX >= 304 && DrawX <= (304 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten155 && DrawX >= 304 && DrawX <= (304 + 3) && DrawY >= 109 && DrawY <= (109 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten156 && DrawX >= 304 && DrawX <= (304 + 3) && DrawY >= 119 && DrawY <= (119 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten157 && DrawX >= 304 && DrawX <= (304 + 3) && DrawY >= 129 && DrawY <= (129 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten158 && DrawX >= 334 && DrawX <= (334 + 3) && DrawY >= 109 && DrawY <= (109 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten159 && DrawX >= 334 && DrawX <= (334 + 3) && DrawY >= 119 && DrawY <= (119 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten160 && DrawX >= 334 && DrawX <= (334 + 3) && DrawY >= 129 && DrawY <= (129 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten161 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 109 && DrawY <= (109 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten162 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 119 && DrawY <= (119 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten163 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 129 && DrawY <= (129 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten164 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 159 && DrawY <= (159 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten165 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 149 && DrawY <= (149 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten166 && DrawX >= 244 && DrawX <= (244 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten167 && DrawX >= 234 && DrawX <= (234 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten168 && DrawX >= 224 && DrawX <= (224 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten169 && DrawX >= 214 && DrawX <= (214 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten170 && DrawX >= 204 && DrawX <= (204 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten171 && DrawX >= 254 && DrawX <= (254 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten172 && DrawX >= 264 && DrawX <= (264 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten173 && DrawX >= 274 && DrawX <= (274 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten174 && DrawX >= 284 && DrawX <= (284 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten175 && DrawX >= 294 && DrawX <= (294 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten176 && DrawX >= 304 && DrawX <= (304 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten177 && DrawX >= 314 && DrawX <= (314 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten178 && DrawX >= 324 && DrawX <= (324 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten179 && DrawX >= 334 && DrawX <= (334 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten180 && DrawX >= 344 && DrawX <= (344 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten181 && DrawX >= 354 && DrawX <= (354 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten182 && DrawX >= 364 && DrawX <= (364 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten183 && DrawX >= 374 && DrawX <= (374 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten184 && DrawX >= 384 && DrawX <= (384 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten185 && DrawX >= 404 && DrawX <= (404 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten186 && DrawX >= 414 && DrawX <= (414 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten187 && DrawX >= 424 && DrawX <= (424 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten188 && DrawX >= 434 && DrawX <= (434 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten189 && DrawX >= 444 && DrawX <= (444 + 3) && DrawY >= 139 && DrawY <= (139 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten190 && DrawX >= 334 && DrawX <= (334 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten191 && DrawX >= 344 && DrawX <= (344 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten192 && DrawX >= 354 && DrawX <= (354 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten193 && DrawX >= 364 && DrawX <= (364 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten194 && DrawX >= 374 && DrawX <= (374 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten195 && DrawX >= 384 && DrawX <= (384 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten196 && DrawX >= 404 && DrawX <= (404 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten197 && DrawX >= 414 && DrawX <= (414 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten198 && DrawX >= 424 && DrawX <= (424 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten199 && DrawX >= 434 && DrawX <= (434 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten200 && DrawX >= 444 && DrawX <= (444 + 3) && DrawY >= 99 && DrawY <= (99 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten201 && DrawX >= 274 && DrawX <= (274 + 3) && DrawY >= 149 && DrawY <= (149 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten202 && DrawX >= 274 && DrawX <= (274 + 3) && DrawY >= 159 && DrawY <= (159 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten203 && DrawX >= 274 && DrawX <= (274 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten204 && DrawX >= 364 && DrawX <= (364 + 3) && DrawY >= 149 && DrawY <= (149 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten205 && DrawX >= 364 && DrawX <= (364 + 3) && DrawY >= 159 && DrawY <= (159 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten206 && DrawX >= 364 && DrawX <= (364 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten207 && DrawX >= 444 && DrawX <= (444 + 3) && DrawY >= 149 && DrawY <= (149 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten208 && DrawX >= 444 && DrawX <= (444 + 3) && DrawY >= 159 && DrawY <= (159 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten209 && DrawX >= 444 && DrawX <= (444 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten210 && DrawX >= 444 && DrawX <= (444 + 3) && DrawY >= 109 && DrawY <= (109 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten211 && DrawX >= 444 && DrawX <= (444 + 3) && DrawY >= 129 && DrawY <= (129 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten212 && DrawX >= 284 && DrawX <= (284 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten213 && DrawX >= 294 && DrawX <= (294 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten214 && DrawX >= 304 && DrawX <= (304 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten215 && DrawX >= 334 && DrawX <= (334 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten216 && DrawX >= 344 && DrawX <= (344 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten217 && DrawX >= 354 && DrawX <= (354 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten218 && DrawX >= 404 && DrawX <= (404 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten219 && DrawX >= 414 && DrawX <= (414 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten220 && DrawX >= 424 && DrawX <= (424 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten221 && DrawX >= 434 && DrawX <= (434 + 3) && DrawY >= 169 && DrawY <= (169 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten222 && DrawX >= 334 && DrawX <= (334 + 3) && DrawY >= 309 && DrawY <= (309 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten223 && DrawX >= 334 && DrawX <= (334 + 3) && DrawY >= 299 && DrawY <= (299 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten224 && DrawX >= 444 && DrawX <= (444 + 3) && DrawY >= 309 && DrawY <= (309 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten225 && DrawX >= 444 && DrawX <= (444 + 3) && DrawY >= 299 && DrawY <= (299 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten226 && DrawX >= 344 && DrawX <= (344 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten227 && DrawX >= 354 && DrawX <= (354 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten228 && DrawX >= 364 && DrawX <= (364 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten229 && DrawX >= 374 && DrawX <= (374 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten230 && DrawX >= 384 && DrawX <= (384 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten231 && DrawX >= 394 && DrawX <= (394 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten232 && DrawX >= 404 && DrawX <= (404 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten233 && DrawX >= 414 && DrawX <= (414 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten234 && DrawX >= 424 && DrawX <= (424 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten235 && DrawX >= 434 && DrawX <= (434 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten236 && DrawX >= 444 && DrawX <= (444 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten237 && DrawX >= 334 && DrawX <= (334 + 3) && DrawY >= 289 && DrawY <= (289 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten238 && DrawX >= 434 && DrawX <= (434 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten239 && DrawX >= 424 && DrawX <= (424 + 3) && DrawY >= 319 && DrawY <= (319 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten240 && DrawX >= 424 && DrawX <= (424 + 3) && DrawY >= 329 && DrawY <= (329 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
				else if(eaten241 && DrawX >= 424 && DrawX <= (424 + 3) && DrawY >= 339 && DrawY <= (339 + 3))
				  begin
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				end
	
	// cherry
			  else if (DrawX >= 312 & DrawX <= 328 & DrawY >= 252 & DrawY <= 268 && cherry_collided == 1'b0) 
			  begin
					Red = cherry_out[23:16];
					Green = cherry_out[15:8];
					Blue = cherry_out[7:0];		  
				
			  end
			  
	// background maze
			  else if (DrawX >= 180 & DrawX <= 461 & DrawY >= 85 & DrawY <= 394) 
			  begin
					Red = back_out[23:16];
					Green = back_out[15:8];
					Blue = back_out[7:0];		  
				
			  end
	//		  else if(DrawX >= (PacX - 8) && DrawX <= (PacX + 8) && DrawY >= (PacY - 8) && DrawY <= (PacY + 8))
	//        begin 
	//			for(int i = 100; i < 360; i = i + 6) begin 
	//				if(DrawY == 100)
	//				begin
	//					Red = 8'hFF; 
	//					Green = 8'hB7;
	//					Blue = 8'hAE;
	//				end
	//				else 
	//				begin 
	//            Red = 8'h00; 
	//            Green = 8'h00;
	//            Blue = 8'h00;
	//				end  
	//			end
	//        end 
			  else 
				  begin 
						Red = 8'h00; 
						Green = 8'h00;
						Blue = 8'h00;
				  end  
		end
//		else
//		begin 
//			Red = 8'h11; 
//			Green = 8'h11;
//			Blue = 8'h11;
//		end 
//    end 

endmodule
