all: syn

#		TIMINGPATH=/opt/skywater/libraries/sky130_fd_sc_hd/latest/timing \
#		TIMINGLIB=sky130_fd_sc_hd__ss_100C_1v60.lib \

syn:
	BASENAME=mavg \
		CLOCKPERIOD=4 \
		TIMINGPATH=/opt/cadence/libraries/gsclib045_all_v4.7/gsclib045/timing \
		TIMINGLIB=slow_vdd1v0_basicCells.lib \
		VERILOG='../rtl/mavg.sv' \
		genus -f genus_script.tcl

clean:
	rm -rf outputs reports genus.log* genus.cmd* *~ fv

