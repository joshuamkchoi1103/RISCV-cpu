module Top(
  input        Clk,
  			   Start,
		       Reset,
  output logic Done);

  wire[9:0] PC;
  wire[1:0] Funct;
  wire[2:0] Aluop;
  wire[1:0] Ra,
			Rb,
			Wd;
  wire[8:0] mach_code;
  wire[7:0] DatA,	     // ALU data in
            DatB,
			Rslt,		 // ALU data out
			RdatA,		 // RF data out
			RdatB,
			WdatR,		 // RF data in
			WdatD,		 // DM data in
			Rdat,		 // DM data out
			Addr;		 // DM address
  wire      Jen,		 // PC jump enable
			WenR,		 // RF write enable
			WenD,		 // DM write enable
			Ldr,		 // LOAD
			Str;		 // STORE
  wire[3:0]	Immed;
  wire signed [5:0]	BImmed;

assign  DatA = RdatA;
assign  DatB = RdatB; 
assign  WdatR = Rslt; 
assign  WdatD = RdatA;

ProgCtr PC1(
  .Clk,
  .Reset,
  .Jen,
  .Start,
  .Done,
  .BImmed,
  .PC);

InstROM IR1(
  .PC,
  .mach_code);

Ctrl C1(
  .mach_code,
  .Aluop,
  .Ra,
  .Rb,
  .Wd,
  .WenR,
  .WenD,
  .Ldr,
  .Str,
  .Funct,
  .Immed,
  .BImmed,
  .Addr);

RegFile RF1(
  .Clk,
  .Wen(WenR),
  .Ra,
  .Rb,
  .Wd,
  .Wdat(WdatR),
  .RdatA,
  .RdatB
);

ALU A1(
  .Aluop,
  .Funct,
  .DatA,
  .DatB,
  .Rdat,
  .Rslt,
  .Done,
  .Jen,
  .Immed,
  .Start);

DMem dm1(
  .Clk,
  .Wen (WenD),
  .WDat(WdatD),
  .Addr,
  .Rdat);


endmodule