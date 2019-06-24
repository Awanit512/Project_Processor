
//Testbench

module testbench_pipeline;
 
reg reset_test;
reg clk_test;
Pipelined_processor pipeline_proc_mod(clk_test,reset_test); 
initial 
begin 
reset_test=0;clk_test=0;
#6 reset_test=1;

forever #10 clk_test=~clk_test;
#200 $finish;
end
endmodule
