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
    node _T = eq(UInt<1>("h0"), io.DATA_IN) @[intervox_receiver.scala 53:23]
    when _T : @[intervox_receiver.scala 53:23]
      node _T_1 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 55:25]
      when _T_1 : @[intervox_receiver.scala 55:31]
        node _inBufr_T = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 56:34]
        node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 56:34]
        inBufr <= _inBufr_T_1 @[intervox_receiver.scala 56:24]
    else :
      node _T_2 = eq(UInt<1>("h1"), io.DATA_IN) @[intervox_receiver.scala 53:23]
      when _T_2 : @[intervox_receiver.scala 53:23]
        node _T_3 = lt(inBufr, UInt<2>("h3")) @[intervox_receiver.scala 60:25]
        when _T_3 : @[intervox_receiver.scala 60:31]
          node _inBufr_T_2 = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 61:34]
          node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 61:34]
          inBufr <= _inBufr_T_3 @[intervox_receiver.scala 61:24]
    node _T_4 = bits(inBufr, 0, 0) @[intervox_receiver.scala 65:17]
    node _T_5 = bits(inBufr, 1, 1) @[intervox_receiver.scala 65:31]
    node _T_6 = xor(_T_4, _T_5) @[intervox_receiver.scala 65:22]
    when _T_6 : @[intervox_receiver.scala 65:36]
      change <= UInt<1>("h1") @[intervox_receiver.scala 66:16]
    node _T_7 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 70:17]
    when _T_7 : @[intervox_receiver.scala 70:25]
      reg change_REG : UInt, clock with :
        reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 71:34]
      change_REG <= UInt<1>("h0") @[intervox_receiver.scala 71:34]
      reg change_REG_1 : UInt, clock with :
        reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 71:26]
      change_REG_1 <= change_REG @[intervox_receiver.scala 71:26]
      change <= change_REG_1 @[intervox_receiver.scala 71:16]
      node _clkRec_T = not(clkRec) @[intervox_receiver.scala 72:24]
      clkRec <= _clkRec_T @[intervox_receiver.scala 72:21]
      deltaCntr <= UInt<1>("h0") @[intervox_receiver.scala 73:21]
      zeroFlipped <= UInt<1>("h0") @[intervox_receiver.scala 74:21]
      syncFlipped <= UInt<1>("h0") @[intervox_receiver.scala 75:21]
      syncFlipped1 <= UInt<1>("h0") @[intervox_receiver.scala 76:21]
    node _T_8 = add(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 80:33]
    node _T_9 = tail(_T_8, 1) @[intervox_receiver.scala 80:33]
    node _T_10 = leq(deltaCntr, _T_9) @[intervox_receiver.scala 80:21]
    when _T_10 : @[intervox_receiver.scala 80:41]
      syncWord <= UInt<1>("h0") @[intervox_receiver.scala 81:18]
      node _T_11 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 82:21]
      when _T_11 : @[intervox_receiver.scala 82:29]
        dataOut <= UInt<1>("h1") @[intervox_receiver.scala 83:21]
    node _T_12 = add(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 88:32]
    node _T_13 = tail(_T_12, 1) @[intervox_receiver.scala 88:32]
    node _T_14 = gt(deltaCntr, _T_13) @[intervox_receiver.scala 88:21]
    node _T_15 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 88:64]
    node _T_16 = lt(deltaCntr, _T_15) @[intervox_receiver.scala 88:53]
    node _T_17 = and(_T_14, _T_16) @[intervox_receiver.scala 88:40]
    when _T_17 : @[intervox_receiver.scala 88:72]
      node _T_18 = eq(zeroFlipped, UInt<1>("h0")) @[intervox_receiver.scala 89:26]
      when _T_18 : @[intervox_receiver.scala 89:34]
        node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 91:23]
        clkRec <= _clkRec_T_1 @[intervox_receiver.scala 91:20]
        zeroFlipped <= UInt<1>("h1") @[intervox_receiver.scala 92:25]
      dataOut <= UInt<1>("h0") @[intervox_receiver.scala 94:17]
    node _T_19 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 100:17]
    when _T_19 : @[intervox_receiver.scala 100:25]
      node _T_20 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 102:37]
      node _T_21 = add(_T_20, UInt<2>("h2")) @[intervox_receiver.scala 102:44]
      node _T_22 = tail(_T_21, 1) @[intervox_receiver.scala 102:44]
      node _T_23 = gt(deltaCntr, _T_22) @[intervox_receiver.scala 102:25]
      node _T_24 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 102:77]
      node _T_25 = sub(_T_24, UInt<2>("h2")) @[intervox_receiver.scala 102:84]
      node _T_26 = tail(_T_25, 1) @[intervox_receiver.scala 102:84]
      node _T_27 = lt(deltaCntr, _T_26) @[intervox_receiver.scala 102:65]
      node _T_28 = and(_T_23, _T_27) @[intervox_receiver.scala 102:52]
      when _T_28 : @[intervox_receiver.scala 102:92]
        node _T_29 = eq(syncFlipped, UInt<1>("h0")) @[intervox_receiver.scala 103:30]
        when _T_29 : @[intervox_receiver.scala 103:38]
          node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 105:27]
          clkRec <= _clkRec_T_2 @[intervox_receiver.scala 105:24]
          syncFlipped <= UInt<1>("h1") @[intervox_receiver.scala 106:29]
      node _T_30 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 109:35]
      node _T_31 = gt(deltaCntr, _T_30) @[intervox_receiver.scala 109:24]
      when _T_31 : @[intervox_receiver.scala 109:42]
        syncWord <= UInt<1>("h1") @[intervox_receiver.scala 110:22]
        node _T_32 = eq(syncFlipped1, UInt<1>("h0")) @[intervox_receiver.scala 111:31]
        when _T_32 : @[intervox_receiver.scala 111:39]
          node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 113:27]
          clkRec <= _clkRec_T_3 @[intervox_receiver.scala 113:24]
          syncFlipped1 <= UInt<1>("h1") @[intervox_receiver.scala 114:30]

  extmodule clk_wiz_0_clk_wiz :
    output CLK_OUT : UInt<1>
    output locked : UInt<1>
    input CLK_IN : UInt<1>
    defname = clk_wiz_0_clk_wiz

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, CLK_DBUG : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LEDS : UInt<16>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 132:26]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 134:25]
    io.LEDS <= clockRec.io.LEDS @[intervox_receiver.scala 136:25]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 137:25]
    io.CLK_DBUG <= clockRec.io.CLK_OUT @[intervox_receiver.scala 138:25]
    io.DBUG1 <= clockRec.io.DBUG1 @[intervox_receiver.scala 139:25]
    io.DBUG <= clockRec.io.DBUG @[intervox_receiver.scala 140:25]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 145:21]
    pll.CLK_IN is invalid
    pll.locked is invalid
    pll.CLK_OUT is invalid
    pll.CLK_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 148:19]
    io.CLK_REC <= pll.CLK_OUT @[intervox_receiver.scala 150:16]

