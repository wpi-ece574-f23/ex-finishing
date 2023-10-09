if {![info exists ::env(TIMINGPATH)] } {
    puts "Error: missing TIMINGPATH"
    exit(0)
}

if {![info exists ::env(TIMINGLIB)] } {
    puts "Error: missing TIMINGLIB"
    exit(0)
}

set_db init_lib_search_path [getenv TIMINGPATH]
read_libs [getenv TIMINGLIB]

if {![info exists ::env(VERILOG)] } {
    puts "Error: missing VERILOG"
    exit(0)
}

set_db init_hdl_search_path ../rtl/
read_hdl -language sv [getenv VERILOG]

elaborate
read_sdc ../constraints/constraints_clk.sdc

set_db syn_generic_effort high
set_db syn_map_effort high
set_db syn_opt_effort high

set_db dft_scan_style muxed_scan
set_db dft_prefix dft_
define_shift_enable -name SE -active high -create_port SE
check_dft_rules

syn_generic
syn_map
syn_opt

if {![info exists ::env(BASENAME)] } {
  set basename "default"
} else {
    set basename [getenv BASENAME]
}

check_dft_rules
set_db design:${basename} .dft_min_number_of_scan_chains 1
define_scan_chain -name top_chain -sdi scan_in -sdo scan_out -create_ports
connect_scan_chains -auto_create_chains
syn_opt -incr

report_scan_chains
write_dft_atpg -library /opt/cadence/libraries/gsclib045_all_v4.7/gsclib045/verilog/slow_vdd1v0_basicCells.v

report_timing > reports/${basename}_report_timing.rpt
report_power  > reports/${basename}_report_power.rpt
report_area   > reports/${basename}_report_area.rpt
report_qor    > reports/${basename}_report_qor.rpt

set outputnetlist     outputs/${basename}_netlist.v
set outputconstraints outputs/${basename}_constraints.sdc
set outputdelays      outputs/${basename}_delays.sdf

write_hdl > $outputnetlist
write_sdc > $outputconstraints
write_sdf -timescale ns -nonegchecks -recrem split -edges check_edge  -setuphold split > $outputdelays

write_scandef >outputs/${basename}.scandef

exit

