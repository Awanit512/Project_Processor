
//Control Unit

module Control(input [1:0] Op_Code,output reg PC_Source,output reg Alucntrl,output reg alu_source,output reg Regwrite);

initial begin
  PC_Source = 0;
end
always@(Op_Code)
	
	begin
	case(Op_Code)
		2'b00: //Add
			begin
			alu_source = 1'b0;
			Alucntrl=1'b0;
			PC_Source=1'b0;
			Regwrite=1'b1;
			end		
		2'b01 : //SLL
			begin
			alu_source = 1'b1;
			Alucntrl=1'b1;
			PC_Source=1'b0;
			Regwrite=1'b1;
			end		
		2'b11: //Jump
			begin
			alu_source = 1'b1;
			Alucntrl=1'b0;
			PC_Source=1'b1;
			Regwrite=1'b0;
			end	
		2'b10:     //nop
			begin
			alu_source = 1'b0;
			Alucntrl=1'b0;
			PC_Source=1'b0;
			Regwrite=1'b0;
			end	
		endcase
	end
endmodule
