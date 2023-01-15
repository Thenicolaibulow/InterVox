circuit interVox_Reciever :
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

  module clock_Recovery :
    input clock : Clock
    input reset : Reset
    output io : { flip DATA_IN : UInt<1>, CLK_OUT : UInt<1>, DATA_OUT : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LEDS : UInt<16>, DATAREG : UInt<64>}

    inst BFR of RWSmem @[intervox_receiver.scala 98:29]
    BFR.clock <= clock
    BFR.reset <= reset
    BFR.io.enable <= UInt<1>("h1") @[intervox_receiver.scala 100:27]
    BFR.io.addr <= UInt<1>("h1") @[intervox_receiver.scala 101:27]
    BFR.io.write <= UInt<1>("h0") @[intervox_receiver.scala 102:27]
    BFR.io.dataIn <= UInt<1>("h0") @[intervox_receiver.scala 103:27]
    reg rising : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 107:30]
    reg trailing : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 108:30]
    reg lastOne : UInt<8>, clock with :
      reset => (reset, UInt<8>("hf")) @[intervox_receiver.scala 109:30]
    reg overSampleCntr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[intervox_receiver.scala 110:32]
    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 111:30]
    reg deltaCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 112:30]
    reg bitCntr : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[intervox_receiver.scala 113:30]
    reg clkRec : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 114:30]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 115:30]
    reg dataOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 116:30]
    reg dataReg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[intervox_receiver.scala 117:30]
    reg syncWord : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 118:30]
    reg zeroFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 119:30]
    reg syncFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 120:30]
    reg syncFlipped1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 121:30]
    reg syncFlipped2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 122:30]
    io.CLK_OUT <= clkRec @[intervox_receiver.scala 124:21]
    io.DATA_OUT <= dataOut @[intervox_receiver.scala 125:21]
    io.DBUG <= change @[intervox_receiver.scala 126:21]
    io.DBUG1 <= syncWord @[intervox_receiver.scala 127:21]
    io.LEDS <= lastOne @[intervox_receiver.scala 128:21]
    io.DATAREG <= dataReg @[intervox_receiver.scala 129:21]
    node _deltaCntr_T = add(deltaCntr, UInt<1>("h1")) @[intervox_receiver.scala 131:31]
    node _deltaCntr_T_1 = tail(_deltaCntr_T, 1) @[intervox_receiver.scala 131:31]
    deltaCntr <= _deltaCntr_T_1 @[intervox_receiver.scala 131:18]
    inst DATAEDGE of edgeDetector @[intervox_receiver.scala 133:38]
    DATAEDGE.clock <= clock
    DATAEDGE.reset <= reset
    DATAEDGE.io.INPUT <= io.DATA_IN @[intervox_receiver.scala 134:29]
    change <= DATAEDGE.io.CHANGE @[intervox_receiver.scala 135:29]
    inst CLKREC_EDGE of edgeDetector_1 @[intervox_receiver.scala 137:41]
    CLKREC_EDGE.clock <= clock
    CLKREC_EDGE.reset <= reset
    CLKREC_EDGE.io.INPUT <= io.DATA_IN @[intervox_receiver.scala 138:32]
    node _T = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 143:17]
    when _T : @[intervox_receiver.scala 143:25]
      reg change_REG : UInt, clock with :
        reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 145:34]
      change_REG <= UInt<1>("h0") @[intervox_receiver.scala 145:34]
      reg change_REG_1 : UInt, clock with :
        reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 145:26]
      change_REG_1 <= change_REG @[intervox_receiver.scala 145:26]
      change <= change_REG_1 @[intervox_receiver.scala 145:16]
      node _clkRec_T = not(clkRec) @[intervox_receiver.scala 147:28]
      clkRec <= _clkRec_T @[intervox_receiver.scala 147:25]
      deltaCntr <= UInt<1>("h0") @[intervox_receiver.scala 149:25]
      zeroFlipped <= UInt<1>("h0") @[intervox_receiver.scala 151:25]
      syncFlipped <= UInt<1>("h0") @[intervox_receiver.scala 152:25]
      syncFlipped1 <= UInt<1>("h0") @[intervox_receiver.scala 153:25]
      node _T_1 = eq(syncWord, UInt<1>("h1")) @[intervox_receiver.scala 154:23]
      when _T_1 : @[intervox_receiver.scala 154:31]
        syncWord <= UInt<1>("h0") @[intervox_receiver.scala 155:25]
        bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 156:25]
        dataReg <= BFR.io.dataOut @[intervox_receiver.scala 157:25]
        BFR.io.write <= UInt<1>("h1") @[intervox_receiver.scala 159:28]
        BFR.io.dataIn <= UInt<1>("h0") @[intervox_receiver.scala 160:28]
    node _T_2 = eq(CLKREC_EDGE.io.RISE, UInt<1>("h1")) @[intervox_receiver.scala 164:30]
    when _T_2 : @[intervox_receiver.scala 164:38]
      node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_receiver.scala 165:28]
      node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_receiver.scala 165:28]
      bitCntr <= _bitCntr_T_1 @[intervox_receiver.scala 165:17]
    node _T_3 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 171:33]
    node _T_4 = tail(_T_3, 1) @[intervox_receiver.scala 171:33]
    node _T_5 = leq(deltaCntr, _T_4) @[intervox_receiver.scala 171:21]
    when _T_5 : @[intervox_receiver.scala 171:41]
      node _T_6 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 174:21]
      when _T_6 : @[intervox_receiver.scala 174:29]
        dataOut <= UInt<1>("h1") @[intervox_receiver.scala 177:21]
        BFR.io.write <= UInt<1>("h1") @[intervox_receiver.scala 180:31]
        node _BFR_io_dataIn_T = sub(UInt<7>("h40"), bitCntr) @[intervox_receiver.scala 181:65]
        node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_receiver.scala 181:65]
        node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_1) @[intervox_receiver.scala 181:56]
        node _BFR_io_dataIn_T_3 = add(BFR.io.dataOut, _BFR_io_dataIn_T_2) @[intervox_receiver.scala 181:49]
        node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_receiver.scala 181:49]
        BFR.io.dataIn <= _BFR_io_dataIn_T_4 @[intervox_receiver.scala 181:31]
    node _T_7 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 191:32]
    node _T_8 = tail(_T_7, 1) @[intervox_receiver.scala 191:32]
    node _T_9 = gt(deltaCntr, _T_8) @[intervox_receiver.scala 191:21]
    node _T_10 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 191:65]
    node _T_11 = add(_T_10, UInt<2>("h2")) @[intervox_receiver.scala 191:72]
    node _T_12 = tail(_T_11, 1) @[intervox_receiver.scala 191:72]
    node _T_13 = lt(deltaCntr, _T_12) @[intervox_receiver.scala 191:53]
    node _T_14 = and(_T_9, _T_13) @[intervox_receiver.scala 191:40]
    when _T_14 : @[intervox_receiver.scala 191:80]
      node _T_15 = eq(zeroFlipped, UInt<1>("h0")) @[intervox_receiver.scala 194:26]
      when _T_15 : @[intervox_receiver.scala 194:34]
        node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 197:23]
        clkRec <= _clkRec_T_1 @[intervox_receiver.scala 197:20]
        zeroFlipped <= UInt<1>("h1") @[intervox_receiver.scala 198:25]
        BFR.io.write <= UInt<1>("h1") @[intervox_receiver.scala 200:31]
        node _BFR_io_dataIn_T_5 = sub(UInt<7>("h40"), bitCntr) @[intervox_receiver.scala 201:65]
        node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_receiver.scala 201:65]
        node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_6) @[intervox_receiver.scala 201:56]
        node _BFR_io_dataIn_T_8 = add(BFR.io.dataOut, _BFR_io_dataIn_T_7) @[intervox_receiver.scala 201:49]
        node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_receiver.scala 201:49]
        BFR.io.dataIn <= _BFR_io_dataIn_T_9 @[intervox_receiver.scala 201:31]
      dataOut <= UInt<1>("h0") @[intervox_receiver.scala 204:17]
    node _T_16 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 211:17]
    when _T_16 : @[intervox_receiver.scala 211:25]
      node _T_17 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 213:38]
      node _T_18 = add(_T_17, UInt<2>("h2")) @[intervox_receiver.scala 213:45]
      node _T_19 = tail(_T_18, 1) @[intervox_receiver.scala 213:45]
      node _T_20 = eq(deltaCntr, _T_19) @[intervox_receiver.scala 213:24]
      when _T_20 : @[intervox_receiver.scala 213:52]
        node _T_21 = eq(syncFlipped, UInt<1>("h0")) @[intervox_receiver.scala 220:30]
        when _T_21 : @[intervox_receiver.scala 220:38]
          node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 222:27]
          clkRec <= _clkRec_T_2 @[intervox_receiver.scala 222:24]
          syncFlipped <= UInt<1>("h1") @[intervox_receiver.scala 223:29]
      node _T_22 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 226:38]
      node _T_23 = eq(deltaCntr, _T_22) @[intervox_receiver.scala 226:24]
      when _T_23 : @[intervox_receiver.scala 226:46]
        syncWord <= UInt<1>("h1") @[intervox_receiver.scala 233:22]
        node _T_24 = eq(syncFlipped1, UInt<1>("h0")) @[intervox_receiver.scala 234:31]
        when _T_24 : @[intervox_receiver.scala 234:39]
          node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 236:27]
          clkRec <= _clkRec_T_3 @[intervox_receiver.scala 236:24]
          syncFlipped1 <= UInt<1>("h1") @[intervox_receiver.scala 237:30]
          bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 239:25]
      node _T_25 = mul(lastOne, UInt<3>("h4")) @[intervox_receiver.scala 242:38]
      node _T_26 = eq(deltaCntr, _T_25) @[intervox_receiver.scala 242:25]
      node _T_27 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 242:56]
      node _T_28 = and(_T_26, _T_27) @[intervox_receiver.scala 242:46]
      when _T_28 : @[intervox_receiver.scala 242:65]
        node _T_29 = eq(syncFlipped2, UInt<1>("h0")) @[intervox_receiver.scala 249:31]
        when _T_29 : @[intervox_receiver.scala 249:39]
          node _clkRec_T_4 = not(clkRec) @[intervox_receiver.scala 251:27]
          clkRec <= _clkRec_T_4 @[intervox_receiver.scala 251:24]
          syncFlipped2 <= UInt<1>("h1") @[intervox_receiver.scala 252:30]

  module edgeDetector_2 :
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
    output io : { flip CLK_IN : UInt<1>, flip DATA_IN : UInt<64>, flip NEXT : UInt<1>, BCLK : UInt<1>, LRCLK : UInt<1>, SDATA : UInt<1>}

    reg enable : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 268:26]
    reg bitCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 269:26]
    reg lrclk : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 270:26]
    reg bclk : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 271:26]
    reg sdataO : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 272:26]
    reg sdata : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[intervox_receiver.scala 273:26]
    sdata <= io.DATA_IN @[intervox_receiver.scala 275:17]
    io.BCLK <= io.CLK_IN @[intervox_receiver.scala 276:17]
    io.LRCLK <= lrclk @[intervox_receiver.scala 277:17]
    io.SDATA <= sdataO @[intervox_receiver.scala 278:17]
    inst BCLKEDGE of edgeDetector_2 @[intervox_receiver.scala 280:37]
    BCLKEDGE.clock <= clock
    BCLKEDGE.reset <= reset
    BCLKEDGE.io.INPUT <= io.CLK_IN @[intervox_receiver.scala 281:31]
    node _T = eq(io.NEXT, UInt<1>("h1")) @[intervox_receiver.scala 283:18]
    when _T : @[intervox_receiver.scala 283:26]
      enable <= UInt<1>("h1") @[intervox_receiver.scala 284:17]
      bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 285:17]
    node _T_1 = geq(bitCntr, UInt<6>("h3f")) @[intervox_receiver.scala 288:18]
    when _T_1 : @[intervox_receiver.scala 288:26]
      enable <= UInt<1>("h0") @[intervox_receiver.scala 289:16]
      bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 290:17]
    node _T_2 = eq(enable, UInt<1>("h1")) @[intervox_receiver.scala 293:17]
    when _T_2 : @[intervox_receiver.scala 293:25]
      node _T_3 = eq(BCLKEDGE.io.RISE, UInt<1>("h1")) @[intervox_receiver.scala 295:31]
      when _T_3 : @[intervox_receiver.scala 295:39]
        node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_receiver.scala 297:32]
        node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_receiver.scala 297:32]
        bitCntr <= _bitCntr_T_1 @[intervox_receiver.scala 297:21]
        node _T_4 = eq(bitCntr, UInt<1>("h0")) @[intervox_receiver.scala 299:26]
        when _T_4 : @[intervox_receiver.scala 299:34]
          lrclk <= UInt<1>("h1") @[intervox_receiver.scala 300:23]
        node _T_5 = eq(bitCntr, UInt<5>("h1f")) @[intervox_receiver.scala 303:26]
        when _T_5 : @[intervox_receiver.scala 303:35]
          lrclk <= UInt<1>("h0") @[intervox_receiver.scala 304:23]
        node _sdataO_T = dshr(sdata, bitCntr) @[intervox_receiver.scala 307:34]
        node _sdataO_T_1 = bits(_sdataO_T, 0, 0) @[intervox_receiver.scala 307:34]
        node _sdataO_T_2 = and(UInt<1>("h1"), _sdataO_T_1) @[intervox_receiver.scala 307:27]
        sdataO <= _sdataO_T_2 @[intervox_receiver.scala 307:20]

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, CLK_DBUG : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LEDS : UInt<16>, BCLK : UInt<1>, LRCLK : UInt<1>, SDATA : UInt<1>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 327:29]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 328:29]
    io.LEDS <= clockRec.io.LEDS @[intervox_receiver.scala 329:21]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 330:21]
    io.CLK_DBUG <= UInt<1>("h0") @[intervox_receiver.scala 331:21]
    io.CLK_REC <= clockRec.io.CLK_OUT @[intervox_receiver.scala 332:21]
    io.DBUG1 <= clockRec.io.DBUG1 @[intervox_receiver.scala 333:21]
    io.DBUG <= clockRec.io.DBUG @[intervox_receiver.scala 334:21]
    inst i2sTrans of i2s_Transmitter @[intervox_receiver.scala 336:29]
    i2sTrans.clock <= clock
    i2sTrans.reset <= reset
    i2sTrans.io.CLK_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 337:29]
    i2sTrans.io.DATA_IN <= clockRec.io.DATAREG @[intervox_receiver.scala 338:29]
    i2sTrans.io.NEXT <= clockRec.io.DBUG1 @[intervox_receiver.scala 339:29]
    io.BCLK <= i2sTrans.io.BCLK @[intervox_receiver.scala 340:21]
    io.SDATA <= i2sTrans.io.SDATA @[intervox_receiver.scala 341:21]
    io.LRCLK <= i2sTrans.io.LRCLK @[intervox_receiver.scala 342:21]

