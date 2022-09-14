# Clock pin
set_property PACKAGE_PIN W5 [get_ports {clock}]
set_property IOSTANDARD LVCMOS33 [get_ports {clock}]

# LEDs
set_property PACKAGE_PIN U16    [get_ports {io_DATA[0]}]
set_property PACKAGE_PIN E19    [get_ports {io_DATA[1]}]
set_property PACKAGE_PIN U19    [get_ports {io_DATA[2]}]
set_property PACKAGE_PIN V19    [get_ports {io_DATA[3]}]
set_property PACKAGE_PIN W18    [get_ports {io_DATA[4]}]
set_property PACKAGE_PIN U15    [get_ports {io_DATA[5]}]
set_property PACKAGE_PIN U14    [get_ports {io_DATA[6]}]
set_property PACKAGE_PIN V14    [get_ports {io_DATA[7]}]
set_property PACKAGE_PIN V13    [get_ports {io_DATA[8]}]
set_property PACKAGE_PIN V3     [get_ports {io_DATA[9]}]
set_property PACKAGE_PIN W3     [get_ports {io_DATA[10]}]
set_property PACKAGE_PIN U3     [get_ports {io_DATA[11]}]
set_property PACKAGE_PIN P3     [get_ports {io_DATA[12]}]

set_property PACKAGE_PIN P17    [get_ports {io_bDATA}]
set_property PACKAGE_PIN N17    [get_ports {io_LRCLK}]
set_property PACKAGE_PIN P18    [get_ports {io_BCLK}]
set_property PACKAGE_PIN R18    [get_ports {io_MCLK}]

#set_property PACKAGE_PIN N3    [get_ports {io_bDATA}]
#set_property PACKAGE_PIN P1    [get_ports {io_LRCLK}]
#set_property PACKAGE_PIN L1    [get_ports {io_BCLK}]

# Switches
set_property PACKAGE_PIN V17    [get_ports {io_sw[0]}]
set_property PACKAGE_PIN V16    [get_ports {io_sw[1]}]
set_property PACKAGE_PIN W16    [get_ports {io_sw[2]}]
set_property PACKAGE_PIN W17    [get_ports {io_sw[3]}]
set_property PACKAGE_PIN W15    [get_ports {io_sw[4]}]
set_property PACKAGE_PIN V15    [get_ports {io_sw[5]}]
set_property PACKAGE_PIN W14    [get_ports {io_sw[6]}]
set_property PACKAGE_PIN W13    [get_ports {io_sw[7]}]
set_property PACKAGE_PIN V2     [get_ports {io_sw[8]}]
set_property PACKAGE_PIN T3     [get_ports {io_sw[9]}]
set_property PACKAGE_PIN T2     [get_ports {io_sw[10]}]
set_property PACKAGE_PIN R3     [get_ports {io_sw[11]}]
set_property PACKAGE_PIN W2     [get_ports {io_sw[12]}]
set_property PACKAGE_PIN U1     [get_ports {io_sw[13]}]
set_property PACKAGE_PIN T1     [get_ports {io_sw[14]}]
set_property PACKAGE_PIN R2     [get_ports {io_sw[15]}]

set_property PACKAGE_PIN T17 [get_ports reset]

# Clock constraints
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clock]