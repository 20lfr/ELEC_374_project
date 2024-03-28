onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SystemTestBench/Clock
add wave -noupdate /SystemTestBench/Interupts
add wave -noupdate /SystemTestBench/reset
add wave -noupdate /SystemTestBench/stop
add wave -noupdate /SystemTestBench/inport_data_ready
add wave -noupdate /SystemTestBench/inport_data
add wave -noupdate /SystemTestBench/outport_data
add wave -noupdate /SystemTestBench/Present_state
add wave -noupdate -radix hexadecimal /SystemTestBench/uut/IR
add wave -noupdate -radix hexadecimal /SystemTestBench/uut/datapath/PC_BusMuxIn
add wave -noupdate -radix hexadecimal /SystemTestBench/uut/control/present_state
add wave -noupdate /SystemTestBench/uut/control/T0
add wave -noupdate /SystemTestBench/uut/control/T1
add wave -noupdate /SystemTestBench/uut/control/T2
add wave -noupdate /SystemTestBench/uut/control/T3
add wave -noupdate /SystemTestBench/uut/control/T4
add wave -noupdate /SystemTestBench/uut/control/T5
add wave -noupdate /SystemTestBench/uut/control/T6
add wave -noupdate /SystemTestBench/uut/control/T7
add wave -noupdate /SystemTestBench/uut/control/LOADI_s
add wave -noupdate /SystemTestBench/uut/control/LOADI_DIR_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {27640 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 304
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
WaveRestoreZoom {0 ps} {349774 ps}
