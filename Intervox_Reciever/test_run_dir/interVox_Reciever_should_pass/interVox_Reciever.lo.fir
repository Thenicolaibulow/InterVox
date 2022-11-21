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
    reg clkCntr2 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), clkCntr2) @[intervox_receiver.scala 28:30]
    reg clkDelta : UInt<8>, clock with :
      reset => (UInt<1>("h0"), clkDelta) @[intervox_receiver.scala 29:30]
    reg lastOne : UInt<8>, clock with :
      reset => (UInt<1>("h0"), lastOne) @[intervox_receiver.scala 30:30]
    reg pllCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pllCntr) @[intervox_receiver.scala 31:30]
    reg inBufr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufr) @[intervox_receiver.scala 32:30]
    reg whatChange : UInt<2>, clock with :
      reset => (UInt<1>("h0"), whatChange) @[intervox_receiver.scala 33:30]
    reg outReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), outReg) @[intervox_receiver.scala 35:30]
    reg clkRec : UInt<1>, clock with :
      reset => (UInt<1>("h0"), clkRec) @[intervox_receiver.scala 36:30]
    reg change : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change) @[intervox_receiver.scala 37:30]
    reg nextFrame : UInt<1>, clock with :
      reset => (UInt<1>("h0"), nextFrame) @[intervox_receiver.scala 38:30]
    node _pllCntr_T = add(pllCntr, UInt<1>("h1")) @[intervox_receiver.scala 45:24]
    node _pllCntr_T_1 = tail(_pllCntr_T, 1) @[intervox_receiver.scala 45:24]
    node _T = eq(pllCntr, UInt<3>("h7")) @[intervox_receiver.scala 46:18]
    node _outReg_T = not(outReg) @[intervox_receiver.scala 49:19]
    node _GEN_0 = mux(_T, _outReg_T, outReg) @[intervox_receiver.scala 46:26 49:16 35:30]
    node _GEN_1 = mux(_T, UInt<1>("h0"), _pllCntr_T_1) @[intervox_receiver.scala 45:13 46:26 50:17]
    node _clkCntr_T = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 58:28]
    node _clkCntr_T_1 = tail(_clkCntr_T, 1) @[intervox_receiver.scala 58:28]
    node _clkCntr1_T = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 60:29]
    node _clkCntr1_T_1 = tail(_clkCntr1_T, 1) @[intervox_receiver.scala 60:29]
    node _T_1 = eq(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 62:18]
    node _GEN_2 = mux(_T_1, UInt<1>("h0"), _clkCntr_T_1) @[intervox_receiver.scala 58:17 62:26 63:17]
    node _GEN_3 = mux(_T_1, UInt<1>("h0"), change) @[intervox_receiver.scala 62:26 64:16 37:30]
    node _T_2 = eq(io_DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 67:21]
    node _T_3 = lt(inBufr, UInt<2>("h3")) @[intervox_receiver.scala 68:21]
    node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 69:30]
    node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 69:30]
    node _GEN_4 = mux(_T_3, _inBufr_T_1, inBufr) @[intervox_receiver.scala 68:27 69:20 32:30]
    node _GEN_5 = mux(_T_2, _GEN_4, inBufr) @[intervox_receiver.scala 67:29 32:30]
    node _T_4 = eq(io_DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 72:21]
    node _T_5 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 73:21]
    node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 74:30]
    node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 74:30]
    node _GEN_6 = mux(_T_5, _inBufr_T_3, _GEN_5) @[intervox_receiver.scala 73:27 74:20]
    node _GEN_7 = mux(_T_4, _GEN_6, _GEN_5) @[intervox_receiver.scala 72:29]
    node _T_6 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 77:17]
    node _T_7 = bits(inBufr, 0, 0) @[intervox_receiver.scala 79:20]
    node _T_8 = bits(inBufr, 1, 1) @[intervox_receiver.scala 79:34]
    node _T_9 = neq(_T_7, _T_8) @[intervox_receiver.scala 79:24]
    node _GEN_8 = mux(_T_9, UInt<1>("h1"), _GEN_3) @[intervox_receiver.scala 79:38 80:20]
    node _GEN_9 = mux(_T_9, UInt<1>("h0"), _clkCntr1_T_1) @[intervox_receiver.scala 60:17 79:38 81:22]
    node _GEN_10 = mux(_T_9, clkCntr1, clkDelta) @[intervox_receiver.scala 79:38 82:22 29:30]
    node _GEN_11 = mux(_T_6, _GEN_8, _GEN_3) @[intervox_receiver.scala 77:25]
    node _GEN_12 = mux(_T_6, _GEN_9, _clkCntr1_T_1) @[intervox_receiver.scala 60:17 77:25]
    node _GEN_13 = mux(_T_6, _GEN_10, clkDelta) @[intervox_receiver.scala 77:25 29:30]
    node _T_10 = gt(clkCntr1, UInt<6>("h20")) @[intervox_receiver.scala 91:20]
    node _GEN_14 = mux(_T_10, UInt<1>("h0"), nextFrame) @[intervox_receiver.scala 91:28 38:30 91:39]
    node _T_11 = gt(clkDelta, UInt<1>("h0")) @[intervox_receiver.scala 93:20]
    node _T_12 = lt(clkDelta, UInt<4>("ha")) @[intervox_receiver.scala 93:39]
    node _T_13 = and(_T_11, _T_12) @[intervox_receiver.scala 93:27]
    node _GEN_15 = mux(_T_13, UInt<1>("h1"), _GEN_14) @[intervox_receiver.scala 93:47 94:19]
    node _GEN_16 = mux(_T_13, clkDelta, lastOne) @[intervox_receiver.scala 93:47 96:17 30:30]
    node _T_14 = gt(clkDelta, UInt<4>("ha")) @[intervox_receiver.scala 106:20]
    node _T_15 = lt(clkDelta, UInt<6>("h20")) @[intervox_receiver.scala 106:40]
    node _T_16 = and(_T_14, _T_15) @[intervox_receiver.scala 106:28]
    node _GEN_17 = mux(_T_16, UInt<1>("h0"), _GEN_15) @[intervox_receiver.scala 106:{48,59}]
    node _T_17 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 112:17]
    node _T_18 = lt(whatChange, UInt<2>("h3")) @[intervox_receiver.scala 113:25]
    node _whatChange_T = add(whatChange, UInt<1>("h1")) @[intervox_receiver.scala 114:38]
    node _whatChange_T_1 = tail(_whatChange_T, 1) @[intervox_receiver.scala 114:38]
    node _GEN_18 = mux(_T_18, _whatChange_T_1, whatChange) @[intervox_receiver.scala 113:31 114:24 33:30]
    node _GEN_19 = mux(_T_17, _GEN_18, whatChange) @[intervox_receiver.scala 112:25 33:30]
    node _T_19 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 117:17]
    node _T_20 = gt(whatChange, UInt<1>("h0")) @[intervox_receiver.scala 118:25]
    node _whatChange_T_2 = sub(whatChange, UInt<1>("h1")) @[intervox_receiver.scala 119:38]
    node _whatChange_T_3 = tail(_whatChange_T_2, 1) @[intervox_receiver.scala 119:38]
    node _GEN_20 = mux(_T_20, _whatChange_T_3, _GEN_19) @[intervox_receiver.scala 118:31 119:24]
    node _GEN_21 = mux(_T_19, _GEN_20, _GEN_19) @[intervox_receiver.scala 117:25]
    node _T_21 = bits(whatChange, 0, 0) @[intervox_receiver.scala 123:21]
    node _T_22 = eq(_T_21, UInt<1>("h1")) @[intervox_receiver.scala 123:25]
    node _T_23 = bits(whatChange, 1, 1) @[intervox_receiver.scala 123:47]
    node _T_24 = eq(_T_23, UInt<1>("h0")) @[intervox_receiver.scala 123:51]
    node _T_25 = and(_T_22, _T_24) @[intervox_receiver.scala 123:34]
    node _GEN_22 = mux(_T_25, UInt<1>("h0"), clkCntr2) @[intervox_receiver.scala 123:60 125:18 28:30]
    node _T_26 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 127:17]
    node _clkCntr2_T = add(clkCntr2, UInt<1>("h1")) @[intervox_receiver.scala 128:30]
    node _clkCntr2_T_1 = tail(_clkCntr2_T, 1) @[intervox_receiver.scala 128:30]
    node _T_27 = sub(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 129:35]
    node _T_28 = tail(_T_27, 1) @[intervox_receiver.scala 129:35]
    node _T_29 = eq(clkCntr2, _T_28) @[intervox_receiver.scala 129:23]
    node _clkRec_T = not(clkRec) @[intervox_receiver.scala 131:28]
    node _GEN_23 = mux(_T_29, _clkRec_T, clkRec) @[intervox_receiver.scala 129:41 131:25 36:30]
    node _GEN_24 = mux(_T_29, UInt<1>("h0"), _clkCntr2_T_1) @[intervox_receiver.scala 128:18 129:41 132:25]
    node _GEN_25 = mux(_T_26, _GEN_24, _GEN_22) @[intervox_receiver.scala 127:25]
    node _GEN_26 = mux(_T_26, _GEN_23, clkRec) @[intervox_receiver.scala 127:25 36:30]
    io_CLK_OUT <= clkRec @[intervox_receiver.scala 40:21]
    io_DATA_OUT <= change @[intervox_receiver.scala 41:21]
    io_NEXT_FRAME <= nextFrame @[intervox_receiver.scala 42:21]
    clkCntr <= mux(reset, UInt<2>("h0"), _GEN_2) @[intervox_receiver.scala 26:{30,30}]
    clkCntr1 <= mux(reset, UInt<8>("h0"), _GEN_12) @[intervox_receiver.scala 27:{30,30}]
    clkCntr2 <= mux(reset, UInt<8>("h0"), _GEN_25) @[intervox_receiver.scala 28:{30,30}]
    clkDelta <= mux(reset, UInt<8>("h0"), _GEN_13) @[intervox_receiver.scala 29:{30,30}]
    lastOne <= mux(reset, UInt<8>("h0"), _GEN_16) @[intervox_receiver.scala 30:{30,30}]
    pllCntr <= mux(reset, UInt<8>("h0"), _GEN_1) @[intervox_receiver.scala 31:{30,30}]
    inBufr <= mux(reset, UInt<2>("h0"), _GEN_7) @[intervox_receiver.scala 32:{30,30}]
    whatChange <= mux(reset, UInt<2>("h0"), _GEN_21) @[intervox_receiver.scala 33:{30,30}]
    outReg <= mux(reset, UInt<1>("h0"), _GEN_0) @[intervox_receiver.scala 35:{30,30}]
    clkRec <= mux(reset, UInt<1>("h0"), _GEN_26) @[intervox_receiver.scala 36:{30,30}]
    change <= mux(reset, UInt<1>("h0"), _GEN_11) @[intervox_receiver.scala 37:{30,30}]
    nextFrame <= mux(reset, UInt<1>("h0"), _GEN_17) @[intervox_receiver.scala 38:{30,30}]

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

    inst clockRec of clock_Recovery @[intervox_receiver.scala 156:26]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 164:21]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 170:24]
    node _GEN_0 = mux(_T, pll.PLL_MCLK, UInt<1>("h0")) @[intervox_receiver.scala 170:32 171:20 175:20]
    node _GEN_1 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[intervox_receiver.scala 170:32 172:20 176:20]
    io_CLK_REC <= _GEN_0
    io_DATA_OUT <= clockRec.io_DATA_OUT @[intervox_receiver.scala 159:25]
    io_NEXT_FRAME <= clockRec.io_NEXT_FRAME @[intervox_receiver.scala 160:25]
    io_DBUG <= clockRec.io_CLK_OUT @[intervox_receiver.scala 161:25]
    io_DBUG1 <= _GEN_1
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io_DATA_IN <= io_INTERVOX_IN @[intervox_receiver.scala 158:25]
    pll.PLL_IN <= clockRec.io_CLK_OUT @[intervox_receiver.scala 167:19]
