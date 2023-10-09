all: syn

ifdef CPGLOBAL
CPTHISRUN=$(CPGLOBAL)
else
CPTHISRUN=2
endif

syn:
	BASENAME=rampipe \
		CLOCKPERIOD=$(CPTHISRUN) \
		TIMINGPATH=../lib \
		TIMINGLIB=slow.lib \
		EXTRALIB=../lib/ram_128x16A_slow_syn.lib \
		VERILOG='../rtl/ram_128x16A.v ../rtl/rampipe.v' \
		genus -f genus_script.tcl

clean:
	rm -rf outputs reports genus.log* genus.cmd* *~ fv
