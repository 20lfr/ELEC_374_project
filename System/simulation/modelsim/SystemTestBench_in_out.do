onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SystemTestBench_out_in/Clock
add wave -noupdate /SystemTestBench_out_in/clear
add wave -noupdate /SystemTestBench_out_in/outport_in
add wave -noupdate /SystemTestBench_out_in/inport_data_ready
add wave -noupdate /SystemTestBench_out_in/HIout
add wave -noupdate /SystemTestBench_out_in/LOout
add wave -noupdate /SystemTestBench_out_in/Zhi_out
add wave -noupdate /SystemTestBench_out_in/Zlo_out
add wave -noupdate /SystemTestBench_out_in/PCout
add wave -noupdate /SystemTestBench_out_in/MDRout
add wave -noupdate /SystemTestBench_out_in/Inport_out
add wave -noupdate /SystemTestBench_out_in/Cout
add wave -noupdate /SystemTestBench_out_in/MARin
add wave -noupdate /SystemTestBench_out_in/Zin
add wave -noupdate /SystemTestBench_out_in/PCin
add wave -noupdate /SystemTestBench_out_in/MDRin
add wave -noupdate /SystemTestBench_out_in/IRin
add wave -noupdate /SystemTestBench_out_in/Yin
add wave -noupdate /SystemTestBench_out_in/HIin
add wave -noupdate /SystemTestBench_out_in/LOin
add wave -noupdate /SystemTestBench_out_in/opcode
add wave -noupdate /SystemTestBench_out_in/IncPC
add wave -noupdate /SystemTestBench_out_in/Gra
add wave -noupdate /SystemTestBench_out_in/Grb
add wave -noupdate /SystemTestBench_out_in/Grc
add wave -noupdate /SystemTestBench_out_in/Rin
add wave -noupdate /SystemTestBench_out_in/Rout
add wave -noupdate /SystemTestBench_out_in/BAout
add wave -noupdate /SystemTestBench_out_in/Mem_read
add wave -noupdate /SystemTestBench_out_in/Mem_Write
add wave -noupdate /SystemTestBench_out_in/Mem_enable512x32
add wave -noupdate /SystemTestBench_out_in/mem_overide
add wave -noupdate /SystemTestBench_out_in/overide_address
add wave -noupdate /SystemTestBench_out_in/overide_data_in
add wave -noupdate /SystemTestBench_out_in/Mem_to_datapath
add wave -noupdate /SystemTestBench_out_in/Mem_data_to_chip
add wave -noupdate /SystemTestBench_out_in/MAR_address
add wave -noupdate /SystemTestBench_out_in/con_ff_bit
add wave -noupdate /SystemTestBench_out_in/CONin
add wave -noupdate -radix unsigned /SystemTestBench_out_in/Present_state
add wave -noupdate -radix hexadecimal /SystemTestBench_out_in/UUT/datapath/R3/q
add wave -noupdate /SystemTestBench_out_in/UUT/datapath/IR/q
add wave -noupdate -radix hexadecimal /SystemTestBench_out_in/UUT/datapath/PC/q
add wave -noupdate -radix hexadecimal /SystemTestBench_out_in/outport_data
add wave -noupdate -radix hexadecimal /SystemTestBench_out_in/inport_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 434
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
WaveRestoreZoom {999050 ps} {999741 ps}
