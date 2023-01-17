circuit interVox_Receiver :
  module RWSmem :
    input clock : Clock
    input reset : Reset
    output io : { flip enable : UInt<1>, flip write : UInt<1>, flip addr : UInt<1>, flip dataIn : UInt<64>, dataOut : UInt<64>}

    smem mem : UInt<64> [1] @[intervox_receiver.scala 69:24]
    io.dataOut is invalid @[intervox_receiver.scala 71:14]
    when io.enable : @[intervox_receiver.scala 73:19]
      infer mport rdwrPort = mem[UInt<1>("h0")], clock @[intervox_receiver.scala 74:23]
      when io.write : @[intervox_receiver.scala 75:21]
        rdwrPort <= io.dataIn @[intervox_receiver.scala 75:32]
      else :
        io.dataOut <= rdwrPort @[intervox_receiver.scala 76:34]

  module RWSmem_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip enable : UInt<1>, flip write : UInt<1>, flip addr : UInt<1>, flip dataIn : UInt<64>, dataOut : UInt<64>}

    smem mem : UInt<64> [1] @[intervox_receiver.scala 69:24]
    io.dataOut is invalid @[intervox_receiver.scala 71:14]
    when io.enable : @[intervox_receiver.scala 73:19]
      infer mport rdwrPort = mem[UInt<1>("h0")], clock @[intervox_receiver.scala 74:23]
      when io.write : @[intervox_receiver.scala 75:21]
        rdwrPort <= io.dataIn @[intervox_receiver.scala 75:32]
      else :
        io.dataOut <= rdwrPort @[intervox_receiver.scala 76:34]

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
    node _T_4 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_receiver.scala 39:22]
    node _T_5 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 39:41]
    node _T_6 = and(_T_4, _T_5) @[intervox_receiver.scala 39:31]
    when _T_6 : @[intervox_receiver.scala 39:50]
      trailing <= UInt<1>("h0") @[intervox_receiver.scala 40:17]
      rising <= UInt<1>("h1") @[intervox_receiver.scala 41:17]
      change <= UInt<1>("h1") @[intervox_receiver.scala 42:17]
    node _T_7 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_receiver.scala 45:22]
    node _T_8 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 45:41]
    node _T_9 = and(_T_7, _T_8) @[intervox_receiver.scala 45:31]
    when _T_9 : @[intervox_receiver.scala 45:50]
      trailing <= UInt<1>("h1") @[intervox_receiver.scala 46:17]
      rising <= UInt<1>("h0") @[intervox_receiver.scala 47:17]
      change <= UInt<1>("h1") @[intervox_receiver.scala 48:17]
    node _T_10 = eq(trailing, UInt<1>("h1")) @[intervox_receiver.scala 51:19]
    when _T_10 : @[intervox_receiver.scala 51:28]
      trailing <= UInt<1>("h0") @[intervox_receiver.scala 51:38]
    node _T_11 = eq(rising, UInt<1>("h1")) @[intervox_receiver.scala 52:17]
    when _T_11 : @[intervox_receiver.scala 52:28]
      rising <= UInt<1>("h0") @[intervox_receiver.scala 52:38]
    node _T_12 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 53:17]
    when _T_12 : @[intervox_receiver.scala 53:28]
      change <= UInt<1>("h0") @[intervox_receiver.scala 53:38]
    io.CHANGE <= change @[intervox_receiver.scala 55:15]
    io.TRAIL <= trailing @[intervox_receiver.scala 56:15]
    io.RISE <= rising @[intervox_receiver.scala 57:15]

  module clock_Recovery :
    input clock : Clock
    input reset : Reset
    output io : { flip DATA_IN : UInt<1>, CLK_OUT : UInt<1>, DATA_OUT : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LED : UInt<16>, flip SW : UInt<16>, DATAREG : UInt<64>, flip BTN_C : UInt<1>}

    inst BFR of RWSmem @[intervox_receiver.scala 94:29]
    BFR.clock <= clock
    BFR.reset <= reset
    BFR.io.enable <= UInt<1>("h1") @[intervox_receiver.scala 95:27]
    BFR.io.addr <= UInt<1>("h1") @[intervox_receiver.scala 96:27]
    BFR.io.write <= UInt<1>("h0") @[intervox_receiver.scala 97:27]
    BFR.io.dataIn <= UInt<1>("h0") @[intervox_receiver.scala 98:27]
    inst BFR1 of RWSmem_1 @[intervox_receiver.scala 99:30]
    BFR1.clock <= clock
    BFR1.reset <= reset
    BFR1.io.enable <= UInt<1>("h1") @[intervox_receiver.scala 100:28]
    BFR1.io.addr <= UInt<1>("h1") @[intervox_receiver.scala 101:28]
    BFR1.io.write <= UInt<1>("h0") @[intervox_receiver.scala 102:28]
    BFR1.io.dataIn <= UInt<1>("h0") @[intervox_receiver.scala 103:28]
    reg rising : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 107:30]
    reg trailing : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 108:30]
    reg lastOne : UInt<8>, clock with :
      reset => (reset, UInt<8>("hf")) @[intervox_receiver.scala 109:30]
    reg leds : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[intervox_receiver.scala 110:30]
    reg overSampleCntr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[intervox_receiver.scala 111:32]
    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 112:30]
    reg deltaCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 113:30]
    reg bitCntr : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[intervox_receiver.scala 114:30]
    reg clkRec : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 115:30]
    reg written : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 116:30]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 117:30]
    reg dataOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 118:30]
    reg syncWord : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 119:30]
    reg zeroFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 120:30]
    reg syncFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 121:30]
    reg syncFlipped1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 122:30]
    reg syncFlipped2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 123:30]
    io.DATA_OUT <= dataOut @[intervox_receiver.scala 126:21]
    io.DBUG1 <= syncWord @[intervox_receiver.scala 127:21]
    io.LED <= leds @[intervox_receiver.scala 128:21]
    node _deltaCntr_T = add(deltaCntr, UInt<1>("h1")) @[intervox_receiver.scala 130:31]
    node _deltaCntr_T_1 = tail(_deltaCntr_T, 1) @[intervox_receiver.scala 130:31]
    deltaCntr <= _deltaCntr_T_1 @[intervox_receiver.scala 130:18]
    inst CLKEDGE of edgeDetector @[intervox_receiver.scala 132:37]
    CLKEDGE.clock <= clock
    CLKEDGE.reset <= reset
    CLKEDGE.io.INPUT <= clkRec @[intervox_receiver.scala 133:29]
    io.CLK_OUT <= clkRec @[intervox_receiver.scala 135:21]
    io.DATAREG <= BFR1.io.dataOut @[intervox_receiver.scala 136:21]
    io.DBUG <= change @[intervox_receiver.scala 137:21]
    node _T = eq(UInt<1>("h1"), io.DATA_IN) @[intervox_receiver.scala 143:23]
    when _T : @[intervox_receiver.scala 143:23]
      node _T_1 = lt(inBufr, UInt<2>("h3")) @[intervox_receiver.scala 145:25]
      when _T_1 : @[intervox_receiver.scala 145:31]
        node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 147:34]
        node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 147:34]
        inBufr <= _inBufr_T_1 @[intervox_receiver.scala 147:24]
    else :
      node _T_2 = eq(UInt<1>("h0"), io.DATA_IN) @[intervox_receiver.scala 143:23]
      when _T_2 : @[intervox_receiver.scala 143:23]
        node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 151:25]
        when _T_3 : @[intervox_receiver.scala 151:31]
          node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 153:34]
          node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 153:34]
          inBufr <= _inBufr_T_3 @[intervox_receiver.scala 153:24]
    node _T_4 = bits(inBufr, 0, 0) @[intervox_receiver.scala 157:17]
    node _T_5 = bits(inBufr, 1, 1) @[intervox_receiver.scala 157:31]
    node _T_6 = xor(_T_4, _T_5) @[intervox_receiver.scala 157:22]
    when _T_6 : @[intervox_receiver.scala 157:36]
      change <= UInt<1>("h1") @[intervox_receiver.scala 158:16]
    node _T_7 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 164:17]
    when _T_7 : @[intervox_receiver.scala 164:25]
      change <= UInt<1>("h0") @[intervox_receiver.scala 165:16]
      node _clkRec_T = not(clkRec) @[intervox_receiver.scala 167:28]
      clkRec <= _clkRec_T @[intervox_receiver.scala 167:25]
      deltaCntr <= UInt<1>("h0") @[intervox_receiver.scala 169:25]
      zeroFlipped <= UInt<1>("h0") @[intervox_receiver.scala 171:25]
      syncFlipped <= UInt<1>("h0") @[intervox_receiver.scala 172:25]
      syncFlipped1 <= UInt<1>("h0") @[intervox_receiver.scala 173:25]
    node _T_8 = eq(syncWord, UInt<1>("h1")) @[intervox_receiver.scala 176:19]
    when _T_8 : @[intervox_receiver.scala 176:27]
      syncWord <= UInt<1>("h0") @[intervox_receiver.scala 177:21]
      bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 178:21]
      BFR.io.write <= UInt<1>("h1") @[intervox_receiver.scala 180:24]
      BFR.io.dataIn <= UInt<1>("h0") @[intervox_receiver.scala 181:24]
    node _T_9 = eq(CLKEDGE.io.RISE, UInt<1>("h1")) @[intervox_receiver.scala 184:26]
    when _T_9 : @[intervox_receiver.scala 184:34]
      node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_receiver.scala 185:28]
      node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_receiver.scala 185:28]
      bitCntr <= _bitCntr_T_1 @[intervox_receiver.scala 185:17]
      BFR.io.write <= UInt<1>("h1") @[intervox_receiver.scala 187:27]
      node _T_10 = eq(dataOut, UInt<1>("h1")) @[intervox_receiver.scala 188:22]
      when _T_10 : @[intervox_receiver.scala 188:30]
        node _BFR_io_dataIn_T = sub(UInt<6>("h3f"), bitCntr) @[intervox_receiver.scala 189:65]
        node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_receiver.scala 189:65]
        node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_1) @[intervox_receiver.scala 189:56]
        node _BFR_io_dataIn_T_3 = or(BFR.io.dataOut, _BFR_io_dataIn_T_2) @[intervox_receiver.scala 189:49]
        BFR.io.dataIn <= _BFR_io_dataIn_T_3 @[intervox_receiver.scala 189:31]
      else :
        node _BFR_io_dataIn_T_4 = sub(UInt<6>("h3f"), bitCntr) @[intervox_receiver.scala 191:65]
        node _BFR_io_dataIn_T_5 = tail(_BFR_io_dataIn_T_4, 1) @[intervox_receiver.scala 191:65]
        node _BFR_io_dataIn_T_6 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_5) @[intervox_receiver.scala 191:56]
        node _BFR_io_dataIn_T_7 = and(BFR.io.dataOut, _BFR_io_dataIn_T_6) @[intervox_receiver.scala 191:49]
        BFR.io.dataIn <= _BFR_io_dataIn_T_7 @[intervox_receiver.scala 191:31]
    node _T_11 = leq(deltaCntr, lastOne) @[intervox_receiver.scala 199:21]
    when _T_11 : @[intervox_receiver.scala 199:35]
      node _T_12 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 202:21]
      when _T_12 : @[intervox_receiver.scala 202:29]
        dataOut <= UInt<1>("h1") @[intervox_receiver.scala 205:21]
    node _T_13 = gt(deltaCntr, lastOne) @[intervox_receiver.scala 212:21]
    node _T_14 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 212:59]
    node _T_15 = lt(deltaCntr, _T_14) @[intervox_receiver.scala 212:47]
    node _T_16 = and(_T_13, _T_15) @[intervox_receiver.scala 212:34]
    when _T_16 : @[intervox_receiver.scala 212:68]
      dataOut <= UInt<1>("h0") @[intervox_receiver.scala 216:17]
      node _T_17 = eq(zeroFlipped, UInt<1>("h0")) @[intervox_receiver.scala 218:26]
      when _T_17 : @[intervox_receiver.scala 218:34]
        node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 221:23]
        clkRec <= _clkRec_T_1 @[intervox_receiver.scala 221:20]
        zeroFlipped <= UInt<1>("h1") @[intervox_receiver.scala 222:25]
    node _T_18 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 231:34]
    node _T_19 = geq(deltaCntr, _T_18) @[intervox_receiver.scala 231:21]
    when _T_19 : @[intervox_receiver.scala 231:43]
      node _T_20 = eq(syncFlipped, UInt<1>("h0")) @[intervox_receiver.scala 238:26]
      when _T_20 : @[intervox_receiver.scala 238:34]
        node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 240:23]
        clkRec <= _clkRec_T_2 @[intervox_receiver.scala 240:20]
        syncFlipped <= UInt<1>("h1") @[intervox_receiver.scala 241:25]
    node _T_21 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 244:34]
    node _T_22 = geq(deltaCntr, _T_21) @[intervox_receiver.scala 244:21]
    when _T_22 : @[intervox_receiver.scala 244:43]
      syncWord <= UInt<1>("h1") @[intervox_receiver.scala 251:18]
      node _T_23 = eq(syncFlipped1, UInt<1>("h0")) @[intervox_receiver.scala 252:27]
      when _T_23 : @[intervox_receiver.scala 252:35]
        node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 254:23]
        clkRec <= _clkRec_T_3 @[intervox_receiver.scala 254:20]
        syncFlipped1 <= UInt<1>("h1") @[intervox_receiver.scala 255:26]
        bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 257:21]
        BFR1.io.write <= UInt<1>("h1") @[intervox_receiver.scala 260:29]
        BFR1.io.dataIn <= BFR.io.dataOut @[intervox_receiver.scala 261:29]
        node _leds_T = dshr(BFR1.io.dataOut, UInt<6>("h2e")) @[intervox_receiver.scala 263:41]
        node _leds_T_1 = and(_leds_T, UInt<16>("hffff")) @[intervox_receiver.scala 263:50]
        leds <= _leds_T_1 @[intervox_receiver.scala 263:21]
    node _T_24 = gt(io.SW, UInt<1>("h0")) @[intervox_receiver.scala 268:16]
    when _T_24 : @[intervox_receiver.scala 268:22]
      node _T_25 = eq(io.BTN_C, UInt<1>("h1")) @[intervox_receiver.scala 269:23]
      when _T_25 : @[intervox_receiver.scala 269:31]
        lastOne <= io.SW @[intervox_receiver.scala 270:21]
        leds <= io.SW @[intervox_receiver.scala 271:21]

  module edgeDetector_1 :
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
    node _T_4 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_receiver.scala 39:22]
    node _T_5 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 39:41]
    node _T_6 = and(_T_4, _T_5) @[intervox_receiver.scala 39:31]
    when _T_6 : @[intervox_receiver.scala 39:50]
      trailing <= UInt<1>("h0") @[intervox_receiver.scala 40:17]
      rising <= UInt<1>("h1") @[intervox_receiver.scala 41:17]
      change <= UInt<1>("h1") @[intervox_receiver.scala 42:17]
    node _T_7 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_receiver.scala 45:22]
    node _T_8 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 45:41]
    node _T_9 = and(_T_7, _T_8) @[intervox_receiver.scala 45:31]
    when _T_9 : @[intervox_receiver.scala 45:50]
      trailing <= UInt<1>("h1") @[intervox_receiver.scala 46:17]
      rising <= UInt<1>("h0") @[intervox_receiver.scala 47:17]
      change <= UInt<1>("h1") @[intervox_receiver.scala 48:17]
    node _T_10 = eq(trailing, UInt<1>("h1")) @[intervox_receiver.scala 51:19]
    when _T_10 : @[intervox_receiver.scala 51:28]
      trailing <= UInt<1>("h0") @[intervox_receiver.scala 51:38]
    node _T_11 = eq(rising, UInt<1>("h1")) @[intervox_receiver.scala 52:17]
    when _T_11 : @[intervox_receiver.scala 52:28]
      rising <= UInt<1>("h0") @[intervox_receiver.scala 52:38]
    node _T_12 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 53:17]
    when _T_12 : @[intervox_receiver.scala 53:28]
      change <= UInt<1>("h0") @[intervox_receiver.scala 53:38]
    io.CHANGE <= change @[intervox_receiver.scala 55:15]
    io.TRAIL <= trailing @[intervox_receiver.scala 56:15]
    io.RISE <= rising @[intervox_receiver.scala 57:15]

  module i2s_Transmitter :
    input clock : Clock
    input reset : Reset
    output io : { flip CLK_IN : UInt<1>, flip DATA_IN : UInt<64>, flip NEXT : UInt<1>, LRCLK : UInt<1>, SDATA : UInt<1>}

    reg bitCntrTrans : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 285:31]
    reg lrclk : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 286:26]
    reg sdataO : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 287:26]
    io.LRCLK <= lrclk @[intervox_receiver.scala 289:17]
    io.SDATA <= sdataO @[intervox_receiver.scala 290:17]
    inst CLK1EDGE of edgeDetector_1 @[intervox_receiver.scala 292:38]
    CLK1EDGE.clock <= clock
    CLK1EDGE.reset <= reset
    CLK1EDGE.io.INPUT <= io.CLK_IN @[intervox_receiver.scala 293:30]
    node _T = eq(io.NEXT, UInt<1>("h1")) @[intervox_receiver.scala 296:18]
    when _T : @[intervox_receiver.scala 296:26]
      bitCntrTrans <= UInt<1>("h0") @[intervox_receiver.scala 297:22]
    node _T_1 = eq(CLK1EDGE.io.RISE, UInt<1>("h1")) @[intervox_receiver.scala 300:27]
    when _T_1 : @[intervox_receiver.scala 300:35]
      node _bitCntrTrans_T = add(bitCntrTrans, UInt<1>("h1")) @[intervox_receiver.scala 302:38]
      node _bitCntrTrans_T_1 = tail(_bitCntrTrans_T, 1) @[intervox_receiver.scala 302:38]
      bitCntrTrans <= _bitCntrTrans_T_1 @[intervox_receiver.scala 302:22]
      node _T_2 = eq(bitCntrTrans, UInt<1>("h0")) @[intervox_receiver.scala 304:27]
      when _T_2 : @[intervox_receiver.scala 304:35]
        lrclk <= UInt<1>("h1") @[intervox_receiver.scala 306:19]
      node _T_3 = gt(bitCntrTrans, UInt<5>("h1f")) @[intervox_receiver.scala 308:27]
      when _T_3 : @[intervox_receiver.scala 308:34]
        lrclk <= UInt<1>("h0") @[intervox_receiver.scala 310:19]
      node _T_4 = leq(bitCntrTrans, UInt<5>("h18")) @[intervox_receiver.scala 312:28]
      when _T_4 : @[intervox_receiver.scala 312:37]
        node _sdataO_T = sub(UInt<6>("h3c"), bitCntrTrans) @[intervox_receiver.scala 314:45]
        node _sdataO_T_1 = tail(_sdataO_T, 1) @[intervox_receiver.scala 314:45]
        node _sdataO_T_2 = dshr(io.DATA_IN, _sdataO_T_1) @[intervox_receiver.scala 314:39]
        node _sdataO_T_3 = bits(_sdataO_T_2, 0, 0) @[intervox_receiver.scala 314:39]
        node _sdataO_T_4 = and(UInt<1>("h1"), _sdataO_T_3) @[intervox_receiver.scala 314:27]
        sdataO <= _sdataO_T_4 @[intervox_receiver.scala 314:20]
      node _T_5 = gt(bitCntrTrans, UInt<5>("h18")) @[intervox_receiver.scala 316:28]
      node _T_6 = leq(bitCntrTrans, UInt<5>("h1f")) @[intervox_receiver.scala 316:52]
      node _T_7 = and(_T_5, _T_6) @[intervox_receiver.scala 316:36]
      when _T_7 : @[intervox_receiver.scala 316:61]
        sdataO <= UInt<1>("h0") @[intervox_receiver.scala 318:20]
      node _T_8 = leq(bitCntrTrans, UInt<6>("h38")) @[intervox_receiver.scala 320:28]
      node _T_9 = gt(bitCntrTrans, UInt<5>("h1f")) @[intervox_receiver.scala 320:53]
      node _T_10 = and(_T_8, _T_9) @[intervox_receiver.scala 320:37]
      when _T_10 : @[intervox_receiver.scala 320:61]
        node _sdataO_T_5 = add(bitCntrTrans, UInt<5>("h1f")) @[intervox_receiver.scala 322:61]
        node _sdataO_T_6 = tail(_sdataO_T_5, 1) @[intervox_receiver.scala 322:61]
        node _sdataO_T_7 = sub(UInt<6>("h24"), _sdataO_T_6) @[intervox_receiver.scala 322:45]
        node _sdataO_T_8 = tail(_sdataO_T_7, 1) @[intervox_receiver.scala 322:45]
        node _sdataO_T_9 = dshr(io.DATA_IN, _sdataO_T_8) @[intervox_receiver.scala 322:39]
        node _sdataO_T_10 = bits(_sdataO_T_9, 0, 0) @[intervox_receiver.scala 322:39]
        node _sdataO_T_11 = and(UInt<1>("h1"), _sdataO_T_10) @[intervox_receiver.scala 322:27]
        sdataO <= _sdataO_T_11 @[intervox_receiver.scala 322:20]
      node _T_11 = gt(bitCntrTrans, UInt<6>("h38")) @[intervox_receiver.scala 324:28]
      when _T_11 : @[intervox_receiver.scala 324:36]
        sdataO <= UInt<1>("h0") @[intervox_receiver.scala 326:20]

  module interVox_Receiver :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, CLK_DBUG : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LED : UInt<16>, flip SW : UInt<16>, BCLK : UInt<1>, LRCLK : UInt<1>, SDATA : UInt<1>, flip BTN_C : UInt<1>, flip BTN_D : UInt<1>, flip BTN_L : UInt<1>, flip BTN_R : UInt<1>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 350:29]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 351:29]
    clockRec.io.SW <= io.SW @[intervox_receiver.scala 352:29]
    clockRec.io.BTN_C <= io.BTN_C @[intervox_receiver.scala 353:29]
    io.LED <= clockRec.io.LED @[intervox_receiver.scala 354:21]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 355:21]
    io.CLK_DBUG <= UInt<1>("h0") @[intervox_receiver.scala 356:21]
    io.CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 357:21]
    io.DBUG1 <= clockRec.io.DBUG1 @[intervox_receiver.scala 358:21]
    io.DBUG <= clockRec.io.DBUG @[intervox_receiver.scala 359:21]
    inst i2sTrans of i2s_Transmitter @[intervox_receiver.scala 361:29]
    i2sTrans.clock <= clock
    i2sTrans.reset <= reset
    i2sTrans.io.CLK_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 362:29]
    i2sTrans.io.DATA_IN <= clockRec.io.DATAREG @[intervox_receiver.scala 363:29]
    i2sTrans.io.NEXT <= clockRec.io.DBUG1 @[intervox_receiver.scala 364:29]
    io.BCLK <= clockRec.io.CLK_OUT @[intervox_receiver.scala 365:21]
    io.SDATA <= i2sTrans.io.SDATA @[intervox_receiver.scala 366:21]
    io.LRCLK <= i2sTrans.io.LRCLK @[intervox_receiver.scala 367:21]

