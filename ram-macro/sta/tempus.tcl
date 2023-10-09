read_lib ../lib/slow.lib
read_lib ../lib/ram_128x16A_slow_syn.lib

read_verilog ../syn/outputs/rampipe_netlist.v
set_top_module rampipe

read_sdc ../syn/outputs/rampipe_constraints.sdc
read_sdf ../syn/outputs/rampipe_delays.sdf

report_timing -late -max_paths 3 > late.rpt
report_timing -early -max_paths 3 > early.rpt

report_timing  -from [all_inputs] -to [all_outputs] -max_paths 12 -path_type summary  > allpaths.rpt
report_timing  -from [all_inputs] -to [all_registers] -max_paths 12 -path_type summary  >> allpaths.rpt
report_timing  -from [all_registers] -to [all_registers] -max_paths 12 -path_type summary >> allpaths.rpt
report_timing  -from [all_registers] -to [all_outputs] -max_paths 12 -path_type summary >> allpaths.rpt
exit
