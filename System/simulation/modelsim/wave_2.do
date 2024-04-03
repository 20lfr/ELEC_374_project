onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SystemTestBench/Clock
add wave -noupdate /SystemTestBench/reset
add wave -noupdate /SystemTestBench/stop
add wave -noupdate -radix hexadecimal /SystemTestBench/inport_data
add wave -noupdate /SystemTestBench/seg_display_upper
add wave -noupdate /SystemTestBench/seg_display_lower
add wave -noupdate /SystemTestBench/run
add wave -noupdate /SystemTestBench/Present_state
add wave -noupdate /SystemTestBench/uut/clk_divided
add wave -noupdate {/SystemTestBench/uut/memory512x32/FullMemorySpace[2]}
add wave -noupdate {/SystemTestBench/uut/memory512x32/FullMemorySpace[1]}
add wave -noupdate {/SystemTestBench/uut/memory512x32/FullMemorySpace[0]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6713009 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {10500 ns}
