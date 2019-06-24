//Register Memory

module Register_file(
input [2:0] Read_Reg_1,
input [2:0] Read_Reg_2,
input [2:0] Write_Reg_Num,
input [7:0] Write_Data,
output [7:0] Read_Data_1,
output [7:0] Read_Data_2,
input Regwrite
);

reg [7:0] RegMemory [7:0];

initial begin
RegMemory[0] = 8'h00; 
RegMemory[1] = 8'h01;
RegMemory[2] = 8'h02; 
RegMemory[3] = 8'h03; 
RegMemory[4] = 8'h04; 
RegMemory[5] = 8'h05; 
RegMemory[6] = 8'h06; 
RegMemory[7] = 8'h07; 
end

assign Read_Data_1 = RegMemory[Read_Reg_1];
assign Read_Data_2 = RegMemory[Read_Reg_2];

always@(*)
begin
   if(Regwrite==1)
   RegMemory[Write_Reg_Num]=Write_Data;
 
end
endmodule
