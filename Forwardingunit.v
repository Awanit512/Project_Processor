
module forwarding_unit(input [7:0] ID_EX_IC, input [7:0]  EX_WB_IC, output reg [1:0] forward_signal);
wire [1:0] OpCode;
assign OpCode = ID_EX_IC [7:6];
always@(OpCode)
	
	begin
	case(OpCode)
		2'b00: 
			begin 
			if((EX_WB_IC[7:6]==2'b00)|(EX_WB_IC[7:6]==2'b01))
				begin
					if((EX_WB_IC[5:3]==ID_EX_IC[5:3])|(EX_WB_IC[5:3]==ID_EX_IC[2:0]))
					begin	
						if(EX_WB_IC[5:3]==ID_EX_IC[5:3])
						forward_signal=2'b01;
					else 
						forward_signal=2'b10;
					end
					else
						forward_signal = 2'b00;
				end

			else 
				forward_signal = 2'b00;
			end		
		2'b01: 
			begin 
			if(((EX_WB_IC[7:6]==2'b00)|(EX_WB_IC[7:6]==2'b01))&(EX_WB_IC[5:3]==ID_EX_IC[5:3]))
			forward_signal=2'b01;
			else 
			forward_signal = 2'b00;
			end		
		default : forward_signal = 0;
		endcase
	end
endmodule
