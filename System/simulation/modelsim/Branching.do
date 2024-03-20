onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SystemTestBench_branch/Clock
add wave -noupdate /SystemTestBench_branch/clear
add wave -noupdate /SystemTestBench_branch/inport_data
add wave -noupdate /SystemTestBench_branch/HIout
add wave -noupdate /SystemTestBench_branch/LOout
add wave -noupdate /SystemTestBench_branch/Zhi_out
add wave -noupdate /SystemTestBench_branch/Zlo_out
add wave -noupdate /SystemTestBench_branch/PCout
add wave -noupdate /SystemTestBench_branch/MDRout
add wave -noupdate /SystemTestBench_branch/Inport_out
add wave -noupdate /SystemTestBench_branch/Cout
add wave -noupdate /SystemTestBench_branch/MARin
add wave -noupdate /SystemTestBench_branch/Zin
add wave -noupdate /SystemTestBench_branch/PCin
add wave -noupdate /SystemTestBench_branch/MDRin
add wave -noupdate /SystemTestBench_branch/IRin
add wave -noupdate /SystemTestBench_branch/Yin
add wave -noupdate /SystemTestBench_branch/HIin
add wave -noupdate /SystemTestBench_branch/LOin
add wave -noupdate /SystemTestBench_branch/CONin
add wave -noupdate /SystemTestBench_branch/outport_in
add wave -noupdate /SystemTestBench_branch/inport_data_ready
add wave -noupdate /SystemTestBench_branch/opcode
add wave -noupdate /SystemTestBench_branch/IncPC
add wave -noupdate /SystemTestBench_branch/Gra
add wave -noupdate /SystemTestBench_branch/Grb
add wave -noupdate /SystemTestBench_branch/Grc
add wave -noupdate /SystemTestBench_branch/Rin
add wave -noupdate /SystemTestBench_branch/Rout
add wave -noupdate /SystemTestBench_branch/BAout
add wave -noupdate /SystemTestBench_branch/Mem_read
add wave -noupdate /SystemTestBench_branch/Mem_Write
add wave -noupdate /SystemTestBench_branch/Mem_enable512x32
add wave -noupdate /SystemTestBench_branch/mem_overide
add wave -noupdate /SystemTestBench_branch/overide_address
add wave -noupdate /SystemTestBench_branch/overide_data_in
add wave -noupdate /SystemTestBench_branch/outport_data
add wave -noupdate /SystemTestBench_branch/Mem_to_datapath
add wave -noupdate /SystemTestBench_branch/Mem_data_to_chip
add wave -noupdate /SystemTestBench_branch/MAR_address
add wave -noupdate /SystemTestBench_branch/memory_done
add wave -noupdate /SystemTestBench_branch/Present_state
add wave -noupdate /SystemTestBench_branch/UUT/datapath/R5/q
add wave -noupdate /SystemTestBench_branch/con_ff_bit
add wave -noupdate /SystemTestBench_branch/UUT/datapath/PC/q
add wave -noupdate /SystemTestBench_branch/UUT/datapath/IR/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {55077 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 283
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {895006 ps}
