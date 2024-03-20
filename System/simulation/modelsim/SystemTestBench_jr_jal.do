onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SystemTestBench_jr_jal/Clock
add wave -noupdate /SystemTestBench_jr_jal/clear
add wave -noupdate /SystemTestBench_jr_jal/inport_data
add wave -noupdate /SystemTestBench_jr_jal/outport_in
add wave -noupdate /SystemTestBench_jr_jal/inport_data_ready
add wave -noupdate /SystemTestBench_jr_jal/HIout
add wave -noupdate /SystemTestBench_jr_jal/LOout
add wave -noupdate /SystemTestBench_jr_jal/Zhi_out
add wave -noupdate /SystemTestBench_jr_jal/Zlo_out
add wave -noupdate /SystemTestBench_jr_jal/PCout
add wave -noupdate /SystemTestBench_jr_jal/MDRout
add wave -noupdate /SystemTestBench_jr_jal/Inport_out
add wave -noupdate /SystemTestBench_jr_jal/Cout
add wave -noupdate /SystemTestBench_jr_jal/MARin
add wave -noupdate /SystemTestBench_jr_jal/Zin
add wave -noupdate /SystemTestBench_jr_jal/PCin
add wave -noupdate /SystemTestBench_jr_jal/MDRin
add wave -noupdate /SystemTestBench_jr_jal/IRin
add wave -noupdate /SystemTestBench_jr_jal/Yin
add wave -noupdate /SystemTestBench_jr_jal/HIin
add wave -noupdate /SystemTestBench_jr_jal/LOin
add wave -noupdate /SystemTestBench_jr_jal/opcode
add wave -noupdate /SystemTestBench_jr_jal/IncPC
add wave -noupdate /SystemTestBench_jr_jal/Gra
add wave -noupdate /SystemTestBench_jr_jal/Grb
add wave -noupdate /SystemTestBench_jr_jal/Grc
add wave -noupdate /SystemTestBench_jr_jal/Rin
add wave -noupdate /SystemTestBench_jr_jal/Rout
add wave -noupdate /SystemTestBench_jr_jal/BAout
add wave -noupdate /SystemTestBench_jr_jal/Mem_read
add wave -noupdate /SystemTestBench_jr_jal/Mem_Write
add wave -noupdate /SystemTestBench_jr_jal/Mem_enable512x32
add wave -noupdate /SystemTestBench_jr_jal/mem_overide
add wave -noupdate /SystemTestBench_jr_jal/overide_address
add wave -noupdate /SystemTestBench_jr_jal/overide_data_in
add wave -noupdate /SystemTestBench_jr_jal/outport_data
add wave -noupdate /SystemTestBench_jr_jal/Mem_to_datapath
add wave -noupdate /SystemTestBench_jr_jal/Mem_data_to_chip
add wave -noupdate /SystemTestBench_jr_jal/MAR_address
add wave -noupdate /SystemTestBench_jr_jal/con_ff_bit
add wave -noupdate /SystemTestBench_jr_jal/CONin
add wave -noupdate /SystemTestBench_jr_jal/Present_state
add wave -noupdate -radix unsigned /SystemTestBench_jr_jal/UUT/datapath/R6/q
add wave -noupdate -radix unsigned /SystemTestBench_jr_jal/UUT/datapath/R7/q
add wave -noupdate -radix unsigned /SystemTestBench_jr_jal/UUT/datapath/R15/q
add wave -noupdate -radix unsigned /SystemTestBench_jr_jal/UUT/datapath/PC/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {999189 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 268
configure wave -valuecolwidth 227
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
WaveRestoreZoom {0 ps} {770380 ps}
