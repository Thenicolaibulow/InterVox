circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : Reset
    output io : { flip DATA_IN : UInt<1>, CLK_OUT : UInt<1>, DATA_OUT : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>}

    reg clkCntr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 27:30]
    reg clkCntr1 : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 28:30]
    reg clkCntr2 : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[intervox_receiver.scala 29:30]
    reg clkCntr3 : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[intervox_receiver.scala 30:30]
    reg clkDelta : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 31:30]
    reg lastOne : UInt<8>, clock with :
      reset => (reset, UInt<8>("h7")) @[intervox_receiver.scala 32:30]
    reg pllCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 33:30]
    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 34:30]
    reg whatChange : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 35:30]
    reg outReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 37:30]
    reg clkRec : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 38:30]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 39:30]
    reg dataOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 40:30]
    reg nextFrame : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 41:30]
    reg zeroPeriode : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 42:30]
    reg syncWord : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 43:30]
    io.CLK_OUT <= clkRec @[intervox_receiver.scala 45:21]
    io.DATA_OUT <= dataOut @[intervox_receiver.scala 46:21]
    io.DBUG <= zeroPeriode @[intervox_receiver.scala 47:21]
    io.DBUG1 <= change @[intervox_receiver.scala 48:21]
    node _clkCntr_T = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 55:28]
    node _clkCntr_T_1 = tail(_clkCntr_T, 1) @[intervox_receiver.scala 55:28]
    clkCntr <= _clkCntr_T_1 @[intervox_receiver.scala 55:17]
    node _clkCntr1_T = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 57:29]
    node _clkCntr1_T_1 = tail(_clkCntr1_T, 1) @[intervox_receiver.scala 57:29]
    clkCntr1 <= _clkCntr1_T_1 @[intervox_receiver.scala 57:17]
    node _T = eq(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 59:18]
    when _T : @[intervox_receiver.scala 59:26]
      clkCntr <= UInt<1>("h0") @[intervox_receiver.scala 60:17]
      change <= UInt<1>("h0") @[intervox_receiver.scala 61:16]
    node _T_1 = eq(io.DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 64:21]
    when _T_1 : @[intervox_receiver.scala 64:29]
      node _T_2 = lt(inBufr, UInt<2>("h3")) @[intervox_receiver.scala 65:21]
      when _T_2 : @[intervox_receiver.scala 65:27]
        node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 66:30]
        node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 66:30]
        inBufr <= _inBufr_T_1 @[intervox_receiver.scala 66:20]
    node _T_3 = eq(io.DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 69:21]
    when _T_3 : @[intervox_receiver.scala 69:29]
      node _T_4 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 70:21]
      when _T_4 : @[intervox_receiver.scala 70:27]
        node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 71:30]
        node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 71:30]
        inBufr <= _inBufr_T_3 @[intervox_receiver.scala 71:20]
    node _T_5 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 74:17]
    when _T_5 : @[intervox_receiver.scala 74:25]
      node _T_6 = bits(inBufr, 0, 0) @[intervox_receiver.scala 76:20]
      node _T_7 = bits(inBufr, 1, 1) @[intervox_receiver.scala 76:34]
      node _T_8 = neq(_T_6, _T_7) @[intervox_receiver.scala 76:24]
      when _T_8 : @[intervox_receiver.scala 76:38]
        change <= UInt<1>("h1") @[intervox_receiver.scala 77:20]
        clkCntr1 <= UInt<1>("h0") @[intervox_receiver.scala 78:22]
        clkDelta <= clkCntr1 @[intervox_receiver.scala 79:22]
    node _T_9 = gt(clkCntr1, UInt<5>("h10")) @[intervox_receiver.scala 94:19]
    when _T_9 : @[intervox_receiver.scala 94:26]
      syncWord <= UInt<1>("h1") @[intervox_receiver.scala 95:18]
    node _T_10 = gt(clkDelta, UInt<1>("h0")) @[intervox_receiver.scala 99:20]
    node _T_11 = lt(clkDelta, UInt<4>("ha")) @[intervox_receiver.scala 99:39]
    node _T_12 = and(_T_10, _T_11) @[intervox_receiver.scala 99:27]
    when _T_12 : @[intervox_receiver.scala 99:47]
      dataOut <= UInt<1>("h1") @[intervox_receiver.scala 100:17]
      node _T_13 = eq(zeroPeriode, UInt<1>("h0")) @[intervox_receiver.scala 101:26]
      when _T_13 : @[intervox_receiver.scala 101:34]
        syncWord <= UInt<1>("h0") @[intervox_receiver.scala 102:22]
      lastOne <= clkDelta @[intervox_receiver.scala 106:17]
    node _T_14 = gt(clkDelta, UInt<4>("ha")) @[intervox_receiver.scala 116:20]
    node _T_15 = lt(clkDelta, UInt<5>("h10")) @[intervox_receiver.scala 116:40]
    node _T_16 = and(_T_14, _T_15) @[intervox_receiver.scala 116:28]
    when _T_16 : @[intervox_receiver.scala 116:48]
      dataOut <= UInt<1>("h0") @[intervox_receiver.scala 117:17]
      node _T_17 = eq(zeroPeriode, UInt<1>("h0")) @[intervox_receiver.scala 118:26]
      when _T_17 : @[intervox_receiver.scala 118:34]
        syncWord <= UInt<1>("h0") @[intervox_receiver.scala 119:22]
    node _T_18 = eq(UInt<1>("h1"), change) @[intervox_receiver.scala 127:19]
    when _T_18 : @[intervox_receiver.scala 127:19]
      node _clkCntr2_T = add(clkCntr2, UInt<1>("h1")) @[intervox_receiver.scala 129:34]
      node _clkCntr2_T_1 = tail(_clkCntr2_T, 1) @[intervox_receiver.scala 129:34]
      clkCntr2 <= _clkCntr2_T_1 @[intervox_receiver.scala 129:22]
      node _T_19 = geq(whatChange, UInt<1>("h0")) @[intervox_receiver.scala 130:29]
      when _T_19 : @[intervox_receiver.scala 130:36]
        node _whatChange_T = sub(whatChange, UInt<1>("h1")) @[intervox_receiver.scala 131:42]
        node _whatChange_T_1 = tail(_whatChange_T, 1) @[intervox_receiver.scala 131:42]
        whatChange <= _whatChange_T_1 @[intervox_receiver.scala 131:28]
    else :
      node _T_20 = eq(UInt<1>("h0"), change) @[intervox_receiver.scala 127:19]
      when _T_20 : @[intervox_receiver.scala 127:19]
        node _whatChange_T_2 = add(whatChange, UInt<1>("h1")) @[intervox_receiver.scala 135:38]
        node _whatChange_T_3 = tail(_whatChange_T_2, 1) @[intervox_receiver.scala 135:38]
        whatChange <= _whatChange_T_3 @[intervox_receiver.scala 135:24]
        node _clkCntr2_T_2 = add(clkCntr2, UInt<1>("h1")) @[intervox_receiver.scala 137:34]
        node _clkCntr2_T_3 = tail(_clkCntr2_T_2, 1) @[intervox_receiver.scala 137:34]
        clkCntr2 <= _clkCntr2_T_3 @[intervox_receiver.scala 137:22]
        node _T_21 = sub(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 138:39]
        node _T_22 = tail(_T_21, 1) @[intervox_receiver.scala 138:39]
        node _T_23 = eq(clkCntr2, _T_22) @[intervox_receiver.scala 138:27]
        when _T_23 : @[intervox_receiver.scala 138:45]
          clkCntr2 <= UInt<1>("h0") @[intervox_receiver.scala 139:29]
    node _T_24 = bits(whatChange, 0, 0) @[intervox_receiver.scala 145:21]
    node _T_25 = eq(_T_24, UInt<1>("h1")) @[intervox_receiver.scala 145:25]
    node _T_26 = bits(whatChange, 1, 1) @[intervox_receiver.scala 145:47]
    node _T_27 = eq(_T_26, UInt<1>("h0")) @[intervox_receiver.scala 145:51]
    node _T_28 = and(_T_25, _T_27) @[intervox_receiver.scala 145:34]
    when _T_28 : @[intervox_receiver.scala 145:60]
      node _T_29 = lt(clkCntr1, lastOne) @[intervox_receiver.scala 147:23]
      when _T_29 : @[intervox_receiver.scala 147:33]
        clkCntr2 <= UInt<1>("h0") @[intervox_receiver.scala 148:25]
        zeroPeriode <= UInt<1>("h0") @[intervox_receiver.scala 149:25]
    node _T_30 = lt(clkCntr1, lastOne) @[intervox_receiver.scala 154:19]
    when _T_30 : @[intervox_receiver.scala 154:29]
      node _T_31 = bits(whatChange, 0, 0) @[intervox_receiver.scala 155:25]
      node _T_32 = eq(_T_31, UInt<1>("h0")) @[intervox_receiver.scala 155:29]
      node _T_33 = bits(whatChange, 1, 1) @[intervox_receiver.scala 155:51]
      node _T_34 = eq(_T_33, UInt<1>("h1")) @[intervox_receiver.scala 155:55]
      node _T_35 = and(_T_32, _T_34) @[intervox_receiver.scala 155:38]
      when _T_35 : @[intervox_receiver.scala 155:64]
        node _clkRec_T = not(clkRec) @[intervox_receiver.scala 157:23]
        clkRec <= _clkRec_T @[intervox_receiver.scala 157:20]
        clkCntr3 <= UInt<1>("h0") @[intervox_receiver.scala 159:22]
        syncWord <= UInt<1>("h0") @[intervox_receiver.scala 160:22]
    node _T_36 = gt(clkCntr1, lastOne) @[intervox_receiver.scala 166:20]
    when _T_36 : @[intervox_receiver.scala 166:31]
      node _T_37 = eq(zeroPeriode, UInt<1>("h0")) @[intervox_receiver.scala 170:27]
      node _T_38 = div(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 170:60]
      node _T_39 = add(_T_38, UInt<1>("h1")) @[intervox_receiver.scala 170:67]
      node _T_40 = tail(_T_39, 1) @[intervox_receiver.scala 170:67]
      node _T_41 = geq(clkCntr2, _T_40) @[intervox_receiver.scala 170:48]
      node _T_42 = and(_T_37, _T_41) @[intervox_receiver.scala 170:36]
      when _T_42 : @[intervox_receiver.scala 170:74]
        node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 171:23]
        clkRec <= _clkRec_T_1 @[intervox_receiver.scala 171:20]
        clkCntr3 <= UInt<1>("h0") @[intervox_receiver.scala 172:22]
      zeroPeriode <= UInt<1>("h1") @[intervox_receiver.scala 174:21]

  extmodule clk_wiz_0_clk_wiz :
    output PLL_MCLK : UInt<1>
    output locked : UInt<1>
    input PLL_IN : UInt<1>
    defname = clk_wiz_0_clk_wiz

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, NEXT_FRAME : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 210:26]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 212:25]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 213:25]
    io.NEXT_FRAME <= clockRec.io.DBUG @[intervox_receiver.scala 214:25]
    io.DBUG1 <= clockRec.io.DBUG1 @[intervox_receiver.scala 215:25]
    io.DBUG <= clockRec.io.CLK_OUT @[intervox_receiver.scala 216:25]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 219:21]
    pll.PLL_IN is invalid
    pll.locked is invalid
    pll.PLL_MCLK is invalid
    pll.PLL_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 222:19]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 225:24]
    when _T : @[intervox_receiver.scala 225:32]
      io.CLK_REC <= pll.PLL_MCLK @[intervox_receiver.scala 226:20]
    else :
      io.CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 229:20]

