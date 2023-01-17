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
    output io : { flip DATA_IN : UInt<1>, CLK_OUT : UInt<1>, DATA_OUT : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LED : UInt<16>, flip SW : UInt<16>, DATAREG : UInt<64>, flip BTN_C : UInt<1>}

    inst BFR of RWSmem @[intervox_receiver.scala 100:29]
    BFR.clock <= clock
    BFR.reset <= reset
    BFR.io.enable <= UInt<1>("h1") @[intervox_receiver.scala 102:27]
    BFR.io.addr <= UInt<1>("h1") @[intervox_receiver.scala 103:27]
    BFR.io.write <= UInt<1>("h0") @[intervox_receiver.scala 104:27]
    BFR.io.dataIn <= UInt<1>("h0") @[intervox_receiver.scala 105:27]
    reg rising : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 109:30]
    reg trailing : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 110:30]
    reg lastOne : UInt<8>, clock with :
      reset => (reset, UInt<8>("hf")) @[intervox_receiver.scala 111:30]
    reg leds : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[intervox_receiver.scala 112:30]
    reg overSampleCntr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[intervox_receiver.scala 113:32]
    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 114:30]
    reg deltaCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 115:30]
    reg bitCntr : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[intervox_receiver.scala 116:30]
    reg clkRec : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 117:30]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 118:30]
    reg dataOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 119:30]
    reg dataReg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[intervox_receiver.scala 120:30]
    reg syncWord : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 121:30]
    reg zeroFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 122:30]
    reg syncFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 123:30]
    reg syncFlipped1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 124:30]
    reg syncFlipped2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 125:30]
    io.CLK_OUT <= clkRec @[intervox_receiver.scala 127:21]
    io.DATA_OUT <= dataOut @[intervox_receiver.scala 128:21]
    io.DBUG <= change @[intervox_receiver.scala 129:21]
    io.DBUG1 <= syncWord @[intervox_receiver.scala 130:21]
    io.LED <= leds @[intervox_receiver.scala 131:21]
    io.DATAREG <= dataReg @[intervox_receiver.scala 132:21]
    node _deltaCntr_T = add(deltaCntr, UInt<1>("h1")) @[intervox_receiver.scala 134:31]
    node _deltaCntr_T_1 = tail(_deltaCntr_T, 1) @[intervox_receiver.scala 134:31]
    deltaCntr <= _deltaCntr_T_1 @[intervox_receiver.scala 134:18]
    inst DATAEDGE of edgeDetector @[intervox_receiver.scala 136:38]
    DATAEDGE.clock <= clock
    DATAEDGE.reset <= reset
    DATAEDGE.io.INPUT <= io.DATA_IN @[intervox_receiver.scala 137:29]
    change <= DATAEDGE.io.CHANGE @[intervox_receiver.scala 138:29]
    inst CLKREC_EDGE of edgeDetector_1 @[intervox_receiver.scala 140:41]
    CLKREC_EDGE.clock <= clock
    CLKREC_EDGE.reset <= reset
    CLKREC_EDGE.io.INPUT <= clkRec @[intervox_receiver.scala 141:32]
    node _T = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 146:17]
    when _T : @[intervox_receiver.scala 146:25]
      reg change_REG : UInt, clock with :
        reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 148:34]
      change_REG <= UInt<1>("h0") @[intervox_receiver.scala 148:34]
      reg change_REG_1 : UInt, clock with :
        reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 148:26]
      change_REG_1 <= change_REG @[intervox_receiver.scala 148:26]
      change <= change_REG_1 @[intervox_receiver.scala 148:16]
      node _clkRec_T = not(clkRec) @[intervox_receiver.scala 150:28]
      clkRec <= _clkRec_T @[intervox_receiver.scala 150:25]
      deltaCntr <= UInt<1>("h0") @[intervox_receiver.scala 152:25]
      zeroFlipped <= UInt<1>("h0") @[intervox_receiver.scala 154:25]
      syncFlipped <= UInt<1>("h0") @[intervox_receiver.scala 155:25]
      syncFlipped1 <= UInt<1>("h0") @[intervox_receiver.scala 156:25]
    node _T_1 = eq(syncWord, UInt<1>("h1")) @[intervox_receiver.scala 159:19]
    when _T_1 : @[intervox_receiver.scala 159:27]
      syncWord <= UInt<1>("h0") @[intervox_receiver.scala 160:21]
      bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 161:21]
      dataReg <= BFR.io.dataOut @[intervox_receiver.scala 162:21]
      BFR.io.write <= UInt<1>("h1") @[intervox_receiver.scala 164:24]
      BFR.io.dataIn <= UInt<1>("h0") @[intervox_receiver.scala 165:24]
    node _T_2 = eq(CLKREC_EDGE.io.RISE, UInt<1>("h1")) @[intervox_receiver.scala 168:30]
    when _T_2 : @[intervox_receiver.scala 168:38]
      node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_receiver.scala 169:28]
      node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_receiver.scala 169:28]
      bitCntr <= _bitCntr_T_1 @[intervox_receiver.scala 169:17]
    node _T_3 = add(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 175:33]
    node _T_4 = tail(_T_3, 1) @[intervox_receiver.scala 175:33]
    node _T_5 = leq(deltaCntr, _T_4) @[intervox_receiver.scala 175:21]
    when _T_5 : @[intervox_receiver.scala 175:41]
      node _T_6 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 178:21]
      when _T_6 : @[intervox_receiver.scala 178:29]
        dataOut <= UInt<1>("h1") @[intervox_receiver.scala 181:21]
        BFR.io.write <= UInt<1>("h1") @[intervox_receiver.scala 184:31]
        node _BFR_io_dataIn_T = sub(UInt<6>("h3f"), bitCntr) @[intervox_receiver.scala 185:65]
        node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_receiver.scala 185:65]
        node _BFR_io_dataIn_T_2 = add(_BFR_io_dataIn_T_1, UInt<2>("h2")) @[intervox_receiver.scala 185:75]
        node _BFR_io_dataIn_T_3 = tail(_BFR_io_dataIn_T_2, 1) @[intervox_receiver.scala 185:75]
        node _BFR_io_dataIn_T_4 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_3) @[intervox_receiver.scala 185:56]
        node _BFR_io_dataIn_T_5 = or(BFR.io.dataOut, _BFR_io_dataIn_T_4) @[intervox_receiver.scala 185:49]
        BFR.io.dataIn <= _BFR_io_dataIn_T_5 @[intervox_receiver.scala 185:31]
    node _T_7 = add(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 195:32]
    node _T_8 = tail(_T_7, 1) @[intervox_receiver.scala 195:32]
    node _T_9 = gt(deltaCntr, _T_8) @[intervox_receiver.scala 195:21]
    node _T_10 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 195:65]
    node _T_11 = lt(deltaCntr, _T_10) @[intervox_receiver.scala 195:53]
    node _T_12 = and(_T_9, _T_11) @[intervox_receiver.scala 195:40]
    when _T_12 : @[intervox_receiver.scala 195:74]
      node _T_13 = eq(zeroFlipped, UInt<1>("h0")) @[intervox_receiver.scala 198:26]
      when _T_13 : @[intervox_receiver.scala 198:34]
        node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 201:23]
        clkRec <= _clkRec_T_1 @[intervox_receiver.scala 201:20]
        zeroFlipped <= UInt<1>("h1") @[intervox_receiver.scala 202:25]
        BFR.io.write <= UInt<1>("h1") @[intervox_receiver.scala 204:31]
        node _BFR_io_dataIn_T_6 = add(bitCntr, UInt<2>("h2")) @[intervox_receiver.scala 205:76]
        node _BFR_io_dataIn_T_7 = tail(_BFR_io_dataIn_T_6, 1) @[intervox_receiver.scala 205:76]
        node _BFR_io_dataIn_T_8 = sub(UInt<6>("h3f"), _BFR_io_dataIn_T_7) @[intervox_receiver.scala 205:65]
        node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_receiver.scala 205:65]
        node _BFR_io_dataIn_T_10 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_9) @[intervox_receiver.scala 205:56]
        node _BFR_io_dataIn_T_11 = or(BFR.io.dataOut, _BFR_io_dataIn_T_10) @[intervox_receiver.scala 205:49]
        BFR.io.dataIn <= _BFR_io_dataIn_T_11 @[intervox_receiver.scala 205:31]
        dataOut <= UInt<1>("h0") @[intervox_receiver.scala 207:21]
    node _T_14 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 215:17]
    when _T_14 : @[intervox_receiver.scala 215:25]
      node _T_15 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 217:38]
      node _T_16 = add(_T_15, UInt<2>("h2")) @[intervox_receiver.scala 217:45]
      node _T_17 = tail(_T_16, 1) @[intervox_receiver.scala 217:45]
      node _T_18 = geq(deltaCntr, _T_17) @[intervox_receiver.scala 217:25]
      when _T_18 : @[intervox_receiver.scala 217:53]
        node _T_19 = eq(syncFlipped, UInt<1>("h0")) @[intervox_receiver.scala 224:30]
        when _T_19 : @[intervox_receiver.scala 224:38]
          node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 226:27]
          clkRec <= _clkRec_T_2 @[intervox_receiver.scala 226:24]
          syncFlipped <= UInt<1>("h1") @[intervox_receiver.scala 227:29]
      node _T_20 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 230:38]
      node _T_21 = add(_T_20, UInt<2>("h2")) @[intervox_receiver.scala 230:45]
      node _T_22 = tail(_T_21, 1) @[intervox_receiver.scala 230:45]
      node _T_23 = geq(deltaCntr, _T_22) @[intervox_receiver.scala 230:25]
      when _T_23 : @[intervox_receiver.scala 230:53]
        syncWord <= UInt<1>("h1") @[intervox_receiver.scala 237:22]
        node _T_24 = eq(syncFlipped1, UInt<1>("h0")) @[intervox_receiver.scala 238:31]
        when _T_24 : @[intervox_receiver.scala 238:39]
          node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 240:27]
          clkRec <= _clkRec_T_3 @[intervox_receiver.scala 240:24]
          syncFlipped1 <= UInt<1>("h1") @[intervox_receiver.scala 241:30]
          bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 243:25]
      node _T_25 = mul(lastOne, UInt<3>("h4")) @[intervox_receiver.scala 246:37]
      node _T_26 = add(_T_25, UInt<2>("h2")) @[intervox_receiver.scala 246:44]
      node _T_27 = tail(_T_26, 1) @[intervox_receiver.scala 246:44]
      node _T_28 = geq(deltaCntr, _T_27) @[intervox_receiver.scala 246:25]
      node _T_29 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 246:61]
      node _T_30 = and(_T_28, _T_29) @[intervox_receiver.scala 246:51]
      when _T_30 : @[intervox_receiver.scala 246:70]
        node _T_31 = eq(syncFlipped2, UInt<1>("h0")) @[intervox_receiver.scala 253:31]
        when _T_31 : @[intervox_receiver.scala 253:39]
          node _clkRec_T_4 = not(clkRec) @[intervox_receiver.scala 255:27]
          clkRec <= _clkRec_T_4 @[intervox_receiver.scala 255:24]
          syncFlipped2 <= UInt<1>("h1") @[intervox_receiver.scala 256:30]
    node _leds_T = dshr(BFR.io.dataOut, UInt<6>("h30")) @[intervox_receiver.scala 261:32]
    node _leds_T_1 = and(_leds_T, UInt<16>("hffff")) @[intervox_receiver.scala 261:41]
    leds <= _leds_T_1 @[intervox_receiver.scala 261:13]
    node _T_32 = gt(io.SW, UInt<1>("h0")) @[intervox_receiver.scala 264:16]
    when _T_32 : @[intervox_receiver.scala 264:22]
      node _T_33 = eq(io.BTN_C, UInt<1>("h1")) @[intervox_receiver.scala 265:23]
      when _T_33 : @[intervox_receiver.scala 265:31]
        lastOne <= io.SW @[intervox_receiver.scala 266:21]
        leds <= io.SW @[intervox_receiver.scala 267:21]

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

    reg bitCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 282:26]
    reg lrclk : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 283:26]
    reg dlay : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 284:26]
    reg bclk : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 285:26]
    reg sdataO : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 286:26]
    reg sdata : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[intervox_receiver.scala 287:26]
    sdata <= io.DATA_IN @[intervox_receiver.scala 289:17]
    io.BCLK <= io.CLK_IN @[intervox_receiver.scala 290:17]
    io.LRCLK <= lrclk @[intervox_receiver.scala 291:17]
    io.SDATA <= sdataO @[intervox_receiver.scala 292:17]
    inst BCLKEDGE of edgeDetector_2 @[intervox_receiver.scala 294:37]
    BCLKEDGE.clock <= clock
    BCLKEDGE.reset <= reset
    BCLKEDGE.io.INPUT <= io.CLK_IN @[intervox_receiver.scala 295:33]
    node _T = eq(io.NEXT, UInt<1>("h1")) @[intervox_receiver.scala 297:18]
    when _T : @[intervox_receiver.scala 297:26]
      bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 298:17]
      lrclk <= UInt<1>("h1") @[intervox_receiver.scala 299:15]
    node _T_1 = geq(bitCntr, UInt<7>("h40")) @[intervox_receiver.scala 302:18]
    when _T_1 : @[intervox_receiver.scala 302:26]
      bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 303:17]
    node _T_2 = eq(BCLKEDGE.io.RISE, UInt<1>("h1")) @[intervox_receiver.scala 307:27]
    when _T_2 : @[intervox_receiver.scala 307:35]
      dlay <= UInt<1>("h1") @[intervox_receiver.scala 309:14]
      node _T_3 = eq(dlay, UInt<1>("h1")) @[intervox_receiver.scala 310:19]
      when _T_3 : @[intervox_receiver.scala 310:27]
        node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_receiver.scala 312:32]
        node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_receiver.scala 312:32]
        bitCntr <= _bitCntr_T_1 @[intervox_receiver.scala 312:21]
        node _T_4 = leq(bitCntr, UInt<5>("h1f")) @[intervox_receiver.scala 314:27]
        when _T_4 : @[intervox_receiver.scala 314:36]
          node _T_5 = leq(bitCntr, UInt<5>("h18")) @[intervox_receiver.scala 316:30]
          when _T_5 : @[intervox_receiver.scala 316:38]
            node _sdataO_T = sub(UInt<6>("h3f"), bitCntr) @[intervox_receiver.scala 317:48]
            node _sdataO_T_1 = tail(_sdataO_T, 1) @[intervox_receiver.scala 317:48]
            node _sdataO_T_2 = dshr(sdata, _sdataO_T_1) @[intervox_receiver.scala 317:42]
            node _sdataO_T_3 = bits(_sdataO_T_2, 0, 0) @[intervox_receiver.scala 317:42]
            node _sdataO_T_4 = and(UInt<1>("h1"), _sdataO_T_3) @[intervox_receiver.scala 317:35]
            sdataO <= _sdataO_T_4 @[intervox_receiver.scala 317:28]
          else :
            sdataO <= UInt<1>("h0") @[intervox_receiver.scala 319:28]
        node _T_6 = gt(bitCntr, UInt<5>("h1e")) @[intervox_receiver.scala 323:26]
        when _T_6 : @[intervox_receiver.scala 323:33]
          lrclk <= UInt<1>("h0") @[intervox_receiver.scala 324:23]
          node _T_7 = leq(bitCntr, UInt<6>("h38")) @[intervox_receiver.scala 326:30]
          when _T_7 : @[intervox_receiver.scala 326:38]
            node _sdataO_T_5 = sub(bitCntr, UInt<5>("h1f")) @[intervox_receiver.scala 327:59]
            node _sdataO_T_6 = tail(_sdataO_T_5, 1) @[intervox_receiver.scala 327:59]
            node _sdataO_T_7 = sub(UInt<6>("h27"), _sdataO_T_6) @[intervox_receiver.scala 327:48]
            node _sdataO_T_8 = tail(_sdataO_T_7, 1) @[intervox_receiver.scala 327:48]
            node _sdataO_T_9 = dshr(sdata, _sdataO_T_8) @[intervox_receiver.scala 327:42]
            node _sdataO_T_10 = bits(_sdataO_T_9, 0, 0) @[intervox_receiver.scala 327:42]
            node _sdataO_T_11 = and(UInt<1>("h1"), _sdataO_T_10) @[intervox_receiver.scala 327:35]
            sdataO <= _sdataO_T_11 @[intervox_receiver.scala 327:28]
          else :
            sdataO <= UInt<1>("h0") @[intervox_receiver.scala 329:28]

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, CLK_DBUG : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LED : UInt<16>, flip SW : UInt<16>, BCLK : UInt<1>, LRCLK : UInt<1>, SDATA : UInt<1>, flip BTN_C : UInt<1>, flip BTN_D : UInt<1>, flip BTN_L : UInt<1>, flip BTN_R : UInt<1>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 356:29]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 357:29]
    clockRec.io.SW <= io.SW @[intervox_receiver.scala 358:29]
    clockRec.io.BTN_C <= io.BTN_C @[intervox_receiver.scala 359:29]
    io.LED <= clockRec.io.LED @[intervox_receiver.scala 360:21]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 361:21]
    io.CLK_DBUG <= UInt<1>("h0") @[intervox_receiver.scala 362:21]
    io.CLK_REC <= clockRec.io.CLK_OUT @[intervox_receiver.scala 363:21]
    io.DBUG1 <= clockRec.io.DBUG1 @[intervox_receiver.scala 364:21]
    io.DBUG <= clockRec.io.DBUG @[intervox_receiver.scala 365:21]
    inst i2sTrans of i2s_Transmitter @[intervox_receiver.scala 367:29]
    i2sTrans.clock <= clock
    i2sTrans.reset <= reset
    i2sTrans.io.CLK_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 368:29]
    i2sTrans.io.DATA_IN <= clockRec.io.DATAREG @[intervox_receiver.scala 369:29]
    i2sTrans.io.NEXT <= clockRec.io.DBUG1 @[intervox_receiver.scala 370:29]
    io.BCLK <= i2sTrans.io.BCLK @[intervox_receiver.scala 371:21]
    io.SDATA <= i2sTrans.io.SDATA @[intervox_receiver.scala 372:21]
    io.LRCLK <= i2sTrans.io.LRCLK @[intervox_receiver.scala 373:21]

