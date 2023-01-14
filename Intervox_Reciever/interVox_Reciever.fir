circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : Reset
    output io : { flip DATA_IN : UInt<1>, CLK_OUT : UInt<1>, DATA_OUT : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LEDS : UInt<16>}

    reg rising : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 79:30]
    reg trailing : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 80:30]
    reg lastOne : UInt<8>, clock with :
      reset => (reset, UInt<8>("hf")) @[intervox_receiver.scala 81:30]
    reg overSampleCntr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[intervox_receiver.scala 82:32]
    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 83:30]
    reg deltaCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 84:30]
    reg clkRec : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 85:30]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 86:30]
    reg dataOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 87:30]
    reg syncWord : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 88:30]
    reg zeroFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 89:30]
    reg syncFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 90:30]
    reg syncFlipped1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 91:30]
    reg syncFlipped2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 92:30]
    io.CLK_OUT <= clkRec @[intervox_receiver.scala 94:21]
    io.DATA_OUT <= dataOut @[intervox_receiver.scala 95:21]
    io.DBUG <= change @[intervox_receiver.scala 96:21]
    io.DBUG1 <= syncWord @[intervox_receiver.scala 97:21]
    io.LEDS <= lastOne @[intervox_receiver.scala 98:21]
    node _deltaCntr_T = add(deltaCntr, UInt<1>("h1")) @[intervox_receiver.scala 100:31]
    node _deltaCntr_T_1 = tail(_deltaCntr_T, 1) @[intervox_receiver.scala 100:31]
    deltaCntr <= _deltaCntr_T_1 @[intervox_receiver.scala 100:18]
    node _T = eq(UInt<1>("h1"), io.DATA_IN) @[intervox_receiver.scala 105:23]
    when _T : @[intervox_receiver.scala 105:23]
      node _T_1 = lt(inBufr, UInt<2>("h3")) @[intervox_receiver.scala 107:25]
      when _T_1 : @[intervox_receiver.scala 107:31]
        node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 109:34]
        node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 109:34]
        inBufr <= _inBufr_T_1 @[intervox_receiver.scala 109:24]
    else :
      node _T_2 = eq(UInt<1>("h0"), io.DATA_IN) @[intervox_receiver.scala 105:23]
      when _T_2 : @[intervox_receiver.scala 105:23]
        node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 113:25]
        when _T_3 : @[intervox_receiver.scala 113:31]
          node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 115:34]
          node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 115:34]
          inBufr <= _inBufr_T_3 @[intervox_receiver.scala 115:24]
    node _T_4 = bits(inBufr, 0, 0) @[intervox_receiver.scala 119:17]
    node _T_5 = bits(inBufr, 1, 1) @[intervox_receiver.scala 119:31]
    node _T_6 = xor(_T_4, _T_5) @[intervox_receiver.scala 119:22]
    when _T_6 : @[intervox_receiver.scala 119:36]
      change <= UInt<1>("h1") @[intervox_receiver.scala 120:16]
    node _T_7 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 126:17]
    when _T_7 : @[intervox_receiver.scala 126:25]
      reg change_REG : UInt, clock with :
        reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 128:34]
      change_REG <= UInt<1>("h0") @[intervox_receiver.scala 128:34]
      reg change_REG_1 : UInt, clock with :
        reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 128:26]
      change_REG_1 <= change_REG @[intervox_receiver.scala 128:26]
      change <= change_REG_1 @[intervox_receiver.scala 128:16]
      node _clkRec_T = not(clkRec) @[intervox_receiver.scala 130:24]
      clkRec <= _clkRec_T @[intervox_receiver.scala 130:21]
      deltaCntr <= UInt<1>("h0") @[intervox_receiver.scala 132:21]
      zeroFlipped <= UInt<1>("h0") @[intervox_receiver.scala 134:21]
      syncFlipped <= UInt<1>("h0") @[intervox_receiver.scala 135:21]
      syncFlipped1 <= UInt<1>("h0") @[intervox_receiver.scala 136:21]
      syncWord <= UInt<1>("h0") @[intervox_receiver.scala 137:18]
    node _T_8 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 143:33]
    node _T_9 = tail(_T_8, 1) @[intervox_receiver.scala 143:33]
    node _T_10 = leq(deltaCntr, _T_9) @[intervox_receiver.scala 143:21]
    when _T_10 : @[intervox_receiver.scala 143:41]
      node _T_11 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 146:21]
      when _T_11 : @[intervox_receiver.scala 146:29]
        dataOut <= UInt<1>("h1") @[intervox_receiver.scala 149:21]
    node _T_12 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 159:32]
    node _T_13 = tail(_T_12, 1) @[intervox_receiver.scala 159:32]
    node _T_14 = gt(deltaCntr, _T_13) @[intervox_receiver.scala 159:21]
    node _T_15 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 159:65]
    node _T_16 = add(_T_15, UInt<2>("h2")) @[intervox_receiver.scala 159:72]
    node _T_17 = tail(_T_16, 1) @[intervox_receiver.scala 159:72]
    node _T_18 = lt(deltaCntr, _T_17) @[intervox_receiver.scala 159:53]
    node _T_19 = and(_T_14, _T_18) @[intervox_receiver.scala 159:40]
    when _T_19 : @[intervox_receiver.scala 159:80]
      node _T_20 = eq(zeroFlipped, UInt<1>("h0")) @[intervox_receiver.scala 162:26]
      when _T_20 : @[intervox_receiver.scala 162:34]
        node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 165:23]
        clkRec <= _clkRec_T_1 @[intervox_receiver.scala 165:20]
        zeroFlipped <= UInt<1>("h1") @[intervox_receiver.scala 166:25]
      dataOut <= UInt<1>("h0") @[intervox_receiver.scala 169:17]
    node _T_21 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 176:17]
    when _T_21 : @[intervox_receiver.scala 176:25]
      node _T_22 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 178:38]
      node _T_23 = add(_T_22, UInt<2>("h2")) @[intervox_receiver.scala 178:45]
      node _T_24 = tail(_T_23, 1) @[intervox_receiver.scala 178:45]
      node _T_25 = eq(deltaCntr, _T_24) @[intervox_receiver.scala 178:24]
      when _T_25 : @[intervox_receiver.scala 178:52]
        node _T_26 = eq(syncFlipped, UInt<1>("h0")) @[intervox_receiver.scala 185:30]
        when _T_26 : @[intervox_receiver.scala 185:38]
          node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 187:27]
          clkRec <= _clkRec_T_2 @[intervox_receiver.scala 187:24]
          syncFlipped <= UInt<1>("h1") @[intervox_receiver.scala 188:29]
      node _T_27 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 191:38]
      node _T_28 = eq(deltaCntr, _T_27) @[intervox_receiver.scala 191:24]
      when _T_28 : @[intervox_receiver.scala 191:46]
        syncWord <= UInt<1>("h1") @[intervox_receiver.scala 198:22]
        node _T_29 = eq(syncFlipped1, UInt<1>("h0")) @[intervox_receiver.scala 200:31]
        when _T_29 : @[intervox_receiver.scala 200:39]
          node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 202:27]
          clkRec <= _clkRec_T_3 @[intervox_receiver.scala 202:24]
          syncFlipped1 <= UInt<1>("h1") @[intervox_receiver.scala 203:30]
      node _T_30 = mul(lastOne, UInt<3>("h4")) @[intervox_receiver.scala 206:38]
      node _T_31 = eq(deltaCntr, _T_30) @[intervox_receiver.scala 206:25]
      node _T_32 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 206:56]
      node _T_33 = and(_T_31, _T_32) @[intervox_receiver.scala 206:46]
      when _T_33 : @[intervox_receiver.scala 206:65]
        node _T_34 = eq(syncFlipped2, UInt<1>("h0")) @[intervox_receiver.scala 213:31]
        when _T_34 : @[intervox_receiver.scala 213:39]
          node _clkRec_T_4 = not(clkRec) @[intervox_receiver.scala 215:27]
          clkRec <= _clkRec_T_4 @[intervox_receiver.scala 215:24]
          syncFlipped2 <= UInt<1>("h1") @[intervox_receiver.scala 216:30]

  module edgeDetector :
    input clock : Clock
    input reset : Reset
    output io : { flip INPUT : UInt<1>, TRAIL : UInt<1>, RISE : UInt<1>, CHANGE : UInt<1>}

    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 12:34]
    reg inBufrPrev : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 13:34]
    reg trailing : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 14:34]
    reg rising : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 15:34]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 16:34]
    reg changed : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 17:34]
    node _T = eq(UInt<1>("h1"), io.INPUT) @[intervox_receiver.scala 22:21]
    when _T : @[intervox_receiver.scala 22:21]
      node _T_1 = lt(inBufr, UInt<2>("h2")) @[intervox_receiver.scala 24:21]
      when _T_1 : @[intervox_receiver.scala 24:27]
        node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 26:35]
        node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 26:35]
        inBufr <= _inBufr_T_1 @[intervox_receiver.scala 26:25]
        inBufrPrev <= inBufr @[intervox_receiver.scala 27:25]
    else :
      node _T_2 = eq(UInt<1>("h0"), io.INPUT) @[intervox_receiver.scala 22:21]
      when _T_2 : @[intervox_receiver.scala 22:21]
        node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 31:21]
        when _T_3 : @[intervox_receiver.scala 31:27]
          node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 33:35]
          node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 33:35]
          inBufr <= _inBufr_T_3 @[intervox_receiver.scala 33:25]
          inBufrPrev <= inBufr @[intervox_receiver.scala 34:25]
    node _T_4 = eq(rising, UInt<1>("h1")) @[intervox_receiver.scala 39:18]
    node _T_5 = eq(trailing, UInt<1>("h1")) @[intervox_receiver.scala 39:39]
    node _T_6 = or(_T_4, _T_5) @[intervox_receiver.scala 39:27]
    when _T_6 : @[intervox_receiver.scala 39:48]
      change <= UInt<1>("h1") @[intervox_receiver.scala 40:17]
    node _T_7 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_receiver.scala 43:22]
    node _T_8 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 43:41]
    node _T_9 = and(_T_7, _T_8) @[intervox_receiver.scala 43:31]
    when _T_9 : @[intervox_receiver.scala 43:50]
      trailing <= UInt<1>("h0") @[intervox_receiver.scala 44:17]
      rising <= UInt<1>("h1") @[intervox_receiver.scala 45:17]
      change <= UInt<1>("h1") @[intervox_receiver.scala 46:17]
    node _T_10 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_receiver.scala 49:22]
    node _T_11 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 49:41]
    node _T_12 = and(_T_10, _T_11) @[intervox_receiver.scala 49:31]
    when _T_12 : @[intervox_receiver.scala 49:50]
      trailing <= UInt<1>("h1") @[intervox_receiver.scala 50:17]
      rising <= UInt<1>("h0") @[intervox_receiver.scala 51:17]
      change <= UInt<1>("h1") @[intervox_receiver.scala 52:17]
    node _T_13 = eq(trailing, UInt<1>("h1")) @[intervox_receiver.scala 55:19]
    when _T_13 : @[intervox_receiver.scala 55:27]
      trailing <= UInt<1>("h0") @[intervox_receiver.scala 55:37]
    node _T_14 = eq(rising, UInt<1>("h1")) @[intervox_receiver.scala 56:17]
    when _T_14 : @[intervox_receiver.scala 56:27]
      rising <= UInt<1>("h0") @[intervox_receiver.scala 56:37]
    node _T_15 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 58:17]
    when _T_15 : @[intervox_receiver.scala 58:25]
      reg change_REG : UInt, clock with :
        reset => (UInt<1>("h0"), change_REG) @[intervox_receiver.scala 59:26]
      change_REG <= UInt<1>("h0") @[intervox_receiver.scala 59:26]
      change <= change_REG @[intervox_receiver.scala 59:16]
    io.CHANGE <= change @[intervox_receiver.scala 62:13]
    io.TRAIL <= trailing @[intervox_receiver.scala 63:13]
    io.RISE <= rising @[intervox_receiver.scala 64:13]

  module i2s_Transmitter :
    input clock : Clock
    input reset : Reset
    output io : { flip CLK_IN : UInt<1>, flip DATA_IN : UInt<1>, flip NEXT : UInt<1>, BCLK : UInt<1>, LRCLK : UInt<1>, SDATA : UInt<1>}

    reg enable : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 232:26]
    reg bitCntr : UInt<6>, clock with :
      reset => (reset, UInt<6>("h0")) @[intervox_receiver.scala 233:26]
    reg lrclk : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 234:26]
    reg bclk : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 235:26]
    reg sdata : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 236:26]
    io.BCLK <= bclk @[intervox_receiver.scala 238:17]
    io.LRCLK <= lrclk @[intervox_receiver.scala 239:17]
    io.SDATA <= sdata @[intervox_receiver.scala 240:17]
    io.BCLK <= io.CLK_IN @[intervox_receiver.scala 241:17]
    inst BCLKEDGE of edgeDetector @[intervox_receiver.scala 243:37]
    BCLKEDGE.clock <= clock
    BCLKEDGE.reset <= reset
    BCLKEDGE.io.INPUT <= io.BCLK @[intervox_receiver.scala 244:31]
    node _T = eq(io.NEXT, UInt<1>("h1")) @[intervox_receiver.scala 246:18]
    when _T : @[intervox_receiver.scala 246:26]
      enable <= UInt<1>("h1") @[intervox_receiver.scala 247:17]
      bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 248:17]
    node _T_1 = eq(enable, UInt<1>("h1")) @[intervox_receiver.scala 251:17]
    when _T_1 : @[intervox_receiver.scala 251:25]
      node _T_2 = eq(BCLKEDGE.io.RISE, UInt<1>("h1")) @[intervox_receiver.scala 253:31]
      when _T_2 : @[intervox_receiver.scala 253:39]
        node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_receiver.scala 255:32]
        node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_receiver.scala 255:32]
        bitCntr <= _bitCntr_T_1 @[intervox_receiver.scala 255:21]
        node _T_3 = eq(bitCntr, UInt<1>("h0")) @[intervox_receiver.scala 257:26]
        when _T_3 : @[intervox_receiver.scala 257:34]
          lrclk <= UInt<1>("h1") @[intervox_receiver.scala 258:23]
        node _T_4 = eq(bitCntr, UInt<5>("h1f")) @[intervox_receiver.scala 261:26]
        when _T_4 : @[intervox_receiver.scala 261:35]
          lrclk <= UInt<1>("h0") @[intervox_receiver.scala 262:23]
        node _T_5 = eq(bitCntr, UInt<6>("h3f")) @[intervox_receiver.scala 265:26]
        when _T_5 : @[intervox_receiver.scala 265:35]
          enable <= UInt<1>("h0") @[intervox_receiver.scala 266:24]
          bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 267:25]
        node _T_6 = eq(io.DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 270:29]
        when _T_6 : @[intervox_receiver.scala 270:37]
          sdata <= UInt<1>("h1") @[intervox_receiver.scala 271:23]
        else :
          sdata <= UInt<1>("h0") @[intervox_receiver.scala 273:23]

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, CLK_DBUG : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LEDS : UInt<16>, BCLK : UInt<1>, LRCLK : UInt<1>, SDATA : UInt<1>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 294:29]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 295:29]
    io.LEDS <= clockRec.io.LEDS @[intervox_receiver.scala 296:21]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 297:21]
    io.CLK_DBUG <= UInt<1>("h0") @[intervox_receiver.scala 298:21]
    io.CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 299:21]
    io.DBUG1 <= clockRec.io.DBUG1 @[intervox_receiver.scala 300:21]
    io.DBUG <= clockRec.io.DBUG @[intervox_receiver.scala 301:21]
    inst i2sTrans of i2s_Transmitter @[intervox_receiver.scala 303:29]
    i2sTrans.clock <= clock
    i2sTrans.reset <= reset
    i2sTrans.io.CLK_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 304:29]
    i2sTrans.io.DATA_IN <= clockRec.io.DATA_OUT @[intervox_receiver.scala 305:29]
    i2sTrans.io.NEXT <= clockRec.io.DBUG1 @[intervox_receiver.scala 306:29]
    io.BCLK <= i2sTrans.io.BCLK @[intervox_receiver.scala 307:21]
    io.SDATA <= i2sTrans.io.SDATA @[intervox_receiver.scala 308:21]
    io.LRCLK <= i2sTrans.io.LRCLK @[intervox_receiver.scala 309:21]

