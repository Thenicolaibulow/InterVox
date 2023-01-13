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
      reset => (reset, UInt<8>("h1f")) @[intervox_receiver.scala 27:30]
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
    node _T_9 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_receiver.scala 90:22]
    node _T_10 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 90:41]
    node _T_11 = and(_T_9, _T_10) @[intervox_receiver.scala 90:31]
    when _T_11 : @[intervox_receiver.scala 90:50]
      change <= UInt<1>("h1") @[intervox_receiver.scala 92:21]
    node _T_12 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_receiver.scala 99:22]
    node _T_13 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 99:41]
    node _T_14 = and(_T_12, _T_13) @[intervox_receiver.scala 99:31]
    when _T_14 : @[intervox_receiver.scala 99:50]
      change <= UInt<1>("h1") @[intervox_receiver.scala 101:21]
    node _T_15 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 105:17]
    when _T_15 : @[intervox_receiver.scala 105:25]
      change <= UInt<1>("h0") @[intervox_receiver.scala 107:21]
      changed <= UInt<1>("h0") @[intervox_receiver.scala 109:21]
      node _clkRec_T = not(clkRec) @[intervox_receiver.scala 111:24]
      clkRec <= _clkRec_T @[intervox_receiver.scala 111:21]
      syncWord <= UInt<1>("h0") @[intervox_receiver.scala 113:21]
      syncFlipped <= UInt<1>("h0") @[intervox_receiver.scala 114:21]
      syncFlipped1 <= UInt<1>("h0") @[intervox_receiver.scala 115:21]
      deltaCntr <= UInt<1>("h0") @[intervox_receiver.scala 117:21]
      node _T_16 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 120:36]
      node _T_17 = tail(_T_16, 1) @[intervox_receiver.scala 120:36]
      node _T_18 = leq(deltaCntr, _T_17) @[intervox_receiver.scala 120:25]
      when _T_18 : @[intervox_receiver.scala 120:43]
        dataOut <= UInt<1>("h1") @[intervox_receiver.scala 125:25]
        zeroPeriode <= UInt<1>("h0") @[intervox_receiver.scala 127:25]
        lastOne <= deltaCntr @[intervox_receiver.scala 129:25]
    node _T_19 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 135:32]
    node _T_20 = tail(_T_19, 1) @[intervox_receiver.scala 135:32]
    node _T_21 = gt(deltaCntr, _T_20) @[intervox_receiver.scala 135:21]
    node _T_22 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 135:65]
    node _T_23 = tail(_T_22, 1) @[intervox_receiver.scala 135:65]
    node _T_24 = mul(_T_23, UInt<2>("h2")) @[intervox_receiver.scala 135:72]
    node _T_25 = lt(deltaCntr, _T_24) @[intervox_receiver.scala 135:53]
    node _T_26 = and(_T_21, _T_25) @[intervox_receiver.scala 135:40]
    when _T_26 : @[intervox_receiver.scala 135:80]
      dataOut <= UInt<1>("h0") @[intervox_receiver.scala 140:25]
      zeroPeriode <= UInt<1>("h1") @[intervox_receiver.scala 142:25]
      syncWord <= UInt<1>("h0") @[intervox_receiver.scala 144:25]
    node _T_27 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 148:34]
    node _T_28 = tail(_T_27, 1) @[intervox_receiver.scala 148:34]
    node _T_29 = mul(_T_28, UInt<2>("h2")) @[intervox_receiver.scala 148:41]
    node _T_30 = geq(deltaCntr, _T_29) @[intervox_receiver.scala 148:21]
    when _T_30 : @[intervox_receiver.scala 148:49]
      syncWord <= UInt<1>("h1") @[intervox_receiver.scala 150:18]
      node _T_31 = eq(syncFlipped, UInt<1>("h0")) @[intervox_receiver.scala 151:26]
      when _T_31 : @[intervox_receiver.scala 151:34]
        node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 153:24]
        clkRec <= _clkRec_T_1 @[intervox_receiver.scala 153:21]
        syncFlipped <= UInt<1>("h1") @[intervox_receiver.scala 154:25]
      node _T_32 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 156:38]
      node _T_33 = tail(_T_32, 1) @[intervox_receiver.scala 156:38]
      node _T_34 = mul(_T_33, UInt<2>("h3")) @[intervox_receiver.scala 156:45]
      node _T_35 = geq(deltaCntr, _T_34) @[intervox_receiver.scala 156:25]
      node _T_36 = eq(syncFlipped1, UInt<1>("h0")) @[intervox_receiver.scala 156:69]
      node _T_37 = and(_T_35, _T_36) @[intervox_receiver.scala 156:53]
      when _T_37 : @[intervox_receiver.scala 156:78]
        node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 158:24]
        clkRec <= _clkRec_T_2 @[intervox_receiver.scala 158:21]
        syncFlipped1 <= UInt<1>("h1") @[intervox_receiver.scala 159:26]
    node _T_38 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 179:32]
    node _T_39 = tail(_T_38, 1) @[intervox_receiver.scala 179:32]
    node _T_40 = gt(deltaCntr, _T_39) @[intervox_receiver.scala 179:22]
    node _T_41 = eq(changed, UInt<1>("h0")) @[intervox_receiver.scala 179:50]
    node _T_42 = and(_T_40, _T_41) @[intervox_receiver.scala 179:39]
    node _T_43 = neq(change, UInt<1>("h1")) @[intervox_receiver.scala 179:69]
    node _T_44 = and(_T_42, _T_43) @[intervox_receiver.scala 179:59]
    node _T_45 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 179:103]
    node _T_46 = tail(_T_45, 1) @[intervox_receiver.scala 179:103]
    node _T_47 = gt(deltaCntr, _T_46) @[intervox_receiver.scala 179:93]
    node _T_48 = eq(zeroPeriode, UInt<1>("h1")) @[intervox_receiver.scala 179:125]
    node _T_49 = and(_T_47, _T_48) @[intervox_receiver.scala 179:110]
    node _T_50 = eq(changed, UInt<1>("h0")) @[intervox_receiver.scala 179:145]
    node _T_51 = and(_T_49, _T_50) @[intervox_receiver.scala 179:134]
    node _T_52 = or(_T_44, _T_51) @[intervox_receiver.scala 179:79]
    when _T_52 : @[intervox_receiver.scala 179:155]
      node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 180:20]
      clkRec <= _clkRec_T_3 @[intervox_receiver.scala 180:17]
      changed <= UInt<1>("h1") @[intervox_receiver.scala 181:17]

  extmodule clk_wiz_0_clk_wiz :
    output CLK_OUT : UInt<1>
    output locked : UInt<1>
    input CLK_IN : UInt<1>
    defname = clk_wiz_0_clk_wiz

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, CLK_DBUG : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LEDS : UInt<16>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 198:26]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 200:25]
    io.LEDS <= clockRec.io.LEDS @[intervox_receiver.scala 202:25]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 203:25]
    io.CLK_DBUG <= clockRec.io.CLK_OUT @[intervox_receiver.scala 204:25]
    io.DBUG1 <= clockRec.io.DBUG1 @[intervox_receiver.scala 205:25]
    io.DBUG <= clockRec.io.DBUG @[intervox_receiver.scala 206:25]
    io.CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 209:16]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 214:21]
    pll.CLK_IN is invalid
    pll.locked is invalid
    pll.CLK_OUT is invalid
    pll.CLK_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 217:19]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 220:24]
    when _T : @[intervox_receiver.scala 220:32]
      io.CLK_REC <= pll.CLK_OUT @[intervox_receiver.scala 221:20]
    else :
      io.CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 224:20]

