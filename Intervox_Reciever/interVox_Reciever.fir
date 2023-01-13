circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : Reset
    output io : { flip DATA_IN : UInt<1>, CLK_OUT : UInt<1>, DATA_OUT : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LEDS : UInt<16>}

    reg deltaCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 25:30]
    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 26:30]
    reg lastOne : UInt<8>, clock with :
      reset => (reset, UInt<8>("hf")) @[intervox_receiver.scala 27:30]
    reg inBufrPrev : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 28:30]
    reg clkRec : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 30:30]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 31:30]
    reg changed : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 32:30]
    reg dataOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 33:30]
    reg zeroPeriode : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 34:30]
    reg syncWord : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 35:30]
    reg syncFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 36:30]
    reg syncFlipped1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 37:31]
    io.CLK_OUT <= clkRec @[intervox_receiver.scala 39:21]
    io.DATA_OUT <= dataOut @[intervox_receiver.scala 40:21]
    io.DBUG <= change @[intervox_receiver.scala 41:21]
    io.DBUG1 <= syncWord @[intervox_receiver.scala 42:21]
    io.LEDS <= lastOne @[intervox_receiver.scala 43:21]
    node _deltaCntr_T = add(deltaCntr, UInt<1>("h1")) @[intervox_receiver.scala 46:31]
    node _deltaCntr_T_1 = tail(_deltaCntr_T, 1) @[intervox_receiver.scala 46:31]
    deltaCntr <= _deltaCntr_T_1 @[intervox_receiver.scala 46:18]
    node _T = eq(io.DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 49:21]
    when _T : @[intervox_receiver.scala 49:29]
      node _T_1 = eq(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 52:21]
      when _T_1 : @[intervox_receiver.scala 52:29]
        inBufr <= UInt<1>("h1") @[intervox_receiver.scala 53:20]
      node _T_2 = lt(inBufr, UInt<2>("h2")) @[intervox_receiver.scala 56:22]
      node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 56:39]
      node _T_4 = and(_T_2, _T_3) @[intervox_receiver.scala 56:29]
      when _T_4 : @[intervox_receiver.scala 56:46]
        inBufrPrev <= inBufr @[intervox_receiver.scala 58:24]
        node _inBufr_T = dshl(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 59:30]
        inBufr <= _inBufr_T @[intervox_receiver.scala 59:20]
      node _T_5 = eq(inBufr, UInt<2>("h2")) @[intervox_receiver.scala 61:21]
      when _T_5 : @[intervox_receiver.scala 61:29]
        inBufrPrev <= inBufr @[intervox_receiver.scala 63:24]
    node _T_6 = eq(io.DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 67:21]
    when _T_6 : @[intervox_receiver.scala 67:29]
      node _T_7 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 70:21]
      when _T_7 : @[intervox_receiver.scala 70:27]
        inBufrPrev <= inBufr @[intervox_receiver.scala 72:24]
        node _inBufr_T_1 = dshr(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 74:30]
        inBufr <= _inBufr_T_1 @[intervox_receiver.scala 74:20]
      node _T_8 = eq(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 76:21]
      when _T_8 : @[intervox_receiver.scala 76:29]
        inBufrPrev <= inBufr @[intervox_receiver.scala 78:24]
    node _T_9 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_receiver.scala 91:23]
    node _T_10 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 91:42]
    node _T_11 = and(_T_9, _T_10) @[intervox_receiver.scala 91:32]
    node _T_12 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_receiver.scala 91:67]
    node _T_13 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 91:86]
    node _T_14 = and(_T_12, _T_13) @[intervox_receiver.scala 91:76]
    node _T_15 = or(_T_11, _T_14) @[intervox_receiver.scala 91:52]
    when _T_15 : @[intervox_receiver.scala 91:96]
      node _change_T = not(change) @[intervox_receiver.scala 93:24]
      change <= _change_T @[intervox_receiver.scala 93:21]
      changed <= UInt<1>("h0") @[intervox_receiver.scala 95:21]
      node _clkRec_T = not(clkRec) @[intervox_receiver.scala 97:24]
      clkRec <= _clkRec_T @[intervox_receiver.scala 97:21]
      syncWord <= UInt<1>("h0") @[intervox_receiver.scala 99:21]
      syncFlipped <= UInt<1>("h0") @[intervox_receiver.scala 100:21]
      syncFlipped1 <= UInt<1>("h0") @[intervox_receiver.scala 101:21]
      deltaCntr <= UInt<1>("h0") @[intervox_receiver.scala 103:21]
      node _T_16 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 107:37]
      node _T_17 = tail(_T_16, 1) @[intervox_receiver.scala 107:37]
      node _T_18 = div(_T_17, UInt<2>("h2")) @[intervox_receiver.scala 107:43]
      node _T_19 = gt(deltaCntr, _T_18) @[intervox_receiver.scala 107:25]
      node _T_20 = add(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 107:74]
      node _T_21 = tail(_T_20, 1) @[intervox_receiver.scala 107:74]
      node _T_22 = lt(deltaCntr, _T_21) @[intervox_receiver.scala 107:63]
      node _T_23 = and(_T_19, _T_22) @[intervox_receiver.scala 107:50]
      when _T_23 : @[intervox_receiver.scala 107:83]
        dataOut <= UInt<1>("h1") @[intervox_receiver.scala 112:25]
        zeroPeriode <= UInt<1>("h0") @[intervox_receiver.scala 114:25]
        lastOne <= deltaCntr @[intervox_receiver.scala 116:25]
    node _T_24 = add(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 122:33]
    node _T_25 = tail(_T_24, 1) @[intervox_receiver.scala 122:33]
    node _T_26 = geq(deltaCntr, _T_25) @[intervox_receiver.scala 122:21]
    node _T_27 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 122:66]
    node _T_28 = add(_T_27, UInt<2>("h2")) @[intervox_receiver.scala 122:74]
    node _T_29 = tail(_T_28, 1) @[intervox_receiver.scala 122:74]
    node _T_30 = lt(deltaCntr, _T_29) @[intervox_receiver.scala 122:54]
    node _T_31 = and(_T_26, _T_30) @[intervox_receiver.scala 122:41]
    when _T_31 : @[intervox_receiver.scala 122:81]
      dataOut <= UInt<1>("h0") @[intervox_receiver.scala 127:25]
      zeroPeriode <= UInt<1>("h1") @[intervox_receiver.scala 129:25]
      syncWord <= UInt<1>("h0") @[intervox_receiver.scala 131:25]
    node _T_32 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 134:34]
    node _T_33 = add(_T_32, UInt<2>("h2")) @[intervox_receiver.scala 134:41]
    node _T_34 = tail(_T_33, 1) @[intervox_receiver.scala 134:41]
    node _T_35 = geq(deltaCntr, _T_34) @[intervox_receiver.scala 134:21]
    when _T_35 : @[intervox_receiver.scala 134:49]
      syncWord <= UInt<1>("h1") @[intervox_receiver.scala 136:18]
      node _T_36 = eq(syncFlipped, UInt<1>("h0")) @[intervox_receiver.scala 138:26]
      when _T_36 : @[intervox_receiver.scala 138:34]
        node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 140:24]
        clkRec <= _clkRec_T_1 @[intervox_receiver.scala 140:21]
        syncFlipped <= UInt<1>("h1") @[intervox_receiver.scala 141:25]
      node _T_37 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 144:38]
      node _T_38 = add(_T_37, UInt<1>("h1")) @[intervox_receiver.scala 144:45]
      node _T_39 = tail(_T_38, 1) @[intervox_receiver.scala 144:45]
      node _T_40 = geq(deltaCntr, _T_39) @[intervox_receiver.scala 144:25]
      node _T_41 = eq(syncFlipped1, UInt<1>("h0")) @[intervox_receiver.scala 144:69]
      node _T_42 = and(_T_40, _T_41) @[intervox_receiver.scala 144:53]
      when _T_42 : @[intervox_receiver.scala 144:78]
        node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 146:24]
        clkRec <= _clkRec_T_2 @[intervox_receiver.scala 146:21]
        syncFlipped1 <= UInt<1>("h1") @[intervox_receiver.scala 147:26]
    node _T_43 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 168:32]
    node _T_44 = tail(_T_43, 1) @[intervox_receiver.scala 168:32]
    node _T_45 = gt(deltaCntr, _T_44) @[intervox_receiver.scala 168:22]
    node _T_46 = eq(changed, UInt<1>("h0")) @[intervox_receiver.scala 168:50]
    node _T_47 = and(_T_45, _T_46) @[intervox_receiver.scala 168:39]
    node _T_48 = neq(change, UInt<1>("h1")) @[intervox_receiver.scala 168:69]
    node _T_49 = and(_T_47, _T_48) @[intervox_receiver.scala 168:59]
    node _T_50 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 168:103]
    node _T_51 = tail(_T_50, 1) @[intervox_receiver.scala 168:103]
    node _T_52 = gt(deltaCntr, _T_51) @[intervox_receiver.scala 168:93]
    node _T_53 = eq(zeroPeriode, UInt<1>("h1")) @[intervox_receiver.scala 168:125]
    node _T_54 = and(_T_52, _T_53) @[intervox_receiver.scala 168:110]
    node _T_55 = eq(changed, UInt<1>("h0")) @[intervox_receiver.scala 168:145]
    node _T_56 = and(_T_54, _T_55) @[intervox_receiver.scala 168:134]
    node _T_57 = or(_T_49, _T_56) @[intervox_receiver.scala 168:79]
    when _T_57 : @[intervox_receiver.scala 168:155]
      node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 169:20]
      clkRec <= _clkRec_T_3 @[intervox_receiver.scala 169:17]
      changed <= UInt<1>("h1") @[intervox_receiver.scala 170:17]

  extmodule clk_wiz_0_clk_wiz :
    output CLK_OUT : UInt<1>
    output locked : UInt<1>
    input CLK_IN : UInt<1>
    defname = clk_wiz_0_clk_wiz

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, CLK_DBUG : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LEDS : UInt<16>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 187:26]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 189:25]
    io.LEDS <= clockRec.io.LEDS @[intervox_receiver.scala 191:25]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 192:25]
    io.CLK_DBUG <= clockRec.io.CLK_OUT @[intervox_receiver.scala 193:25]
    io.DBUG1 <= clockRec.io.DBUG1 @[intervox_receiver.scala 194:25]
    io.DBUG <= clockRec.io.DBUG @[intervox_receiver.scala 195:25]
    io.CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 198:16]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 203:21]
    pll.CLK_IN is invalid
    pll.locked is invalid
    pll.CLK_OUT is invalid
    pll.CLK_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 206:19]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 209:24]
    when _T : @[intervox_receiver.scala 209:32]
      io.CLK_REC <= pll.CLK_OUT @[intervox_receiver.scala 210:20]
    else :
      io.CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 213:20]

