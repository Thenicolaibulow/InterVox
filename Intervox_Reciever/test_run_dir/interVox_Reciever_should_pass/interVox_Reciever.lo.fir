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
    reg zeroClkFlp : UInt<1>, clock with :
      reset => (UInt<1>("h0"), zeroClkFlp) @[intervox_receiver.scala 44:30]
    node _clkCntr_T = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 56:28]
    node _clkCntr_T_1 = tail(_clkCntr_T, 1) @[intervox_receiver.scala 56:28]
    node _clkCntr1_T = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 58:29]
    node _clkCntr1_T_1 = tail(_clkCntr1_T, 1) @[intervox_receiver.scala 58:29]
    node _T = eq(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 60:18]
    node _GEN_0 = mux(_T, UInt<1>("h0"), _clkCntr_T_1) @[intervox_receiver.scala 56:17 60:26 61:17]
    node _GEN_1 = mux(_T, UInt<1>("h0"), change) @[intervox_receiver.scala 60:26 62:16 39:30]
    node _T_1 = eq(io_DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 65:21]
    node _T_2 = lt(inBufr, UInt<2>("h3")) @[intervox_receiver.scala 66:21]
    node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 67:30]
    node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 67:30]
    node _GEN_2 = mux(_T_2, _inBufr_T_1, inBufr) @[intervox_receiver.scala 66:27 67:20 34:30]
    node _GEN_3 = mux(_T_1, _GEN_2, inBufr) @[intervox_receiver.scala 65:29 34:30]
    node _T_3 = eq(io_DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 70:21]
    node _T_4 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 71:21]
    node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 72:30]
    node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 72:30]
    node _GEN_4 = mux(_T_4, _inBufr_T_3, _GEN_3) @[intervox_receiver.scala 71:27 72:20]
    node _GEN_5 = mux(_T_3, _GEN_4, _GEN_3) @[intervox_receiver.scala 70:29]
    node _T_5 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 80:17]
    node _T_6 = bits(inBufr, 0, 0) @[intervox_receiver.scala 82:20]
    node _T_7 = bits(inBufr, 1, 1) @[intervox_receiver.scala 82:34]
    node _T_8 = neq(_T_6, _T_7) @[intervox_receiver.scala 82:24]
    node _T_9 = lt(clkCntr1, UInt<4>("h9")) @[intervox_receiver.scala 85:27]
    node _GEN_6 = mux(_T_9, clkCntr1, lastOne) @[intervox_receiver.scala 85:33 87:25 32:30]
    node _GEN_7 = mux(_T_9, UInt<1>("h1"), dataOut) @[intervox_receiver.scala 85:33 88:25 40:30]
    node _GEN_8 = mux(_T_9, UInt<1>("h0"), zeroPeriode) @[intervox_receiver.scala 85:33 89:29 42:30]
    node _GEN_9 = mux(_T_9, UInt<1>("h0"), syncWord) @[intervox_receiver.scala 85:33 90:26 43:30]
    node _GEN_10 = mux(_T_9, UInt<1>("h0"), zeroClkFlp) @[intervox_receiver.scala 85:33 91:28 44:30]
    node _GEN_11 = mux(_T_8, UInt<1>("h1"), _GEN_1) @[intervox_receiver.scala 82:38 84:20]
    node _GEN_12 = mux(_T_8, _GEN_6, lastOne) @[intervox_receiver.scala 32:30 82:38]
    node _GEN_13 = mux(_T_8, _GEN_7, dataOut) @[intervox_receiver.scala 40:30 82:38]
    node _GEN_14 = mux(_T_8, _GEN_8, zeroPeriode) @[intervox_receiver.scala 42:30 82:38]
    node _GEN_15 = mux(_T_8, _GEN_9, syncWord) @[intervox_receiver.scala 43:30 82:38]
    node _GEN_16 = mux(_T_8, _GEN_10, zeroClkFlp) @[intervox_receiver.scala 44:30 82:38]
    node _GEN_17 = mux(_T_8, UInt<1>("h0"), _clkCntr1_T_1) @[intervox_receiver.scala 58:17 82:38 93:22]
    node _GEN_18 = mux(_T_8, clkCntr1, clkDelta) @[intervox_receiver.scala 82:38 94:22 31:30]
    node _GEN_19 = mux(_T_5, _GEN_11, _GEN_1) @[intervox_receiver.scala 80:25]
    node _GEN_20 = mux(_T_5, _GEN_12, lastOne) @[intervox_receiver.scala 80:25 32:30]
    node _GEN_21 = mux(_T_5, _GEN_13, dataOut) @[intervox_receiver.scala 80:25 40:30]
    node _GEN_22 = mux(_T_5, _GEN_14, zeroPeriode) @[intervox_receiver.scala 80:25 42:30]
    node _GEN_23 = mux(_T_5, _GEN_15, syncWord) @[intervox_receiver.scala 80:25 43:30]
    node _GEN_24 = mux(_T_5, _GEN_16, zeroClkFlp) @[intervox_receiver.scala 80:25 44:30]
    node _GEN_25 = mux(_T_5, _GEN_17, _clkCntr1_T_1) @[intervox_receiver.scala 58:17 80:25]
    node _GEN_26 = mux(_T_5, _GEN_18, clkDelta) @[intervox_receiver.scala 80:25 31:30]
    node _T_10 = geq(clkCntr1, UInt<4>("h9")) @[intervox_receiver.scala 97:20]
    node _T_11 = lt(clkCntr1, UInt<5>("h10")) @[intervox_receiver.scala 97:40]
    node _T_12 = and(_T_10, _T_11) @[intervox_receiver.scala 97:28]
    node _T_13 = eq(zeroClkFlp, UInt<1>("h0")) @[intervox_receiver.scala 102:25]
    node _clkRec_T = not(clkRec) @[intervox_receiver.scala 103:23]
    node _GEN_27 = mux(_T_13, _clkRec_T, clkRec) @[intervox_receiver.scala 102:33 103:20 38:30]
    node _GEN_28 = mux(_T_13, UInt<1>("h1"), _GEN_24) @[intervox_receiver.scala 102:33 104:24]
    node _GEN_29 = mux(_T_12, UInt<1>("h0"), _GEN_21) @[intervox_receiver.scala 97:48 99:17]
    node _GEN_30 = mux(_T_12, UInt<1>("h1"), _GEN_22) @[intervox_receiver.scala 100:21 97:48]
    node _GEN_31 = mux(_T_12, UInt<1>("h0"), _GEN_23) @[intervox_receiver.scala 101:18 97:48]
    node _GEN_32 = mux(_T_12, _GEN_27, clkRec) @[intervox_receiver.scala 38:30 97:48]
    node _GEN_33 = mux(_T_12, _GEN_28, _GEN_24) @[intervox_receiver.scala 97:48]
    node _T_14 = gt(clkCntr1, UInt<5>("h10")) @[intervox_receiver.scala 107:19]
    node _GEN_34 = mux(_T_14, UInt<1>("h1"), _GEN_31) @[intervox_receiver.scala 107:26 109:18]
    node _T_15 = eq(zeroPeriode, UInt<1>("h1")) @[intervox_receiver.scala 113:23]
    node _T_16 = add(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 113:56]
    node _T_17 = tail(_T_16, 1) @[intervox_receiver.scala 113:56]
    node _T_18 = eq(clkCntr1, _T_17) @[intervox_receiver.scala 113:44]
    node _T_19 = and(_T_15, _T_18) @[intervox_receiver.scala 113:32]
    node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 115:19]
    node _GEN_35 = mux(_T_19, _clkRec_T_1, _GEN_32) @[intervox_receiver.scala 113:63 115:16]
    node _T_20 = eq(UInt<1>("h1"), change) @[intervox_receiver.scala 122:19]
    node _T_21 = geq(whatChange, UInt<1>("h0")) @[intervox_receiver.scala 124:29]
    node _whatChange_T = sub(whatChange, UInt<1>("h1")) @[intervox_receiver.scala 125:42]
    node _whatChange_T_1 = tail(_whatChange_T, 1) @[intervox_receiver.scala 125:42]
    node _GEN_36 = mux(_T_21, _whatChange_T_1, whatChange) @[intervox_receiver.scala 124:36 125:28 35:30]
    node _T_22 = eq(UInt<1>("h0"), change) @[intervox_receiver.scala 122:19]
    node _T_23 = lt(whatChange, UInt<2>("h3")) @[intervox_receiver.scala 129:29]
    node _whatChange_T_2 = add(whatChange, UInt<1>("h1")) @[intervox_receiver.scala 130:42]
    node _whatChange_T_3 = tail(_whatChange_T_2, 1) @[intervox_receiver.scala 130:42]
    node _GEN_37 = mux(_T_23, _whatChange_T_3, whatChange) @[intervox_receiver.scala 129:35 130:28 35:30]
    node _GEN_38 = mux(_T_22, _GEN_37, whatChange) @[intervox_receiver.scala 122:19 35:30]
    node _GEN_39 = mux(_T_20, _GEN_36, _GEN_38) @[intervox_receiver.scala 122:19]
    node _T_24 = eq(whatChange, UInt<1>("h1")) @[intervox_receiver.scala 134:21]
    node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 135:19]
    node _GEN_40 = mux(_T_24, _clkRec_T_2, _GEN_35) @[intervox_receiver.scala 134:29 135:16]
    node _T_25 = eq(whatChange, UInt<2>("h2")) @[intervox_receiver.scala 137:21]
    io_CLK_OUT <= clkRec @[intervox_receiver.scala 46:21]
    io_DATA_OUT <= dataOut @[intervox_receiver.scala 47:21]
    io_DBUG <= zeroPeriode @[intervox_receiver.scala 48:21]
    io_DBUG1 <= change @[intervox_receiver.scala 49:21]
    clkCntr <= mux(reset, UInt<2>("h0"), _GEN_0) @[intervox_receiver.scala 27:{30,30}]
    clkCntr1 <= mux(reset, UInt<8>("h0"), _GEN_25) @[intervox_receiver.scala 28:{30,30}]
    clkCntr2 <= mux(reset, UInt<4>("h0"), clkCntr2) @[intervox_receiver.scala 29:{30,30,30}]
    clkCntr3 <= mux(reset, UInt<4>("h0"), clkCntr3) @[intervox_receiver.scala 30:{30,30,30}]
    clkDelta <= mux(reset, UInt<8>("h0"), _GEN_26) @[intervox_receiver.scala 31:{30,30}]
    lastOne <= mux(reset, UInt<8>("h7"), _GEN_20) @[intervox_receiver.scala 32:{30,30}]
    pllCntr <= mux(reset, UInt<8>("h0"), pllCntr) @[intervox_receiver.scala 33:{30,30,30}]
    inBufr <= mux(reset, UInt<2>("h0"), _GEN_5) @[intervox_receiver.scala 34:{30,30}]
    whatChange <= mux(reset, UInt<2>("h0"), _GEN_39) @[intervox_receiver.scala 35:{30,30}]
    outReg <= mux(reset, UInt<1>("h0"), outReg) @[intervox_receiver.scala 37:{30,30,30}]
    clkRec <= mux(reset, UInt<1>("h0"), _GEN_40) @[intervox_receiver.scala 38:{30,30}]
    change <= mux(reset, UInt<1>("h0"), _GEN_19) @[intervox_receiver.scala 39:{30,30}]
    dataOut <= mux(reset, UInt<1>("h0"), _GEN_29) @[intervox_receiver.scala 40:{30,30}]
    nextFrame <= mux(reset, UInt<1>("h0"), nextFrame) @[intervox_receiver.scala 41:{30,30,30}]
    zeroPeriode <= mux(reset, UInt<1>("h0"), _GEN_30) @[intervox_receiver.scala 42:{30,30}]
    syncWord <= mux(reset, UInt<1>("h0"), _GEN_34) @[intervox_receiver.scala 43:{30,30}]
    zeroClkFlp <= mux(reset, UInt<1>("h0"), _GEN_33) @[intervox_receiver.scala 44:{30,30}]

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

    inst clockRec of clock_Recovery @[intervox_receiver.scala 153:26]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 162:21]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 168:24]
    node _GEN_0 = mux(_T, pll.PLL_MCLK, UInt<1>("h0")) @[intervox_receiver.scala 168:32 169:20 172:20]
    io_CLK_REC <= _GEN_0
    io_DATA_OUT <= clockRec.io_DATA_OUT @[intervox_receiver.scala 156:25]
    io_NEXT_FRAME <= clockRec.io_DBUG @[intervox_receiver.scala 157:25]
    io_DBUG <= clockRec.io_CLK_OUT @[intervox_receiver.scala 159:25]
    io_DBUG1 <= clockRec.io_DBUG1 @[intervox_receiver.scala 158:25]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io_DATA_IN <= io_INTERVOX_IN @[intervox_receiver.scala 155:25]
    pll.PLL_IN <= clockRec.io_CLK_OUT @[intervox_receiver.scala 165:19]
