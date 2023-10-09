power:
	BASENAME=rampipe \
		VCD=../sim/trace.vcd \
		FRAME_COUNT=99 \
		TIMINGPATH=/opt/cadence/libraries/gsclib045_all_v4.7/gsclib045/timing \
		TIMINGLIB=slow_vdd1v0_basicCells.lib \
		EXTRALIB=../lib/ram_128x16A_slow_syn.lib  \
		VERILOG='../rtl/rampipe.v' \
		SDC='../constraints/constraints_clk.sdc' \
		joules -files joules_script.tcl

clean:
	rm -rf *~ *.db *.sdb fv joules_work *.data *.report *.png
