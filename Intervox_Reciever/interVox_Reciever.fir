circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : Reset
    output io : { flip DATA_IN : UInt<1>, CLK_OUT : UInt<1>, DATA_OUT : UInt<1>, NEXT_FRAME : UInt<1>}

    reg clkCntr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 26:30]
    reg clkCntr1 : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 27:30]
    reg clkDelta : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 28:30]
    reg pllCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 29:30]
    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 30:30]
    reg outReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 32:30]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 33:30]
    reg nextFrame : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 34:30]
    io.CLK_OUT <= outReg @[intervox_receiver.scala 36:21]
    io.DATA_OUT <= change @[intervox_receiver.scala 37:21]
    io.NEXT_FRAME <= nextFrame @[intervox_receiver.scala 38:21]
    node _pllCntr_T = add(pllCntr, UInt<1>("h1")) @[intervox_receiver.scala 41:24]
    node _pllCntr_T_1 = tail(_pllCntr_T, 1) @[intervox_receiver.scala 41:24]
    pllCntr <= _pllCntr_T_1 @[intervox_receiver.scala 41:13]
    node _T = eq(pllCntr, UInt<3>("h7")) @[intervox_receiver.scala 42:18]
    when _T : @[intervox_receiver.scala 42:26]
      node _outReg_T = not(outReg) @[intervox_receiver.scala 45:19]
      outReg <= _outReg_T @[intervox_receiver.scala 45:16]
      pllCntr <= UInt<1>("h0") @[intervox_receiver.scala 46:17]
    node _clkCntr_T = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 54:28]
    node _clkCntr_T_1 = tail(_clkCntr_T, 1) @[intervox_receiver.scala 54:28]
    clkCntr <= _clkCntr_T_1 @[intervox_receiver.scala 54:17]
    node _clkCntr1_T = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 56:29]
    node _clkCntr1_T_1 = tail(_clkCntr1_T, 1) @[intervox_receiver.scala 56:29]
    clkCntr1 <= _clkCntr1_T_1 @[intervox_receiver.scala 56:17]
    node _T_1 = eq(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 58:18]
    when _T_1 : @[intervox_receiver.scala 58:26]
      clkCntr <= UInt<1>("h0") @[intervox_receiver.scala 59:17]
      change <= UInt<1>("h0") @[intervox_receiver.scala 60:16]
    node _T_2 = eq(io.DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 63:21]
    when _T_2 : @[intervox_receiver.scala 63:29]
      node _T_3 = lt(inBufr, UInt<2>("h3")) @[intervox_receiver.scala 64:21]
      when _T_3 : @[intervox_receiver.scala 64:27]
        node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 65:30]
        node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 65:30]
        inBufr <= _inBufr_T_1 @[intervox_receiver.scala 65:20]
    node _T_4 = eq(io.DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 68:21]
    when _T_4 : @[intervox_receiver.scala 68:29]
      node _T_5 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 69:21]
      when _T_5 : @[intervox_receiver.scala 69:27]
        node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 70:30]
        node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 70:30]
        inBufr <= _inBufr_T_3 @[intervox_receiver.scala 70:20]
    node _T_6 = gt(clkCntr1, UInt<6>("h20")) @[intervox_receiver.scala 75:20]
    when _T_6 : @[intervox_receiver.scala 75:28]
      nextFrame <= UInt<1>("h0") @[intervox_receiver.scala 75:39]
    node _T_7 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 77:17]
    when _T_7 : @[intervox_receiver.scala 77:25]
      node _T_8 = bits(inBufr, 0, 0) @[intervox_receiver.scala 79:20]
      node _T_9 = bits(inBufr, 1, 1) @[intervox_receiver.scala 79:34]
      node _T_10 = neq(_T_8, _T_9) @[intervox_receiver.scala 79:24]
      when _T_10 : @[intervox_receiver.scala 79:38]
        change <= UInt<1>("h1") @[intervox_receiver.scala 80:20]
        clkCntr1 <= UInt<1>("h0") @[intervox_receiver.scala 81:22]
        clkDelta <= clkCntr1 @[intervox_receiver.scala 82:22]
    node _T_11 = gt(clkDelta, UInt<1>("h0")) @[intervox_receiver.scala 91:20]
    node _T_12 = lt(clkDelta, UInt<4>("ha")) @[intervox_receiver.scala 91:39]
    node _T_13 = and(_T_11, _T_12) @[intervox_receiver.scala 91:27]
    when _T_13 : @[intervox_receiver.scala 91:47]
      nextFrame <= UInt<1>("h1") @[intervox_receiver.scala 91:58]
    node _T_14 = gt(clkDelta, UInt<4>("ha")) @[intervox_receiver.scala 93:20]
    node _T_15 = lt(clkDelta, UInt<6>("h20")) @[intervox_receiver.scala 93:40]
    node _T_16 = and(_T_14, _T_15) @[intervox_receiver.scala 93:28]
    when _T_16 : @[intervox_receiver.scala 93:48]
      nextFrame <= UInt<1>("h0") @[intervox_receiver.scala 93:59]

  extmodule clk_wiz_0_clk_wiz :
    output PLL_MCLK : UInt<1>
    output locked : UInt<1>
    input PLL_IN : UInt<1>
    defname = clk_wiz_0_clk_wiz

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, NEXT_FRAME : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 108:26]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 110:25]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 111:25]
    io.NEXT_FRAME <= clockRec.io.NEXT_FRAME @[intervox_receiver.scala 112:25]
    io.DBUG <= clockRec.io.CLK_OUT @[intervox_receiver.scala 113:25]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 116:21]
    pll.PLL_IN is invalid
    pll.locked is invalid
    pll.PLL_MCLK is invalid
    pll.PLL_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 119:19]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 122:24]
    when _T : @[intervox_receiver.scala 122:32]
      io.CLK_REC <= pll.PLL_MCLK @[intervox_receiver.scala 123:20]
      io.DBUG1 <= UInt<1>("h1") @[intervox_receiver.scala 124:20]
    else :
      io.CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 127:20]
      io.DBUG1 <= UInt<1>("h0") @[intervox_receiver.scala 128:20]

