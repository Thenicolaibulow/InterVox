circuit interVox_Encoder :
  module RWSmem :
    input clock : Clock
    input reset : Reset
    output io : { flip enable : UInt<1>, flip write : UInt<1>, flip addr : UInt<1>, flip dataIn : UInt<64>, dataOut : UInt<64>}

    smem mem : UInt<64> [1] @[intervox_transmitter.scala 19:24]
    io.dataOut is invalid @[intervox_transmitter.scala 21:14]
    when io.enable : @[intervox_transmitter.scala 23:19]
      infer mport rdwrPort = mem[UInt<1>("h0")], clock @[intervox_transmitter.scala 24:23]
      when io.write : @[intervox_transmitter.scala 25:21]
        rdwrPort <= io.dataIn @[intervox_transmitter.scala 25:32]
      else :
        io.dataOut <= rdwrPort @[intervox_transmitter.scala 26:34]

  module RWSmem_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip enable : UInt<1>, flip write : UInt<1>, flip addr : UInt<1>, flip dataIn : UInt<64>, dataOut : UInt<64>}

    smem mem : UInt<64> [1] @[intervox_transmitter.scala 19:24]
    io.dataOut is invalid @[intervox_transmitter.scala 21:14]
    when io.enable : @[intervox_transmitter.scala 23:19]
      infer mport rdwrPort = mem[UInt<1>("h0")], clock @[intervox_transmitter.scala 24:23]
      when io.write : @[intervox_transmitter.scala 25:21]
        rdwrPort <= io.dataIn @[intervox_transmitter.scala 25:32]
      else :
        io.dataOut <= rdwrPort @[intervox_transmitter.scala 26:34]

  module biPhaseEncoder :
    input clock : Clock
    input reset : Reset
    output io : { DATA_OUT : UInt<1>, flip AUDIOINPUT : UInt<64>, flip DSPINPUT : UInt<64>, flip ENA : UInt<1>, flip CLK : UInt<1>, flip TRIG : UInt<1>}

    reg outReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 39:32]
    reg stereoData : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[intervox_transmitter.scala 40:32]
    reg dspData : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[intervox_transmitter.scala 41:32]
    reg bitCntr_enc : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 42:32]
    reg hasNone : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 43:32]
    reg dataIndex : UInt<6>, clock with :
      reset => (reset, UInt<6>("h0")) @[intervox_transmitter.scala 44:32]
    io.DATA_OUT <= outReg @[intervox_transmitter.scala 46:17]
    stereoData <= io.AUDIOINPUT @[intervox_transmitter.scala 48:17]
    dspData <= io.DSPINPUT @[intervox_transmitter.scala 49:17]
    reg ndexR : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 51:32]
    node _T = eq(io.ENA, UInt<1>("h1")) @[intervox_transmitter.scala 53:17]
    when _T : @[intervox_transmitter.scala 53:25]
      node _T_1 = eq(io.CLK, UInt<1>("h1")) @[intervox_transmitter.scala 57:19]
      when _T_1 : @[intervox_transmitter.scala 57:27]
        node _T_2 = eq(bitCntr_enc, UInt<2>("h3")) @[intervox_transmitter.scala 66:28]
        when _T_2 : @[intervox_transmitter.scala 66:36]
          node _outReg_T = not(outReg) @[intervox_transmitter.scala 67:23]
          outReg <= _outReg_T @[intervox_transmitter.scala 67:20]
        node _T_3 = eq(bitCntr_enc, UInt<3>("h4")) @[intervox_transmitter.scala 70:28]
        when _T_3 : @[intervox_transmitter.scala 70:36]
          node _outReg_T_1 = not(outReg) @[intervox_transmitter.scala 71:23]
          outReg <= _outReg_T_1 @[intervox_transmitter.scala 71:20]
          hasNone <= UInt<1>("h0") @[intervox_transmitter.scala 73:21]
        node _T_4 = gt(bitCntr_enc, UInt<3>("h5")) @[intervox_transmitter.scala 77:29]
        when _T_4 : @[intervox_transmitter.scala 77:36]
          node _ndexR_T = not(ndexR) @[intervox_transmitter.scala 80:22]
          ndexR <= _ndexR_T @[intervox_transmitter.scala 80:19]
          node _T_5 = eq(ndexR, UInt<1>("h0")) @[intervox_transmitter.scala 81:24]
          when _T_5 : @[intervox_transmitter.scala 81:32]
            node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 83:38]
            node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 83:38]
            dataIndex <= _dataIndex_T_1 @[intervox_transmitter.scala 83:25]
          node _T_6 = leq(bitCntr_enc, UInt<6>("h35")) @[intervox_transmitter.scala 92:30]
          when _T_6 : @[intervox_transmitter.scala 92:38]
            node _T_7 = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 94:50]
            node _T_8 = tail(_T_7, 1) @[intervox_transmitter.scala 94:50]
            node _T_9 = sub(UInt<7>("h40"), _T_8) @[intervox_transmitter.scala 94:37]
            node _T_10 = tail(_T_9, 1) @[intervox_transmitter.scala 94:37]
            node _T_11 = dshr(stereoData, _T_10) @[intervox_transmitter.scala 94:31]
            node _T_12 = bits(_T_11, 0, 0) @[intervox_transmitter.scala 94:31]
            node _T_13 = eq(_T_12, UInt<1>("h0")) @[intervox_transmitter.scala 94:59]
            when _T_13 : @[intervox_transmitter.scala 94:68]
              hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 96:25]
          node _T_14 = gt(bitCntr_enc, UInt<6>("h35")) @[intervox_transmitter.scala 104:31]
          node _T_15 = leq(bitCntr_enc, UInt<7>("h65")) @[intervox_transmitter.scala 104:54]
          node _T_16 = and(_T_14, _T_15) @[intervox_transmitter.scala 104:39]
          when _T_16 : @[intervox_transmitter.scala 104:64]
            node _T_17 = sub(dataIndex, UInt<5>("h17")) @[intervox_transmitter.scala 106:51]
            node _T_18 = tail(_T_17, 1) @[intervox_transmitter.scala 106:51]
            node _T_19 = sub(UInt<7>("h40"), _T_18) @[intervox_transmitter.scala 106:38]
            node _T_20 = tail(_T_19, 1) @[intervox_transmitter.scala 106:38]
            node _T_21 = dshr(stereoData, _T_20) @[intervox_transmitter.scala 106:31]
            node _T_22 = bits(_T_21, 0, 0) @[intervox_transmitter.scala 106:31]
            node _T_23 = eq(_T_22, UInt<1>("h0")) @[intervox_transmitter.scala 106:62]
            when _T_23 : @[intervox_transmitter.scala 106:71]
              hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 107:25]
          node _T_24 = gt(bitCntr_enc, UInt<7>("h65")) @[intervox_transmitter.scala 116:31]
          node _T_25 = leq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 116:55]
          node _T_26 = and(_T_24, _T_25) @[intervox_transmitter.scala 116:40]
          when _T_26 : @[intervox_transmitter.scala 116:65]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 120:23]
          node _T_27 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 127:26]
          when _T_27 : @[intervox_transmitter.scala 127:34]
            outReg <= outReg @[intervox_transmitter.scala 129:22]
            hasNone <= UInt<1>("h0") @[intervox_transmitter.scala 130:23]
          else :
            node _outReg_T_2 = not(outReg) @[intervox_transmitter.scala 134:27]
            outReg <= _outReg_T_2 @[intervox_transmitter.scala 134:24]
        node _bitCntr_enc_T = add(bitCntr_enc, UInt<1>("h1")) @[intervox_transmitter.scala 138:38]
        node _bitCntr_enc_T_1 = tail(_bitCntr_enc_T, 1) @[intervox_transmitter.scala 138:38]
        bitCntr_enc <= _bitCntr_enc_T_1 @[intervox_transmitter.scala 138:23]
        node _T_28 = eq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 141:28]
        when _T_28 : @[intervox_transmitter.scala 141:38]
          bitCntr_enc <= UInt<1>("h0") @[intervox_transmitter.scala 142:25]
          dataIndex <= UInt<1>("h0") @[intervox_transmitter.scala 143:23]

  module edgeDetector :
    input clock : Clock
    input reset : Reset
    output io : { flip INPUT : UInt<1>, TRAIL : UInt<1>, RISE : UInt<1>, CHANGE : UInt<1>}

    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 157:34]
    reg inBufrPrev : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 158:34]
    reg trailing : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 159:34]
    reg rising : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 160:34]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 161:34]
    reg changed : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 162:34]
    node _T = eq(UInt<1>("h1"), io.INPUT) @[intervox_transmitter.scala 167:21]
    when _T : @[intervox_transmitter.scala 167:21]
      node _T_1 = lt(inBufr, UInt<2>("h2")) @[intervox_transmitter.scala 169:21]
      when _T_1 : @[intervox_transmitter.scala 169:27]
        node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 171:35]
        node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_transmitter.scala 171:35]
        inBufr <= _inBufr_T_1 @[intervox_transmitter.scala 171:25]
        inBufrPrev <= inBufr @[intervox_transmitter.scala 172:25]
    else :
      node _T_2 = eq(UInt<1>("h0"), io.INPUT) @[intervox_transmitter.scala 167:21]
      when _T_2 : @[intervox_transmitter.scala 167:21]
        node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_transmitter.scala 176:21]
        when _T_3 : @[intervox_transmitter.scala 176:27]
          node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 178:35]
          node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_transmitter.scala 178:35]
          inBufr <= _inBufr_T_3 @[intervox_transmitter.scala 178:25]
          inBufrPrev <= inBufr @[intervox_transmitter.scala 179:25]
    node _T_4 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 184:18]
    node _T_5 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 184:39]
    node _T_6 = or(_T_4, _T_5) @[intervox_transmitter.scala 184:27]
    when _T_6 : @[intervox_transmitter.scala 184:48]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 185:17]
    node _T_7 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_transmitter.scala 188:22]
    node _T_8 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 188:41]
    node _T_9 = and(_T_7, _T_8) @[intervox_transmitter.scala 188:31]
    when _T_9 : @[intervox_transmitter.scala 188:50]
      trailing <= UInt<1>("h0") @[intervox_transmitter.scala 189:17]
      rising <= UInt<1>("h1") @[intervox_transmitter.scala 190:17]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 191:17]
    node _T_10 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_transmitter.scala 194:22]
    node _T_11 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 194:41]
    node _T_12 = and(_T_10, _T_11) @[intervox_transmitter.scala 194:31]
    when _T_12 : @[intervox_transmitter.scala 194:50]
      trailing <= UInt<1>("h1") @[intervox_transmitter.scala 195:17]
      rising <= UInt<1>("h0") @[intervox_transmitter.scala 196:17]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 197:17]
    node _T_13 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 200:19]
    when _T_13 : @[intervox_transmitter.scala 200:27]
      trailing <= UInt<1>("h0") @[intervox_transmitter.scala 200:37]
    node _T_14 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 201:17]
    when _T_14 : @[intervox_transmitter.scala 201:27]
      rising <= UInt<1>("h0") @[intervox_transmitter.scala 201:37]
    node _T_15 = eq(change, UInt<1>("h1")) @[intervox_transmitter.scala 203:17]
    when _T_15 : @[intervox_transmitter.scala 203:25]
      reg change_REG : UInt, clock with :
        reset => (UInt<1>("h0"), change_REG) @[intervox_transmitter.scala 204:26]
      change_REG <= UInt<1>("h0") @[intervox_transmitter.scala 204:26]
      change <= change_REG @[intervox_transmitter.scala 204:16]
    io.CHANGE <= change @[intervox_transmitter.scala 207:13]
    io.TRAIL <= trailing @[intervox_transmitter.scala 208:13]
    io.RISE <= rising @[intervox_transmitter.scala 209:13]

  module edgeDetector_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip INPUT : UInt<1>, TRAIL : UInt<1>, RISE : UInt<1>, CHANGE : UInt<1>}

    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 157:34]
    reg inBufrPrev : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 158:34]
    reg trailing : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 159:34]
    reg rising : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 160:34]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 161:34]
    reg changed : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 162:34]
    node _T = eq(UInt<1>("h1"), io.INPUT) @[intervox_transmitter.scala 167:21]
    when _T : @[intervox_transmitter.scala 167:21]
      node _T_1 = lt(inBufr, UInt<2>("h2")) @[intervox_transmitter.scala 169:21]
      when _T_1 : @[intervox_transmitter.scala 169:27]
        node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 171:35]
        node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_transmitter.scala 171:35]
        inBufr <= _inBufr_T_1 @[intervox_transmitter.scala 171:25]
        inBufrPrev <= inBufr @[intervox_transmitter.scala 172:25]
    else :
      node _T_2 = eq(UInt<1>("h0"), io.INPUT) @[intervox_transmitter.scala 167:21]
      when _T_2 : @[intervox_transmitter.scala 167:21]
        node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_transmitter.scala 176:21]
        when _T_3 : @[intervox_transmitter.scala 176:27]
          node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 178:35]
          node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_transmitter.scala 178:35]
          inBufr <= _inBufr_T_3 @[intervox_transmitter.scala 178:25]
          inBufrPrev <= inBufr @[intervox_transmitter.scala 179:25]
    node _T_4 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 184:18]
    node _T_5 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 184:39]
    node _T_6 = or(_T_4, _T_5) @[intervox_transmitter.scala 184:27]
    when _T_6 : @[intervox_transmitter.scala 184:48]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 185:17]
    node _T_7 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_transmitter.scala 188:22]
    node _T_8 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 188:41]
    node _T_9 = and(_T_7, _T_8) @[intervox_transmitter.scala 188:31]
    when _T_9 : @[intervox_transmitter.scala 188:50]
      trailing <= UInt<1>("h0") @[intervox_transmitter.scala 189:17]
      rising <= UInt<1>("h1") @[intervox_transmitter.scala 190:17]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 191:17]
    node _T_10 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_transmitter.scala 194:22]
    node _T_11 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 194:41]
    node _T_12 = and(_T_10, _T_11) @[intervox_transmitter.scala 194:31]
    when _T_12 : @[intervox_transmitter.scala 194:50]
      trailing <= UInt<1>("h1") @[intervox_transmitter.scala 195:17]
      rising <= UInt<1>("h0") @[intervox_transmitter.scala 196:17]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 197:17]
    node _T_13 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 200:19]
    when _T_13 : @[intervox_transmitter.scala 200:27]
      trailing <= UInt<1>("h0") @[intervox_transmitter.scala 200:37]
    node _T_14 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 201:17]
    when _T_14 : @[intervox_transmitter.scala 201:27]
      rising <= UInt<1>("h0") @[intervox_transmitter.scala 201:37]
    node _T_15 = eq(change, UInt<1>("h1")) @[intervox_transmitter.scala 203:17]
    when _T_15 : @[intervox_transmitter.scala 203:25]
      reg change_REG : UInt, clock with :
        reset => (UInt<1>("h0"), change_REG) @[intervox_transmitter.scala 204:26]
      change_REG <= UInt<1>("h0") @[intervox_transmitter.scala 204:26]
      change <= change_REG @[intervox_transmitter.scala 204:16]
    io.CHANGE <= change @[intervox_transmitter.scala 207:13]
    io.TRAIL <= trailing @[intervox_transmitter.scala 208:13]
    io.RISE <= rising @[intervox_transmitter.scala 209:13]

  module interVox_Encoder :
    input clock : Clock
    input reset : UInt<1>
    output io : { MCLK_O : Clock, flip BCLK_IN : UInt<1>, flip LRCLK_IN : UInt<1>, flip SDATA_IN : UInt<1>, DATA_O : UInt<1>, LRCLK_O : UInt<1>, BCLK_O : UInt<1>, SDATA_O : UInt<1>, NXT_FRAME : UInt<1>, flip SW : UInt<16>, LED : UInt<16>}

    reg currentState : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 229:33]
    reg syncing : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 231:34]
    reg synced : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 232:34]
    reg leds : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[intervox_transmitter.scala 235:34]
    reg bclkR : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[intervox_transmitter.scala 237:34]
    reg encoderClk : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 239:34]
    reg bitCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 241:34]
    inst BFR of RWSmem @[intervox_transmitter.scala 243:33]
    BFR.clock <= clock
    BFR.reset <= reset
    inst BFR1 of RWSmem_1 @[intervox_transmitter.scala 244:33]
    BFR1.clock <= clock
    BFR1.reset <= reset
    inst biPhaseEncoder of biPhaseEncoder @[intervox_transmitter.scala 246:35]
    biPhaseEncoder.clock <= clock
    biPhaseEncoder.reset <= reset
    inst LREDGE of edgeDetector @[intervox_transmitter.scala 248:33]
    LREDGE.clock <= clock
    LREDGE.reset <= reset
    LREDGE.io.INPUT <= io.LRCLK_IN @[intervox_transmitter.scala 249:25]
    inst BCLKEDGE of edgeDetector_1 @[intervox_transmitter.scala 250:33]
    BCLKEDGE.clock <= clock
    BCLKEDGE.reset <= reset
    BCLKEDGE.io.INPUT <= io.BCLK_IN @[intervox_transmitter.scala 251:25]
    io.DATA_O <= biPhaseEncoder.io.DATA_OUT @[intervox_transmitter.scala 254:25]
    io.MCLK_O <= clock @[intervox_transmitter.scala 255:25]
    io.BCLK_O <= io.BCLK_IN @[intervox_transmitter.scala 256:25]
    io.LRCLK_O <= io.LRCLK_IN @[intervox_transmitter.scala 257:25]
    io.SDATA_O <= io.SDATA_IN @[intervox_transmitter.scala 258:25]
    io.LED <= leds @[intervox_transmitter.scala 259:25]
    BFR.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 262:25]
    BFR.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 263:25]
    BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 264:25]
    BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 265:25]
    BFR1.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 266:25]
    BFR1.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 267:25]
    BFR1.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 268:25]
    BFR1.io.dataIn <= BFR.io.dataOut @[intervox_transmitter.scala 269:25]
    io.NXT_FRAME <= biPhaseEncoder.io.TRIG @[intervox_transmitter.scala 272:31]
    biPhaseEncoder.io.CLK <= encoderClk @[intervox_transmitter.scala 274:33]
    biPhaseEncoder.io.ENA <= UInt<1>("h0") @[intervox_transmitter.scala 275:33]
    biPhaseEncoder.io.TRIG <= BCLKEDGE.io.CHANGE @[intervox_transmitter.scala 276:33]
    biPhaseEncoder.io.AUDIOINPUT <= BFR1.io.dataOut @[intervox_transmitter.scala 278:33]
    biPhaseEncoder.io.DSPINPUT <= UInt<1>("h0") @[intervox_transmitter.scala 280:33]
    node _T = eq(synced, UInt<1>("h0")) @[intervox_transmitter.scala 297:15]
    when _T : @[intervox_transmitter.scala 297:23]
      node _T_1 = eq(LREDGE.io.TRAIL, UInt<1>("h1")) @[intervox_transmitter.scala 299:26]
      when _T_1 : @[intervox_transmitter.scala 299:34]
        syncing <= UInt<1>("h1") @[intervox_transmitter.scala 300:15]
      node _T_2 = eq(syncing, UInt<1>("h1")) @[intervox_transmitter.scala 302:19]
      when _T_2 : @[intervox_transmitter.scala 302:27]
        node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 303:30]
        node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 303:30]
        bitCntr <= _bitCntr_T_1 @[intervox_transmitter.scala 303:19]
        node _T_3 = eq(bitCntr, UInt<7>("h7d")) @[intervox_transmitter.scala 305:20]
        when _T_3 : @[intervox_transmitter.scala 305:30]
          synced <= UInt<1>("h1") @[intervox_transmitter.scala 306:19]
          bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 307:19]
    node _T_4 = eq(UInt<2>("h0"), currentState) @[intervox_transmitter.scala 319:23]
    when _T_4 : @[intervox_transmitter.scala 319:23]
      currentState <= UInt<2>("h2") @[intervox_transmitter.scala 323:20]
    else :
      node _T_5 = eq(UInt<2>("h1"), currentState) @[intervox_transmitter.scala 319:23]
      when _T_5 : @[intervox_transmitter.scala 319:23]
        currentState <= UInt<2>("h2") @[intervox_transmitter.scala 327:20]
      else :
        node _T_6 = eq(UInt<2>("h2"), currentState) @[intervox_transmitter.scala 319:23]
        when _T_6 : @[intervox_transmitter.scala 319:23]
          node _T_7 = eq(synced, UInt<1>("h1")) @[intervox_transmitter.scala 331:19]
          when _T_7 : @[intervox_transmitter.scala 331:27]
            biPhaseEncoder.io.ENA <= UInt<1>("h1") @[intervox_transmitter.scala 338:31]
            node _encoderClk_T = not(encoderClk) @[intervox_transmitter.scala 341:23]
            encoderClk <= _encoderClk_T @[intervox_transmitter.scala 341:20]
            node _T_8 = eq(BCLKEDGE.io.RISE, UInt<1>("h1")) @[intervox_transmitter.scala 344:31]
            when _T_8 : @[intervox_transmitter.scala 344:39]
              node _bitCntr_T_2 = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 347:30]
              node _bitCntr_T_3 = tail(_bitCntr_T_2, 1) @[intervox_transmitter.scala 347:30]
              bitCntr <= _bitCntr_T_3 @[intervox_transmitter.scala 347:19]
              node _T_9 = eq(io.SW, UInt<1>("h0")) @[intervox_transmitter.scala 357:22]
              when _T_9 : @[intervox_transmitter.scala 357:30]
                node _T_10 = gt(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 359:26]
                when _T_10 : @[intervox_transmitter.scala 359:33]
                  BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 362:33]
                  node _T_11 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 364:32]
                  when _T_11 : @[intervox_transmitter.scala 364:40]
                    node _BFR_io_dataIn_T = sub(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 368:80]
                    node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 368:80]
                    node _BFR_io_dataIn_T_2 = sub(UInt<6>("h27"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 368:69]
                    node _BFR_io_dataIn_T_3 = tail(_BFR_io_dataIn_T_2, 1) @[intervox_transmitter.scala 368:69]
                    node _BFR_io_dataIn_T_4 = add(_BFR_io_dataIn_T_3, UInt<4>("h9")) @[intervox_transmitter.scala 368:89]
                    node _BFR_io_dataIn_T_5 = tail(_BFR_io_dataIn_T_4, 1) @[intervox_transmitter.scala 368:89]
                    node _BFR_io_dataIn_T_6 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_5) @[intervox_transmitter.scala 368:60]
                    node _BFR_io_dataIn_T_7 = add(BFR.io.dataOut, _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 368:53]
                    node _BFR_io_dataIn_T_8 = tail(_BFR_io_dataIn_T_7, 1) @[intervox_transmitter.scala 368:53]
                    BFR.io.dataIn <= _BFR_io_dataIn_T_8 @[intervox_transmitter.scala 368:35]
                  node _T_12 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 370:32]
                  when _T_12 : @[intervox_transmitter.scala 370:40]
                    node _BFR_io_dataIn_T_9 = sub(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 371:81]
                    node _BFR_io_dataIn_T_10 = tail(_BFR_io_dataIn_T_9, 1) @[intervox_transmitter.scala 371:81]
                    node _BFR_io_dataIn_T_11 = sub(UInt<6>("h27"), _BFR_io_dataIn_T_10) @[intervox_transmitter.scala 371:70]
                    node _BFR_io_dataIn_T_12 = tail(_BFR_io_dataIn_T_11, 1) @[intervox_transmitter.scala 371:70]
                    node _BFR_io_dataIn_T_13 = add(_BFR_io_dataIn_T_12, UInt<4>("h9")) @[intervox_transmitter.scala 371:89]
                    node _BFR_io_dataIn_T_14 = tail(_BFR_io_dataIn_T_13, 1) @[intervox_transmitter.scala 371:89]
                    node _BFR_io_dataIn_T_15 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_14) @[intervox_transmitter.scala 371:60]
                    node _BFR_io_dataIn_T_16 = add(BFR.io.dataOut, _BFR_io_dataIn_T_15) @[intervox_transmitter.scala 371:53]
                    node _BFR_io_dataIn_T_17 = tail(_BFR_io_dataIn_T_16, 1) @[intervox_transmitter.scala 371:53]
                    BFR.io.dataIn <= _BFR_io_dataIn_T_17 @[intervox_transmitter.scala 371:35]
                else :
                  BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 375:33]
                  node _T_13 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 377:32]
                  when _T_13 : @[intervox_transmitter.scala 377:41]
                    node _BFR_io_dataIn_T_18 = sub(UInt<6>("h3f"), bitCntr) @[intervox_transmitter.scala 380:69]
                    node _BFR_io_dataIn_T_19 = tail(_BFR_io_dataIn_T_18, 1) @[intervox_transmitter.scala 380:69]
                    node _BFR_io_dataIn_T_20 = add(_BFR_io_dataIn_T_19, UInt<4>("h9")) @[intervox_transmitter.scala 380:81]
                    node _BFR_io_dataIn_T_21 = tail(_BFR_io_dataIn_T_20, 1) @[intervox_transmitter.scala 380:81]
                    node _BFR_io_dataIn_T_22 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_21) @[intervox_transmitter.scala 380:60]
                    node _BFR_io_dataIn_T_23 = add(BFR.io.dataOut, _BFR_io_dataIn_T_22) @[intervox_transmitter.scala 380:53]
                    node _BFR_io_dataIn_T_24 = tail(_BFR_io_dataIn_T_23, 1) @[intervox_transmitter.scala 380:53]
                    BFR.io.dataIn <= _BFR_io_dataIn_T_24 @[intervox_transmitter.scala 380:35]
                  node _T_14 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 382:32]
                  when _T_14 : @[intervox_transmitter.scala 382:40]
                    node _BFR_io_dataIn_T_25 = sub(UInt<6>("h3f"), bitCntr) @[intervox_transmitter.scala 383:69]
                    node _BFR_io_dataIn_T_26 = tail(_BFR_io_dataIn_T_25, 1) @[intervox_transmitter.scala 383:69]
                    node _BFR_io_dataIn_T_27 = add(_BFR_io_dataIn_T_26, UInt<4>("h9")) @[intervox_transmitter.scala 383:81]
                    node _BFR_io_dataIn_T_28 = tail(_BFR_io_dataIn_T_27, 1) @[intervox_transmitter.scala 383:81]
                    node _BFR_io_dataIn_T_29 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_28) @[intervox_transmitter.scala 383:60]
                    node _BFR_io_dataIn_T_30 = add(BFR.io.dataOut, _BFR_io_dataIn_T_29) @[intervox_transmitter.scala 383:53]
                    node _BFR_io_dataIn_T_31 = tail(_BFR_io_dataIn_T_30, 1) @[intervox_transmitter.scala 383:53]
                    BFR.io.dataIn <= _BFR_io_dataIn_T_31 @[intervox_transmitter.scala 383:35]
              else :
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 389:27]
                node _BFR_io_dataIn_T_32 = add(UInt<6>("h3f"), UInt<4>("h9")) @[intervox_transmitter.scala 392:46]
                node _BFR_io_dataIn_T_33 = tail(_BFR_io_dataIn_T_32, 1) @[intervox_transmitter.scala 392:46]
                node _BFR_io_dataIn_T_34 = dshl(io.SW, _BFR_io_dataIn_T_33) @[intervox_transmitter.scala 392:37]
                node _BFR_io_dataIn_T_35 = add(UInt<6>("h27"), UInt<4>("h9")) @[intervox_transmitter.scala 392:72]
                node _BFR_io_dataIn_T_36 = tail(_BFR_io_dataIn_T_35, 1) @[intervox_transmitter.scala 392:72]
                node _BFR_io_dataIn_T_37 = dshl(io.SW, _BFR_io_dataIn_T_36) @[intervox_transmitter.scala 392:63]
                node _BFR_io_dataIn_T_38 = add(_BFR_io_dataIn_T_34, _BFR_io_dataIn_T_37) @[intervox_transmitter.scala 392:54]
                node _BFR_io_dataIn_T_39 = tail(_BFR_io_dataIn_T_38, 1) @[intervox_transmitter.scala 392:54]
                BFR.io.dataIn <= _BFR_io_dataIn_T_39 @[intervox_transmitter.scala 392:27]
              node _T_15 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 395:24]
              when _T_15 : @[intervox_transmitter.scala 395:33]
                BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 398:31]
                BFR1.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 399:31]
                BFR1.io.dataIn <= BFR.io.dataOut @[intervox_transmitter.scala 400:31]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 403:28]
                BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 404:28]
                node _leds_T = dshr(BFR1.io.dataOut, UInt<6>("h30")) @[intervox_transmitter.scala 408:38]
                node _leds_T_1 = and(_leds_T, UInt<16>("hffff")) @[intervox_transmitter.scala 408:47]
                leds <= _leds_T_1 @[intervox_transmitter.scala 408:18]
                bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 410:21]

