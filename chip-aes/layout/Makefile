syn:
	BASENAME=picoaes \
	CLOCKPERIOD=10 \
        TIMINGLIBS='/opt/cadence/libraries/gsclib045_all_v4.7/gsclib045/timing/slow_vdd1v0_basicCells.lib ../chip/pdkIO.lib' \
	CORENETLIST='../syn/outputs/picoaes_netlist.v' \
	CHIPVERILOG='../chip/pads.v ../chip/picotop.v ../chip/chip.v' \
        LEF='/opt/cadence/libraries/gsclib045_all_v4.7/gsclib045/lef/gsclib045_tech.lef /opt/cadence/libraries/gsclib045_all_v4.7/gsclib045/lef/gsclib045_macro.lef ../chip/pdkIO.lef' \
        QRC='/opt/cadence/libraries/gsclib045_all_v4.7/gsclib045/qrc/qx/gpdk045.tch' \
        genus -f run_genus.tcl

layout:
	innovus -stylus -files run_innovus.tcl

clean:
	rm -rf reports syndb synout *~ innovus.cmd* innovus.log* genus.cmd* genus.log* RPT out synthDb fv rc_model.bin *.rpt qrc*.log
