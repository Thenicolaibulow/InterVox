circuit interVox_Encoder :
  module bi_phase_encoder :
    input clock : Clock
    input reset : Reset
    output io : { DATA_OUT : UInt<1>, flip AUDIOINPUT : UInt<64>, flip DSPINPUT : UInt<64>, flip ENA : UInt<1>, NEXT : UInt<1>}

    reg outReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 38:32]
    reg next : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 39:32]
    reg stereoData : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[intervox_transmitter.scala 40:32]
    reg dspData : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[intervox_transmitter.scala 41:32]
    reg dspData2 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[intervox_transmitter.scala 42:32]
    reg bitCntr_enc : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 43:32]
    reg hasNone : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 44:32]
    reg dataIndex : UInt<6>, clock with :
      reset => (reset, UInt<6>("h0")) @[intervox_transmitter.scala 45:32]
    io.DATA_OUT <= outReg @[intervox_transmitter.scala 47:17]
    stereoData <= io.AUDIOINPUT @[intervox_transmitter.scala 49:17]
    dspData <= io.DSPINPUT @[intervox_transmitter.scala 50:17]
    dspData2 <= UInt<1>("h0") @[intervox_transmitter.scala 51:17]
    io.NEXT <= next @[intervox_transmitter.scala 52:17]
    reg ndexR : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 54:32]
    node _T = eq(io.ENA, UInt<1>("h1")) @[intervox_transmitter.scala 58:17]
    when _T : @[intervox_transmitter.scala 58:25]
      node _bitCntr_enc_T = add(bitCntr_enc, UInt<1>("h1")) @[intervox_transmitter.scala 60:36]
      node _bitCntr_enc_T_1 = tail(_bitCntr_enc_T, 1) @[intervox_transmitter.scala 60:36]
      bitCntr_enc <= _bitCntr_enc_T_1 @[intervox_transmitter.scala 60:21]
      node _ndexR_T = not(ndexR) @[intervox_transmitter.scala 63:18]
      ndexR <= _ndexR_T @[intervox_transmitter.scala 63:15]
      node _T_1 = eq(ndexR, UInt<1>("h1")) @[intervox_transmitter.scala 64:20]
      when _T_1 : @[intervox_transmitter.scala 64:28]
        node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 66:34]
        node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 66:34]
        dataIndex <= _dataIndex_T_1 @[intervox_transmitter.scala 66:21]
      node _T_2 = lt(bitCntr_enc, UInt<3>("h7")) @[intervox_transmitter.scala 70:26]
      when _T_2 : @[intervox_transmitter.scala 70:33]
        node _T_3 = lt(bitCntr_enc, UInt<3>("h6")) @[intervox_transmitter.scala 73:28]
        when _T_3 : @[intervox_transmitter.scala 74:11]
          outReg <= UInt<1>("h0") @[intervox_transmitter.scala 75:20]
        else :
          outReg <= UInt<1>("h1") @[intervox_transmitter.scala 79:20]
      node _T_4 = gt(bitCntr_enc, UInt<3>("h7")) @[intervox_transmitter.scala 83:27]
      when _T_4 : @[intervox_transmitter.scala 83:34]
        node _T_5 = lt(bitCntr_enc, UInt<6>("h37")) @[intervox_transmitter.scala 86:28]
        when _T_5 : @[intervox_transmitter.scala 86:35]
          node _T_6 = sub(dataIndex, UInt<2>("h3")) @[intervox_transmitter.scala 88:48]
          node _T_7 = tail(_T_6, 1) @[intervox_transmitter.scala 88:48]
          node _T_8 = sub(UInt<7>("h40"), _T_7) @[intervox_transmitter.scala 88:35]
          node _T_9 = tail(_T_8, 1) @[intervox_transmitter.scala 88:35]
          node _T_10 = dshr(stereoData, _T_9) @[intervox_transmitter.scala 88:29]
          node _T_11 = bits(_T_10, 0, 0) @[intervox_transmitter.scala 88:29]
          node _T_12 = eq(_T_11, UInt<1>("h0")) @[intervox_transmitter.scala 88:58]
          when _T_12 : @[intervox_transmitter.scala 88:67]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 90:23]
        node _T_13 = geq(bitCntr_enc, UInt<6>("h37")) @[intervox_transmitter.scala 93:29]
        node _T_14 = lt(bitCntr_enc, UInt<7>("h67")) @[intervox_transmitter.scala 93:53]
        node _T_15 = and(_T_13, _T_14) @[intervox_transmitter.scala 93:38]
        when _T_15 : @[intervox_transmitter.scala 93:62]
          node _T_16 = sub(dataIndex, UInt<5>("h1b")) @[intervox_transmitter.scala 95:49]
          node _T_17 = tail(_T_16, 1) @[intervox_transmitter.scala 95:49]
          node _T_18 = sub(UInt<7>("h40"), _T_17) @[intervox_transmitter.scala 95:36]
          node _T_19 = tail(_T_18, 1) @[intervox_transmitter.scala 95:36]
          node _T_20 = dshr(stereoData, _T_19) @[intervox_transmitter.scala 95:29]
          node _T_21 = bits(_T_20, 0, 0) @[intervox_transmitter.scala 95:29]
          node _T_22 = eq(_T_21, UInt<1>("h0")) @[intervox_transmitter.scala 95:61]
          when _T_22 : @[intervox_transmitter.scala 95:70]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 97:23]
        node _T_23 = geq(bitCntr_enc, UInt<7>("h67")) @[intervox_transmitter.scala 101:29]
        node _T_24 = lt(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 101:54]
        node _T_25 = and(_T_23, _T_24) @[intervox_transmitter.scala 101:39]
        when _T_25 : @[intervox_transmitter.scala 101:63]
          node _T_26 = sub(dataIndex, UInt<6>("h34")) @[intervox_transmitter.scala 105:40]
          node _T_27 = tail(_T_26, 1) @[intervox_transmitter.scala 105:40]
          node _T_28 = dshr(dspData, _T_27) @[intervox_transmitter.scala 105:28]
          node _T_29 = bits(_T_28, 0, 0) @[intervox_transmitter.scala 105:28]
          node _T_30 = eq(_T_29, UInt<1>("h0")) @[intervox_transmitter.scala 105:51]
          when _T_30 : @[intervox_transmitter.scala 105:60]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 107:23]
        node _T_31 = geq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 111:29]
        node _T_32 = lt(bitCntr_enc, UInt<8>("hff")) @[intervox_transmitter.scala 111:54]
        node _T_33 = and(_T_31, _T_32) @[intervox_transmitter.scala 111:39]
        when _T_33 : @[intervox_transmitter.scala 111:63]
          node _T_34 = sub(dataIndex, UInt<7>("h40")) @[intervox_transmitter.scala 115:41]
          node _T_35 = tail(_T_34, 1) @[intervox_transmitter.scala 115:41]
          node _T_36 = dshr(dspData2, _T_35) @[intervox_transmitter.scala 115:29]
          node _T_37 = bits(_T_36, 0, 0) @[intervox_transmitter.scala 115:29]
          node _T_38 = eq(_T_37, UInt<1>("h0")) @[intervox_transmitter.scala 115:52]
          when _T_38 : @[intervox_transmitter.scala 115:61]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 117:23]
        node _T_39 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 121:24]
        when _T_39 : @[intervox_transmitter.scala 121:32]
          outReg <= outReg @[intervox_transmitter.scala 122:20]
          hasNone <= UInt<1>("h0") @[intervox_transmitter.scala 123:21]
        else :
          node _outReg_T = not(outReg) @[intervox_transmitter.scala 127:23]
          outReg <= _outReg_T @[intervox_transmitter.scala 127:20]
      node _T_40 = eq(bitCntr_enc, UInt<8>("hff")) @[intervox_transmitter.scala 131:26]
      when _T_40 : @[intervox_transmitter.scala 131:36]
        bitCntr_enc <= UInt<1>("h0") @[intervox_transmitter.scala 132:23]

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
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 153:34]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 155:34]
    reg DATA_OUT_REG_1B : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 157:34]
    reg FirstFrame : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 159:34]
    reg synced : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 161:34]
    reg bclkR : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[intervox_transmitter.scala 163:34]
    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 165:33]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    reg bitCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 167:34]
    inst BFR of RWSmem @[intervox_transmitter.scala 169:33]
    BFR.clock <= clock
    BFR.reset <= reset
    inst BFR1 of RWSmem_1 @[intervox_transmitter.scala 170:33]
    BFR1.clock <= clock
    BFR1.reset <= reset
    io.DATA_O <= bi_phase_enc.io.DATA_OUT @[intervox_transmitter.scala 173:25]
    io.MCLK_O <= clock @[intervox_transmitter.scala 174:25]
    io.BCLK_O <= io.BCLK_IN @[intervox_transmitter.scala 175:25]
    io.LRCLK_O <= io.LRCLK_IN @[intervox_transmitter.scala 176:25]
    io.SDATA_O <= io.SDATA_IN @[intervox_transmitter.scala 177:25]
    BFR.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 180:25]
    BFR.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 181:25]
    BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 182:25]
    BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 183:25]
    BFR1.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 184:25]
    BFR1.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 185:25]
    BFR1.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 186:25]
    BFR1.io.dataIn <= BFR.io.dataOut @[intervox_transmitter.scala 187:25]
    io.NXT_FRAME <= bi_phase_enc.io.ENA @[intervox_transmitter.scala 190:31]
    bi_phase_enc.io.ENA <= UInt<1>("h0") @[intervox_transmitter.scala 193:31]
    bi_phase_enc.io.AUDIOINPUT <= BFR1.io.dataOut @[intervox_transmitter.scala 195:31]
    bi_phase_enc.io.DSPINPUT <= UInt<1>("h0") @[intervox_transmitter.scala 197:31]
    node _T = eq(synced, UInt<1>("h0")) @[intervox_transmitter.scala 214:15]
    when _T : @[intervox_transmitter.scala 214:23]
      node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 216:42]
      node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 216:42]
      BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_1 @[intervox_transmitter.scala 216:22]
      node _T_1 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 218:27]
      when _T_1 : @[intervox_transmitter.scala 218:35]
        BiPhase_CLK_CNTR <= UInt<1>("h0") @[intervox_transmitter.scala 219:24]
        node _T_2 = eq(io.LRCLK_IN, UInt<1>("h1")) @[intervox_transmitter.scala 221:24]
        when _T_2 : @[intervox_transmitter.scala 221:32]
          bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 222:17]
        node _T_3 = eq(io.LRCLK_IN, UInt<1>("h0")) @[intervox_transmitter.scala 225:24]
        when _T_3 : @[intervox_transmitter.scala 225:32]
          node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 226:28]
          node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 226:28]
          bitCntr <= _bitCntr_T_1 @[intervox_transmitter.scala 226:17]
          node _T_4 = eq(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 228:22]
          when _T_4 : @[intervox_transmitter.scala 228:31]
            bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 229:19]
            synced <= UInt<1>("h1") @[intervox_transmitter.scala 230:18]
    node _T_5 = eq(synced, UInt<1>("h1")) @[intervox_transmitter.scala 242:15]
    when _T_5 : @[intervox_transmitter.scala 242:23]
      node _T_6 = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 244:26]
      when _T_6 : @[intervox_transmitter.scala 244:26]
        current_state <= UInt<2>("h2") @[intervox_transmitter.scala 248:23]
      else :
        node _T_7 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 244:26]
        when _T_7 : @[intervox_transmitter.scala 244:26]
          current_state <= UInt<2>("h2") @[intervox_transmitter.scala 252:23]
        else :
          node _T_8 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 244:26]
          when _T_8 : @[intervox_transmitter.scala 244:26]
            bi_phase_enc.io.ENA <= UInt<1>("h1") @[intervox_transmitter.scala 256:29]
            node _BiPhase_CLK_CNTR_T_2 = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 258:46]
            node _BiPhase_CLK_CNTR_T_3 = tail(_BiPhase_CLK_CNTR_T_2, 1) @[intervox_transmitter.scala 258:46]
            BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_3 @[intervox_transmitter.scala 258:26]
            node _T_9 = eq(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 264:31]
            when _T_9 : @[intervox_transmitter.scala 264:39]
              BiPhase_CLK_CNTR <= UInt<1>("h0") @[intervox_transmitter.scala 265:28]
              node _bitCntr_T_2 = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 268:30]
              node _bitCntr_T_3 = tail(_bitCntr_T_2, 1) @[intervox_transmitter.scala 268:30]
              bitCntr <= _bitCntr_T_3 @[intervox_transmitter.scala 268:19]
              node _T_10 = eq(bitCntr, UInt<1>("h0")) @[intervox_transmitter.scala 272:24]
              when _T_10 : @[intervox_transmitter.scala 272:32]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 274:31]
                BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 275:31]
              node _T_11 = gt(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 278:24]
              when _T_11 : @[intervox_transmitter.scala 278:31]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 283:31]
                node _T_12 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 285:30]
                when _T_12 : @[intervox_transmitter.scala 285:38]
                  node _BFR_io_dataIn_T = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 287:67]
                  node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 287:67]
                  node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 287:58]
                  node _BFR_io_dataIn_T_3 = add(BFR.io.dataOut, _BFR_io_dataIn_T_2) @[intervox_transmitter.scala 287:51]
                  node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_transmitter.scala 287:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_4 @[intervox_transmitter.scala 287:33]
                node _T_13 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 290:30]
                when _T_13 : @[intervox_transmitter.scala 290:38]
                  node _BFR_io_dataIn_T_5 = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 291:68]
                  node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_transmitter.scala 291:68]
                  node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 291:58]
                  node _BFR_io_dataIn_T_8 = add(BFR.io.dataOut, _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 291:51]
                  node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 291:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_9 @[intervox_transmitter.scala 291:33]
              else :
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 297:31]
                node _T_14 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 299:30]
                when _T_14 : @[intervox_transmitter.scala 299:39]
                  node _BFR_io_dataIn_T_10 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 301:67]
                  node _BFR_io_dataIn_T_11 = tail(_BFR_io_dataIn_T_10, 1) @[intervox_transmitter.scala 301:67]
                  node _BFR_io_dataIn_T_12 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_11) @[intervox_transmitter.scala 301:58]
                  node _BFR_io_dataIn_T_13 = add(BFR.io.dataOut, _BFR_io_dataIn_T_12) @[intervox_transmitter.scala 301:51]
                  node _BFR_io_dataIn_T_14 = tail(_BFR_io_dataIn_T_13, 1) @[intervox_transmitter.scala 301:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_14 @[intervox_transmitter.scala 301:33]
                node _T_15 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 304:30]
                when _T_15 : @[intervox_transmitter.scala 304:38]
                  node _BFR_io_dataIn_T_15 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 305:67]
                  node _BFR_io_dataIn_T_16 = tail(_BFR_io_dataIn_T_15, 1) @[intervox_transmitter.scala 305:67]
                  node _BFR_io_dataIn_T_17 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_16) @[intervox_transmitter.scala 305:58]
                  node _BFR_io_dataIn_T_18 = add(BFR.io.dataOut, _BFR_io_dataIn_T_17) @[intervox_transmitter.scala 305:51]
                  node _BFR_io_dataIn_T_19 = tail(_BFR_io_dataIn_T_18, 1) @[intervox_transmitter.scala 305:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_19 @[intervox_transmitter.scala 305:33]
              node _T_16 = eq(bitCntr, UInt<7>("h7f")) @[intervox_transmitter.scala 309:24]
              when _T_16 : @[intervox_transmitter.scala 309:34]
                BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 312:31]
                BFR1.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 313:31]
                BFR1.io.dataIn <= BFR.io.dataOut @[intervox_transmitter.scala 314:31]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 317:28]
                BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 318:28]
                bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 320:21]

