if {![info exists ::env(TIMINGPATH)] } {
    puts "Error: missing TIMINGPATH"
    exit(0)
}

set_attribute lib_search_path [getenv TIMINGPATH]
set_attribute hdl_search_path ../syn/out

if {![info exists ::env(TIMINGLIB)] } {
    puts "Error: missing TIMINGLIB"
    exit(0)
}

if {![info exists ::env(VERILOG)] } {
    puts "Error: missing VERILOG"
    exit(0)
}

if {![info exists ::env(SDF)] } {
    puts "Error: missing SDF"
    exit(0)
}

if {![info exists ::env(SDC)] } {
    puts "Error: missing SDC"
    exit(0)
}

if {![info exists ::env(SPEF)] } {
    puts "Error: missing SDC"
    exit(0)
}

read_libs [getenv TIMINGLIB]
read_netlist [getenv VERILOG]
read_sdf [getenv SDF]
read_spef [getenv SPEF]

if {![info exists ::env(BASENAME)] } {
    puts "Error: missing BASENAME"
    exit(0)
}

if {![info exists ::env(VCD)] } {
    puts "Error: missing VCD"
    exit(0)
}

if {![info exists ::env(FRAME_COUNT)] } {
    puts "Error: missing FRAME_COUNT"
    exit(0)
}

read_stimulus -file [getenv VCD] -dut_instance /tb/dut -frame_count [getenv FRAME_COUNT]
read_sdc [getenv SDC]
power_map
gen_clock_tree
compute_power
report_power -out dut.final.report
compute_power -mode time_based
plot_power_profile -format png  -unit W -out dut.trace.png
exit
