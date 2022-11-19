# Clock pin
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33}     [get_ports {clock}]
set_property -dict {IOSTANDARD LVCMOS33}                    [get_ports {clock}]


set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS33}    [get_ports {io_INTERVOX_IN}]
#set_property CLOCK_DEDICATED_ROUTE_FALSE                    [get_nets {pll/PLL_IN_clk_wiz_0}]

set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33}    [get_ports {io_CLK_REC}]
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33}    [get_ports {io_DATA_OUT}]
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33}    [get_ports {io_NEXT_FRAME}]
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33}    [get_ports {io_DBUG}]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33}    [get_ports {io_DBUG1}]
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33}    [get_ports reset]

# Clock constraints
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clock]