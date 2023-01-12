# Clock pin
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33}     [get_ports {clock}]
set_property -dict {IOSTANDARD LVCMOS33}                    [get_ports {clock}]

# InterVox input
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS33}    [get_ports {io_INTERVOX_IN}]
# PLL Output
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33}    [get_ports {io_CLK_REC}]
# Data Output
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33}    [get_ports {io_DATA_OUT}]
# CLK REC, Pre. PLL
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33}    [get_ports {io_CLK_DBUG}]
# Zero Periode
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33}    [get_ports {io_DBUG}]
# Syncword Detect
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33}    [get_ports {io_DBUG1}]
# Rst.
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33}    [get_ports reset]

## LEDs
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[0]}]					
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[1]}]					
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[2]}]					
set_property -dict {PACKAGE_PIN V19 IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[3]}]					
set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[4]}]					
set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[5]}]					
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[6]}]					
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[7]}]					
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[8]}]					
set_property -dict {PACKAGE_PIN V3  IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[9]}]					
set_property -dict {PACKAGE_PIN W3  IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[10]}]					
set_property -dict {PACKAGE_PIN U3  IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[11]}]					
set_property -dict {PACKAGE_PIN P3  IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[12]}]					
set_property -dict {PACKAGE_PIN N3  IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[13]}]					
set_property -dict {PACKAGE_PIN P1  IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[14]}]					
set_property -dict {PACKAGE_PIN L1  IOSTANDARD LVCMOS33}    [get_ports {io_LEDS[15]}]	

# Clock constraints
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clock]
