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
      change <= UInt<1>("h0") @[intervox_receiver.scala 59:16]
    io.CHANGE <= change @[intervox_receiver.scala 62:13]
    io.TRAIL <= trailing @[intervox_receiver.scala 63:13]
    io.RISE <= rising @[intervox_receiver.scala 64:13]

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
      change <= UInt<1>("h0") @[intervox_receiver.scala 59:16]
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
    reg dataOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 124:30]
    reg syncWord : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 125:30]
    reg zeroFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 126:30]
    reg syncFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 127:30]
    reg syncFlipped1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 128:30]
    reg syncFlipped2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 129:30]
    io.DATA_OUT <= dataOut @[intervox_receiver.scala 132:21]
    io.DBUG1 <= syncWord @[intervox_receiver.scala 133:21]
    io.LED <= leds @[intervox_receiver.scala 134:21]
    node _deltaCntr_T = add(deltaCntr, UInt<1>("h1")) @[intervox_receiver.scala 136:31]
    node _deltaCntr_T_1 = tail(_deltaCntr_T, 1) @[intervox_receiver.scala 136:31]
    deltaCntr <= _deltaCntr_T_1 @[intervox_receiver.scala 136:18]
    inst DATAEDGE of edgeDetector @[intervox_receiver.scala 138:38]
    DATAEDGE.clock <= clock
    DATAEDGE.reset <= reset
    DATAEDGE.io.INPUT <= io.DATA_IN @[intervox_receiver.scala 139:29]
    inst CLKEDGE of edgeDetector_1 @[intervox_receiver.scala 140:37]
    CLKEDGE.clock <= clock
    CLKEDGE.reset <= reset
    CLKEDGE.io.INPUT <= clkRec @[intervox_receiver.scala 141:29]
    io.CLK_OUT <= CLKEDGE.io.RISE @[intervox_receiver.scala 143:21]
    io.DATAREG <= BFR1.io.dataOut @[intervox_receiver.scala 144:21]
    io.DBUG <= DATAEDGE.io.CHANGE @[intervox_receiver.scala 145:21]
    node _T = eq(DATAEDGE.io.CHANGE, UInt<1>("h1")) @[intervox_receiver.scala 150:29]
    when _T : @[intervox_receiver.scala 150:37]
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
    node _T_2 = eq(CLKEDGE.io.RISE, UInt<1>("h1")) @[intervox_receiver.scala 169:26]
    when _T_2 : @[intervox_receiver.scala 169:34]
      node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_receiver.scala 170:28]
      node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_receiver.scala 170:28]
      bitCntr <= _bitCntr_T_1 @[intervox_receiver.scala 170:17]
      BFR.io.write <= UInt<1>("h1") @[intervox_receiver.scala 172:27]
      node _T_3 = eq(dataOut, UInt<1>("h1")) @[intervox_receiver.scala 173:22]
      when _T_3 : @[intervox_receiver.scala 173:30]
        node _BFR_io_dataIn_T = sub(UInt<6>("h3f"), bitCntr) @[intervox_receiver.scala 174:65]
        node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_receiver.scala 174:65]
        node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_1) @[intervox_receiver.scala 174:56]
        node _BFR_io_dataIn_T_3 = or(BFR.io.dataOut, _BFR_io_dataIn_T_2) @[intervox_receiver.scala 174:49]
        BFR.io.dataIn <= _BFR_io_dataIn_T_3 @[intervox_receiver.scala 174:31]
      else :
        node _BFR_io_dataIn_T_4 = sub(UInt<6>("h3f"), bitCntr) @[intervox_receiver.scala 176:65]
        node _BFR_io_dataIn_T_5 = tail(_BFR_io_dataIn_T_4, 1) @[intervox_receiver.scala 176:65]
        node _BFR_io_dataIn_T_6 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_5) @[intervox_receiver.scala 176:56]
        node _BFR_io_dataIn_T_7 = and(BFR.io.dataOut, _BFR_io_dataIn_T_6) @[intervox_receiver.scala 176:49]
        BFR.io.dataIn <= _BFR_io_dataIn_T_7 @[intervox_receiver.scala 176:31]
    node _T_4 = leq(deltaCntr, lastOne) @[intervox_receiver.scala 184:21]
    when _T_4 : @[intervox_receiver.scala 184:35]
      node _T_5 = eq(DATAEDGE.io.CHANGE, UInt<1>("h1")) @[intervox_receiver.scala 187:33]
      when _T_5 : @[intervox_receiver.scala 187:41]
        dataOut <= UInt<1>("h1") @[intervox_receiver.scala 190:21]
    node _T_6 = gt(deltaCntr, lastOne) @[intervox_receiver.scala 197:21]
    node _T_7 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 197:59]
    node _T_8 = lt(deltaCntr, _T_7) @[intervox_receiver.scala 197:47]
    node _T_9 = and(_T_6, _T_8) @[intervox_receiver.scala 197:34]
    when _T_9 : @[intervox_receiver.scala 197:68]
      dataOut <= UInt<1>("h0") @[intervox_receiver.scala 201:17]
      node _T_10 = eq(zeroFlipped, UInt<1>("h0")) @[intervox_receiver.scala 203:26]
      when _T_10 : @[intervox_receiver.scala 203:34]
        node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 206:23]
        clkRec <= _clkRec_T_1 @[intervox_receiver.scala 206:20]
        zeroFlipped <= UInt<1>("h1") @[intervox_receiver.scala 207:25]
    node _T_11 = eq(DATAEDGE.io.CHANGE, UInt<1>("h0")) @[intervox_receiver.scala 215:29]
    when _T_11 : @[intervox_receiver.scala 215:37]
      node _T_12 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 217:38]
      node _T_13 = geq(deltaCntr, _T_12) @[intervox_receiver.scala 217:25]
      when _T_13 : @[intervox_receiver.scala 217:47]
        node _T_14 = eq(syncFlipped, UInt<1>("h0")) @[intervox_receiver.scala 224:30]
        when _T_14 : @[intervox_receiver.scala 224:38]
          node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 226:27]
          clkRec <= _clkRec_T_2 @[intervox_receiver.scala 226:24]
          syncFlipped <= UInt<1>("h1") @[intervox_receiver.scala 227:29]
      node _T_15 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 230:38]
      node _T_16 = geq(deltaCntr, _T_15) @[intervox_receiver.scala 230:25]
      node _T_17 = eq(DATAEDGE.io.CHANGE, UInt<1>("h1")) @[intervox_receiver.scala 230:69]
      node _T_18 = and(_T_16, _T_17) @[intervox_receiver.scala 230:47]
      when _T_18 : @[intervox_receiver.scala 230:78]
        syncWord <= UInt<1>("h1") @[intervox_receiver.scala 237:22]
        node _T_19 = eq(syncFlipped1, UInt<1>("h0")) @[intervox_receiver.scala 238:31]
        when _T_19 : @[intervox_receiver.scala 238:39]
          node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 240:27]
          clkRec <= _clkRec_T_3 @[intervox_receiver.scala 240:24]
          syncFlipped1 <= UInt<1>("h1") @[intervox_receiver.scala 241:30]
          bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 243:25]
          BFR1.io.write <= UInt<1>("h1") @[intervox_receiver.scala 246:33]
          BFR1.io.dataIn <= BFR.io.dataOut @[intervox_receiver.scala 247:33]
          node _leds_T = dshr(BFR1.io.dataOut, UInt<6>("h2e")) @[intervox_receiver.scala 249:45]
          node _leds_T_1 = and(_leds_T, UInt<16>("hffff")) @[intervox_receiver.scala 249:54]
          leds <= _leds_T_1 @[intervox_receiver.scala 249:25]
    node _T_20 = gt(io.SW, UInt<1>("h0")) @[intervox_receiver.scala 255:16]
    when _T_20 : @[intervox_receiver.scala 255:22]
      node _T_21 = eq(io.BTN_C, UInt<1>("h1")) @[intervox_receiver.scala 256:23]
      when _T_21 : @[intervox_receiver.scala 256:31]
        lastOne <= io.SW @[intervox_receiver.scala 257:21]
        leds <= io.SW @[intervox_receiver.scala 258:21]

  module i2s_Transmitter :
    input clock : Clock
    input reset : Reset
    output io : { flip CLK_IN : UInt<1>, flip DATA_IN : UInt<64>, flip NEXT : UInt<1>, LRCLK : UInt<1>, SDATA : UInt<1>}

    reg bitCntrTrans : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 272:31]
    reg lrclk : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 273:26]
    reg sdataO : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 274:26]
    io.LRCLK <= lrclk @[intervox_receiver.scala 276:17]
    io.SDATA <= sdataO @[intervox_receiver.scala 277:17]
    node _T = eq(io.NEXT, UInt<1>("h1")) @[intervox_receiver.scala 280:18]
    when _T : @[intervox_receiver.scala 280:26]
      bitCntrTrans <= UInt<1>("h0") @[intervox_receiver.scala 281:22]
    node _T_1 = eq(io.CLK_IN, UInt<1>("h1")) @[intervox_receiver.scala 284:20]
    when _T_1 : @[intervox_receiver.scala 284:28]
      node _bitCntrTrans_T = add(bitCntrTrans, UInt<1>("h1")) @[intervox_receiver.scala 286:38]
      node _bitCntrTrans_T_1 = tail(_bitCntrTrans_T, 1) @[intervox_receiver.scala 286:38]
      bitCntrTrans <= _bitCntrTrans_T_1 @[intervox_receiver.scala 286:22]
      node _T_2 = eq(bitCntrTrans, UInt<1>("h0")) @[intervox_receiver.scala 288:27]
      when _T_2 : @[intervox_receiver.scala 288:35]
        lrclk <= UInt<1>("h1") @[intervox_receiver.scala 290:19]
      node _T_3 = gt(bitCntrTrans, UInt<5>("h1f")) @[intervox_receiver.scala 292:27]
      when _T_3 : @[intervox_receiver.scala 292:34]
        lrclk <= UInt<1>("h0") @[intervox_receiver.scala 294:19]
      node _T_4 = leq(bitCntrTrans, UInt<5>("h18")) @[intervox_receiver.scala 296:28]
      when _T_4 : @[intervox_receiver.scala 296:37]
        node _sdataO_T = sub(UInt<6>("h3c"), bitCntrTrans) @[intervox_receiver.scala 298:45]
        node _sdataO_T_1 = tail(_sdataO_T, 1) @[intervox_receiver.scala 298:45]
        node _sdataO_T_2 = dshr(io.DATA_IN, _sdataO_T_1) @[intervox_receiver.scala 298:39]
        node _sdataO_T_3 = bits(_sdataO_T_2, 0, 0) @[intervox_receiver.scala 298:39]
        node _sdataO_T_4 = and(UInt<1>("h1"), _sdataO_T_3) @[intervox_receiver.scala 298:27]
        sdataO <= _sdataO_T_4 @[intervox_receiver.scala 298:20]
      node _T_5 = gt(bitCntrTrans, UInt<5>("h18")) @[intervox_receiver.scala 300:28]
      node _T_6 = leq(bitCntrTrans, UInt<5>("h1f")) @[intervox_receiver.scala 300:52]
      node _T_7 = and(_T_5, _T_6) @[intervox_receiver.scala 300:36]
      when _T_7 : @[intervox_receiver.scala 300:61]
        sdataO <= UInt<1>("h0") @[intervox_receiver.scala 302:20]
      node _T_8 = leq(bitCntrTrans, UInt<6>("h38")) @[intervox_receiver.scala 304:28]
      node _T_9 = gt(bitCntrTrans, UInt<5>("h1f")) @[intervox_receiver.scala 304:53]
      node _T_10 = and(_T_8, _T_9) @[intervox_receiver.scala 304:37]
      when _T_10 : @[intervox_receiver.scala 304:61]
        node _sdataO_T_5 = add(bitCntrTrans, UInt<5>("h1f")) @[intervox_receiver.scala 306:61]
        node _sdataO_T_6 = tail(_sdataO_T_5, 1) @[intervox_receiver.scala 306:61]
        node _sdataO_T_7 = sub(UInt<6>("h24"), _sdataO_T_6) @[intervox_receiver.scala 306:45]
        node _sdataO_T_8 = tail(_sdataO_T_7, 1) @[intervox_receiver.scala 306:45]
        node _sdataO_T_9 = dshr(io.DATA_IN, _sdataO_T_8) @[intervox_receiver.scala 306:39]
        node _sdataO_T_10 = bits(_sdataO_T_9, 0, 0) @[intervox_receiver.scala 306:39]
        node _sdataO_T_11 = and(UInt<1>("h1"), _sdataO_T_10) @[intervox_receiver.scala 306:27]
        sdataO <= _sdataO_T_11 @[intervox_receiver.scala 306:20]
      node _T_11 = gt(bitCntrTrans, UInt<6>("h38")) @[intervox_receiver.scala 308:28]
      when _T_11 : @[intervox_receiver.scala 308:36]
        sdataO <= UInt<1>("h0") @[intervox_receiver.scala 310:20]

  module interVox_Receiver :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, CLK_DBUG : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LED : UInt<16>, flip SW : UInt<16>, BCLK : UInt<1>, LRCLK : UInt<1>, SDATA : UInt<1>, flip BTN_C : UInt<1>, flip BTN_D : UInt<1>, flip BTN_L : UInt<1>, flip BTN_R : UInt<1>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 334:29]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 335:29]
    clockRec.io.SW <= io.SW @[intervox_receiver.scala 336:29]
    clockRec.io.BTN_C <= io.BTN_C @[intervox_receiver.scala 337:29]
    io.LED <= clockRec.io.LED @[intervox_receiver.scala 338:21]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 339:21]
    io.CLK_DBUG <= UInt<1>("h0") @[intervox_receiver.scala 340:21]
    io.CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 341:21]
    io.DBUG1 <= clockRec.io.DBUG1 @[intervox_receiver.scala 342:21]
    io.DBUG <= clockRec.io.DBUG @[intervox_receiver.scala 343:21]
    inst i2sTrans of i2s_Transmitter @[intervox_receiver.scala 345:29]
    i2sTrans.clock <= clock
    i2sTrans.reset <= reset
    i2sTrans.io.CLK_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 346:29]
    i2sTrans.io.DATA_IN <= clockRec.io.DATAREG @[intervox_receiver.scala 347:29]
    i2sTrans.io.NEXT <= clockRec.io.DBUG1 @[intervox_receiver.scala 348:29]
    io.BCLK <= clockRec.io.CLK_OUT @[intervox_receiver.scala 349:21]
    io.SDATA <= i2sTrans.io.SDATA @[intervox_receiver.scala 350:21]
    io.LRCLK <= i2sTrans.io.LRCLK @[intervox_receiver.scala 351:21]

