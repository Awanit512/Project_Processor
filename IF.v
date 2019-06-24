module Instruction_Fetch(input clk,input reset, output [7:0] Instruction_Code,output reg [7:0]PC,input PC_Source,input [7:0]JTA);

wire [7:0]pc_assign;
assign pc_assign =(Instruction_Code[7]==1)?JTA:PC+1;
always@(posedge clk,negedge reset)
begin
if(reset==0)
PC<=0;
else 
    PC<=pc_assign;
end
Instruction_Memory Instr_mem(PC,reset,Instruction_Code);
endmodule

//Instruction Memory

module Instruction_Memory(input [7:0] PC,input reset,output [7:0]Instruction_Code);
reg [7:0]Mem[5:0];
assign Instruction_Code ={Mem[PC]};
always@(reset)
begin 
if (reset==0)
begin
Mem[0]=8'h19;Mem[1]=8'h49;Mem[2]=8'h0B;Mem[3]=8'hC5;
Mem[4]=8'h4B;Mem[5]=8'h19;
end
end
endmodule
