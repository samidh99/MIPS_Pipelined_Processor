# MIPS_Pipelined_Processor

Designed and implemented a 4-stage pipelined microprocessor for a subset of MIPS ISA. Datapath and Controlpath coded in Verilog HDL.

Problem Statement: 
* This processor supports data transfer (mov), addition (add) and Unconditional Jump (J) instructions. 
* The processor should implement forwarding to resolve data hazards. 
* The processor has Reset, CLK as inputs and no outputs. 
* The processor has instruction fetch unit, register file (with 8 8 bit registers), Execution and Writeback unit. 
* Read and write operations on Register file can happen simultaneously and should be independent of CLK. 
* The processor also contains three pipelined registers IF/ID, ID/EX and EX/WB. 
* Functioning:
  * When reset is activated the PC, IF/ID, ID/EX, EX/WB registers are initialized to 0, the instruction memory and registerfile get loaded by predefined values. 
  * When the instruction unit starts fetching the first instruction the pipeline registers contain unknown values. 
  * When the second instruction is being fetched in IF unit, the IF/ID registers will hold the instruction code for first instruction. 
  * When the third instruction is being fetched by IF unit, the IF/ID register contains the instruction code of second instruction, ID/EX register contains information related to first instruction and so on. 
* (Assume 8-bit PC. Also Assume Address and Data size as 8-bits)

Data Path and Control Path of the processor: 
![Design](https://user-images.githubusercontent.com/33369534/104713507-fafc4d00-5749-11eb-9c4f-ef13fb346154.PNG)
