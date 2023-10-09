sim:
	xrun tb.v \
	-define SIMULATION \
	../rtl/ram_128x16A.v ../rtl/rampipe.v \
	-access +rwc \
	-top tb

clean:
	rm -rf trace.vcd  xcelium.d  xrun.history  xrun.log xrun.key *~ waves.shm
