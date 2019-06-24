//ALU

module ALU(input [7:0] A,input [7:0] B,input Control_alu,output reg [7:0] Result);
  
  always@(A,B,Control_alu)
  begin 
    
    case (Control_alu)
      
        1'b0 : Result = A + B;
	1'b1 : Result = A << B;  
	 	  
      default : $display("Invalid ALU control signal");
      
    endcase
  end
endmodule
