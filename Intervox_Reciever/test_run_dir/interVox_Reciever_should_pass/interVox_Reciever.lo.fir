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

    reg rising : UInt<2>, clock with :
      reset => (UInt<1>("h0"), rising) @[intervox_receiver.scala 27:30]
    reg trailing : UInt<2>, clock with :
      reset => (UInt<1>("h0"), trailing) @[intervox_receiver.scala 28:30]
    reg lastOne : UInt<8>, clock with :
      reset => (UInt<1>("h0"), lastOne) @[intervox_receiver.scala 29:30]
    reg overSampleCntr : UInt<4>, clock with :
      reset => (UInt<1>("h0"), overSampleCntr) @[intervox_receiver.scala 30:32]
    reg inBufr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufr) @[intervox_receiver.scala 31:30]
    reg deltaCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), deltaCntr) @[intervox_receiver.scala 32:30]
    reg clkRec : UInt<1>, clock with :
      reset => (UInt<1>("h0"), clkRec) @[intervox_receiver.scala 33:30]
    reg change : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change) @[intervox_receiver.scala 34:30]
    reg dataOut : UInt<1>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[intervox_receiver.scala 35:30]
    reg syncWord : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncWord) @[intervox_receiver.scala 36:30]
    reg zeroFlipped : UInt<1>, clock with :
      reset => (UInt<1>("h0"), zeroFlipped) @[intervox_receiver.scala 37:30]
    reg syncFlipped : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncFlipped) @[intervox_receiver.scala 38:30]
    reg syncFlipped1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncFlipped1) @[intervox_receiver.scala 39:30]
    node _deltaCntr_T = add(deltaCntr, UInt<1>("h1")) @[intervox_receiver.scala 49:31]
    node _deltaCntr_T_1 = tail(_deltaCntr_T, 1) @[intervox_receiver.scala 49:31]
    node _T = eq(UInt<1>("h0"), io_DATA_IN) @[intervox_receiver.scala 53:23]
    node _T_1 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 55:25]
    node _inBufr_T = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 56:34]
    node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 56:34]
    node _GEN_0 = mux(_T_1, _inBufr_T_1, inBufr) @[intervox_receiver.scala 55:31 56:24 31:30]
    node _T_2 = eq(UInt<1>("h1"), io_DATA_IN) @[intervox_receiver.scala 53:23]
    node _T_3 = lt(inBufr, UInt<2>("h3")) @[intervox_receiver.scala 60:25]
    node _inBufr_T_2 = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 61:34]
    node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 61:34]
    node _GEN_1 = mux(_T_3, _inBufr_T_3, inBufr) @[intervox_receiver.scala 60:31 61:24 31:30]
    node _GEN_2 = mux(_T_2, _GEN_1, inBufr) @[intervox_receiver.scala 53:23 31:30]
    node _GEN_3 = mux(_T, _GEN_0, _GEN_2) @[intervox_receiver.scala 53:23]
    node _T_4 = bits(inBufr, 0, 0) @[intervox_receiver.scala 65:17]
    node _T_5 = bits(inBufr, 1, 1) @[intervox_receiver.scala 65:31]
    node _T_6 = xor(_T_4, _T_5) @[intervox_receiver.scala 65:22]
    node _GEN_4 = mux(_T_6, UInt<1>("h1"), change) @[intervox_receiver.scala 65:36 66:16 34:30]
    node _T_7 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 70:17]
    reg change_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change_REG) @[intervox_receiver.scala 71:34]
    reg change_REG_1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change_REG_1) @[intervox_receiver.scala 71:26]
    node _clkRec_T = not(clkRec) @[intervox_receiver.scala 72:24]
    node _GEN_5 = mux(_T_7, change_REG_1, _GEN_4) @[intervox_receiver.scala 70:25 71:16]
    node _GEN_6 = mux(_T_7, _clkRec_T, clkRec) @[intervox_receiver.scala 70:25 72:21 33:30]
    node _GEN_7 = mux(_T_7, UInt<1>("h0"), _deltaCntr_T_1) @[intervox_receiver.scala 49:18 70:25 73:21]
    node _GEN_8 = mux(_T_7, UInt<1>("h0"), zeroFlipped) @[intervox_receiver.scala 70:25 74:21 37:30]
    node _GEN_9 = mux(_T_7, UInt<1>("h0"), syncFlipped) @[intervox_receiver.scala 70:25 75:21 38:30]
    node _GEN_10 = mux(_T_7, UInt<1>("h0"), syncFlipped1) @[intervox_receiver.scala 70:25 76:21 39:30]
    node _T_8 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 80:33]
    node _T_9 = tail(_T_8, 1) @[intervox_receiver.scala 80:33]
    node _T_10 = leq(deltaCntr, _T_9) @[intervox_receiver.scala 80:21]
    node _T_11 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 82:21]
    node _GEN_11 = mux(_T_11, UInt<1>("h1"), dataOut) @[intervox_receiver.scala 82:29 83:21 35:30]
    node _GEN_12 = mux(_T_10, UInt<1>("h0"), syncWord) @[intervox_receiver.scala 80:41 81:18 36:30]
    node _GEN_13 = mux(_T_10, _GEN_11, dataOut) @[intervox_receiver.scala 35:30 80:41]
    node _T_12 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 88:32]
    node _T_13 = tail(_T_12, 1) @[intervox_receiver.scala 88:32]
    node _T_14 = gt(deltaCntr, _T_13) @[intervox_receiver.scala 88:21]
    node _T_15 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 88:64]
    node _T_16 = lt(deltaCntr, _T_15) @[intervox_receiver.scala 88:53]
    node _T_17 = and(_T_14, _T_16) @[intervox_receiver.scala 88:40]
    node _T_18 = eq(zeroFlipped, UInt<1>("h0")) @[intervox_receiver.scala 89:26]
    node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 91:23]
    node _GEN_14 = mux(_T_18, _clkRec_T_1, _GEN_6) @[intervox_receiver.scala 89:34 91:20]
    node _GEN_15 = mux(_T_18, UInt<1>("h1"), _GEN_8) @[intervox_receiver.scala 89:34 92:25]
    node _GEN_16 = mux(_T_17, _GEN_14, _GEN_6) @[intervox_receiver.scala 88:72]
    node _GEN_17 = mux(_T_17, _GEN_15, _GEN_8) @[intervox_receiver.scala 88:72]
    node _GEN_18 = mux(_T_17, UInt<1>("h0"), _GEN_13) @[intervox_receiver.scala 88:72 94:17]
    node _T_19 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 100:17]
    node _T_20 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 102:36]
    node _T_21 = gt(deltaCntr, _T_20) @[intervox_receiver.scala 102:24]
    node _T_22 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 102:68]
    node _T_23 = lt(deltaCntr, _T_22) @[intervox_receiver.scala 102:57]
    node _T_24 = and(_T_21, _T_23) @[intervox_receiver.scala 102:44]
    node _T_25 = eq(syncFlipped, UInt<1>("h0")) @[intervox_receiver.scala 103:30]
    node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 105:27]
    node _GEN_19 = mux(_T_25, _clkRec_T_2, _GEN_16) @[intervox_receiver.scala 103:38 105:24]
    node _GEN_20 = mux(_T_25, UInt<1>("h1"), _GEN_9) @[intervox_receiver.scala 103:38 106:29]
    node _GEN_21 = mux(_T_24, _GEN_19, _GEN_16) @[intervox_receiver.scala 102:76]
    node _GEN_22 = mux(_T_24, _GEN_20, _GEN_9) @[intervox_receiver.scala 102:76]
    node _T_26 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 109:35]
    node _T_27 = gt(deltaCntr, _T_26) @[intervox_receiver.scala 109:24]
    node _T_28 = eq(syncFlipped1, UInt<1>("h0")) @[intervox_receiver.scala 111:31]
    node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 113:27]
    node _GEN_23 = mux(_T_28, _clkRec_T_3, _GEN_21) @[intervox_receiver.scala 111:39 113:24]
    node _GEN_24 = mux(_T_28, UInt<1>("h1"), _GEN_10) @[intervox_receiver.scala 111:39 114:30]
    node _GEN_25 = mux(_T_27, UInt<1>("h1"), _GEN_12) @[intervox_receiver.scala 109:42 110:22]
    node _GEN_26 = mux(_T_27, _GEN_23, _GEN_21) @[intervox_receiver.scala 109:42]
    node _GEN_27 = mux(_T_27, _GEN_24, _GEN_10) @[intervox_receiver.scala 109:42]
    node _GEN_28 = mux(_T_19, _GEN_26, _GEN_16) @[intervox_receiver.scala 100:25]
    node _GEN_29 = mux(_T_19, _GEN_22, _GEN_9) @[intervox_receiver.scala 100:25]
    node _GEN_30 = mux(_T_19, _GEN_25, _GEN_12) @[intervox_receiver.scala 100:25]
    node _GEN_31 = mux(_T_19, _GEN_27, _GEN_10) @[intervox_receiver.scala 100:25]
    io_CLK_OUT <= clkRec @[intervox_receiver.scala 43:21]
    io_DATA_OUT <= dataOut @[intervox_receiver.scala 44:21]
    io_DBUG <= change @[intervox_receiver.scala 45:21]
    io_DBUG1 <= syncWord @[intervox_receiver.scala 46:21]
    io_LEDS <= pad(lastOne, 16) @[intervox_receiver.scala 47:21]
    rising <= mux(reset, UInt<2>("h0"), rising) @[intervox_receiver.scala 27:{30,30,30}]
    trailing <= mux(reset, UInt<2>("h0"), trailing) @[intervox_receiver.scala 28:{30,30,30}]
    lastOne <= mux(reset, UInt<8>("hf"), lastOne) @[intervox_receiver.scala 29:{30,30,30}]
    overSampleCntr <= mux(reset, UInt<4>("h0"), overSampleCntr) @[intervox_receiver.scala 30:{32,32,32}]
    inBufr <= mux(reset, UInt<2>("h0"), _GEN_3) @[intervox_receiver.scala 31:{30,30}]
    deltaCntr <= mux(reset, UInt<8>("h0"), _GEN_7) @[intervox_receiver.scala 32:{30,30}]
    clkRec <= mux(reset, UInt<1>("h0"), _GEN_28) @[intervox_receiver.scala 33:{30,30}]
    change <= mux(reset, UInt<1>("h0"), _GEN_5) @[intervox_receiver.scala 34:{30,30}]
    dataOut <= mux(reset, UInt<1>("h0"), _GEN_18) @[intervox_receiver.scala 35:{30,30}]
    syncWord <= mux(reset, UInt<1>("h0"), _GEN_30) @[intervox_receiver.scala 36:{30,30}]
    zeroFlipped <= mux(reset, UInt<1>("h0"), _GEN_17) @[intervox_receiver.scala 37:{30,30}]
    syncFlipped <= mux(reset, UInt<1>("h0"), _GEN_29) @[intervox_receiver.scala 38:{30,30}]
    syncFlipped1 <= mux(reset, UInt<1>("h0"), _GEN_31) @[intervox_receiver.scala 39:{30,30}]
    change_REG <= mux(reset, UInt<1>("h0"), UInt<1>("h0")) @[intervox_receiver.scala 71:{34,34,34}]
    change_REG_1 <= mux(reset, UInt<1>("h0"), change_REG) @[intervox_receiver.scala 71:{26,26,26}]

  extmodule clk_wiz_0_clk_wiz :
    output CLK_OUT : UInt<1>
    output locked : UInt<1>
    input CLK_IN : UInt<1>
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

    inst clockRec of clock_Recovery @[intervox_receiver.scala 132:26]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 145:21]
    io_CLK_REC <= pll.CLK_OUT @[intervox_receiver.scala 149:16]
    io_DATA_OUT <= clockRec.io_DATA_OUT @[intervox_receiver.scala 137:25]
    io_CLK_DBUG <= clockRec.io_CLK_OUT @[intervox_receiver.scala 138:25]
    io_DBUG <= clockRec.io_DBUG @[intervox_receiver.scala 140:25]
    io_DBUG1 <= clockRec.io_DBUG1 @[intervox_receiver.scala 139:25]
    io_LEDS <= clockRec.io_LEDS @[intervox_receiver.scala 136:25]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io_DATA_IN <= io_INTERVOX_IN @[intervox_receiver.scala 134:25]
    pll.CLK_IN <= clockRec.io_CLK_OUT @[intervox_receiver.scala 148:19]
