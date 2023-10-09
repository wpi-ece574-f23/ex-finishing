all: syn testvectors

ifdef CPGLOBAL
CPTHISRUN=$(CPGLOBAL)
else
CPTHISRUN=10
endif

syn:
	BASENAME=picoaes \
		CLOCKPERIOD=$(CPTHISRUN) \
		TIMINGPATH='/opt/cadence/libraries/gsclib045_all_v4.7/gsclib045/timing/' \
		TIMINGLIB='slow_vdd1v0_basicCells.lib' \
	        VERILOG='../rtl/comp_sbox.v ../rtl/aes_comp_inv_sbox.v ../rtl/aes_comp_sbox.v ../rtl/aes_comp_key_mem.v ../rtl/aes_comp_encipher_block.v ../rtl/aes_comp_decipher_block.v ../rtl/aes_comp_core.v ../rtl/picoaes.v' \
		genus -f genus_dft_script.tcl

testvectors:
	modus -f modus_script.tcl

clean:
	rm -rf outputs reports genus.log* genus.cmd* *~ fv test_scripts modus.cmd* modus.log*
