circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : UInt<1>
    input io_DATA_IN : UInt<1>
    output io_CLK_OUT : UInt<1>
    output io_DATA_OUT : UInt<1>
    output io_DBUG : UInt<1>
    output io_DBUG1 : UInt<1>
    output io_LEDS : UInt<16>

    reg deltaCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), deltaCntr) @[intervox_receiver.scala 25:30]
    reg lastOne : UInt<8>, clock with :
      reset => (UInt<1>("h0"), lastOne) @[intervox_receiver.scala 26:30]
    reg inBufr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufr) @[intervox_receiver.scala 27:30]
    reg inBufrPrev : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufrPrev) @[intervox_receiver.scala 28:30]
    reg whatChange : UInt<2>, clock with :
      reset => (UInt<1>("h0"), whatChange) @[intervox_receiver.scala 29:30]
    reg outReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), outReg) @[intervox_receiver.scala 31:30]
    reg clkRec : UInt<1>, clock with :
      reset => (UInt<1>("h0"), clkRec) @[intervox_receiver.scala 32:30]
    reg change : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change) @[intervox_receiver.scala 33:30]
    reg changed : UInt<1>, clock with :
      reset => (UInt<1>("h0"), changed) @[intervox_receiver.scala 34:30]
    reg changedOne : UInt<1>, clock with :
      reset => (UInt<1>("h0"), changedOne) @[intervox_receiver.scala 35:30]
    reg dataOut : UInt<1>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[intervox_receiver.scala 36:30]
    reg zeroPeriode : UInt<1>, clock with :
      reset => (UInt<1>("h0"), zeroPeriode) @[intervox_receiver.scala 37:30]
    reg syncWord : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncWord) @[intervox_receiver.scala 38:30]
    reg zeroClkFlp : UInt<1>, clock with :
      reset => (UInt<1>("h0"), zeroClkFlp) @[intervox_receiver.scala 39:30]
    node _deltaCntr_T = add(deltaCntr, UInt<1>("h1")) @[intervox_receiver.scala 48:31]
    node _deltaCntr_T_1 = tail(_deltaCntr_T, 1) @[intervox_receiver.scala 48:31]
    node _T = eq(io_DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 51:21]
    node _T_1 = eq(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 54:21]
    node _GEN_0 = mux(_T_1, UInt<1>("h1"), inBufr) @[intervox_receiver.scala 54:29 55:20 27:30]
    node _T_2 = lt(inBufr, UInt<2>("h2")) @[intervox_receiver.scala 58:22]
    node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 58:39]
    node _T_4 = and(_T_2, _T_3) @[intervox_receiver.scala 58:29]
    node _inBufr_T = dshl(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 61:30]
    node _GEN_1 = mux(_T_4, inBufr, inBufrPrev) @[intervox_receiver.scala 58:46 60:24 28:30]
    node _GEN_2 = mux(_T_4, _inBufr_T, _GEN_0) @[intervox_receiver.scala 58:46 61:20]
    node _T_5 = eq(inBufr, UInt<2>("h2")) @[intervox_receiver.scala 63:21]
    node _GEN_3 = mux(_T_5, inBufr, _GEN_1) @[intervox_receiver.scala 63:29 65:24]
    node _GEN_4 = mux(_T, _GEN_2, inBufr) @[intervox_receiver.scala 51:29 27:30]
    node _GEN_5 = mux(_T, _GEN_3, inBufrPrev) @[intervox_receiver.scala 51:29 28:30]
    node _T_6 = eq(io_DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 69:21]
    node _T_7 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 72:21]
    node _inBufr_T_1 = dshr(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 76:30]
    node _GEN_6 = mux(_T_7, inBufr, _GEN_5) @[intervox_receiver.scala 72:27 74:24]
    node _GEN_7 = mux(_T_7, _inBufr_T_1, _GEN_4) @[intervox_receiver.scala 72:27 76:20]
    node _T_8 = eq(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 78:21]
    node _GEN_8 = mux(_T_8, inBufr, _GEN_6) @[intervox_receiver.scala 78:29 80:24]
    node _GEN_9 = mux(_T_6, _GEN_8, _GEN_5) @[intervox_receiver.scala 69:29]
    node _GEN_10 = mux(_T_6, _GEN_7, _GEN_4) @[intervox_receiver.scala 69:29]
    node _T_9 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_receiver.scala 92:22]
    node _T_10 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 92:41]
    node _T_11 = and(_T_9, _T_10) @[intervox_receiver.scala 92:31]
    node _GEN_11 = mux(_T_11, UInt<1>("h1"), change) @[intervox_receiver.scala 92:50 94:21 33:30]
    node _T_12 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_receiver.scala 102:22]
    node _T_13 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 102:41]
    node _T_14 = and(_T_12, _T_13) @[intervox_receiver.scala 102:31]
    node _GEN_12 = mux(_T_14, UInt<1>("h1"), _GEN_11) @[intervox_receiver.scala 102:50 104:21]
    node _T_15 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 109:17]
    node _GEN_13 = mux(_T_15, UInt<1>("h0"), _GEN_12) @[intervox_receiver.scala 109:25 110:21]
    node _GEN_14 = mux(_T_15, UInt<1>("h0"), changed) @[intervox_receiver.scala 109:25 111:21 34:30]
    node _T_16 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 114:17]
    node _T_17 = eq(changedOne, UInt<1>("h0")) @[intervox_receiver.scala 117:25]
    node _GEN_15 = mux(_T_17, UInt<1>("h1"), changedOne) @[intervox_receiver.scala 117:33 119:25 35:30]
    node _GEN_16 = mux(_T_17, UInt<1>("h0"), _deltaCntr_T_1) @[intervox_receiver.scala 117:33 121:25 48:18]
    node _GEN_17 = mux(_T_17, UInt<1>("h0"), syncWord) @[intervox_receiver.scala 117:33 123:25 38:30]
    node _T_18 = leq(deltaCntr, lastOne) @[intervox_receiver.scala 127:25]
    node _T_19 = eq(changedOne, UInt<1>("h1")) @[intervox_receiver.scala 127:51]
    node _T_20 = and(_T_18, _T_19) @[intervox_receiver.scala 127:37]
    node _GEN_18 = mux(_T_20, UInt<1>("h1"), dataOut) @[intervox_receiver.scala 127:60 132:25 36:30]
    node _GEN_19 = mux(_T_20, UInt<1>("h0"), zeroPeriode) @[intervox_receiver.scala 127:60 134:25 37:30]
    node _GEN_20 = mux(_T_20, UInt<1>("h0"), _GEN_15) @[intervox_receiver.scala 127:60 138:25]
    node _GEN_21 = mux(_T_20, UInt<1>("h0"), _GEN_16) @[intervox_receiver.scala 127:60 140:25]
    node _GEN_22 = mux(_T_16, _GEN_20, changedOne) @[intervox_receiver.scala 114:25 35:30]
    node _GEN_23 = mux(_T_16, _GEN_21, _deltaCntr_T_1) @[intervox_receiver.scala 114:25 48:18]
    node _GEN_24 = mux(_T_16, _GEN_17, syncWord) @[intervox_receiver.scala 114:25 38:30]
    node _GEN_25 = mux(_T_16, _GEN_18, dataOut) @[intervox_receiver.scala 114:25 36:30]
    node _GEN_26 = mux(_T_16, _GEN_19, zeroPeriode) @[intervox_receiver.scala 114:25 37:30]
    node _T_21 = gt(deltaCntr, lastOne) @[intervox_receiver.scala 145:21]
    node _GEN_27 = mux(_T_21, UInt<1>("h0"), _GEN_25) @[intervox_receiver.scala 145:34 150:25]
    node _GEN_28 = mux(_T_21, UInt<1>("h1"), _GEN_26) @[intervox_receiver.scala 145:34 152:25]
    node _GEN_29 = mux(_T_21, UInt<1>("h0"), _GEN_24) @[intervox_receiver.scala 145:34 154:25]
    node _GEN_30 = mux(_T_21, UInt<1>("h0"), _GEN_22) @[intervox_receiver.scala 145:34 156:25]
    node _T_22 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 159:32]
    node _T_23 = gt(deltaCntr, _T_22) @[intervox_receiver.scala 159:21]
    node _GEN_31 = mux(_T_23, UInt<1>("h1"), _GEN_29) @[intervox_receiver.scala 159:40 161:18]
    node _T_24 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 172:18]
    node _clkRec_T = not(clkRec) @[intervox_receiver.scala 173:20]
    node _GEN_32 = mux(_T_24, _clkRec_T, clkRec) @[intervox_receiver.scala 172:27 173:17 32:30]
    node _T_25 = geq(deltaCntr, lastOne) @[intervox_receiver.scala 179:21]
    node _T_26 = eq(changed, UInt<1>("h0")) @[intervox_receiver.scala 179:44]
    node _T_27 = and(_T_25, _T_26) @[intervox_receiver.scala 179:33]
    node _T_28 = neq(change, UInt<1>("h1")) @[intervox_receiver.scala 179:63]
    node _T_29 = and(_T_27, _T_28) @[intervox_receiver.scala 179:53]
    node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 180:20]
    node _GEN_33 = mux(_T_29, _clkRec_T_1, _GEN_32) @[intervox_receiver.scala 179:72 180:17]
    node _GEN_34 = mux(_T_29, UInt<1>("h1"), _GEN_14) @[intervox_receiver.scala 179:72 181:17]
    io_CLK_OUT <= clkRec @[intervox_receiver.scala 41:21]
    io_DATA_OUT <= dataOut @[intervox_receiver.scala 42:21]
    io_DBUG <= zeroPeriode @[intervox_receiver.scala 43:21]
    io_DBUG1 <= syncWord @[intervox_receiver.scala 44:21]
    io_LEDS <= pad(lastOne, 16) @[intervox_receiver.scala 45:21]
    deltaCntr <= mux(reset, UInt<8>("h0"), _GEN_23) @[intervox_receiver.scala 25:{30,30}]
    lastOne <= mux(reset, UInt<8>("h10"), lastOne) @[intervox_receiver.scala 26:{30,30,30}]
    inBufr <= bits(mux(reset, UInt<2>("h0"), _GEN_10), 1, 0) @[intervox_receiver.scala 27:{30,30}]
    inBufrPrev <= mux(reset, UInt<2>("h0"), _GEN_9) @[intervox_receiver.scala 28:{30,30}]
    whatChange <= mux(reset, UInt<2>("h0"), whatChange) @[intervox_receiver.scala 29:{30,30,30}]
    outReg <= mux(reset, UInt<1>("h0"), outReg) @[intervox_receiver.scala 31:{30,30,30}]
    clkRec <= mux(reset, UInt<1>("h0"), _GEN_33) @[intervox_receiver.scala 32:{30,30}]
    change <= mux(reset, UInt<1>("h0"), _GEN_13) @[intervox_receiver.scala 33:{30,30}]
    changed <= mux(reset, UInt<1>("h0"), _GEN_34) @[intervox_receiver.scala 34:{30,30}]
    changedOne <= mux(reset, UInt<1>("h0"), _GEN_30) @[intervox_receiver.scala 35:{30,30}]
    dataOut <= mux(reset, UInt<1>("h0"), _GEN_27) @[intervox_receiver.scala 36:{30,30}]
    zeroPeriode <= mux(reset, UInt<1>("h0"), _GEN_28) @[intervox_receiver.scala 37:{30,30}]
    syncWord <= mux(reset, UInt<1>("h0"), _GEN_31) @[intervox_receiver.scala 38:{30,30}]
    zeroClkFlp <= mux(reset, UInt<1>("h0"), zeroClkFlp) @[intervox_receiver.scala 39:{30,30,30}]

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
    output io_CLK_DBUG : UInt<1>
    output io_DBUG : UInt<1>
    output io_DBUG1 : UInt<1>
    output io_LEDS : UInt<16>

    inst clockRec of clock_Recovery @[intervox_receiver.scala 197:26]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 208:21]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 214:24]
    node _GEN_0 = mux(_T, pll.PLL_MCLK, UInt<1>("h0")) @[intervox_receiver.scala 214:32 215:20 218:20]
    io_CLK_REC <= _GEN_0
    io_DATA_OUT <= clockRec.io_DATA_OUT @[intervox_receiver.scala 202:25]
    io_CLK_DBUG <= clockRec.io_CLK_OUT @[intervox_receiver.scala 203:25]
    io_DBUG <= clockRec.io_DBUG @[intervox_receiver.scala 205:25]
    io_DBUG1 <= clockRec.io_DBUG1 @[intervox_receiver.scala 204:25]
    io_LEDS <= clockRec.io_LEDS @[intervox_receiver.scala 201:25]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io_DATA_IN <= io_INTERVOX_IN @[intervox_receiver.scala 199:25]
    pll.PLL_IN <= clockRec.io_CLK_OUT @[intervox_receiver.scala 211:19]
