# Project_Processor
This project was completed in partial fulfillment on the Computer Architecture course taught by Prof. Chetan Kumar from BITS Pilani, Hyderabad Campus.

The Project Statement:

4-stage pipelined processor in Verilog. This processor supports addition (add), shift left logical (sll) and Unconditional Jump (J) instructions only. The processor should implement forwarding to resolve data hazards. The processor has Reset, CLK as inputs and no outputs. The processor has instruction fetch unit, register file (with 8 8-bit registers), Execution and Writeback unit. Read and write operations on Register file can happen simultaneously and should be independent of CLK. The processor also contains three pipelined registers IF/ID, ID/EX and EX/WB. When reset is activated the PC, IF/ID, ID/EX, EX/WB registers are initialized to 0, the instruction memory and registerfile get loaded by predefined values. When the instruction unit starts fetching the first instruction the pipeline registers contain unknown values. When the second instruction is being fetched in IF unit, the IF/ID registers will hold the instruction code for first instruction. When the third instruction is being fetched by IF unit, the IF/ID register contains the instruction code of second instruction, ID/EX register contains information related to first instruction and so on. (Assume 8-bit PC. Also Assume Address and Data size as 8-bits)
The instruction and its 8-bit instruction format are shown below:
add DestinationReg, SourceReg   (adds data in register specified by register number in Rsrc field to data in register specified by register number in RDst field. Result is stored in register specified by register number in RDst field. Opcode for add is 00)

sll DestinationReg, shiftamount   (Left shifts data in register specified by register number in RDst field by shift amount and moves back result to same register. Opcode for sll is 01)


j L1 (Jumps to an address generated by appending 2 MSB bits of PC+1 to the data specified in instruction field (5:0). Opcode for j is 11)

Assume the register file contains 8 registers (R0-R7) each register can hold 8-bit data. On reset register file should get initialized such that R0 = 0, R1 = 1, R2 = 2, R3 = 3 …etc. On reset assume that the instruction memory gets initialized with four instructions. 

  add R3,R1; 8’h19

sll R1,1; 49

add R1,R3; 0B

j L1;	C5

sll R1,3; 4B

add R3,R1; 19
