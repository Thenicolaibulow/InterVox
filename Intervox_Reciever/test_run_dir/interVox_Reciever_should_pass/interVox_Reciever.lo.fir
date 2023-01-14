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
      reset => (UInt<1>("h0"), rising) @[intervox_receiver.scala 79:30]
    reg trailing : UInt<2>, clock with :
      reset => (UInt<1>("h0"), trailing) @[intervox_receiver.scala 80:30]
    reg lastOne : UInt<8>, clock with :
      reset => (UInt<1>("h0"), lastOne) @[intervox_receiver.scala 81:30]
    reg overSampleCntr : UInt<4>, clock with :
      reset => (UInt<1>("h0"), overSampleCntr) @[intervox_receiver.scala 82:32]
    reg inBufr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufr) @[intervox_receiver.scala 83:30]
    reg deltaCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), deltaCntr) @[intervox_receiver.scala 84:30]
    reg clkRec : UInt<1>, clock with :
      reset => (UInt<1>("h0"), clkRec) @[intervox_receiver.scala 85:30]
    reg change : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change) @[intervox_receiver.scala 86:30]
    reg dataOut : UInt<1>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[intervox_receiver.scala 87:30]
    reg syncWord : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncWord) @[intervox_receiver.scala 88:30]
    reg zeroFlipped : UInt<1>, clock with :
      reset => (UInt<1>("h0"), zeroFlipped) @[intervox_receiver.scala 89:30]
    reg syncFlipped : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncFlipped) @[intervox_receiver.scala 90:30]
    reg syncFlipped1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncFlipped1) @[intervox_receiver.scala 91:30]
    reg syncFlipped2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncFlipped2) @[intervox_receiver.scala 92:30]
    node _deltaCntr_T = add(deltaCntr, UInt<1>("h1")) @[intervox_receiver.scala 100:31]
    node _deltaCntr_T_1 = tail(_deltaCntr_T, 1) @[intervox_receiver.scala 100:31]
    node _T = eq(UInt<1>("h1"), io_DATA_IN) @[intervox_receiver.scala 105:23]
    node _T_1 = lt(inBufr, UInt<2>("h3")) @[intervox_receiver.scala 107:25]
    node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 109:34]
    node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 109:34]
    node _GEN_0 = mux(_T_1, _inBufr_T_1, inBufr) @[intervox_receiver.scala 107:31 109:24 83:30]
    node _T_2 = eq(UInt<1>("h0"), io_DATA_IN) @[intervox_receiver.scala 105:23]
    node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 113:25]
    node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 115:34]
    node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 115:34]
    node _GEN_1 = mux(_T_3, _inBufr_T_3, inBufr) @[intervox_receiver.scala 113:31 115:24 83:30]
    node _GEN_2 = mux(_T_2, _GEN_1, inBufr) @[intervox_receiver.scala 105:23 83:30]
    node _GEN_3 = mux(_T, _GEN_0, _GEN_2) @[intervox_receiver.scala 105:23]
    node _T_4 = bits(inBufr, 0, 0) @[intervox_receiver.scala 119:17]
    node _T_5 = bits(inBufr, 1, 1) @[intervox_receiver.scala 119:31]
    node _T_6 = xor(_T_4, _T_5) @[intervox_receiver.scala 119:22]
    node _GEN_4 = mux(_T_6, UInt<1>("h1"), change) @[intervox_receiver.scala 119:36 120:16 86:30]
    node _T_7 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 126:17]
    reg change_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change_REG) @[intervox_receiver.scala 128:34]
    reg change_REG_1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change_REG_1) @[intervox_receiver.scala 128:26]
    node _clkRec_T = not(clkRec) @[intervox_receiver.scala 130:24]
    node _GEN_5 = mux(_T_7, change_REG_1, _GEN_4) @[intervox_receiver.scala 126:25 128:16]
    node _GEN_6 = mux(_T_7, _clkRec_T, clkRec) @[intervox_receiver.scala 126:25 130:21 85:30]
    node _GEN_7 = mux(_T_7, UInt<1>("h0"), _deltaCntr_T_1) @[intervox_receiver.scala 100:18 126:25 132:21]
    node _GEN_8 = mux(_T_7, UInt<1>("h0"), zeroFlipped) @[intervox_receiver.scala 126:25 134:21 89:30]
    node _GEN_9 = mux(_T_7, UInt<1>("h0"), syncFlipped) @[intervox_receiver.scala 126:25 135:21 90:30]
    node _GEN_10 = mux(_T_7, UInt<1>("h0"), syncFlipped1) @[intervox_receiver.scala 126:25 136:21 91:30]
    node _GEN_11 = mux(_T_7, UInt<1>("h0"), syncWord) @[intervox_receiver.scala 126:25 137:18 88:30]
    node _T_8 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 143:33]
    node _T_9 = tail(_T_8, 1) @[intervox_receiver.scala 143:33]
    node _T_10 = leq(deltaCntr, _T_9) @[intervox_receiver.scala 143:21]
    node _T_11 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 146:21]
    node _GEN_12 = mux(_T_11, UInt<1>("h1"), dataOut) @[intervox_receiver.scala 146:29 149:21 87:30]
    node _GEN_13 = mux(_T_10, _GEN_12, dataOut) @[intervox_receiver.scala 143:41 87:30]
    node _T_12 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 159:32]
    node _T_13 = tail(_T_12, 1) @[intervox_receiver.scala 159:32]
    node _T_14 = gt(deltaCntr, _T_13) @[intervox_receiver.scala 159:21]
    node _T_15 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 159:65]
    node _T_16 = add(_T_15, UInt<2>("h2")) @[intervox_receiver.scala 159:72]
    node _T_17 = tail(_T_16, 1) @[intervox_receiver.scala 159:72]
    node _T_18 = lt(deltaCntr, _T_17) @[intervox_receiver.scala 159:53]
    node _T_19 = and(_T_14, _T_18) @[intervox_receiver.scala 159:40]
    node _T_20 = eq(zeroFlipped, UInt<1>("h0")) @[intervox_receiver.scala 162:26]
    node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 165:23]
    node _GEN_14 = mux(_T_20, _clkRec_T_1, _GEN_6) @[intervox_receiver.scala 162:34 165:20]
    node _GEN_15 = mux(_T_20, UInt<1>("h1"), _GEN_8) @[intervox_receiver.scala 162:34 166:25]
    node _GEN_16 = mux(_T_19, _GEN_14, _GEN_6) @[intervox_receiver.scala 159:80]
    node _GEN_17 = mux(_T_19, _GEN_15, _GEN_8) @[intervox_receiver.scala 159:80]
    node _GEN_18 = mux(_T_19, UInt<1>("h0"), _GEN_13) @[intervox_receiver.scala 159:80 169:17]
    node _T_21 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 176:17]
    node _T_22 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 178:38]
    node _T_23 = add(_T_22, UInt<2>("h2")) @[intervox_receiver.scala 178:45]
    node _T_24 = tail(_T_23, 1) @[intervox_receiver.scala 178:45]
    node _T_25 = eq(deltaCntr, _T_24) @[intervox_receiver.scala 178:24]
    node _T_26 = eq(syncFlipped, UInt<1>("h0")) @[intervox_receiver.scala 185:30]
    node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 187:27]
    node _GEN_19 = mux(_T_26, _clkRec_T_2, _GEN_16) @[intervox_receiver.scala 185:38 187:24]
    node _GEN_20 = mux(_T_26, UInt<1>("h1"), _GEN_9) @[intervox_receiver.scala 185:38 188:29]
    node _GEN_21 = mux(_T_25, _GEN_19, _GEN_16) @[intervox_receiver.scala 178:52]
    node _GEN_22 = mux(_T_25, _GEN_20, _GEN_9) @[intervox_receiver.scala 178:52]
    node _T_27 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 191:38]
    node _T_28 = eq(deltaCntr, _T_27) @[intervox_receiver.scala 191:24]
    node _T_29 = eq(syncFlipped1, UInt<1>("h0")) @[intervox_receiver.scala 200:31]
    node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 202:27]
    node _GEN_23 = mux(_T_29, _clkRec_T_3, _GEN_21) @[intervox_receiver.scala 200:39 202:24]
    node _GEN_24 = mux(_T_29, UInt<1>("h1"), _GEN_10) @[intervox_receiver.scala 200:39 203:30]
    node _GEN_25 = mux(_T_28, UInt<1>("h1"), _GEN_11) @[intervox_receiver.scala 191:46 198:22]
    node _GEN_26 = mux(_T_28, _GEN_23, _GEN_21) @[intervox_receiver.scala 191:46]
    node _GEN_27 = mux(_T_28, _GEN_24, _GEN_10) @[intervox_receiver.scala 191:46]
    node _T_30 = mul(lastOne, UInt<3>("h4")) @[intervox_receiver.scala 206:38]
    node _T_31 = eq(deltaCntr, _T_30) @[intervox_receiver.scala 206:25]
    node _T_32 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 206:56]
    node _T_33 = and(_T_31, _T_32) @[intervox_receiver.scala 206:46]
    node _T_34 = eq(syncFlipped2, UInt<1>("h0")) @[intervox_receiver.scala 213:31]
    node _clkRec_T_4 = not(clkRec) @[intervox_receiver.scala 215:27]
    node _GEN_28 = mux(_T_34, _clkRec_T_4, _GEN_26) @[intervox_receiver.scala 213:39 215:24]
    node _GEN_29 = mux(_T_34, UInt<1>("h1"), syncFlipped2) @[intervox_receiver.scala 213:39 216:30 92:30]
    node _GEN_30 = mux(_T_33, _GEN_28, _GEN_26) @[intervox_receiver.scala 206:65]
    node _GEN_31 = mux(_T_33, _GEN_29, syncFlipped2) @[intervox_receiver.scala 206:65 92:30]
    node _GEN_32 = mux(_T_21, _GEN_30, _GEN_16) @[intervox_receiver.scala 176:25]
    node _GEN_33 = mux(_T_21, _GEN_22, _GEN_9) @[intervox_receiver.scala 176:25]
    node _GEN_34 = mux(_T_21, _GEN_25, _GEN_11) @[intervox_receiver.scala 176:25]
    node _GEN_35 = mux(_T_21, _GEN_27, _GEN_10) @[intervox_receiver.scala 176:25]
    node _GEN_36 = mux(_T_21, _GEN_31, syncFlipped2) @[intervox_receiver.scala 176:25 92:30]
    io_CLK_OUT <= clkRec @[intervox_receiver.scala 94:21]
    io_DATA_OUT <= dataOut @[intervox_receiver.scala 95:21]
    io_DBUG <= change @[intervox_receiver.scala 96:21]
    io_DBUG1 <= syncWord @[intervox_receiver.scala 97:21]
    io_LEDS <= pad(lastOne, 16) @[intervox_receiver.scala 98:21]
    rising <= mux(reset, UInt<2>("h0"), rising) @[intervox_receiver.scala 79:{30,30,30}]
    trailing <= mux(reset, UInt<2>("h0"), trailing) @[intervox_receiver.scala 80:{30,30,30}]
    lastOne <= mux(reset, UInt<8>("hf"), lastOne) @[intervox_receiver.scala 81:{30,30,30}]
    overSampleCntr <= mux(reset, UInt<4>("h0"), overSampleCntr) @[intervox_receiver.scala 82:{32,32,32}]
    inBufr <= mux(reset, UInt<2>("h0"), _GEN_3) @[intervox_receiver.scala 83:{30,30}]
    deltaCntr <= mux(reset, UInt<8>("h0"), _GEN_7) @[intervox_receiver.scala 84:{30,30}]
    clkRec <= mux(reset, UInt<1>("h0"), _GEN_32) @[intervox_receiver.scala 85:{30,30}]
    change <= mux(reset, UInt<1>("h0"), _GEN_5) @[intervox_receiver.scala 86:{30,30}]
    dataOut <= mux(reset, UInt<1>("h0"), _GEN_18) @[intervox_receiver.scala 87:{30,30}]
    syncWord <= mux(reset, UInt<1>("h0"), _GEN_34) @[intervox_receiver.scala 88:{30,30}]
    zeroFlipped <= mux(reset, UInt<1>("h0"), _GEN_17) @[intervox_receiver.scala 89:{30,30}]
    syncFlipped <= mux(reset, UInt<1>("h0"), _GEN_33) @[intervox_receiver.scala 90:{30,30}]
    syncFlipped1 <= mux(reset, UInt<1>("h0"), _GEN_35) @[intervox_receiver.scala 91:{30,30}]
    syncFlipped2 <= mux(reset, UInt<1>("h0"), _GEN_36) @[intervox_receiver.scala 92:{30,30}]
    change_REG <= mux(reset, UInt<1>("h0"), UInt<1>("h0")) @[intervox_receiver.scala 128:{34,34,34}]
    change_REG_1 <= mux(reset, UInt<1>("h0"), change_REG) @[intervox_receiver.scala 128:{26,26,26}]

  module edgeDetector :
    input clock : Clock
    input reset : UInt<1>
    input io_INPUT : UInt<1>
    output io_TRAIL : UInt<1>
    output io_RISE : UInt<1>
    output io_CHANGE : UInt<1>

    reg inBufr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufr) @[intervox_receiver.scala 12:34]
    reg inBufrPrev : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufrPrev) @[intervox_receiver.scala 13:34]
    reg trailing : UInt<1>, clock with :
      reset => (UInt<1>("h0"), trailing) @[intervox_receiver.scala 14:34]
    reg rising : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rising) @[intervox_receiver.scala 15:34]
    reg change : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change) @[intervox_receiver.scala 16:34]
    reg changed : UInt<1>, clock with :
      reset => (UInt<1>("h0"), changed) @[intervox_receiver.scala 17:34]
    node _T = eq(UInt<1>("h1"), io_INPUT) @[intervox_receiver.scala 22:21]
    node _T_1 = lt(inBufr, UInt<2>("h2")) @[intervox_receiver.scala 24:21]
    node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 26:35]
    node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 26:35]
    node _GEN_0 = mux(_T_1, _inBufr_T_1, inBufr) @[intervox_receiver.scala 24:27 26:25 12:34]
    node _GEN_1 = mux(_T_1, inBufr, inBufrPrev) @[intervox_receiver.scala 24:27 27:25 13:34]
    node _T_2 = eq(UInt<1>("h0"), io_INPUT) @[intervox_receiver.scala 22:21]
    node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 31:21]
    node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 33:35]
    node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 33:35]
    node _GEN_2 = mux(_T_3, _inBufr_T_3, inBufr) @[intervox_receiver.scala 31:27 33:25 12:34]
    node _GEN_3 = mux(_T_3, inBufr, inBufrPrev) @[intervox_receiver.scala 31:27 34:25 13:34]
    node _GEN_4 = mux(_T_2, _GEN_2, inBufr) @[intervox_receiver.scala 22:21 12:34]
    node _GEN_5 = mux(_T_2, _GEN_3, inBufrPrev) @[intervox_receiver.scala 22:21 13:34]
    node _GEN_6 = mux(_T, _GEN_0, _GEN_4) @[intervox_receiver.scala 22:21]
    node _GEN_7 = mux(_T, _GEN_1, _GEN_5) @[intervox_receiver.scala 22:21]
    node _T_4 = eq(rising, UInt<1>("h1")) @[intervox_receiver.scala 39:18]
    node _T_5 = eq(trailing, UInt<1>("h1")) @[intervox_receiver.scala 39:39]
    node _T_6 = or(_T_4, _T_5) @[intervox_receiver.scala 39:27]
    node _GEN_8 = mux(_T_6, UInt<1>("h1"), change) @[intervox_receiver.scala 39:48 40:17 16:34]
    node _T_7 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_receiver.scala 43:22]
    node _T_8 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 43:41]
    node _T_9 = and(_T_7, _T_8) @[intervox_receiver.scala 43:31]
    node _GEN_9 = mux(_T_9, UInt<1>("h0"), trailing) @[intervox_receiver.scala 43:50 44:17 14:34]
    node _GEN_10 = mux(_T_9, UInt<1>("h1"), rising) @[intervox_receiver.scala 43:50 45:17 15:34]
    node _GEN_11 = mux(_T_9, UInt<1>("h1"), _GEN_8) @[intervox_receiver.scala 43:50 46:17]
    node _T_10 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_receiver.scala 49:22]
    node _T_11 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 49:41]
    node _T_12 = and(_T_10, _T_11) @[intervox_receiver.scala 49:31]
    node _GEN_12 = mux(_T_12, UInt<1>("h1"), _GEN_9) @[intervox_receiver.scala 49:50 50:17]
    node _GEN_13 = mux(_T_12, UInt<1>("h0"), _GEN_10) @[intervox_receiver.scala 49:50 51:17]
    node _GEN_14 = mux(_T_12, UInt<1>("h1"), _GEN_11) @[intervox_receiver.scala 49:50 52:17]
    node _T_13 = eq(trailing, UInt<1>("h1")) @[intervox_receiver.scala 55:19]
    node _GEN_15 = mux(_T_13, UInt<1>("h0"), _GEN_12) @[intervox_receiver.scala 55:{27,37}]
    node _T_14 = eq(rising, UInt<1>("h1")) @[intervox_receiver.scala 56:17]
    node _GEN_16 = mux(_T_14, UInt<1>("h0"), _GEN_13) @[intervox_receiver.scala 56:{27,37}]
    node _T_15 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 58:17]
    reg change_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change_REG) @[intervox_receiver.scala 59:26]
    node _GEN_17 = mux(_T_15, change_REG, _GEN_14) @[intervox_receiver.scala 58:25 59:16]
    io_TRAIL <= trailing @[intervox_receiver.scala 63:13]
    io_RISE <= rising @[intervox_receiver.scala 64:13]
    io_CHANGE <= change @[intervox_receiver.scala 62:13]
    inBufr <= mux(reset, UInt<2>("h0"), _GEN_6) @[intervox_receiver.scala 12:{34,34}]
    inBufrPrev <= mux(reset, UInt<2>("h0"), _GEN_7) @[intervox_receiver.scala 13:{34,34}]
    trailing <= mux(reset, UInt<1>("h0"), _GEN_15) @[intervox_receiver.scala 14:{34,34}]
    rising <= mux(reset, UInt<1>("h0"), _GEN_16) @[intervox_receiver.scala 15:{34,34}]
    change <= mux(reset, UInt<1>("h0"), _GEN_17) @[intervox_receiver.scala 16:{34,34}]
    changed <= mux(reset, UInt<1>("h0"), changed) @[intervox_receiver.scala 17:{34,34,34}]
    change_REG <= UInt<1>("h0") @[intervox_receiver.scala 59:26]

  module i2s_Transmitter :
    input clock : Clock
    input reset : UInt<1>
    input io_CLK_IN : UInt<1>
    input io_DATA_IN : UInt<1>
    input io_NEXT : UInt<1>
    output io_BCLK : UInt<1>
    output io_LRCLK : UInt<1>
    output io_SDATA : UInt<1>

    inst BCLKEDGE of edgeDetector @[intervox_receiver.scala 243:37]
    reg enable : UInt<1>, clock with :
      reset => (UInt<1>("h0"), enable) @[intervox_receiver.scala 232:26]
    reg bitCntr : UInt<6>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_receiver.scala 233:26]
    reg lrclk : UInt<1>, clock with :
      reset => (UInt<1>("h0"), lrclk) @[intervox_receiver.scala 234:26]
    reg bclk : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bclk) @[intervox_receiver.scala 235:26]
    reg sdata : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sdata) @[intervox_receiver.scala 236:26]
    node _T = eq(io_NEXT, UInt<1>("h1")) @[intervox_receiver.scala 246:18]
    node _GEN_0 = mux(_T, UInt<1>("h1"), enable) @[intervox_receiver.scala 246:26 247:17 232:26]
    node _GEN_1 = mux(_T, UInt<1>("h0"), bitCntr) @[intervox_receiver.scala 246:26 248:17 233:26]
    node _T_1 = eq(enable, UInt<1>("h1")) @[intervox_receiver.scala 251:17]
    node _T_2 = eq(BCLKEDGE.io_RISE, UInt<1>("h1")) @[intervox_receiver.scala 253:31]
    node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_receiver.scala 255:32]
    node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_receiver.scala 255:32]
    node _T_3 = eq(bitCntr, UInt<1>("h0")) @[intervox_receiver.scala 257:26]
    node _GEN_2 = mux(_T_3, UInt<1>("h1"), lrclk) @[intervox_receiver.scala 257:34 258:23 234:26]
    node _T_4 = eq(bitCntr, UInt<5>("h1f")) @[intervox_receiver.scala 261:26]
    node _GEN_3 = mux(_T_4, UInt<1>("h0"), _GEN_2) @[intervox_receiver.scala 261:35 262:23]
    node _T_5 = eq(bitCntr, UInt<6>("h3f")) @[intervox_receiver.scala 265:26]
    node _GEN_4 = mux(_T_5, UInt<1>("h0"), _GEN_0) @[intervox_receiver.scala 265:35 266:24]
    node _GEN_5 = mux(_T_5, UInt<1>("h0"), _bitCntr_T_1) @[intervox_receiver.scala 255:21 265:35 267:25]
    node _T_6 = eq(io_DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 270:29]
    node _GEN_6 = mux(_T_6, UInt<1>("h1"), UInt<1>("h0")) @[intervox_receiver.scala 270:37 271:23 273:23]
    node _GEN_7 = mux(_T_2, _GEN_5, _GEN_1) @[intervox_receiver.scala 253:39]
    node _GEN_8 = mux(_T_2, _GEN_3, lrclk) @[intervox_receiver.scala 234:26 253:39]
    node _GEN_9 = mux(_T_2, _GEN_4, _GEN_0) @[intervox_receiver.scala 253:39]
    node _GEN_10 = mux(_T_2, _GEN_6, sdata) @[intervox_receiver.scala 236:26 253:39]
    node _GEN_11 = mux(_T_1, _GEN_7, _GEN_1) @[intervox_receiver.scala 251:25]
    node _GEN_12 = mux(_T_1, _GEN_8, lrclk) @[intervox_receiver.scala 251:25 234:26]
    node _GEN_13 = mux(_T_1, _GEN_9, _GEN_0) @[intervox_receiver.scala 251:25]
    node _GEN_14 = mux(_T_1, _GEN_10, sdata) @[intervox_receiver.scala 251:25 236:26]
    io_BCLK <= io_CLK_IN @[intervox_receiver.scala 241:17]
    io_LRCLK <= lrclk @[intervox_receiver.scala 239:17]
    io_SDATA <= sdata @[intervox_receiver.scala 240:17]
    enable <= mux(reset, UInt<1>("h0"), _GEN_13) @[intervox_receiver.scala 232:{26,26}]
    bitCntr <= mux(reset, UInt<6>("h0"), _GEN_11) @[intervox_receiver.scala 233:{26,26}]
    lrclk <= mux(reset, UInt<1>("h0"), _GEN_12) @[intervox_receiver.scala 234:{26,26}]
    bclk <= mux(reset, UInt<1>("h0"), bclk) @[intervox_receiver.scala 235:{26,26,26}]
    sdata <= mux(reset, UInt<1>("h0"), _GEN_14) @[intervox_receiver.scala 236:{26,26}]
    BCLKEDGE.clock <= clock
    BCLKEDGE.reset <= reset
    BCLKEDGE.io_INPUT <= io_BCLK @[intervox_receiver.scala 244:31]

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
    output io_BCLK : UInt<1>
    output io_LRCLK : UInt<1>
    output io_SDATA : UInt<1>

    inst clockRec of clock_Recovery @[intervox_receiver.scala 294:29]
    inst i2sTrans of i2s_Transmitter @[intervox_receiver.scala 303:29]
    io_CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 299:21]
    io_DATA_OUT <= clockRec.io_DATA_OUT @[intervox_receiver.scala 297:21]
    io_CLK_DBUG <= UInt<1>("h0") @[intervox_receiver.scala 298:21]
    io_DBUG <= clockRec.io_DBUG @[intervox_receiver.scala 301:21]
    io_DBUG1 <= clockRec.io_DBUG1 @[intervox_receiver.scala 300:21]
    io_LEDS <= clockRec.io_LEDS @[intervox_receiver.scala 296:21]
    io_BCLK <= i2sTrans.io_BCLK @[intervox_receiver.scala 307:21]
    io_LRCLK <= i2sTrans.io_LRCLK @[intervox_receiver.scala 309:21]
    io_SDATA <= i2sTrans.io_SDATA @[intervox_receiver.scala 308:21]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io_DATA_IN <= io_INTERVOX_IN @[intervox_receiver.scala 295:29]
    i2sTrans.clock <= clock
    i2sTrans.reset <= reset
    i2sTrans.io_CLK_IN <= clockRec.io_CLK_OUT @[intervox_receiver.scala 304:29]
    i2sTrans.io_DATA_IN <= clockRec.io_DATA_OUT @[intervox_receiver.scala 305:29]
    i2sTrans.io_NEXT <= clockRec.io_DBUG1 @[intervox_receiver.scala 306:29]
