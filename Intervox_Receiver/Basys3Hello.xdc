# Clock pin
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33}     [get_ports {clock}]
set_property -dict {IOSTANDARD LVCMOS33}                    [get_ports {clock}]

# InterVox input
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS33}    [get_ports {io_INTERVOX_IN}]
# PLL Output
set_property -dict {PACKAGE_PIN A17 IOSTANDARD LVCMOS33}    [get_ports {io_CLK_REC}]
# Data Output
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33}    [get_ports {io_DATA_OUT}]
# CLK REC, Pre. PLL
set_property -dict {PACKAGE_PIN C15 IOSTANDARD LVCMOS33}    [get_ports {io_CLK_DBUG}]
# Zero Periode
set_property -dict {PACKAGE_PIN A15 IOSTANDARD LVCMOS33}    [get_ports {io_DBUG}]
# Syncword Detect
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33}    [get_ports {io_DBUG1}]


# I2S Pins
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33}    [get_ports {io_BCLK}]
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33}    [get_ports {io_LRCLK}]
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33}    [get_ports {io_SDATA}]


# Rst.
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33}    [get_ports reset]

## LED
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33}    [get_ports {io_LED[0]}]					
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33}    [get_ports {io_LED[1]}]					
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33}    [get_ports {io_LED[2]}]					
set_property -dict {PACKAGE_PIN V19 IOSTANDARD LVCMOS33}    [get_ports {io_LED[3]}]					
set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33}    [get_ports {io_LED[4]}]					
set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33}    [get_ports {io_LED[5]}]					
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33}    [get_ports {io_LED[6]}]					
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33}    [get_ports {io_LED[7]}]					
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33}    [get_ports {io_LED[8]}]					
set_property -dict {PACKAGE_PIN V3  IOSTANDARD LVCMOS33}    [get_ports {io_LED[9]}]					
set_property -dict {PACKAGE_PIN W3  IOSTANDARD LVCMOS33}    [get_ports {io_LED[10]}]					
set_property -dict {PACKAGE_PIN U3  IOSTANDARD LVCMOS33}    [get_ports {io_LED[11]}]					
set_property -dict {PACKAGE_PIN P3  IOSTANDARD LVCMOS33}    [get_ports {io_LED[12]}]					
set_property -dict {PACKAGE_PIN N3  IOSTANDARD LVCMOS33}    [get_ports {io_LED[13]}]					
set_property -dict {PACKAGE_PIN P1  IOSTANDARD LVCMOS33}    [get_ports {io_LED[14]}]					
set_property -dict {PACKAGE_PIN L1  IOSTANDARD LVCMOS33}    [get_ports {io_LED[15]}]	

# Clock constraints
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clock]

# Switches
set_property PACKAGE_PIN V17 [get_ports {io_SW[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[0]}]
set_property PACKAGE_PIN V16 [get_ports {io_SW[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[1]}]
set_property PACKAGE_PIN W16 [get_ports {io_SW[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[2]}]
set_property PACKAGE_PIN W17 [get_ports {io_SW[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[3]}]
set_property PACKAGE_PIN W15 [get_ports {io_SW[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[4]}]
set_property PACKAGE_PIN V15 [get_ports {io_SW[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[5]}]
set_property PACKAGE_PIN W14 [get_ports {io_SW[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[6]}]
set_property PACKAGE_PIN W13 [get_ports {io_SW[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[7]}]
set_property PACKAGE_PIN V2 [get_ports {io_SW[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[8]}]
set_property PACKAGE_PIN T3 [get_ports {io_SW[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[9]}]
set_property PACKAGE_PIN T2 [get_ports {io_SW[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[10]}]
set_property PACKAGE_PIN R3 [get_ports {io_SW[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[11]}]
set_property PACKAGE_PIN W2 [get_ports {io_SW[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[12]}]
set_property PACKAGE_PIN U1 [get_ports {io_SW[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[13]}]
set_property PACKAGE_PIN T1 [get_ports {io_SW[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[14]}]
set_property PACKAGE_PIN R2 [get_ports {io_SW[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {io_SW[15]}]
 

#Buttons
set_property PACKAGE_PIN U18 [get_ports io_BTN_C]						
	set_property IOSTANDARD LVCMOS33 [get_ports io_BTN_C]
set_property PACKAGE_PIN W19 [get_ports io_BTN_L]						
	set_property IOSTANDARD LVCMOS33 [get_ports io_BTN_L]
set_property PACKAGE_PIN T17 [get_ports io_BTN_R]						
	set_property IOSTANDARD LVCMOS33 [get_ports io_BTN_R]
set_property PACKAGE_PIN U17 [get_ports io_BTN_D]						
	set_property IOSTANDARD LVCMOS33 [get_ports io_BTN_D]
 
