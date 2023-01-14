circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : Reset
    output io : { flip DATA_IN : UInt<1>, CLK_OUT : UInt<1>, DATA_OUT : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LEDS : UInt<16>}

    reg rising : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 27:30]
    reg trailing : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 28:30]
    reg lastOne : UInt<8>, clock with :
      reset => (reset, UInt<8>("hf")) @[intervox_receiver.scala 29:30]
    reg overSampleCntr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[intervox_receiver.scala 30:32]
    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 31:30]
    reg deltaCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 32:30]
    reg clkRec : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 33:30]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 34:30]
    reg dataOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 35:30]
    reg syncWord : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 36:30]
    reg zeroFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 37:30]
    reg syncFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 38:30]
    reg syncFlipped1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 39:30]
    io.CLK_OUT <= clkRec @[intervox_receiver.scala 43:21]
    io.DATA_OUT <= dataOut @[intervox_receiver.scala 44:21]
    io.DBUG <= change @[intervox_receiver.scala 45:21]
    io.DBUG1 <= syncWord @[intervox_receiver.scala 46:21]
    io.LEDS <= lastOne @[intervox_receiver.scala 47:21]
    node _deltaCntr_T = add(deltaCntr, UInt<1>("h1")) @[intervox_receiver.scala 49:31]
    node _deltaCntr_T_1 = tail(_deltaCntr_T, 1) @[intervox_receiver.scala 49:31]
    deltaCntr <= _deltaCntr_T_1 @[intervox_receiver.scala 49:18]
    node _T = eq(UInt<1>("h1"), io.DATA_IN) @[intervox_receiver.scala 54:23]
    when _T : @[intervox_receiver.scala 54:23]
      node _T_1 = lt(inBufr, UInt<2>("h3")) @[intervox_receiver.scala 56:25]
      when _T_1 : @[intervox_receiver.scala 56:31]
        node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 58:34]
        node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 58:34]
        inBufr <= _inBufr_T_1 @[intervox_receiver.scala 58:24]
    else :
      node _T_2 = eq(UInt<1>("h0"), io.DATA_IN) @[intervox_receiver.scala 54:23]
      when _T_2 : @[intervox_receiver.scala 54:23]
        node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 62:25]
        when _T_3 : @[intervox_receiver.scala 62:31]
          node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 64:34]
          node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 64:34]
          inBufr <= _inBufr_T_3 @[intervox_receiver.scala 64:24]
    node _T_4 = bits(inBufr, 0, 0) @[intervox_receiver.scala 68:17]
    node _T_5 = bits(inBufr, 1, 1) @[intervox_receiver.scala 68:31]
    node _T_6 = xor(_T_4, _T_5) @[intervox_receiver.scala 68:22]
    when _T_6 : @[intervox_receiver.scala 68:36]
      change <= UInt<1>("h1") @[intervox_receiver.scala 69:16]
    node _T_7 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 75:17]
    when _T_7 : @[intervox_receiver.scala 75:25]
      reg change_REG : UInt, clock with :
        reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 77:34]
      change_REG <= UInt<1>("h0") @[intervox_receiver.scala 77:34]
      reg change_REG_1 : UInt, clock with :
        reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 77:26]
      change_REG_1 <= change_REG @[intervox_receiver.scala 77:26]
      change <= change_REG_1 @[intervox_receiver.scala 77:16]
      node _clkRec_T = not(clkRec) @[intervox_receiver.scala 79:24]
      clkRec <= _clkRec_T @[intervox_receiver.scala 79:21]
      deltaCntr <= UInt<1>("h0") @[intervox_receiver.scala 81:21]
      zeroFlipped <= UInt<1>("h0") @[intervox_receiver.scala 83:21]
      syncFlipped <= UInt<1>("h0") @[intervox_receiver.scala 84:21]
      syncFlipped1 <= UInt<1>("h0") @[intervox_receiver.scala 85:21]
      syncWord <= UInt<1>("h0") @[intervox_receiver.scala 86:18]
    node _T_8 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 92:33]
    node _T_9 = tail(_T_8, 1) @[intervox_receiver.scala 92:33]
    node _T_10 = leq(deltaCntr, _T_9) @[intervox_receiver.scala 92:21]
    when _T_10 : @[intervox_receiver.scala 92:41]
      node _T_11 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 95:21]
      when _T_11 : @[intervox_receiver.scala 95:29]
        dataOut <= UInt<1>("h1") @[intervox_receiver.scala 98:21]
    node _T_12 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 108:32]
    node _T_13 = tail(_T_12, 1) @[intervox_receiver.scala 108:32]
    node _T_14 = gt(deltaCntr, _T_13) @[intervox_receiver.scala 108:21]
    node _T_15 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 108:65]
    node _T_16 = add(_T_15, UInt<2>("h2")) @[intervox_receiver.scala 108:72]
    node _T_17 = tail(_T_16, 1) @[intervox_receiver.scala 108:72]
    node _T_18 = lt(deltaCntr, _T_17) @[intervox_receiver.scala 108:53]
    node _T_19 = and(_T_14, _T_18) @[intervox_receiver.scala 108:40]
    when _T_19 : @[intervox_receiver.scala 108:80]
      node _T_20 = eq(zeroFlipped, UInt<1>("h0")) @[intervox_receiver.scala 111:26]
      when _T_20 : @[intervox_receiver.scala 111:34]
        node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 114:23]
        clkRec <= _clkRec_T_1 @[intervox_receiver.scala 114:20]
        zeroFlipped <= UInt<1>("h1") @[intervox_receiver.scala 115:25]
      dataOut <= UInt<1>("h0") @[intervox_receiver.scala 118:17]
    node _T_21 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 125:17]
    when _T_21 : @[intervox_receiver.scala 125:25]
      node _T_22 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 127:38]
      node _T_23 = add(_T_22, UInt<2>("h2")) @[intervox_receiver.scala 127:45]
      node _T_24 = tail(_T_23, 1) @[intervox_receiver.scala 127:45]
      node _T_25 = eq(deltaCntr, _T_24) @[intervox_receiver.scala 127:24]
      when _T_25 : @[intervox_receiver.scala 127:52]
        node _T_26 = eq(syncFlipped, UInt<1>("h0")) @[intervox_receiver.scala 134:30]
        when _T_26 : @[intervox_receiver.scala 134:38]
          node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 136:27]
          clkRec <= _clkRec_T_2 @[intervox_receiver.scala 136:24]
          syncFlipped <= UInt<1>("h1") @[intervox_receiver.scala 137:29]
      node _T_27 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 140:38]
      node _T_28 = eq(deltaCntr, _T_27) @[intervox_receiver.scala 140:24]
      when _T_28 : @[intervox_receiver.scala 140:46]
        syncWord <= UInt<1>("h1") @[intervox_receiver.scala 147:22]
        node _T_29 = eq(syncFlipped1, UInt<1>("h0")) @[intervox_receiver.scala 149:31]
        when _T_29 : @[intervox_receiver.scala 149:39]
          node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 151:27]
          clkRec <= _clkRec_T_3 @[intervox_receiver.scala 151:24]
          syncFlipped1 <= UInt<1>("h1") @[intervox_receiver.scala 152:30]

  extmodule clk_wiz_0_clk_wiz :
    output CLK_OUT : UInt<1>
    output locked : UInt<1>
    input CLK_IN : UInt<1>
    defname = clk_wiz_0_clk_wiz

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, CLK_DBUG : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LEDS : UInt<16>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 170:26]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 172:25]
    io.LEDS <= clockRec.io.LEDS @[intervox_receiver.scala 174:25]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 175:25]
    io.CLK_DBUG <= clockRec.io.CLK_OUT @[intervox_receiver.scala 176:25]
    io.DBUG1 <= clockRec.io.DBUG1 @[intervox_receiver.scala 177:25]
    io.DBUG <= clockRec.io.DBUG @[intervox_receiver.scala 178:25]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 183:21]
    pll.CLK_IN is invalid
    pll.locked is invalid
    pll.CLK_OUT is invalid
    pll.CLK_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 186:19]
    io.CLK_REC <= pll.CLK_OUT @[intervox_receiver.scala 187:16]

