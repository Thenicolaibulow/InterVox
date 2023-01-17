circuit interVox_Receiver :
  module RWSmem :
    input clock : Clock
    input reset : Reset
    output io : { flip enable : UInt<1>, flip write : UInt<1>, flip addr : UInt<1>, flip dataIn : UInt<64>, dataOut : UInt<64>}

    smem mem : UInt<64> [1] @[intervox_receiver.scala 76:24]
    io.dataOut is invalid @[intervox_receiver.scala 78:14]
    when io.enable : @[intervox_receiver.scala 80:19]
      infer mport rdwrPort = mem[UInt<1>("h0")], clock @[intervox_receiver.scala 81:23]
      when io.write : @[intervox_receiver.scala 82:21]
        rdwrPort <= io.dataIn @[intervox_receiver.scala 82:32]
      else :
        io.dataOut <= rdwrPort @[intervox_receiver.scala 83:34]

  module RWSmem_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip enable : UInt<1>, flip write : UInt<1>, flip addr : UInt<1>, flip dataIn : UInt<64>, dataOut : UInt<64>}

    smem mem : UInt<64> [1] @[intervox_receiver.scala 76:24]
    io.dataOut is invalid @[intervox_receiver.scala 78:14]
    when io.enable : @[intervox_receiver.scala 80:19]
      infer mport rdwrPort = mem[UInt<1>("h0")], clock @[intervox_receiver.scala 81:23]
      when io.write : @[intervox_receiver.scala 82:21]
        rdwrPort <= io.dataIn @[intervox_receiver.scala 82:32]
      else :
        io.dataOut <= rdwrPort @[intervox_receiver.scala 83:34]

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
    node _T_4 = bits(inBufr, 0, 0) @[intervox_receiver.scala 39:17]
    node _T_5 = bits(inBufr, 1, 1) @[intervox_receiver.scala 39:31]
    node _T_6 = xor(_T_4, _T_5) @[intervox_receiver.scala 39:22]
    when _T_6 : @[intervox_receiver.scala 39:36]
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

  module clock_Recovery :
    input clock : Clock
    input reset : Reset
    output io : { flip DATA_IN : UInt<1>, CLK_OUT : UInt<1>, DATA_OUT : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LED : UInt<16>, flip SW : UInt<16>, DATAREG : UInt<64>, flip BTN_C : UInt<1>}

    inst BFR of RWSmem @[intervox_receiver.scala 101:29]
    BFR.clock <= clock
    BFR.reset <= reset
    BFR.io.enable <= UInt<1>("h1") @[intervox_receiver.scala 102:27]
    BFR.io.addr <= UInt<1>("h1") @[intervox_receiver.scala 103:27]
    BFR.io.write <= UInt<1>("h0") @[intervox_receiver.scala 104:27]
    BFR.io.dataIn <= UInt<1>("h0") @[intervox_receiver.scala 105:27]
    inst BFR1 of RWSmem_1 @[intervox_receiver.scala 106:30]
    BFR1.clock <= clock
    BFR1.reset <= reset
    BFR1.io.enable <= UInt<1>("h1") @[intervox_receiver.scala 107:28]
    BFR1.io.addr <= UInt<1>("h1") @[intervox_receiver.scala 108:28]
    BFR1.io.write <= UInt<1>("h0") @[intervox_receiver.scala 109:28]
    BFR1.io.dataIn <= UInt<1>("h0") @[intervox_receiver.scala 110:28]
    reg rising : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 114:30]
    reg trailing : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 115:30]
    reg lastOne : UInt<8>, clock with :
      reset => (reset, UInt<8>("hf")) @[intervox_receiver.scala 116:30]
    reg leds : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[intervox_receiver.scala 117:30]
    reg overSampleCntr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[intervox_receiver.scala 118:32]
    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 119:30]
    reg deltaCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 120:30]
    reg bitCntr : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[intervox_receiver.scala 121:30]
    reg clkRec : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 122:30]
    reg written : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 123:30]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 124:30]
    reg dataOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 125:30]
    reg syncWord : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 126:30]
    reg zeroFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 127:30]
    reg syncFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 128:30]
    reg syncFlipped1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 129:30]
    reg syncFlipped2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 130:30]
    io.CLK_OUT <= clkRec @[intervox_receiver.scala 132:21]
    io.DATA_OUT <= dataOut @[intervox_receiver.scala 133:21]
    io.DBUG <= change @[intervox_receiver.scala 134:21]
    io.DBUG1 <= syncWord @[intervox_receiver.scala 135:21]
    io.LED <= leds @[intervox_receiver.scala 136:21]
    io.DATAREG <= BFR1.io.dataOut @[intervox_receiver.scala 137:21]
    node _deltaCntr_T = add(deltaCntr, UInt<1>("h1")) @[intervox_receiver.scala 139:31]
    node _deltaCntr_T_1 = tail(_deltaCntr_T, 1) @[intervox_receiver.scala 139:31]
    deltaCntr <= _deltaCntr_T_1 @[intervox_receiver.scala 139:18]
    inst DATAEDGE of edgeDetector @[intervox_receiver.scala 141:38]
    DATAEDGE.clock <= clock
    DATAEDGE.reset <= reset
    DATAEDGE.io.INPUT <= io.DATA_IN @[intervox_receiver.scala 142:29]
    change <= DATAEDGE.io.CHANGE @[intervox_receiver.scala 143:29]
    node _T = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 148:17]
    when _T : @[intervox_receiver.scala 148:25]
      reg change_REG : UInt, clock with :
        reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 150:34]
      change_REG <= UInt<1>("h0") @[intervox_receiver.scala 150:34]
      reg change_REG_1 : UInt, clock with :
        reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 150:26]
      change_REG_1 <= change_REG @[intervox_receiver.scala 150:26]
      change <= change_REG_1 @[intervox_receiver.scala 150:16]
      node _clkRec_T = not(clkRec) @[intervox_receiver.scala 152:28]
      clkRec <= _clkRec_T @[intervox_receiver.scala 152:25]
      deltaCntr <= UInt<1>("h0") @[intervox_receiver.scala 154:25]
      zeroFlipped <= UInt<1>("h0") @[intervox_receiver.scala 156:25]
      syncFlipped <= UInt<1>("h0") @[intervox_receiver.scala 157:25]
      syncFlipped1 <= UInt<1>("h0") @[intervox_receiver.scala 158:25]
    node _T_1 = eq(syncWord, UInt<1>("h1")) @[intervox_receiver.scala 161:19]
    when _T_1 : @[intervox_receiver.scala 161:27]
      syncWord <= UInt<1>("h0") @[intervox_receiver.scala 162:21]
      bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 163:21]
      BFR.io.write <= UInt<1>("h1") @[intervox_receiver.scala 165:24]
      BFR.io.dataIn <= UInt<1>("h0") @[intervox_receiver.scala 166:24]
    node _T_2 = eq(clkRec, UInt<1>("h1")) @[intervox_receiver.scala 169:17]
    when _T_2 : @[intervox_receiver.scala 169:25]
      node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_receiver.scala 170:28]
      node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_receiver.scala 170:28]
      bitCntr <= _bitCntr_T_1 @[intervox_receiver.scala 170:17]
      written <= UInt<1>("h0") @[intervox_receiver.scala 171:17]
    node _T_3 = leq(deltaCntr, lastOne) @[intervox_receiver.scala 177:21]
    when _T_3 : @[intervox_receiver.scala 177:35]
      node _T_4 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 180:21]
      when _T_4 : @[intervox_receiver.scala 180:29]
        node _T_5 = eq(written, UInt<1>("h0")) @[intervox_receiver.scala 183:26]
        when _T_5 : @[intervox_receiver.scala 183:34]
          BFR.io.write <= UInt<1>("h1") @[intervox_receiver.scala 185:35]
          node _BFR_io_dataIn_T = sub(UInt<6>("h3f"), bitCntr) @[intervox_receiver.scala 186:69]
          node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_receiver.scala 186:69]
          node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_1) @[intervox_receiver.scala 186:60]
          node _BFR_io_dataIn_T_3 = or(BFR.io.dataOut, _BFR_io_dataIn_T_2) @[intervox_receiver.scala 186:53]
          BFR.io.dataIn <= _BFR_io_dataIn_T_3 @[intervox_receiver.scala 186:35]
          dataOut <= UInt<1>("h1") @[intervox_receiver.scala 187:25]
    node _T_6 = gt(deltaCntr, lastOne) @[intervox_receiver.scala 197:21]
    node _T_7 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 197:59]
    node _T_8 = lt(deltaCntr, _T_7) @[intervox_receiver.scala 197:47]
    node _T_9 = and(_T_6, _T_8) @[intervox_receiver.scala 197:34]
    when _T_9 : @[intervox_receiver.scala 197:68]
      node _T_10 = eq(written, UInt<1>("h0")) @[intervox_receiver.scala 200:22]
      when _T_10 : @[intervox_receiver.scala 200:30]
        BFR.io.write <= UInt<1>("h1") @[intervox_receiver.scala 202:31]
        node _BFR_io_dataIn_T_4 = sub(UInt<6>("h3f"), bitCntr) @[intervox_receiver.scala 203:65]
        node _BFR_io_dataIn_T_5 = tail(_BFR_io_dataIn_T_4, 1) @[intervox_receiver.scala 203:65]
        node _BFR_io_dataIn_T_6 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_5) @[intervox_receiver.scala 203:56]
        node _BFR_io_dataIn_T_7 = and(BFR.io.dataOut, _BFR_io_dataIn_T_6) @[intervox_receiver.scala 203:49]
        BFR.io.dataIn <= _BFR_io_dataIn_T_7 @[intervox_receiver.scala 203:31]
        dataOut <= UInt<1>("h0") @[intervox_receiver.scala 205:21]
      node _T_11 = eq(zeroFlipped, UInt<1>("h0")) @[intervox_receiver.scala 207:26]
      when _T_11 : @[intervox_receiver.scala 207:34]
        node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 210:23]
        clkRec <= _clkRec_T_1 @[intervox_receiver.scala 210:20]
        zeroFlipped <= UInt<1>("h1") @[intervox_receiver.scala 211:25]
    node _T_12 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 219:17]
    when _T_12 : @[intervox_receiver.scala 219:25]
      node _T_13 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 221:38]
      node _T_14 = geq(deltaCntr, _T_13) @[intervox_receiver.scala 221:25]
      when _T_14 : @[intervox_receiver.scala 221:47]
        node _T_15 = eq(syncFlipped, UInt<1>("h0")) @[intervox_receiver.scala 228:30]
        when _T_15 : @[intervox_receiver.scala 228:38]
          node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 230:27]
          clkRec <= _clkRec_T_2 @[intervox_receiver.scala 230:24]
          syncFlipped <= UInt<1>("h1") @[intervox_receiver.scala 231:29]
      node _T_16 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 234:38]
      node _T_17 = geq(deltaCntr, _T_16) @[intervox_receiver.scala 234:25]
      node _T_18 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 234:57]
      node _T_19 = and(_T_17, _T_18) @[intervox_receiver.scala 234:47]
      when _T_19 : @[intervox_receiver.scala 234:66]
        syncWord <= UInt<1>("h1") @[intervox_receiver.scala 241:22]
        node _T_20 = eq(syncFlipped1, UInt<1>("h0")) @[intervox_receiver.scala 242:31]
        when _T_20 : @[intervox_receiver.scala 242:39]
          node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 244:27]
          clkRec <= _clkRec_T_3 @[intervox_receiver.scala 244:24]
          syncFlipped1 <= UInt<1>("h1") @[intervox_receiver.scala 245:30]
          bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 247:25]
          BFR1.io.write <= UInt<1>("h1") @[intervox_receiver.scala 250:33]
          BFR1.io.dataIn <= BFR.io.dataOut @[intervox_receiver.scala 251:33]
          node _leds_T = dshr(BFR1.io.dataOut, UInt<6>("h2e")) @[intervox_receiver.scala 253:45]
          node _leds_T_1 = and(_leds_T, UInt<16>("hffff")) @[intervox_receiver.scala 253:54]
          leds <= _leds_T_1 @[intervox_receiver.scala 253:25]
    node _T_21 = gt(io.SW, UInt<1>("h0")) @[intervox_receiver.scala 259:16]
    when _T_21 : @[intervox_receiver.scala 259:22]
      node _T_22 = eq(io.BTN_C, UInt<1>("h1")) @[intervox_receiver.scala 260:23]
      when _T_22 : @[intervox_receiver.scala 260:31]
        lastOne <= io.SW @[intervox_receiver.scala 261:21]
        leds <= io.SW @[intervox_receiver.scala 262:21]

  module i2s_Transmitter :
    input clock : Clock
    input reset : Reset
    output io : { flip CLK_IN : UInt<1>, flip DATA_IN : UInt<64>, flip NEXT : UInt<1>, BCLK : UInt<1>, LRCLK : UInt<1>, SDATA : UInt<1>}

    reg bitCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 277:26]
    reg lrclk : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 278:26]
    reg sdataO : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 279:26]
    reg sdata : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[intervox_receiver.scala 280:26]
    sdata <= io.DATA_IN @[intervox_receiver.scala 282:17]
    io.LRCLK <= lrclk @[intervox_receiver.scala 283:17]
    io.SDATA <= sdataO @[intervox_receiver.scala 284:17]
    io.BCLK <= io.CLK_IN @[intervox_receiver.scala 285:17]
    node _T = eq(io.CLK_IN, UInt<1>("h1")) @[intervox_receiver.scala 292:20]
    when _T : @[intervox_receiver.scala 292:28]
      node _T_1 = gt(bitCntr, UInt<6>("h3f")) @[intervox_receiver.scala 294:22]
      when _T_1 : @[intervox_receiver.scala 294:29]
        bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 294:38]
      node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_receiver.scala 297:28]
      node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_receiver.scala 297:28]
      bitCntr <= _bitCntr_T_1 @[intervox_receiver.scala 297:17]
      node _T_2 = eq(bitCntr, UInt<1>("h0")) @[intervox_receiver.scala 299:22]
      when _T_2 : @[intervox_receiver.scala 299:30]
        lrclk <= UInt<1>("h1") @[intervox_receiver.scala 301:19]
      node _T_3 = gt(bitCntr, UInt<5>("h1f")) @[intervox_receiver.scala 303:22]
      when _T_3 : @[intervox_receiver.scala 303:29]
        lrclk <= UInt<1>("h0") @[intervox_receiver.scala 305:19]
      node _T_4 = leq(bitCntr, UInt<5>("h18")) @[intervox_receiver.scala 307:23]
      when _T_4 : @[intervox_receiver.scala 307:32]
        sdataO <= UInt<1>("h1") @[intervox_receiver.scala 309:20]
      node _T_5 = gt(bitCntr, UInt<5>("h18")) @[intervox_receiver.scala 311:23]
      node _T_6 = leq(bitCntr, UInt<5>("h1f")) @[intervox_receiver.scala 311:42]
      node _T_7 = and(_T_5, _T_6) @[intervox_receiver.scala 311:31]
      when _T_7 : @[intervox_receiver.scala 311:51]
        sdataO <= UInt<1>("h0") @[intervox_receiver.scala 313:20]
      node _T_8 = leq(bitCntr, UInt<6>("h38")) @[intervox_receiver.scala 315:23]
      node _T_9 = gt(bitCntr, UInt<5>("h1f")) @[intervox_receiver.scala 315:43]
      node _T_10 = and(_T_8, _T_9) @[intervox_receiver.scala 315:32]
      when _T_10 : @[intervox_receiver.scala 315:51]
        sdataO <= UInt<1>("h1") @[intervox_receiver.scala 317:20]
      node _T_11 = gt(bitCntr, UInt<6>("h38")) @[intervox_receiver.scala 319:23]
      when _T_11 : @[intervox_receiver.scala 319:31]
        sdataO <= UInt<1>("h0") @[intervox_receiver.scala 321:20]

  module interVox_Receiver :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, CLK_DBUG : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LED : UInt<16>, flip SW : UInt<16>, BCLK : UInt<1>, LRCLK : UInt<1>, SDATA : UInt<1>, flip BTN_C : UInt<1>, flip BTN_D : UInt<1>, flip BTN_L : UInt<1>, flip BTN_R : UInt<1>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 345:29]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 346:29]
    clockRec.io.SW <= io.SW @[intervox_receiver.scala 347:29]
    clockRec.io.BTN_C <= io.BTN_C @[intervox_receiver.scala 348:29]
    io.LED <= clockRec.io.LED @[intervox_receiver.scala 349:21]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 350:21]
    io.CLK_DBUG <= UInt<1>("h0") @[intervox_receiver.scala 351:21]
    io.CLK_REC <= clockRec.io.CLK_OUT @[intervox_receiver.scala 352:21]
    io.DBUG1 <= clockRec.io.DBUG1 @[intervox_receiver.scala 353:21]
    io.DBUG <= clockRec.io.DBUG @[intervox_receiver.scala 354:21]
    inst i2sTrans of i2s_Transmitter @[intervox_receiver.scala 356:29]
    i2sTrans.clock <= clock
    i2sTrans.reset <= reset
    i2sTrans.io.CLK_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 357:29]
    i2sTrans.io.DATA_IN <= clockRec.io.DATAREG @[intervox_receiver.scala 358:29]
    i2sTrans.io.NEXT <= clockRec.io.DBUG1 @[intervox_receiver.scala 359:29]
    io.BCLK <= i2sTrans.io.BCLK @[intervox_receiver.scala 360:21]
    io.SDATA <= i2sTrans.io.SDATA @[intervox_receiver.scala 361:21]
    io.LRCLK <= i2sTrans.io.LRCLK @[intervox_receiver.scala 362:21]

