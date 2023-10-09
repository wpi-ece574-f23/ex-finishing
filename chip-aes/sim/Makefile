sim:
	xrun \
	    ../rtl/comp_sbox.v \
	    ../rtl/aes_comp_inv_sbox.v \
	    ../rtl/aes_comp_sbox.v \
	    ../rtl/aes_comp_key_mem.v \
	    ../rtl/aes_comp_encipher_block.v \
	    ../rtl/aes_comp_decipher_block.v \
	    ../rtl/aes_comp_core.v \
	    ../rtl/picoaes.v \
	    tb.v \
	-access +rwc \
	-top tb 



clean:
	rm -rf trace.vcd  xcelium.d  xrun.history  xrun.log xrun.key *~ waves.shm
