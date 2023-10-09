all:
	@echo "clean: remove all intermediate results"

clean:
	cd chip; rm -f *~; cd ..
	cd constraints; rm -f *~; cd ..
	cd glpower; make clean; cd ..
	cd glsim; make clean; cd ..
	cd glsta; make clean; cd ..
	cd layout; make clean; cd ..
	cd glpower; make clean; cd ..
	cd rtlpower; make clean; cd ..
	cd rtl; rm -f *~; cd ..
	cd sim; make clean; cd ..
	cd sta; make clean; cd ..
	cd syn; make clean; cd ..
