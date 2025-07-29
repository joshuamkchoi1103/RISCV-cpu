module ALU(
  input [2:0] Aluop,
  input [1:0] Funct,
  input [7:0] DatA,
              DatB,
  input [7:0] Rdat,
  output logic[7:0] Rslt,
  output logic    	Done,
					Jen,
  input logic[3:0] Immed,
input Start);

always_comb begin
  static logic [7:0] cmp_value = 0;
  Rslt = 8'b0;
  Jen = 0;
   Done = 1'b0;
  
  case(Aluop)
    3'b000: begin
      case (Funct)
          2'b00: Rslt = DatA + DatB;          // add
          2'b01: Rslt = DatA - DatB;          // sub
          2'b10: Rslt = ~DatA;          // not
        2'b11: Rslt = {DatA[0], 7'b0};           // lsb operation but special type
        endcase
      end   
    3'b001: begin
      case (Funct)
        2'b00: Rslt = {7'b0, DatA[7]};                         // msb
          2'b01: Rslt = (DatA < DatB) ? 8'd1 : 8'd0;         // slt (set if less)
          2'b10: Rslt = DatA << 1;                         // shl by 1
          2'b11: Rslt = DatA >> 1;                         // shr by 1 (logical)
        endcase
      end 
    //mov
    3'b010: begin
      Rslt = (Immed);
      end
    //bne
    3'b110: begin
        cmp_value = DatA - DatB;
      if (cmp_value != 0) begin
        Rslt = 8'd1;
        Jen = 1;
      end
        else begin
          Rslt = 8'd0;
          Jen = 0;
        end
      end
    //beq
    3'b101: begin
        cmp_value = DatA - DatB;
      if (cmp_value == 0) begin
        Rslt = 8'd1;
        Jen = 1;
      end
        else begin
          Rslt = 8'd0;
          Jen = 0;
        end
      end
    3'b011:	begin
      Rslt = Rdat;
    end
    //done
    3'b111: begin
        Done = 1;
      end

      default: Rslt = 8'd0;
  endcase
  
  //if (Start)
    //Done = 0;
end


endmodule