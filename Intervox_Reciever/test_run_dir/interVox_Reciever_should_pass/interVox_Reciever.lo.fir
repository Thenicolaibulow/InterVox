circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : UInt<1>
    input io_DATA_IN : UInt<1>
    output io_CLK_OUT : UInt<1>
    output io_DATA_OUT : UInt<1>
    output io_NEXT_FRAME : UInt<1>

    reg clkCntr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), clkCntr) @[intervox_receiver.scala 26:30]
    reg clkCntr1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), clkCntr1) @[intervox_receiver.scala 27:30]
    reg clkDelta : UInt<8>, clock with :
      reset => (UInt<1>("h0"), clkDelta) @[intervox_receiver.scala 28:30]
    reg pllCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pllCntr) @[intervox_receiver.scala 29:30]
    reg inBufr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufr) @[intervox_receiver.scala 30:30]
    reg outReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), outReg) @[intervox_receiver.scala 32:30]
    reg change : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change) @[intervox_receiver.scala 33:30]
    reg nextFrame : UInt<1>, clock with :
      reset => (UInt<1>("h0"), nextFrame) @[intervox_receiver.scala 34:30]
    node _pllCntr_T = add(pllCntr, UInt<1>("h1")) @[intervox_receiver.scala 41:24]
    node _pllCntr_T_1 = tail(_pllCntr_T, 1) @[intervox_receiver.scala 41:24]
    node _T = eq(pllCntr, UInt<3>("h7")) @[intervox_receiver.scala 42:18]
    node _outReg_T = not(outReg) @[intervox_receiver.scala 45:19]
    node _GEN_0 = mux(_T, _outReg_T, outReg) @[intervox_receiver.scala 42:26 45:16 32:30]
    node _GEN_1 = mux(_T, UInt<1>("h0"), _pllCntr_T_1) @[intervox_receiver.scala 41:13 42:26 46:17]
    node _clkCntr_T = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 54:28]
    node _clkCntr_T_1 = tail(_clkCntr_T, 1) @[intervox_receiver.scala 54:28]
    node _clkCntr1_T = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 56:29]
    node _clkCntr1_T_1 = tail(_clkCntr1_T, 1) @[intervox_receiver.scala 56:29]
    node _T_1 = eq(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 58:18]
    node _GEN_2 = mux(_T_1, UInt<1>("h0"), _clkCntr_T_1) @[intervox_receiver.scala 54:17 58:26 59:17]
    node _GEN_3 = mux(_T_1, UInt<1>("h0"), change) @[intervox_receiver.scala 58:26 60:16 33:30]
    node _T_2 = eq(io_DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 63:21]
    node _T_3 = lt(inBufr, UInt<2>("h3")) @[intervox_receiver.scala 64:21]
    node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 65:30]
    node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 65:30]
    node _GEN_4 = mux(_T_3, _inBufr_T_1, inBufr) @[intervox_receiver.scala 64:27 65:20 30:30]
    node _GEN_5 = mux(_T_2, _GEN_4, inBufr) @[intervox_receiver.scala 63:29 30:30]
    node _T_4 = eq(io_DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 68:21]
    node _T_5 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 69:21]
    node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 70:30]
    node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 70:30]
    node _GEN_6 = mux(_T_5, _inBufr_T_3, _GEN_5) @[intervox_receiver.scala 69:27 70:20]
    node _GEN_7 = mux(_T_4, _GEN_6, _GEN_5) @[intervox_receiver.scala 68:29]
    node _T_6 = gt(clkCntr1, UInt<6>("h20")) @[intervox_receiver.scala 75:20]
    node _GEN_8 = mux(_T_6, UInt<1>("h0"), nextFrame) @[intervox_receiver.scala 75:28 34:30 75:39]
    node _T_7 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 77:17]
    node _T_8 = bits(inBufr, 0, 0) @[intervox_receiver.scala 79:20]
    node _T_9 = bits(inBufr, 1, 1) @[intervox_receiver.scala 79:34]
    node _T_10 = neq(_T_8, _T_9) @[intervox_receiver.scala 79:24]
    node _GEN_9 = mux(_T_10, UInt<1>("h1"), _GEN_3) @[intervox_receiver.scala 79:38 80:20]
    node _GEN_10 = mux(_T_10, UInt<1>("h0"), _clkCntr1_T_1) @[intervox_receiver.scala 56:17 79:38 81:22]
    node _GEN_11 = mux(_T_10, clkCntr1, clkDelta) @[intervox_receiver.scala 79:38 82:22 28:30]
    node _GEN_12 = mux(_T_7, _GEN_9, _GEN_3) @[intervox_receiver.scala 77:25]
    node _GEN_13 = mux(_T_7, _GEN_10, _clkCntr1_T_1) @[intervox_receiver.scala 56:17 77:25]
    node _GEN_14 = mux(_T_7, _GEN_11, clkDelta) @[intervox_receiver.scala 77:25 28:30]
    node _T_11 = gt(clkDelta, UInt<1>("h0")) @[intervox_receiver.scala 91:20]
    node _T_12 = lt(clkDelta, UInt<4>("ha")) @[intervox_receiver.scala 91:39]
    node _T_13 = and(_T_11, _T_12) @[intervox_receiver.scala 91:27]
    node _GEN_15 = mux(_T_13, UInt<1>("h1"), _GEN_8) @[intervox_receiver.scala 91:{47,58}]
    node _T_14 = gt(clkDelta, UInt<4>("ha")) @[intervox_receiver.scala 93:20]
    node _T_15 = lt(clkDelta, UInt<6>("h20")) @[intervox_receiver.scala 93:40]
    node _T_16 = and(_T_14, _T_15) @[intervox_receiver.scala 93:28]
    node _GEN_16 = mux(_T_16, UInt<1>("h0"), _GEN_15) @[intervox_receiver.scala 93:{48,59}]
    io_CLK_OUT <= outReg @[intervox_receiver.scala 36:21]
    io_DATA_OUT <= change @[intervox_receiver.scala 37:21]
    io_NEXT_FRAME <= nextFrame @[intervox_receiver.scala 38:21]
    clkCntr <= mux(reset, UInt<2>("h0"), _GEN_2) @[intervox_receiver.scala 26:{30,30}]
    clkCntr1 <= mux(reset, UInt<8>("h0"), _GEN_13) @[intervox_receiver.scala 27:{30,30}]
    clkDelta <= mux(reset, UInt<8>("h0"), _GEN_14) @[intervox_receiver.scala 28:{30,30}]
    pllCntr <= mux(reset, UInt<8>("h0"), _GEN_1) @[intervox_receiver.scala 29:{30,30}]
    inBufr <= mux(reset, UInt<2>("h0"), _GEN_7) @[intervox_receiver.scala 30:{30,30}]
    outReg <= mux(reset, UInt<1>("h0"), _GEN_0) @[intervox_receiver.scala 32:{30,30}]
    change <= mux(reset, UInt<1>("h0"), _GEN_12) @[intervox_receiver.scala 33:{30,30}]
    nextFrame <= mux(reset, UInt<1>("h0"), _GEN_16) @[intervox_receiver.scala 34:{30,30}]

  extmodule clk_wiz_0_clk_wiz :
    output PLL_MCLK : UInt<1>
    output locked : UInt<1>
    input PLL_IN : UInt<1>
    defname = clk_wiz_0_clk_wiz

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    input io_INTERVOX_IN : UInt<1>
    output io_CLK_REC : UInt<1>
    output io_DATA_OUT : UInt<1>
    output io_NEXT_FRAME : UInt<1>
    output io_DBUG : UInt<1>
    output io_DBUG1 : UInt<1>

    inst clockRec of clock_Recovery @[intervox_receiver.scala 108:26]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 116:21]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 122:24]
    node _GEN_0 = mux(_T, pll.PLL_MCLK, UInt<1>("h0")) @[intervox_receiver.scala 122:32 123:20 127:20]
    node _GEN_1 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[intervox_receiver.scala 122:32 124:20 128:20]
    io_CLK_REC <= _GEN_0
    io_DATA_OUT <= clockRec.io_DATA_OUT @[intervox_receiver.scala 111:25]
    io_NEXT_FRAME <= clockRec.io_NEXT_FRAME @[intervox_receiver.scala 112:25]
    io_DBUG <= clockRec.io_CLK_OUT @[intervox_receiver.scala 113:25]
    io_DBUG1 <= _GEN_1
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io_DATA_IN <= io_INTERVOX_IN @[intervox_receiver.scala 110:25]
    pll.PLL_IN <= clockRec.io_CLK_OUT @[intervox_receiver.scala 119:19]
