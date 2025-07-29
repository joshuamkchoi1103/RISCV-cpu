module Ctrl(
  input        [8:0] mach_code,
  output logic [2:0] Aluop,
  output logic [1:0] Ra,
			         Rb,
			         Wd,
  output logic       WenR,
					 WenD,
					 Ldr,
					 Str,
  output logic [1:0] Funct,
  output logic [3:0] Immed,
  output logic signed [5:0] BImmed,
  output logic [7:0] Addr
);
  
  always_comb begin
      Ra = 2'b00;
  Rb = 2'b00;
  Wd = 2'b00;
  WenR = 1'b0;
  WenD = 1'b0;
  Ldr  = 1'b0;
  Str  = 1'b0;
  Funct = 2'b00;
  Immed = 4'b0000;
  BImmed = 6'sb0;
  Addr = 8'b0;
    
    Aluop = mach_code[8:6];		// ALU
    
    if (Aluop == 3'b000 || Aluop == 3'b001) begin
      Ra = mach_code[5:4];
      Rb = mach_code[3:2];
      Funct = mach_code[1:0];
      Wd = 'd0;
      if ((Funct == 2'b10 || Funct == 2'b11) && Aluop == 3'b001) begin
        Wd = Ra;
      end
      
      WenR = 'd1;
    end
    else if (Aluop == 3'b011 || Aluop == 3'b100 || Aluop == 3'b010) begin
      Immed = mach_code[3:0];
      if (Aluop == 3'b011) begin
        Wd = mach_code[5:4];
        Ldr = 'd1;
        Addr = mach_code[3:0];
        WenR = 'd1;
      end
      if (Aluop == 3'b100) begin
        Ra = mach_code[5:4];
        Str = 'd1;
        WenD = 'd1;
        Addr = mach_code[3:0];
      end
      if (Aluop == 3'b010) begin
        Wd = mach_code[5:4];
        WenR = 1;
      end
    end
    else if (Aluop == 3'b101 || Aluop == 3'b110) begin
      BImmed = $signed(mach_code[5:0]);
      Ra = 'd1;
      Rb = 'd2;
    end

//    case(mach_code)

//	endcase
  end

endmodule