set_db init_power_nets  VDD
set_db init_ground_nets VSS

source ./syndb/final.invs_setup.tcl

set_db design_process_node 45

connect_global_net VSS -type tie_lo -all
connect_global_net VSS -type pg_pin -pin_base_name VSS

connect_global_net VDD -type tie_hi -all
connect_global_net VDD -type pg_pin -pin_base_name VDD


create_relative_floorplan -place ram -ref_type core_boundary -horizontal_edge_separate {3 20 3} -vertical_edge_separate {0 20 0}
create_place_halo -halo_deltas {10 10 10 10} -inst ram

create_floorplan -core_density_size  0.35 0.5 20 20 20 20

read_io_file {../chip/chip.io}

add_rings -around user_defined \
    -type core_rings \
    -nets {VDD VSS} \
    -center 0 \
    -offset 1 \
    -width 1 \
    -spacing 1 \
    -layer {bottom Metal5 top Metal5 right Metal6 left Metal6}

# set_db add_stripes_extend_to_first_ring true
# set_db add_stripes_trim_antenna_back_to_shape stripe
# set_db add_stripes_stop_at_closest_target stripe

add_stripes \
  -layer Metal6 \
  -direction vertical \
  -width 4 \
  -spacing 10 \
  -start_offset 10 \
  -set_to_set_distance 60 \
  -nets {VSS VDD}

# set_db add_stripes_extend_to_first_ring true
# set_db add_stripes_trim_antenna_back_to_shape stripe
# set_db add_stripes_stop_at_closest_target stripe

add_stripes \
  -layer Metal5 \
  -direction horizontal \
  -width 4 \
  -spacing 10 \
  -start_offset 10 \
  -set_to_set_distance 60 \
  -nets {VSS VDD}

route_special -connect {core_pin block_pin} -nets {VDD VSS}

suspend


#-----------------------------------------------------------------------
# Pre-placement timing check
#-----------------------------------------------------------------------

check_timing
time_design -pre_place -report_prefix preplace -report_dir reports/STA

#-----------------------------------------------------------------------
## Placement and Pre CTS optimization
#-----------------------------------------------------------------------
set_db design_process_node 180
set_db timing_analysis_type ocv
set_db place_global_cong_effort auto
set_db place_global_clock_gate_aware true
set_db place_global_place_io_pins false
set_db opt_timing_preserve_assertions true
set_db opt_useful_skew true

place_opt_design -report_dir reports/STA

set_db add_tieoffs_cells { TIEHI TIELO }
add_tieoffs


#-----------------------------------------------------------------------
## Pre Clock tree timing analysis
#-----------------------------------------------------------------------

time_design -pre_cts -report_dir reports/STA

#-----------------------------------------------------------------------
## Clock Tree Synthesis
#-----------------------------------------------------------------------
set_db cts_inverter_cells {CLKINVX12 CLKINVX16 CLKINVX4}
set_db cts_buffer_cells {CLKBUFX16 CLKBUFX12 CLKBUFX4}
set_db cts_update_io_latency false

clock_design

report_clock_trees -summary -out_file reports/report_clock_trees.rpt
report_skew_groups  -summary -out_file reports/report_ccopt_skew_groups.rpt

#-----------------------------------------------------------------------
## Post CTS setup and hold optimization
#-----------------------------------------------------------------------

set_interactive_constraint_modes [all_constraint_modes -active]
reset_clock_tree_latency [all_clocks]
set_propagated_clock [all_clocks]
set_interactive_constraint_modes []

opt_design -post_cts        -report_dir reports/STA
time_design -post_cts       -report_dir reports/STA

opt_design -post_cts -hold -report_dir reports/STA
time_design -post_cts -hold -report_dir reports/STA

#-----------------------------------------------------------------------
## Global and Detail routing
#-----------------------------------------------------------------------

assign_io_pins

route_design

#-----------------------------------------------------------------------
## Post Route setup and hold optimization
#-----------------------------------------------------------------------
set_db extract_rc_engine post_route
set_db extract_rc_effort_level medium

# enable Signal Integrity analysis
set_db delaycal_enable_si true
set_db timing_analysis_type ocv

opt_design -post_route -setup -hold -report_dir reports/STA

#-----------------------------------------------------------------------
## Add filler cells
#-----------------------------------------------------------------------
set_db add_fillers_cells {FILL64 FILL32 FILL16 FILL8 FILL4 FILL2 FILL1}
add_fillers

#-----------------------------------------------------------------------
## Verification: physical, logical equivalent checking and timing
#-----------------------------------------------------------------------

# DRC and LVS
check_drc           -out_file RPT/check_drc.rpt
check_connectivity  -out_file RPT/check_connectivity.rpt

#-----------------------------------------------------------------------
## Signoff extraction
#-----------------------------------------------------------------------
# Select QRC extraction to be in signoff mode
set_db extract_rc_engine post_route
set_db extract_rc_effort_level signoff
set_db extract_rc_coupled true
set_db extract_rc_lef_tech_file_map ../lib/lefdef.layermap

extract_rc

# Generate RC spefs  for WC_rc & BC_rc corners
write_parasitics -rc_corner default_rc -spef_file out/design_default_rc.spef

#-----------------------------------------------------------------------
## Saving verilog netlist
#-----------------------------------------------------------------------
write_netlist out/design.v

# save placed design data

write_def -netlist out/design.def

#-----------------------------------------------------------------------
## Save the design
#-----------------------------------------------------------------------
write_db out/final_route.db




