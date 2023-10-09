power:
	BASENAME=picoaes \
		VCD=../sim/trace.vcd \
		FRAME_COUNT=379 \
		TIMINGPATH=/opt/cadence/libraries/gsclib045_all_v4.7/gsclib045/timing \
		TIMINGLIB=slow_vdd1v0_basicCells.lib \
		VERILOG='../rtl/comp_sbox.v ../rtl/aes_comp_inv_sbox.v ../rtl/aes_comp_sbox.v ../rtl/aes_comp_key_mem.v ../rtl/aes_comp_encipher_block.v ../rtl/aes_comp_decipher_block.v ../rtl/aes_comp_core.v ../rtl/picoaes.v' \
		SDC='../constraints/constraints_clk.sdc' \
		joules -files joules_script.tcl

clean:
	rm -rf *~ *.db *.sdb fv joules_work *.data *.report *.png
