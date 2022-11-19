circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : Reset
    output io : { flip DATA_IN : UInt<1>, CLK_OUT : UInt<1>, DATA_OUT : UInt<1>, NEXT_FRAME : UInt<1>}

    node _expected_cycles_syncword_T = mul(UInt<6>("h20"), UInt<3>("h4")) @[intervox_receiver.scala 25:42]
    node _expected_cycles_syncword_T_1 = sub(_expected_cycles_syncword_T, UInt<1>("h1")) @[intervox_receiver.scala 25:49]
    node expected_cycles_syncword = tail(_expected_cycles_syncword_T_1, 1) @[intervox_receiver.scala 25:49]
    node _expected_cycles_zero_T = sub(UInt<7>("h40"), UInt<1>("h1")) @[intervox_receiver.scala 26:37]
    node expected_cycles_zero = tail(_expected_cycles_zero_T, 1) @[intervox_receiver.scala 26:37]
    node _expected_cycles_one_T = sub(UInt<6>("h20"), UInt<1>("h1")) @[intervox_receiver.scala 27:36]
    node expected_cycles_one = tail(_expected_cycles_one_T, 1) @[intervox_receiver.scala 27:36]
    reg clkCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 29:30]
    reg pllCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 30:30]
    reg inState : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 31:30]
    reg prevInState : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 32:30]
    reg inStateWas : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 33:30]
    reg outReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 34:30]
    reg dataOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 35:30]
    reg nextFrame : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 36:30]
    reg noChange : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 37:30]
    io.CLK_OUT <= outReg @[intervox_receiver.scala 39:21]
    io.DATA_OUT <= dataOut @[intervox_receiver.scala 40:21]
    io.NEXT_FRAME <= nextFrame @[intervox_receiver.scala 41:21]
    node _pllCntr_T = add(pllCntr, UInt<1>("h1")) @[intervox_receiver.scala 43:24]
    node _pllCntr_T_1 = tail(_pllCntr_T, 1) @[intervox_receiver.scala 43:24]
    pllCntr <= _pllCntr_T_1 @[intervox_receiver.scala 43:13]
    node _T = eq(pllCntr, UInt<3>("h7")) @[intervox_receiver.scala 44:18]
    when _T : @[intervox_receiver.scala 44:26]
      node _outReg_T = not(outReg) @[intervox_receiver.scala 45:19]
      outReg <= _outReg_T @[intervox_receiver.scala 45:16]
      pllCntr <= UInt<1>("h0") @[intervox_receiver.scala 46:17]
    node _T_1 = eq(UInt<1>("h0"), io.DATA_IN) @[intervox_receiver.scala 50:23]
    when _T_1 : @[intervox_receiver.scala 50:23]
      node _T_2 = eq(inState, UInt<1>("h1")) @[intervox_receiver.scala 54:27]
      when _T_2 : @[intervox_receiver.scala 54:36]
        inState <= UInt<1>("h0") @[intervox_receiver.scala 56:25]
      node _clkCntr_T = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 59:32]
      node _clkCntr_T_1 = tail(_clkCntr_T, 1) @[intervox_receiver.scala 59:32]
      clkCntr <= _clkCntr_T_1 @[intervox_receiver.scala 59:21]
    else :
      node _T_3 = eq(UInt<1>("h1"), io.DATA_IN) @[intervox_receiver.scala 50:23]
      when _T_3 : @[intervox_receiver.scala 50:23]
        node _T_4 = eq(inState, UInt<1>("h0")) @[intervox_receiver.scala 63:26]
        when _T_4 : @[intervox_receiver.scala 63:34]
          inState <= UInt<1>("h1") @[intervox_receiver.scala 65:25]
        node _clkCntr_T_2 = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 68:32]
        node _clkCntr_T_3 = tail(_clkCntr_T_2, 1) @[intervox_receiver.scala 68:32]
        clkCntr <= _clkCntr_T_3 @[intervox_receiver.scala 68:21]
    node _T_5 = sub(expected_cycles_syncword, UInt<5>("h10")) @[intervox_receiver.scala 72:47]
    node _T_6 = tail(_T_5, 1) @[intervox_receiver.scala 72:47]
    node _T_7 = geq(clkCntr, _T_6) @[intervox_receiver.scala 72:18]
    when _T_7 : @[intervox_receiver.scala 72:55]
      node _T_8 = eq(inState, UInt<1>("h1")) @[intervox_receiver.scala 74:22]
      when _T_8 : @[intervox_receiver.scala 74:30]
        nextFrame <= UInt<1>("h1") @[intervox_receiver.scala 76:23]
      node _T_9 = geq(clkCntr, expected_cycles_syncword) @[intervox_receiver.scala 78:22]
      when _T_9 : @[intervox_receiver.scala 78:52]
        clkCntr <= UInt<1>("h0") @[intervox_receiver.scala 80:21]
    node _T_10 = eq(clkCntr, UInt<5>("h10")) @[intervox_receiver.scala 85:18]
    node _T_11 = eq(clkCntr, UInt<6>("h30")) @[intervox_receiver.scala 85:38]
    node _T_12 = or(_T_10, _T_11) @[intervox_receiver.scala 85:27]
    when _T_12 : @[intervox_receiver.scala 85:47]
      node _T_13 = eq(inState, io.DATA_IN) @[intervox_receiver.scala 87:22]
      when _T_13 : @[intervox_receiver.scala 87:37]
        noChange <= UInt<1>("h1") @[intervox_receiver.scala 89:22]
      node _T_14 = not(io.DATA_IN) @[intervox_receiver.scala 92:26]
      node _T_15 = eq(inState, _T_14) @[intervox_receiver.scala 92:22]
      when _T_15 : @[intervox_receiver.scala 92:38]
        noChange <= UInt<1>("h0") @[intervox_receiver.scala 94:22]
    node _T_16 = eq(clkCntr, expected_cycles_one) @[intervox_receiver.scala 98:18]
    when _T_16 : @[intervox_receiver.scala 98:42]
      node _T_17 = eq(noChange, UInt<1>("h0")) @[intervox_receiver.scala 100:23]
      when _T_17 : @[intervox_receiver.scala 100:31]
        dataOut <= UInt<1>("h1") @[intervox_receiver.scala 102:21]
        clkCntr <= UInt<1>("h0") @[intervox_receiver.scala 103:21]
    node _T_18 = gt(clkCntr, expected_cycles_one) @[intervox_receiver.scala 107:18]
    when _T_18 : @[intervox_receiver.scala 107:40]
      node _T_19 = eq(noChange, UInt<1>("h1")) @[intervox_receiver.scala 109:23]
      when _T_19 : @[intervox_receiver.scala 109:31]
        dataOut <= UInt<1>("h0") @[intervox_receiver.scala 111:21]
      node _T_20 = eq(clkCntr, expected_cycles_zero) @[intervox_receiver.scala 114:22]
      when _T_20 : @[intervox_receiver.scala 114:47]
        clkCntr <= UInt<1>("h0") @[intervox_receiver.scala 116:21]

  extmodule clk_wiz_0_clk_wiz :
    output PLL_MCLK : UInt<1>
    output locked : UInt<1>
    input PLL_IN : UInt<1>
    defname = clk_wiz_0_clk_wiz

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, NEXT_FRAME : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 137:26]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 139:25]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 140:25]
    io.NEXT_FRAME <= clockRec.io.NEXT_FRAME @[intervox_receiver.scala 141:25]
    io.DBUG <= clockRec.io.CLK_OUT @[intervox_receiver.scala 142:25]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 145:21]
    pll.PLL_IN is invalid
    pll.locked is invalid
    pll.PLL_MCLK is invalid
    pll.PLL_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 148:19]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 151:24]
    when _T : @[intervox_receiver.scala 151:32]
      io.CLK_REC <= pll.PLL_MCLK @[intervox_receiver.scala 152:20]
      io.DBUG1 <= UInt<1>("h1") @[intervox_receiver.scala 153:20]
    else :
      io.CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 156:20]
      io.DBUG1 <= UInt<1>("h0") @[intervox_receiver.scala 157:20]

