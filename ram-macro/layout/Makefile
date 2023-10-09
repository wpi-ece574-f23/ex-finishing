syn:
	BASENAME=rampipe \
	CLOCKPERIOD=2 \
	TIMINGPATH=../lib \
	TIMINGLIB=slow.lib \
	EXTRALIB=../lib/ram_128x16A_slow_syn.lib \
	VERILOG='../rtl/rampipe.v' \
	LEF='../lib/all.lef' \
	QRC='../lib/t018s6mm.tch' \
	genus -f run_genus.tcl

layout:
	innovus -stylus -files run_innovus.tcl

clean:
	rm -rf reports syndb synout *~ innovus.cmd* innovus.log* genus.cmd* genus.log* RPT out synthDb fv rc_model.bin *.rpt qrc*.log
