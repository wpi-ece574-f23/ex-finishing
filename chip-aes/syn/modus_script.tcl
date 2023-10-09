set basename picoaes
set testtechlib /opt/cadence/libraries/gsclib045_all_v4.7/gsclib045/verilog/slow_vdd1v0_basicCells.v

build_model \
    -workdir test_scripts \
    -designsource test_scripts/${basename}.test_netlist.v \
    -techlib $testtechlib \
    -designtop ${basename}

build_testmode\
    -workdir test_scripts \
    -testmode FULLSCAN \
    -assignfile  test_scripts/${basename}.FULLSCAN.pinassign

verify_test_structures \
    -workdir test_scripts \
    -testmode FULLSCAN

report_test_structures \
    -workdir test_scripts \
    -testmode FULLSCAN

build_faultmodel \
    -workdir test_scripts \
    -fullfault yes

create_scanchain_tests \
    -workdir test_scripts \
    -testmode FULLSCAN \
    -experiment scan

create_logic_tests \
    -workdir test_scripts \
    -testmode FULLSCAN \
    -experiment logic \
    -effort low

write_vectors \
    -workdir test_scripts \
    -testmode FULLSCAN \
    -inexperiment logic \
    -language verilog \
    -scanformat serial \
    -outputfilename test_results

exit
