All 3 programs run properly with no rounding with each of the 3 testbenches attached. 

Please Refer to each of the following .sv files for reference. There should be the following files attached:
"ALU.sv"
"Ctrl.sv"
"DMem.sv"
"InstROM.sv"
"ProgCtr.sv"
"RegFile.sv"
"Top.sv"

Testbenches:
"fix2flt_tb.sv"
"flt2fix_tb.sv"
"fltflt_no_rnd_tb.sv"

Dummy Modules:
"data_mem.sv"
"Top_level0.sv"
"flt2fix0.sv"
"fltflt0_no_rnd.sv"

Assembly Code:
"program1_assembly.txt"
"program2_assembly.txt"
"program3_assembly.txt"

Machine Code:
"program1_mc.txt"
"program2_mc.txt"
"program3_mc.txt"

Assembler:
"assembler.py"

"run.do" file to generate netlist.

InstROM will read "mach_code.txt". Depending on which testbench we are trying to run we have to also include the dummy modules and put the proper machine code in that file.

To get the machine code, we have to run the assembler.py file with an input file of assebmly code and it will have an output file with the respective machine code.

On EDAPlayground, include the necessary files and run them and the correct output of 100% test cases passed will show up hence acknowleding that my modules and machine code works properly