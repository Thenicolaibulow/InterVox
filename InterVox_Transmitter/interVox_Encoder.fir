circuit interVox_Encoder :
  module bi_phase_encoder :
    input clock : Clock
    input reset : Reset
    output io : { DATA_OUT : UInt<1>, flip AUDIOINPUT : UInt<64>, flip DSPINPUT : UInt<64>, flip TICK : UInt<1>, NEXT : UInt<1>}

    reg outReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 38:32]
    reg next : UInt<1>, clock with :
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
    stereoData <= io.AUDIOINPUT @[intervox_transmitter.scala 48:16]
    dspData <= io.DSPINPUT @[intervox_transmitter.scala 49:13]
    io.NEXT <= next @[intervox_transmitter.scala 50:13]
    reg ndexR : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 52:32]
    node _T = eq(io.TICK, UInt<1>("h0")) @[intervox_transmitter.scala 56:18]
    when _T : @[intervox_transmitter.scala 56:26]
      node _bitCntr_enc_T = add(bitCntr_enc, UInt<1>("h1")) @[intervox_transmitter.scala 58:36]
      node _bitCntr_enc_T_1 = tail(_bitCntr_enc_T, 1) @[intervox_transmitter.scala 58:36]
      bitCntr_enc <= _bitCntr_enc_T_1 @[intervox_transmitter.scala 58:21]
      node _ndexR_T = not(ndexR) @[intervox_transmitter.scala 61:18]
      ndexR <= _ndexR_T @[intervox_transmitter.scala 61:15]
      node _T_1 = eq(ndexR, UInt<1>("h1")) @[intervox_transmitter.scala 62:20]
      when _T_1 : @[intervox_transmitter.scala 62:28]
        node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 64:34]
        node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 64:34]
        dataIndex <= _dataIndex_T_1 @[intervox_transmitter.scala 64:21]
      node _T_2 = lt(bitCntr_enc, UInt<3>("h7")) @[intervox_transmitter.scala 68:26]
      when _T_2 : @[intervox_transmitter.scala 68:33]
        node _T_3 = lt(bitCntr_enc, UInt<3>("h6")) @[intervox_transmitter.scala 71:28]
        when _T_3 : @[intervox_transmitter.scala 72:11]
          outReg <= UInt<1>("h0") @[intervox_transmitter.scala 73:20]
        else :
          outReg <= UInt<1>("h1") @[intervox_transmitter.scala 77:20]
      node _T_4 = gt(bitCntr_enc, UInt<3>("h7")) @[intervox_transmitter.scala 81:27]
      when _T_4 : @[intervox_transmitter.scala 81:34]
        node _T_5 = lt(bitCntr_enc, UInt<6>("h37")) @[intervox_transmitter.scala 84:28]
        when _T_5 : @[intervox_transmitter.scala 84:35]
          node _T_6 = sub(dataIndex, UInt<2>("h3")) @[intervox_transmitter.scala 86:48]
          node _T_7 = tail(_T_6, 1) @[intervox_transmitter.scala 86:48]
          node _T_8 = sub(UInt<7>("h40"), _T_7) @[intervox_transmitter.scala 86:35]
          node _T_9 = tail(_T_8, 1) @[intervox_transmitter.scala 86:35]
          node _T_10 = dshr(stereoData, _T_9) @[intervox_transmitter.scala 86:29]
          node _T_11 = bits(_T_10, 0, 0) @[intervox_transmitter.scala 86:29]
          node _T_12 = eq(_T_11, UInt<1>("h0")) @[intervox_transmitter.scala 86:58]
          when _T_12 : @[intervox_transmitter.scala 86:67]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 88:23]
        node _T_13 = geq(bitCntr_enc, UInt<6>("h37")) @[intervox_transmitter.scala 91:29]
        node _T_14 = lt(bitCntr_enc, UInt<7>("h67")) @[intervox_transmitter.scala 91:53]
        node _T_15 = and(_T_13, _T_14) @[intervox_transmitter.scala 91:38]
        when _T_15 : @[intervox_transmitter.scala 91:62]
          node _T_16 = sub(dataIndex, UInt<5>("h1b")) @[intervox_transmitter.scala 93:49]
          node _T_17 = tail(_T_16, 1) @[intervox_transmitter.scala 93:49]
          node _T_18 = sub(UInt<7>("h40"), _T_17) @[intervox_transmitter.scala 93:36]
          node _T_19 = tail(_T_18, 1) @[intervox_transmitter.scala 93:36]
          node _T_20 = dshr(stereoData, _T_19) @[intervox_transmitter.scala 93:29]
          node _T_21 = bits(_T_20, 0, 0) @[intervox_transmitter.scala 93:29]
          node _T_22 = eq(_T_21, UInt<1>("h0")) @[intervox_transmitter.scala 93:61]
          when _T_22 : @[intervox_transmitter.scala 93:70]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 95:23]
        node _T_23 = geq(bitCntr_enc, UInt<7>("h67")) @[intervox_transmitter.scala 99:29]
        node _T_24 = lt(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 99:54]
        node _T_25 = and(_T_23, _T_24) @[intervox_transmitter.scala 99:39]
        when _T_25 : @[intervox_transmitter.scala 99:63]
          node _T_26 = sub(dataIndex, UInt<6>("h34")) @[intervox_transmitter.scala 103:40]
          node _T_27 = tail(_T_26, 1) @[intervox_transmitter.scala 103:40]
          node _T_28 = dshr(dspData, _T_27) @[intervox_transmitter.scala 103:28]
          node _T_29 = bits(_T_28, 0, 0) @[intervox_transmitter.scala 103:28]
          node _T_30 = eq(_T_29, UInt<1>("h0")) @[intervox_transmitter.scala 103:51]
          when _T_30 : @[intervox_transmitter.scala 103:60]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 105:23]
        node _T_31 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 109:24]
        when _T_31 : @[intervox_transmitter.scala 109:32]
          outReg <= outReg @[intervox_transmitter.scala 110:20]
          hasNone <= UInt<1>("h0") @[intervox_transmitter.scala 111:21]
        else :
          node _outReg_T = not(outReg) @[intervox_transmitter.scala 115:23]
          outReg <= _outReg_T @[intervox_transmitter.scala 115:20]
      node _T_32 = eq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 119:26]
      when _T_32 : @[intervox_transmitter.scala 119:36]
        bitCntr_enc <= UInt<1>("h0") @[intervox_transmitter.scala 120:23]

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

  module interVox_Encoder :
    input clock : Clock
    input reset : UInt<1>
    output io : { MCLK_O : Clock, flip BCLK_IN : UInt<1>, flip LRCLK_IN : UInt<1>, flip SDATA_IN : UInt<1>, DATA_O : UInt<1>, LRCLK_O : UInt<1>, BCLK_O : UInt<1>, SDATA_O : UInt<1>, NXT_FRAME : UInt<1>}

    reg current_state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 141:34]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 143:34]
    reg DATA_OUT_REG_1B : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 145:34]
    reg FirstFrame : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 147:34]
    reg synced : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 149:34]
    reg bclkR : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[intervox_transmitter.scala 151:34]
    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 153:33]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    reg bitCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 155:34]
    inst BFR of RWSmem @[intervox_transmitter.scala 157:33]
    BFR.clock <= clock
    BFR.reset <= reset
    inst BFR1 of RWSmem_1 @[intervox_transmitter.scala 158:33]
    BFR1.clock <= clock
    BFR1.reset <= reset
    io.DATA_O <= bi_phase_enc.io.DATA_OUT @[intervox_transmitter.scala 161:25]
    io.MCLK_O <= clock @[intervox_transmitter.scala 162:25]
    io.BCLK_O <= io.BCLK_IN @[intervox_transmitter.scala 163:25]
    io.LRCLK_O <= io.LRCLK_IN @[intervox_transmitter.scala 164:25]
    io.SDATA_O <= io.SDATA_IN @[intervox_transmitter.scala 165:25]
    BFR.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 168:25]
    BFR.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 169:25]
    BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 170:25]
    BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 171:25]
    BFR1.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 172:25]
    BFR1.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 173:25]
    BFR1.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 174:25]
    BFR1.io.dataIn <= BFR.io.dataOut @[intervox_transmitter.scala 175:25]
    io.NXT_FRAME <= bi_phase_enc.io.TICK @[intervox_transmitter.scala 178:25]
    bi_phase_enc.io.TICK <= UInt<1>("h1") @[intervox_transmitter.scala 180:31]
    bi_phase_enc.io.AUDIOINPUT <= BFR1.io.dataOut @[intervox_transmitter.scala 182:31]
    bi_phase_enc.io.DSPINPUT <= UInt<1>("h0") @[intervox_transmitter.scala 184:31]
    node _T = eq(synced, UInt<1>("h0")) @[intervox_transmitter.scala 206:15]
    when _T : @[intervox_transmitter.scala 206:23]
      node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 207:42]
      node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 207:42]
      BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_1 @[intervox_transmitter.scala 207:22]
      node _T_1 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 209:27]
      when _T_1 : @[intervox_transmitter.scala 209:35]
        BiPhase_CLK_CNTR <= UInt<1>("h0") @[intervox_transmitter.scala 210:24]
        node _T_2 = eq(io.LRCLK_IN, UInt<1>("h1")) @[intervox_transmitter.scala 212:24]
        when _T_2 : @[intervox_transmitter.scala 212:32]
          bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 213:17]
        node _T_3 = eq(io.LRCLK_IN, UInt<1>("h0")) @[intervox_transmitter.scala 216:24]
        when _T_3 : @[intervox_transmitter.scala 216:32]
          node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 217:28]
          node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 217:28]
          bitCntr <= _bitCntr_T_1 @[intervox_transmitter.scala 217:17]
          node _T_4 = eq(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 219:22]
          when _T_4 : @[intervox_transmitter.scala 219:31]
            bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 220:19]
            synced <= UInt<1>("h1") @[intervox_transmitter.scala 221:18]
    node _T_5 = eq(synced, UInt<1>("h1")) @[intervox_transmitter.scala 233:15]
    when _T_5 : @[intervox_transmitter.scala 233:23]
      node _T_6 = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 235:26]
      when _T_6 : @[intervox_transmitter.scala 235:26]
        current_state <= UInt<2>("h2") @[intervox_transmitter.scala 239:23]
      else :
        node _T_7 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 235:26]
        when _T_7 : @[intervox_transmitter.scala 235:26]
          current_state <= UInt<2>("h2") @[intervox_transmitter.scala 243:23]
        else :
          node _T_8 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 235:26]
          when _T_8 : @[intervox_transmitter.scala 235:26]
            node _bclkR_T = not(bclkR) @[intervox_transmitter.scala 247:19]
            bclkR <= _bclkR_T @[intervox_transmitter.scala 247:16]
            node _T_9 = eq(bclkR, UInt<1>("h0")) @[intervox_transmitter.scala 249:20]
            when _T_9 : @[intervox_transmitter.scala 249:28]
              bi_phase_enc.io.TICK <= UInt<1>("h0") @[intervox_transmitter.scala 250:32]
            node _BiPhase_CLK_CNTR_T_2 = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 253:46]
            node _BiPhase_CLK_CNTR_T_3 = tail(_BiPhase_CLK_CNTR_T_2, 1) @[intervox_transmitter.scala 253:46]
            BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_3 @[intervox_transmitter.scala 253:26]
            node _T_10 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 259:31]
            when _T_10 : @[intervox_transmitter.scala 259:39]
              BiPhase_CLK_CNTR <= UInt<1>("h0") @[intervox_transmitter.scala 260:28]
              node _bitCntr_T_2 = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 263:30]
              node _bitCntr_T_3 = tail(_bitCntr_T_2, 1) @[intervox_transmitter.scala 263:30]
              bitCntr <= _bitCntr_T_3 @[intervox_transmitter.scala 263:19]
              node _T_11 = eq(bitCntr, UInt<1>("h0")) @[intervox_transmitter.scala 267:24]
              when _T_11 : @[intervox_transmitter.scala 267:32]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 269:31]
                BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 270:31]
              node _T_12 = gt(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 273:24]
              when _T_12 : @[intervox_transmitter.scala 273:31]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 278:31]
                node _T_13 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 280:30]
                when _T_13 : @[intervox_transmitter.scala 280:38]
                  node _BFR_io_dataIn_T = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 282:67]
                  node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 282:67]
                  node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 282:58]
                  node _BFR_io_dataIn_T_3 = add(BFR.io.dataOut, _BFR_io_dataIn_T_2) @[intervox_transmitter.scala 282:51]
                  node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_transmitter.scala 282:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_4 @[intervox_transmitter.scala 282:33]
                node _T_14 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 285:30]
                when _T_14 : @[intervox_transmitter.scala 285:38]
                  node _BFR_io_dataIn_T_5 = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 286:68]
                  node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_transmitter.scala 286:68]
                  node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 286:58]
                  node _BFR_io_dataIn_T_8 = add(BFR.io.dataOut, _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 286:51]
                  node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 286:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_9 @[intervox_transmitter.scala 286:33]
              else :
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 292:31]
                node _T_15 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 294:30]
                when _T_15 : @[intervox_transmitter.scala 294:39]
                  node _BFR_io_dataIn_T_10 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 296:67]
                  node _BFR_io_dataIn_T_11 = tail(_BFR_io_dataIn_T_10, 1) @[intervox_transmitter.scala 296:67]
                  node _BFR_io_dataIn_T_12 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_11) @[intervox_transmitter.scala 296:58]
                  node _BFR_io_dataIn_T_13 = add(BFR.io.dataOut, _BFR_io_dataIn_T_12) @[intervox_transmitter.scala 296:51]
                  node _BFR_io_dataIn_T_14 = tail(_BFR_io_dataIn_T_13, 1) @[intervox_transmitter.scala 296:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_14 @[intervox_transmitter.scala 296:33]
                node _T_16 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 299:30]
                when _T_16 : @[intervox_transmitter.scala 299:38]
                  node _BFR_io_dataIn_T_15 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 300:67]
                  node _BFR_io_dataIn_T_16 = tail(_BFR_io_dataIn_T_15, 1) @[intervox_transmitter.scala 300:67]
                  node _BFR_io_dataIn_T_17 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_16) @[intervox_transmitter.scala 300:58]
                  node _BFR_io_dataIn_T_18 = add(BFR.io.dataOut, _BFR_io_dataIn_T_17) @[intervox_transmitter.scala 300:51]
                  node _BFR_io_dataIn_T_19 = tail(_BFR_io_dataIn_T_18, 1) @[intervox_transmitter.scala 300:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_19 @[intervox_transmitter.scala 300:33]
              node _T_17 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 304:24]
              when _T_17 : @[intervox_transmitter.scala 304:33]
                BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 307:31]
                BFR1.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 308:31]
                BFR1.io.dataIn <= BFR.io.dataOut @[intervox_transmitter.scala 309:31]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 312:28]
                BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 313:28]
                bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 315:21]

