
 module Pipelined_processor(input clk,input reset);
  
  ///Pipeline register variables
  //IF_ID stage
  reg [7:0]	IF_ID_PC;
  reg [7:0]	IF_ID_IC;

  //ID EX stage
  reg [7:0]	 ID_EX_Read_Data_1;
  reg [7:0]	 ID_EX_Read_Data_2;
  reg [7:0]	 ID_EX_IC; 
  reg  ID_EX_alu_source;
  reg  ID_EX_Regwrite;
  reg  ID_EX_Alucntrl;
  
  //EX WB stage
  reg [7:0]	  EX_WB_IC;
  reg   EX_WB_Regwrite;
  reg [7:0]	EX_WB_AluRes;

wire [7:0] Instruction_Code;
wire [7:0] PC;
wire [7:0] JTA;
wire PC_Source;

wire [7:0] Read_Data_1;
wire [7:0] Read_Data_2;
wire [7:0] Write_Data;

wire Alucntrl;
wire alu_source;
wire Regwrite;

Instruction_Fetch IF_mod(clk,reset,Instruction_Code,PC,PC_Source,JTA);
 wire [7:0] sign_extension;
assign sign_extension[5:0] =Instruction_Code[5:0];				
assign sign_extension[7:6] = PC[7:6];
assign  JTA =sign_extension;

  always@(posedge clk)
  begin
  if(reset==0)
	begin
		IF_ID_PC<=0;
		IF_ID_IC<=0;
	end
   else
   begin
	IF_ID_PC<=PC;
	IF_ID_IC<=Instruction_Code;
  end

end

Control control_mod(IF_ID_IC[7:6],PC_Source,Alucntrl,alu_source,Regwrite); 
Register_file reg_mod(IF_ID_IC[2:0],IF_ID_IC[5:3], EX_WB_IC[5:3],Write_Data,Read_Data_1,Read_Data_2, EX_WB_Regwrite);



  always@(posedge clk)
  begin
  if(reset==0)
	begin
  ID_EX_IC<=0;
  ID_EX_Read_Data_1<=0;
  ID_EX_Read_Data_2<=0;
  ID_EX_alu_source<=0;
  ID_EX_Alucntrl<=0;
  ID_EX_Regwrite<=0;
	end
	else
	begin
  ID_EX_IC<=IF_ID_IC;
  ID_EX_Read_Data_1<=Read_Data_1;
  ID_EX_Read_Data_2<=Read_Data_2;
  ID_EX_alu_source<=alu_source;
  ID_EX_Alucntrl<=Alucntrl;
  ID_EX_Regwrite<=Regwrite;
  end
  end
  
  
wire [7:0]Alu_input_1;
wire [7:0]Alu_input_2;
wire [7:0]Temp_1;
wire [7:0]Temp_2;

wire [1:0]forward_signal;
wire [7:0] Aluresult;
wire [7:0] Shamt;

//Shift amount
assign Shamt[2:0]=ID_EX_IC[2:0];
assign Shamt[7:3]={5{1'b0}};
//Jump Target Calculation

forwarding_unit fwdmod (ID_EX_IC,  EX_WB_IC, forward_signal);

assign Temp_2=(ID_EX_alu_source==0)? ID_EX_Read_Data_1:Shamt;
assign Temp_1=ID_EX_Read_Data_2;
assign Alu_input_1=(forward_signal[0]==0)? Temp_1:EX_WB_AluRes;
assign Alu_input_2=(forward_signal[1]==0)? Temp_2:EX_WB_AluRes;


ALU alu_mod(Alu_input_1,Alu_input_2,ID_EX_Alucntrl,Aluresult);
 
 always@(posedge clk)
  begin
   if(reset==0)
	begin
   EX_WB_IC<= 0;
   EX_WB_AluRes<=0;
   EX_WB_Regwrite<=0;
	end
	else
	begin
   EX_WB_IC<= ID_EX_IC;
   EX_WB_AluRes<=Aluresult;
   EX_WB_Regwrite<=ID_EX_Regwrite;
   end
  end
  
  assign Write_Data =EX_WB_AluRes;   
  endmodule
