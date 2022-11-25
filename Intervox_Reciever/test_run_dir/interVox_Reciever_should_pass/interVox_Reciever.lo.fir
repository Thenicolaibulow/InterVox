circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : UInt<1>
    input io_DATA_IN : UInt<1>
    output io_CLK_OUT : UInt<1>
    output io_DATA_OUT : UInt<1>
    output io_DBUG : UInt<1>
    output io_DBUG1 : UInt<1>

    reg clkCntr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), clkCntr) @[intervox_receiver.scala 27:30]
    reg clkCntr1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), clkCntr1) @[intervox_receiver.scala 28:30]
    reg clkCntr2 : UInt<4>, clock with :
      reset => (UInt<1>("h0"), clkCntr2) @[intervox_receiver.scala 29:30]
    reg clkCntr3 : UInt<4>, clock with :
      reset => (UInt<1>("h0"), clkCntr3) @[intervox_receiver.scala 30:30]
    reg clkDelta : UInt<8>, clock with :
      reset => (UInt<1>("h0"), clkDelta) @[intervox_receiver.scala 31:30]
    reg lastOne : UInt<8>, clock with :
      reset => (UInt<1>("h0"), lastOne) @[intervox_receiver.scala 32:30]
    reg pllCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pllCntr) @[intervox_receiver.scala 33:30]
    reg inBufr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufr) @[intervox_receiver.scala 34:30]
    reg whatChange : UInt<2>, clock with :
      reset => (UInt<1>("h0"), whatChange) @[intervox_receiver.scala 35:30]
    reg outReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), outReg) @[intervox_receiver.scala 37:30]
    reg clkRec : UInt<1>, clock with :
      reset => (UInt<1>("h0"), clkRec) @[intervox_receiver.scala 38:30]
    reg change : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change) @[intervox_receiver.scala 39:30]
    reg dataOut : UInt<1>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[intervox_receiver.scala 40:30]
    reg nextFrame : UInt<1>, clock with :
      reset => (UInt<1>("h0"), nextFrame) @[intervox_receiver.scala 41:30]
    reg zeroPeriode : UInt<1>, clock with :
      reset => (UInt<1>("h0"), zeroPeriode) @[intervox_receiver.scala 42:30]
    reg syncWord : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncWord) @[intervox_receiver.scala 43:30]
    node _clkCntr_T = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 55:28]
    node _clkCntr_T_1 = tail(_clkCntr_T, 1) @[intervox_receiver.scala 55:28]
    node _clkCntr1_T = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 57:29]
    node _clkCntr1_T_1 = tail(_clkCntr1_T, 1) @[intervox_receiver.scala 57:29]
    node _T = eq(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 59:18]
    node _GEN_0 = mux(_T, UInt<1>("h0"), _clkCntr_T_1) @[intervox_receiver.scala 55:17 59:26 60:17]
    node _GEN_1 = mux(_T, UInt<1>("h0"), change) @[intervox_receiver.scala 59:26 61:16 39:30]
    node _T_1 = eq(io_DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 64:21]
    node _T_2 = lt(inBufr, UInt<2>("h3")) @[intervox_receiver.scala 65:21]
    node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 66:30]
    node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 66:30]
    node _GEN_2 = mux(_T_2, _inBufr_T_1, inBufr) @[intervox_receiver.scala 65:27 66:20 34:30]
    node _GEN_3 = mux(_T_1, _GEN_2, inBufr) @[intervox_receiver.scala 64:29 34:30]
    node _T_3 = eq(io_DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 69:21]
    node _T_4 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 70:21]
    node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 71:30]
    node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 71:30]
    node _GEN_4 = mux(_T_4, _inBufr_T_3, _GEN_3) @[intervox_receiver.scala 70:27 71:20]
    node _GEN_5 = mux(_T_3, _GEN_4, _GEN_3) @[intervox_receiver.scala 69:29]
    node _T_5 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 74:17]
    node _T_6 = bits(inBufr, 0, 0) @[intervox_receiver.scala 76:20]
    node _T_7 = bits(inBufr, 1, 1) @[intervox_receiver.scala 76:34]
    node _T_8 = neq(_T_6, _T_7) @[intervox_receiver.scala 76:24]
    node _GEN_6 = mux(_T_8, UInt<1>("h1"), _GEN_1) @[intervox_receiver.scala 76:38 77:20]
    node _GEN_7 = mux(_T_8, UInt<1>("h0"), _clkCntr1_T_1) @[intervox_receiver.scala 57:17 76:38 78:22]
    node _GEN_8 = mux(_T_8, clkCntr1, clkDelta) @[intervox_receiver.scala 76:38 79:22 31:30]
    node _GEN_9 = mux(_T_5, _GEN_6, _GEN_1) @[intervox_receiver.scala 74:25]
    node _GEN_10 = mux(_T_5, _GEN_7, _clkCntr1_T_1) @[intervox_receiver.scala 57:17 74:25]
    node _GEN_11 = mux(_T_5, _GEN_8, clkDelta) @[intervox_receiver.scala 74:25 31:30]
    node _T_9 = gt(clkCntr1, UInt<5>("h10")) @[intervox_receiver.scala 94:19]
    node _GEN_12 = mux(_T_9, UInt<1>("h1"), syncWord) @[intervox_receiver.scala 94:26 95:18 43:30]
    node _T_10 = gt(clkDelta, UInt<1>("h0")) @[intervox_receiver.scala 99:20]
    node _T_11 = lt(clkDelta, UInt<4>("ha")) @[intervox_receiver.scala 99:39]
    node _T_12 = and(_T_10, _T_11) @[intervox_receiver.scala 99:27]
    node _T_13 = eq(zeroPeriode, UInt<1>("h0")) @[intervox_receiver.scala 102:26]
    node _GEN_13 = mux(_T_13, UInt<1>("h0"), _GEN_12) @[intervox_receiver.scala 102:34 103:22]
    node _GEN_14 = mux(_T_12, UInt<1>("h0"), zeroPeriode) @[intervox_receiver.scala 100:21 42:30 99:47]
    node _GEN_15 = mux(_T_12, UInt<1>("h1"), dataOut) @[intervox_receiver.scala 101:17 40:30 99:47]
    node _GEN_16 = mux(_T_12, _GEN_13, _GEN_12) @[intervox_receiver.scala 99:47]
    node _GEN_17 = mux(_T_12, clkDelta, lastOne) @[intervox_receiver.scala 107:17 32:30 99:47]
    node _T_14 = gt(clkDelta, UInt<4>("ha")) @[intervox_receiver.scala 117:20]
    node _T_15 = lt(clkDelta, UInt<5>("h10")) @[intervox_receiver.scala 117:40]
    node _T_16 = and(_T_14, _T_15) @[intervox_receiver.scala 117:28]
    node _T_17 = eq(zeroPeriode, UInt<1>("h0")) @[intervox_receiver.scala 119:26]
    node _GEN_18 = mux(_T_17, UInt<1>("h0"), _GEN_16) @[intervox_receiver.scala 119:34 120:22]
    node _GEN_19 = mux(_T_16, UInt<1>("h0"), _GEN_15) @[intervox_receiver.scala 117:48 118:17]
    node _GEN_20 = mux(_T_16, _GEN_18, _GEN_16) @[intervox_receiver.scala 117:48]
    node _T_18 = eq(UInt<1>("h1"), change) @[intervox_receiver.scala 128:19]
    node _clkCntr2_T = add(clkCntr2, UInt<1>("h1")) @[intervox_receiver.scala 130:34]
    node _clkCntr2_T_1 = tail(_clkCntr2_T, 1) @[intervox_receiver.scala 130:34]
    node _T_19 = geq(whatChange, UInt<1>("h0")) @[intervox_receiver.scala 131:29]
    node _whatChange_T = sub(whatChange, UInt<1>("h1")) @[intervox_receiver.scala 132:42]
    node _whatChange_T_1 = tail(_whatChange_T, 1) @[intervox_receiver.scala 132:42]
    node _GEN_21 = mux(_T_19, _whatChange_T_1, whatChange) @[intervox_receiver.scala 131:36 132:28 35:30]
    node _T_20 = eq(UInt<1>("h0"), change) @[intervox_receiver.scala 128:19]
    node _whatChange_T_2 = add(whatChange, UInt<1>("h1")) @[intervox_receiver.scala 136:38]
    node _whatChange_T_3 = tail(_whatChange_T_2, 1) @[intervox_receiver.scala 136:38]
    node _clkCntr2_T_2 = add(clkCntr2, UInt<1>("h1")) @[intervox_receiver.scala 138:34]
    node _clkCntr2_T_3 = tail(_clkCntr2_T_2, 1) @[intervox_receiver.scala 138:34]
    node _T_21 = sub(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 139:39]
    node _T_22 = tail(_T_21, 1) @[intervox_receiver.scala 139:39]
    node _T_23 = eq(clkCntr2, _T_22) @[intervox_receiver.scala 139:27]
    node _GEN_22 = mux(_T_23, UInt<1>("h0"), _clkCntr2_T_3) @[intervox_receiver.scala 138:22 139:45 140:29]
    node _GEN_23 = mux(_T_20, _whatChange_T_3, whatChange) @[intervox_receiver.scala 128:19 136:24 35:30]
    node _GEN_24 = mux(_T_20, _GEN_22, clkCntr2) @[intervox_receiver.scala 128:19 29:30]
    node _GEN_25 = mux(_T_18, _clkCntr2_T_1, _GEN_24) @[intervox_receiver.scala 128:19 130:22]
    node _GEN_26 = mux(_T_18, _GEN_21, _GEN_23) @[intervox_receiver.scala 128:19]
    node _T_24 = bits(whatChange, 0, 0) @[intervox_receiver.scala 146:21]
    node _T_25 = eq(_T_24, UInt<1>("h1")) @[intervox_receiver.scala 146:25]
    node _T_26 = bits(whatChange, 1, 1) @[intervox_receiver.scala 146:47]
    node _T_27 = eq(_T_26, UInt<1>("h0")) @[intervox_receiver.scala 146:51]
    node _T_28 = and(_T_25, _T_27) @[intervox_receiver.scala 146:34]
    node _T_29 = lt(clkCntr1, lastOne) @[intervox_receiver.scala 148:23]
    node _GEN_27 = mux(_T_29, UInt<1>("h0"), _GEN_25) @[intervox_receiver.scala 148:33 149:25]
    node _GEN_28 = mux(_T_28, _GEN_27, _GEN_25) @[intervox_receiver.scala 146:60]
    node _T_30 = lt(clkCntr1, lastOne) @[intervox_receiver.scala 154:19]
    node _T_31 = bits(whatChange, 0, 0) @[intervox_receiver.scala 155:25]
    node _T_32 = eq(_T_31, UInt<1>("h0")) @[intervox_receiver.scala 155:29]
    node _T_33 = bits(whatChange, 1, 1) @[intervox_receiver.scala 155:51]
    node _T_34 = eq(_T_33, UInt<1>("h1")) @[intervox_receiver.scala 155:55]
    node _T_35 = and(_T_32, _T_34) @[intervox_receiver.scala 155:38]
    node _clkRec_T = not(clkRec) @[intervox_receiver.scala 157:23]
    node _GEN_29 = mux(_T_35, _clkRec_T, clkRec) @[intervox_receiver.scala 155:64 157:20 38:30]
    node _GEN_30 = mux(_T_35, UInt<1>("h0"), clkCntr3) @[intervox_receiver.scala 155:64 159:22 30:30]
    node _GEN_31 = mux(_T_35, UInt<1>("h0"), _GEN_20) @[intervox_receiver.scala 155:64 160:22]
    node _GEN_32 = mux(_T_30, _GEN_29, clkRec) @[intervox_receiver.scala 154:29 38:30]
    node _GEN_33 = mux(_T_30, _GEN_30, clkCntr3) @[intervox_receiver.scala 154:29 30:30]
    node _GEN_34 = mux(_T_30, _GEN_31, _GEN_20) @[intervox_receiver.scala 154:29]
    node _T_36 = gt(clkCntr1, lastOne) @[intervox_receiver.scala 166:20]
    node _T_37 = eq(zeroPeriode, UInt<1>("h0")) @[intervox_receiver.scala 170:27]
    node _T_38 = div(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 170:60]
    node _T_39 = add(_T_38, UInt<1>("h1")) @[intervox_receiver.scala 170:67]
    node _T_40 = tail(_T_39, 1) @[intervox_receiver.scala 170:67]
    node _T_41 = geq(clkCntr2, _T_40) @[intervox_receiver.scala 170:48]
    node _T_42 = and(_T_37, _T_41) @[intervox_receiver.scala 170:36]
    node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 171:23]
    node _GEN_35 = mux(_T_42, _clkRec_T_1, _GEN_32) @[intervox_receiver.scala 170:74 171:20]
    node _GEN_36 = mux(_T_42, UInt<1>("h0"), _GEN_33) @[intervox_receiver.scala 170:74 172:22]
    node _GEN_37 = mux(_T_36, _GEN_35, _GEN_32) @[intervox_receiver.scala 166:31]
    node _GEN_38 = mux(_T_36, _GEN_36, _GEN_33) @[intervox_receiver.scala 166:31]
    node _GEN_39 = mux(_T_36, UInt<1>("h1"), _GEN_14) @[intervox_receiver.scala 166:31 174:21]
    io_CLK_OUT <= clkRec @[intervox_receiver.scala 45:21]
    io_DATA_OUT <= dataOut @[intervox_receiver.scala 46:21]
    io_DBUG <= zeroPeriode @[intervox_receiver.scala 47:21]
    io_DBUG1 <= change @[intervox_receiver.scala 48:21]
    clkCntr <= mux(reset, UInt<2>("h0"), _GEN_0) @[intervox_receiver.scala 27:{30,30}]
    clkCntr1 <= mux(reset, UInt<8>("h0"), _GEN_10) @[intervox_receiver.scala 28:{30,30}]
    clkCntr2 <= mux(reset, UInt<4>("h0"), _GEN_28) @[intervox_receiver.scala 29:{30,30}]
    clkCntr3 <= mux(reset, UInt<4>("h0"), _GEN_38) @[intervox_receiver.scala 30:{30,30}]
    clkDelta <= mux(reset, UInt<8>("h0"), _GEN_11) @[intervox_receiver.scala 31:{30,30}]
    lastOne <= mux(reset, UInt<8>("h7"), _GEN_17) @[intervox_receiver.scala 32:{30,30}]
    pllCntr <= mux(reset, UInt<8>("h0"), pllCntr) @[intervox_receiver.scala 33:{30,30,30}]
    inBufr <= mux(reset, UInt<2>("h0"), _GEN_5) @[intervox_receiver.scala 34:{30,30}]
    whatChange <= mux(reset, UInt<2>("h0"), _GEN_26) @[intervox_receiver.scala 35:{30,30}]
    outReg <= mux(reset, UInt<1>("h0"), outReg) @[intervox_receiver.scala 37:{30,30,30}]
    clkRec <= mux(reset, UInt<1>("h0"), _GEN_37) @[intervox_receiver.scala 38:{30,30}]
    change <= mux(reset, UInt<1>("h0"), _GEN_9) @[intervox_receiver.scala 39:{30,30}]
    dataOut <= mux(reset, UInt<1>("h0"), _GEN_19) @[intervox_receiver.scala 40:{30,30}]
    nextFrame <= mux(reset, UInt<1>("h0"), nextFrame) @[intervox_receiver.scala 41:{30,30,30}]
    zeroPeriode <= mux(reset, UInt<1>("h0"), _GEN_39) @[intervox_receiver.scala 42:{30,30}]
    syncWord <= mux(reset, UInt<1>("h0"), _GEN_34) @[intervox_receiver.scala 43:{30,30}]

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

    inst clockRec of clock_Recovery @[intervox_receiver.scala 210:26]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 219:21]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 225:24]
    node _GEN_0 = mux(_T, pll.PLL_MCLK, UInt<1>("h0")) @[intervox_receiver.scala 225:32 226:20 229:20]
    io_CLK_REC <= _GEN_0
    io_DATA_OUT <= clockRec.io_DATA_OUT @[intervox_receiver.scala 213:25]
    io_NEXT_FRAME <= clockRec.io_DBUG @[intervox_receiver.scala 214:25]
    io_DBUG <= clockRec.io_CLK_OUT @[intervox_receiver.scala 216:25]
    io_DBUG1 <= clockRec.io_DBUG1 @[intervox_receiver.scala 215:25]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io_DATA_IN <= io_INTERVOX_IN @[intervox_receiver.scala 212:25]
    pll.PLL_IN <= clockRec.io_CLK_OUT @[intervox_receiver.scala 222:19]
