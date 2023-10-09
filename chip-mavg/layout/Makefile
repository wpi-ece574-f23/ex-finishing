syn:
	BASENAME=mavg \
	CLOCKPERIOD=4 \
	TIMINGLIBS='/opt/cadence/libraries/gsclib045_all_v4.7/gsclib045/timing/slow_vdd1v0_basicCells.lib ../chip/pdkIO.lib' \
	VERILOG='../rtl/mavg.sv ../chip/pads.v ../chip/chip.v' \
	LEF='/opt/cadence/libraries/gsclib045_all_v4.7/gsclib045/lef/gsclib045_tech.lef /opt/cadence/libraries/gsclib045_all_v4.7/gsclib045/lef/gsclib045_macro.lef ../chip/pdkIO.lef' \
	QRC='/opt/cadence/libraries/gsclib045_all_v4.7/gsclib045/qrc/qx/gpdk045.tch' \
	genus -f run_genus.tcl

layout:
	innovus -stylus -files run_innovus.tcl

clean:
	rm -rf qrc*log reports syndb *~ innovus.cmd* innovus.log* genus.cmd* genus.log* RPT out synthDb fv rc_model.bin *.rpt
