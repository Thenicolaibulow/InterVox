circuit interVox_Encoder :
  module bi_phase_encoder :
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
        node _T_4 = geq(bitCntr_enc, UInt<3>("h5")) @[intervox_transmitter.scala 82:29]
        when _T_4 : @[intervox_transmitter.scala 82:37]
          node _ndexR_T = not(ndexR) @[intervox_transmitter.scala 85:22]
          ndexR <= _ndexR_T @[intervox_transmitter.scala 85:19]
          node _T_5 = eq(ndexR, UInt<1>("h0")) @[intervox_transmitter.scala 86:24]
          when _T_5 : @[intervox_transmitter.scala 86:32]
            node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 88:38]
            node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 88:38]
            dataIndex <= _dataIndex_T_1 @[intervox_transmitter.scala 88:25]
          node _T_6 = leq(bitCntr_enc, UInt<6>("h35")) @[intervox_transmitter.scala 95:30]
          when _T_6 : @[intervox_transmitter.scala 95:38]
            node _T_7 = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 97:50]
            node _T_8 = tail(_T_7, 1) @[intervox_transmitter.scala 97:50]
            node _T_9 = sub(UInt<7>("h40"), _T_8) @[intervox_transmitter.scala 97:37]
            node _T_10 = tail(_T_9, 1) @[intervox_transmitter.scala 97:37]
            node _T_11 = dshr(stereoData, _T_10) @[intervox_transmitter.scala 97:31]
            node _T_12 = bits(_T_11, 0, 0) @[intervox_transmitter.scala 97:31]
            node _T_13 = eq(_T_12, UInt<1>("h0")) @[intervox_transmitter.scala 97:59]
            when _T_13 : @[intervox_transmitter.scala 97:68]
              hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 99:25]
          node _T_14 = gt(bitCntr_enc, UInt<6>("h35")) @[intervox_transmitter.scala 107:31]
          node _T_15 = leq(bitCntr_enc, UInt<7>("h65")) @[intervox_transmitter.scala 107:54]
          node _T_16 = and(_T_14, _T_15) @[intervox_transmitter.scala 107:39]
          when _T_16 : @[intervox_transmitter.scala 107:64]
            node _T_17 = sub(dataIndex, UInt<5>("h17")) @[intervox_transmitter.scala 109:51]
            node _T_18 = tail(_T_17, 1) @[intervox_transmitter.scala 109:51]
            node _T_19 = sub(UInt<7>("h40"), _T_18) @[intervox_transmitter.scala 109:38]
            node _T_20 = tail(_T_19, 1) @[intervox_transmitter.scala 109:38]
            node _T_21 = dshr(stereoData, _T_20) @[intervox_transmitter.scala 109:31]
            node _T_22 = bits(_T_21, 0, 0) @[intervox_transmitter.scala 109:31]
            node _T_23 = eq(_T_22, UInt<1>("h0")) @[intervox_transmitter.scala 109:62]
            when _T_23 : @[intervox_transmitter.scala 109:71]
              hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 110:25]
          node _T_24 = gt(bitCntr_enc, UInt<7>("h65")) @[intervox_transmitter.scala 119:31]
          node _T_25 = lt(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 119:55]
          node _T_26 = and(_T_24, _T_25) @[intervox_transmitter.scala 119:40]
          when _T_26 : @[intervox_transmitter.scala 119:64]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 123:23]
          node _T_27 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 130:26]
          when _T_27 : @[intervox_transmitter.scala 130:34]
            outReg <= outReg @[intervox_transmitter.scala 132:22]
            hasNone <= UInt<1>("h0") @[intervox_transmitter.scala 133:23]
          else :
            node _outReg_T_2 = not(outReg) @[intervox_transmitter.scala 137:27]
            outReg <= _outReg_T_2 @[intervox_transmitter.scala 137:24]
        node _bitCntr_enc_T = add(bitCntr_enc, UInt<1>("h1")) @[intervox_transmitter.scala 141:38]
        node _bitCntr_enc_T_1 = tail(_bitCntr_enc_T, 1) @[intervox_transmitter.scala 141:38]
        bitCntr_enc <= _bitCntr_enc_T_1 @[intervox_transmitter.scala 141:23]
        node _T_28 = eq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 144:28]
        when _T_28 : @[intervox_transmitter.scala 144:38]
          bitCntr_enc <= UInt<1>("h0") @[intervox_transmitter.scala 145:25]
          dataIndex <= UInt<1>("h0") @[intervox_transmitter.scala 146:23]

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

  module edgeDetector :
    input clock : Clock
    input reset : Reset
    output io : { flip INPUT : UInt<1>, TRAIL : UInt<1>, RISE : UInt<1>, CHANGE : UInt<1>}

    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 160:34]
    reg inBufrPrev : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 161:34]
    reg trailing : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 162:34]
    reg rising : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 163:34]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 164:34]
    reg changed : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 165:34]
    node _T = eq(UInt<1>("h1"), io.INPUT) @[intervox_transmitter.scala 170:21]
    when _T : @[intervox_transmitter.scala 170:21]
      node _T_1 = lt(inBufr, UInt<2>("h2")) @[intervox_transmitter.scala 172:21]
      when _T_1 : @[intervox_transmitter.scala 172:27]
        node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 174:35]
        node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_transmitter.scala 174:35]
        inBufr <= _inBufr_T_1 @[intervox_transmitter.scala 174:25]
        inBufrPrev <= inBufr @[intervox_transmitter.scala 175:25]
    else :
      node _T_2 = eq(UInt<1>("h0"), io.INPUT) @[intervox_transmitter.scala 170:21]
      when _T_2 : @[intervox_transmitter.scala 170:21]
        node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_transmitter.scala 179:21]
        when _T_3 : @[intervox_transmitter.scala 179:27]
          node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 181:35]
          node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_transmitter.scala 181:35]
          inBufr <= _inBufr_T_3 @[intervox_transmitter.scala 181:25]
          inBufrPrev <= inBufr @[intervox_transmitter.scala 182:25]
    node _T_4 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 187:18]
    node _T_5 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 187:39]
    node _T_6 = or(_T_4, _T_5) @[intervox_transmitter.scala 187:27]
    when _T_6 : @[intervox_transmitter.scala 187:48]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 188:17]
    node _T_7 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_transmitter.scala 191:22]
    node _T_8 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 191:41]
    node _T_9 = and(_T_7, _T_8) @[intervox_transmitter.scala 191:31]
    when _T_9 : @[intervox_transmitter.scala 191:50]
      trailing <= UInt<1>("h0") @[intervox_transmitter.scala 192:17]
      rising <= UInt<1>("h1") @[intervox_transmitter.scala 193:17]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 194:17]
    node _T_10 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_transmitter.scala 197:22]
    node _T_11 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 197:41]
    node _T_12 = and(_T_10, _T_11) @[intervox_transmitter.scala 197:31]
    when _T_12 : @[intervox_transmitter.scala 197:50]
      trailing <= UInt<1>("h1") @[intervox_transmitter.scala 198:17]
      rising <= UInt<1>("h0") @[intervox_transmitter.scala 199:17]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 200:17]
    node _T_13 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 203:19]
    when _T_13 : @[intervox_transmitter.scala 203:27]
      trailing <= UInt<1>("h0") @[intervox_transmitter.scala 203:37]
    node _T_14 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 204:17]
    when _T_14 : @[intervox_transmitter.scala 204:27]
      rising <= UInt<1>("h0") @[intervox_transmitter.scala 204:37]
    node _T_15 = eq(change, UInt<1>("h1")) @[intervox_transmitter.scala 206:17]
    when _T_15 : @[intervox_transmitter.scala 206:25]
      reg change_REG : UInt, clock with :
        reset => (UInt<1>("h0"), change_REG) @[intervox_transmitter.scala 207:26]
      change_REG <= UInt<1>("h0") @[intervox_transmitter.scala 207:26]
      change <= change_REG @[intervox_transmitter.scala 207:16]
    io.CHANGE <= change @[intervox_transmitter.scala 210:13]
    io.TRAIL <= trailing @[intervox_transmitter.scala 211:13]
    io.RISE <= rising @[intervox_transmitter.scala 212:13]

  module edgeDetector_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip INPUT : UInt<1>, TRAIL : UInt<1>, RISE : UInt<1>, CHANGE : UInt<1>}

    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 160:34]
    reg inBufrPrev : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 161:34]
    reg trailing : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 162:34]
    reg rising : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 163:34]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 164:34]
    reg changed : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 165:34]
    node _T = eq(UInt<1>("h1"), io.INPUT) @[intervox_transmitter.scala 170:21]
    when _T : @[intervox_transmitter.scala 170:21]
      node _T_1 = lt(inBufr, UInt<2>("h2")) @[intervox_transmitter.scala 172:21]
      when _T_1 : @[intervox_transmitter.scala 172:27]
        node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 174:35]
        node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_transmitter.scala 174:35]
        inBufr <= _inBufr_T_1 @[intervox_transmitter.scala 174:25]
        inBufrPrev <= inBufr @[intervox_transmitter.scala 175:25]
    else :
      node _T_2 = eq(UInt<1>("h0"), io.INPUT) @[intervox_transmitter.scala 170:21]
      when _T_2 : @[intervox_transmitter.scala 170:21]
        node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_transmitter.scala 179:21]
        when _T_3 : @[intervox_transmitter.scala 179:27]
          node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 181:35]
          node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_transmitter.scala 181:35]
          inBufr <= _inBufr_T_3 @[intervox_transmitter.scala 181:25]
          inBufrPrev <= inBufr @[intervox_transmitter.scala 182:25]
    node _T_4 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 187:18]
    node _T_5 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 187:39]
    node _T_6 = or(_T_4, _T_5) @[intervox_transmitter.scala 187:27]
    when _T_6 : @[intervox_transmitter.scala 187:48]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 188:17]
    node _T_7 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_transmitter.scala 191:22]
    node _T_8 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 191:41]
    node _T_9 = and(_T_7, _T_8) @[intervox_transmitter.scala 191:31]
    when _T_9 : @[intervox_transmitter.scala 191:50]
      trailing <= UInt<1>("h0") @[intervox_transmitter.scala 192:17]
      rising <= UInt<1>("h1") @[intervox_transmitter.scala 193:17]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 194:17]
    node _T_10 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_transmitter.scala 197:22]
    node _T_11 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 197:41]
    node _T_12 = and(_T_10, _T_11) @[intervox_transmitter.scala 197:31]
    when _T_12 : @[intervox_transmitter.scala 197:50]
      trailing <= UInt<1>("h1") @[intervox_transmitter.scala 198:17]
      rising <= UInt<1>("h0") @[intervox_transmitter.scala 199:17]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 200:17]
    node _T_13 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 203:19]
    when _T_13 : @[intervox_transmitter.scala 203:27]
      trailing <= UInt<1>("h0") @[intervox_transmitter.scala 203:37]
    node _T_14 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 204:17]
    when _T_14 : @[intervox_transmitter.scala 204:27]
      rising <= UInt<1>("h0") @[intervox_transmitter.scala 204:37]
    node _T_15 = eq(change, UInt<1>("h1")) @[intervox_transmitter.scala 206:17]
    when _T_15 : @[intervox_transmitter.scala 206:25]
      reg change_REG : UInt, clock with :
        reset => (UInt<1>("h0"), change_REG) @[intervox_transmitter.scala 207:26]
      change_REG <= UInt<1>("h0") @[intervox_transmitter.scala 207:26]
      change <= change_REG @[intervox_transmitter.scala 207:16]
    io.CHANGE <= change @[intervox_transmitter.scala 210:13]
    io.TRAIL <= trailing @[intervox_transmitter.scala 211:13]
    io.RISE <= rising @[intervox_transmitter.scala 212:13]

  module interVox_Encoder :
    input clock : Clock
    input reset : UInt<1>
    output io : { MCLK_O : Clock, flip BCLK_IN : UInt<1>, flip LRCLK_IN : UInt<1>, flip SDATA_IN : UInt<1>, DATA_O : UInt<1>, LRCLK_O : UInt<1>, BCLK_O : UInt<1>, SDATA_O : UInt<1>, NXT_FRAME : UInt<1>}

    reg current_state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 230:34]
    reg syncing : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 232:34]
    reg synced : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 233:34]
    reg clkCntr1 : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[intervox_transmitter.scala 237:35]
    reg fuckyou : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 238:35]
    reg bclkR : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[intervox_transmitter.scala 242:34]
    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 244:33]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    reg encoderClk : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 246:34]
    reg bitCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 248:34]
    inst BFR of RWSmem @[intervox_transmitter.scala 250:33]
    BFR.clock <= clock
    BFR.reset <= reset
    inst BFR1 of RWSmem_1 @[intervox_transmitter.scala 251:33]
    BFR1.clock <= clock
    BFR1.reset <= reset
    inst LREDGE of edgeDetector @[intervox_transmitter.scala 253:33]
    LREDGE.clock <= clock
    LREDGE.reset <= reset
    LREDGE.io.INPUT <= io.LRCLK_IN @[intervox_transmitter.scala 254:25]
    inst BCLKEDGE of edgeDetector_1 @[intervox_transmitter.scala 255:33]
    BCLKEDGE.clock <= clock
    BCLKEDGE.reset <= reset
    BCLKEDGE.io.INPUT <= io.BCLK_IN @[intervox_transmitter.scala 256:25]
    io.DATA_O <= bi_phase_enc.io.DATA_OUT @[intervox_transmitter.scala 259:25]
    io.MCLK_O <= clock @[intervox_transmitter.scala 260:25]
    io.BCLK_O <= io.BCLK_IN @[intervox_transmitter.scala 261:25]
    io.LRCLK_O <= io.LRCLK_IN @[intervox_transmitter.scala 262:25]
    io.SDATA_O <= io.SDATA_IN @[intervox_transmitter.scala 263:25]
    BFR.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 266:25]
    BFR.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 267:25]
    BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 268:25]
    BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 269:25]
    BFR1.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 270:25]
    BFR1.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 271:25]
    BFR1.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 272:25]
    BFR1.io.dataIn <= BFR.io.dataOut @[intervox_transmitter.scala 273:25]
    io.NXT_FRAME <= bi_phase_enc.io.TRIG @[intervox_transmitter.scala 276:31]
    bi_phase_enc.io.CLK <= encoderClk @[intervox_transmitter.scala 278:31]
    bi_phase_enc.io.ENA <= UInt<1>("h0") @[intervox_transmitter.scala 279:31]
    bi_phase_enc.io.TRIG <= BCLKEDGE.io.CHANGE @[intervox_transmitter.scala 280:31]
    bi_phase_enc.io.AUDIOINPUT <= BFR1.io.dataOut @[intervox_transmitter.scala 282:31]
    bi_phase_enc.io.DSPINPUT <= UInt<1>("h0") @[intervox_transmitter.scala 284:31]
    node _T = eq(synced, UInt<1>("h0")) @[intervox_transmitter.scala 301:15]
    when _T : @[intervox_transmitter.scala 301:23]
      node _T_1 = eq(LREDGE.io.TRAIL, UInt<1>("h1")) @[intervox_transmitter.scala 303:26]
      when _T_1 : @[intervox_transmitter.scala 303:34]
        syncing <= UInt<1>("h1") @[intervox_transmitter.scala 304:15]
      node _T_2 = eq(syncing, UInt<1>("h1")) @[intervox_transmitter.scala 306:19]
      when _T_2 : @[intervox_transmitter.scala 306:27]
        node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 307:30]
        node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 307:30]
        bitCntr <= _bitCntr_T_1 @[intervox_transmitter.scala 307:19]
        node _T_3 = eq(bitCntr, UInt<7>("h7c")) @[intervox_transmitter.scala 309:20]
        when _T_3 : @[intervox_transmitter.scala 309:30]
          synced <= UInt<1>("h1") @[intervox_transmitter.scala 310:19]
          bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 311:19]
    node _T_4 = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 323:24]
    when _T_4 : @[intervox_transmitter.scala 323:24]
      current_state <= UInt<2>("h2") @[intervox_transmitter.scala 327:21]
    else :
      node _T_5 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 323:24]
      when _T_5 : @[intervox_transmitter.scala 323:24]
        current_state <= UInt<2>("h2") @[intervox_transmitter.scala 331:21]
      else :
        node _T_6 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 323:24]
        when _T_6 : @[intervox_transmitter.scala 323:24]
          node _T_7 = eq(synced, UInt<1>("h1")) @[intervox_transmitter.scala 335:19]
          when _T_7 : @[intervox_transmitter.scala 335:27]
            bi_phase_enc.io.ENA <= UInt<1>("h1") @[intervox_transmitter.scala 342:29]
            node _encoderClk_T = not(encoderClk) @[intervox_transmitter.scala 345:23]
            encoderClk <= _encoderClk_T @[intervox_transmitter.scala 345:20]
            node _clkCntr1_T = add(clkCntr1, UInt<1>("h1")) @[intervox_transmitter.scala 347:30]
            node _clkCntr1_T_1 = tail(_clkCntr1_T, 1) @[intervox_transmitter.scala 347:30]
            clkCntr1 <= _clkCntr1_T_1 @[intervox_transmitter.scala 347:18]
            node _T_8 = eq(clkCntr1, UInt<2>("h3")) @[intervox_transmitter.scala 348:23]
            when _T_8 : @[intervox_transmitter.scala 348:31]
              clkCntr1 <= UInt<1>("h0") @[intervox_transmitter.scala 348:41]
            node _T_9 = eq(clkCntr1, UInt<1>("h1")) @[intervox_transmitter.scala 350:23]
            when _T_9 : @[intervox_transmitter.scala 350:31]
              node _bitCntr_T_2 = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 353:30]
              node _bitCntr_T_3 = tail(_bitCntr_T_2, 1) @[intervox_transmitter.scala 353:30]
              bitCntr <= _bitCntr_T_3 @[intervox_transmitter.scala 353:19]
              node _T_10 = eq(bitCntr, UInt<1>("h0")) @[intervox_transmitter.scala 357:24]
              when _T_10 : @[intervox_transmitter.scala 357:32]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 359:31]
                BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 360:31]
              node _T_11 = gt(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 364:24]
              when _T_11 : @[intervox_transmitter.scala 364:31]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 369:31]
                node _T_12 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 371:30]
                when _T_12 : @[intervox_transmitter.scala 371:38]
                  node _BFR_io_dataIn_T = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 373:67]
                  node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 373:67]
                  node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 373:58]
                  node _BFR_io_dataIn_T_3 = add(BFR.io.dataOut, _BFR_io_dataIn_T_2) @[intervox_transmitter.scala 373:51]
                  node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_transmitter.scala 373:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_4 @[intervox_transmitter.scala 373:33]
                node _T_13 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 376:30]
                when _T_13 : @[intervox_transmitter.scala 376:38]
                  node _BFR_io_dataIn_T_5 = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 377:68]
                  node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_transmitter.scala 377:68]
                  node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 377:58]
                  node _BFR_io_dataIn_T_8 = add(BFR.io.dataOut, _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 377:51]
                  node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 377:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_9 @[intervox_transmitter.scala 377:33]
              else :
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 383:31]
                node _T_14 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 385:30]
                when _T_14 : @[intervox_transmitter.scala 385:39]
                  node _BFR_io_dataIn_T_10 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 387:67]
                  node _BFR_io_dataIn_T_11 = tail(_BFR_io_dataIn_T_10, 1) @[intervox_transmitter.scala 387:67]
                  node _BFR_io_dataIn_T_12 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_11) @[intervox_transmitter.scala 387:58]
                  node _BFR_io_dataIn_T_13 = add(BFR.io.dataOut, _BFR_io_dataIn_T_12) @[intervox_transmitter.scala 387:51]
                  node _BFR_io_dataIn_T_14 = tail(_BFR_io_dataIn_T_13, 1) @[intervox_transmitter.scala 387:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_14 @[intervox_transmitter.scala 387:33]
                node _T_15 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 390:30]
                when _T_15 : @[intervox_transmitter.scala 390:38]
                  node _BFR_io_dataIn_T_15 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 391:67]
                  node _BFR_io_dataIn_T_16 = tail(_BFR_io_dataIn_T_15, 1) @[intervox_transmitter.scala 391:67]
                  node _BFR_io_dataIn_T_17 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_16) @[intervox_transmitter.scala 391:58]
                  node _BFR_io_dataIn_T_18 = add(BFR.io.dataOut, _BFR_io_dataIn_T_17) @[intervox_transmitter.scala 391:51]
                  node _BFR_io_dataIn_T_19 = tail(_BFR_io_dataIn_T_18, 1) @[intervox_transmitter.scala 391:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_19 @[intervox_transmitter.scala 391:33]
              node _T_16 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 410:25]
              when _T_16 : @[intervox_transmitter.scala 410:35]
                BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 413:31]
                BFR1.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 414:31]
                node _fuckyou_T = not(fuckyou) @[intervox_transmitter.scala 416:24]
                fuckyou <= _fuckyou_T @[intervox_transmitter.scala 416:21]
                node _T_17 = eq(fuckyou, UInt<1>("h1")) @[intervox_transmitter.scala 418:26]
                when _T_17 : @[intervox_transmitter.scala 418:34]
                  node _BFR1_io_dataIn_T = dshl(UInt<16>("haaaa"), UInt<6>("h30")) @[intervox_transmitter.scala 419:45]
                  BFR1.io.dataIn <= _BFR1_io_dataIn_T @[intervox_transmitter.scala 419:33]
                else :
                  node _BFR1_io_dataIn_T_1 = dshl(UInt<16>("haaab"), UInt<6>("h30")) @[intervox_transmitter.scala 421:45]
                  BFR1.io.dataIn <= _BFR1_io_dataIn_T_1 @[intervox_transmitter.scala 421:33]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 427:28]
                BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 428:28]
                bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 430:21]

