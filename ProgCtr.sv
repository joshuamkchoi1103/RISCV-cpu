module ProgCtr(
  input             Clk,
                    Reset,
					Jen,
  					Start,
  					Done,
  input signed       [5:0] BImmed,
  output logic[9:0] PC);
  
  always_ff @(posedge Clk) begin
    if(Reset || Start) PC <= 'b0;
    else if(Jen) PC <= PC + 10'(signed'(BImmed));
	else      PC <= PC + 10'd1;
  end

endmodule