all: syn

ifdef CPGLOBAL
CPTHISRUN=$(CPGLOBAL)
else
CPTHISRUN=2
endif

syn:
	BASENAME=movavg \
		CLOCKPERIOD=$(CPTHISRUN) \
		TIMINGPATH=/opt/cadence/libraries/gsclib045_all_v4.7/gsclib045/timing \
		TIMINGLIB=slow_vdd1v0_basicCells.lib \
		VERILOG='../rtl/movavg.sv' \
		genus -f genus_dft_script.tcl

testvectors:
	modus -f modus_script.tcl

clean:
	rm -rf outputs reports genus.log* genus.cmd* *~ fv modus.cmd* modus.log* work_test test_scripts


