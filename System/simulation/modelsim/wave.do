onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SystemTestBench/Clock
add wave -noupdate /SystemTestBench/reset
add wave -noupdate /SystemTestBench/stop
add wave -noupdate /SystemTestBench/inport_data
add wave -noupdate /SystemTestBench/seg_display_upper
add wave -noupdate /SystemTestBench/seg_display_lower
add wave -noupdate /SystemTestBench/run
add wave -noupdate /SystemTestBench/Present_state
add wave -noupdate /SystemTestBench/Clock
add wave -noupdate /SystemTestBench/reset
add wave -noupdate /SystemTestBench/stop
add wave -noupdate /SystemTestBench/inport_data
add wave -noupdate -radix hexadecimal /SystemTestBench/seg_display_upper
add wave -noupdate -radix hexadecimal /SystemTestBench/seg_display_lower
add wave -noupdate /SystemTestBench/Present_state
add wave -noupdate /SystemTestBench/Clock
add wave -noupdate /SystemTestBench/reset
add wave -noupdate /SystemTestBench/stop
add wave -noupdate -radix hexadecimal /SystemTestBench/inport_data
add wave -noupdate -radix hexadecimal /SystemTestBench/seg_display_upper
add wave -noupdate -radix hexadecimal /SystemTestBench/seg_display_lower
add wave -noupdate /SystemTestBench/Present_state
add wave -noupdate -radix hexadecimal /SystemTestBench/uut/display_upper/outport
add wave -noupdate -radix hexadecimal /SystemTestBench/uut/display_lower/outport
add wave -noupdate /SystemTestBench/Clock
add wave -noupdate /SystemTestBench/reset
add wave -noupdate /SystemTestBench/stop
add wave -noupdate /SystemTestBench/inport_data
add wave -noupdate /SystemTestBench/Present_state
add wave -noupdate /SystemTestBench/Clock
add wave -noupdate /SystemTestBench/reset
add wave -noupdate /SystemTestBench/stop
add wave -noupdate -radix hexadecimal /SystemTestBench/inport_data
add wave -noupdate /SystemTestBench/Present_state
add wave -noupdate -radix unsigned /SystemTestBench/uut/datapath/PC_BusMuxIn
add wave -noupdate -radix unsigned /SystemTestBench/uut/control/present_state
add wave -noupdate /SystemTestBench/uut/control/T0
add wave -noupdate /SystemTestBench/uut/control/T1
add wave -noupdate /SystemTestBench/uut/control/T2
add wave -noupdate /SystemTestBench/uut/control/T3
add wave -noupdate /SystemTestBench/uut/control/T4
add wave -noupdate /SystemTestBench/uut/control/IN_s
add wave -noupdate /SystemTestBench/uut/control/OUT_s
add wave -noupdate -radix hexadecimal /SystemTestBench/uut/display_upper/data
add wave -noupdate -radix hexadecimal /SystemTestBench/uut/display_lower/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21960000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 328
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {41334300 ps}
