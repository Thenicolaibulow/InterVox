circuit interVox_Encoder :
  module bi_phase_encoder :
    input clock : Clock
    input reset : Reset
    output io : { DATA_OUT : UInt<1>, flip AUDIOINPUT : UInt<64>, flip DSPINPUT : UInt<64>, flip ENA : UInt<1>, flip TICK : UInt<1>}

    reg outReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 38:32]
    reg stereoData : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[intervox_transmitter.scala 39:32]
    reg dspData : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[intervox_transmitter.scala 40:32]
    reg bitCntr_enc : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 41:32]
    reg hasNone : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 42:32]
    reg dataIndex : UInt<6>, clock with :
      reset => (reset, UInt<6>("h0")) @[intervox_transmitter.scala 43:32]
    io.DATA_OUT <= outReg @[intervox_transmitter.scala 45:17]
    stereoData <= io.AUDIOINPUT @[intervox_transmitter.scala 47:17]
    dspData <= io.DSPINPUT @[intervox_transmitter.scala 48:17]
    reg ndexR : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 50:32]
    node _T = eq(io.ENA, UInt<1>("h1")) @[intervox_transmitter.scala 52:17]
    when _T : @[intervox_transmitter.scala 52:25]
      node _T_1 = eq(io.TICK, UInt<1>("h1")) @[intervox_transmitter.scala 56:20]
      when _T_1 : @[intervox_transmitter.scala 56:28]
        node _T_2 = eq(bitCntr_enc, UInt<2>("h3")) @[intervox_transmitter.scala 61:28]
        when _T_2 : @[intervox_transmitter.scala 61:36]
          node _outReg_T = not(outReg) @[intervox_transmitter.scala 62:23]
          outReg <= _outReg_T @[intervox_transmitter.scala 62:20]
        node _T_3 = eq(bitCntr_enc, UInt<3>("h4")) @[intervox_transmitter.scala 65:28]
        when _T_3 : @[intervox_transmitter.scala 65:36]
          node _outReg_T_1 = not(outReg) @[intervox_transmitter.scala 66:23]
          outReg <= _outReg_T_1 @[intervox_transmitter.scala 66:20]
          hasNone <= UInt<1>("h0") @[intervox_transmitter.scala 68:21]
        node _T_4 = gt(bitCntr_enc, UInt<3>("h4")) @[intervox_transmitter.scala 72:29]
        when _T_4 : @[intervox_transmitter.scala 72:36]
          node _ndexR_T = not(ndexR) @[intervox_transmitter.scala 76:22]
          ndexR <= _ndexR_T @[intervox_transmitter.scala 76:19]
          node _T_5 = eq(ndexR, UInt<1>("h0")) @[intervox_transmitter.scala 77:24]
          when _T_5 : @[intervox_transmitter.scala 77:32]
            node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 79:38]
            node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 79:38]
            dataIndex <= _dataIndex_T_1 @[intervox_transmitter.scala 79:25]
          node _T_6 = lt(bitCntr_enc, UInt<6>("h35")) @[intervox_transmitter.scala 84:30]
          when _T_6 : @[intervox_transmitter.scala 84:37]
            node _T_7 = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 86:50]
            node _T_8 = tail(_T_7, 1) @[intervox_transmitter.scala 86:50]
            node _T_9 = sub(UInt<7>("h40"), _T_8) @[intervox_transmitter.scala 86:37]
            node _T_10 = tail(_T_9, 1) @[intervox_transmitter.scala 86:37]
            node _T_11 = dshr(stereoData, _T_10) @[intervox_transmitter.scala 86:31]
            node _T_12 = bits(_T_11, 0, 0) @[intervox_transmitter.scala 86:31]
            node _T_13 = eq(_T_12, UInt<1>("h0")) @[intervox_transmitter.scala 86:59]
            when _T_13 : @[intervox_transmitter.scala 86:68]
              hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 88:25]
          node _T_14 = geq(bitCntr_enc, UInt<6>("h35")) @[intervox_transmitter.scala 93:31]
          node _T_15 = lt(bitCntr_enc, UInt<7>("h65")) @[intervox_transmitter.scala 93:55]
          node _T_16 = and(_T_14, _T_15) @[intervox_transmitter.scala 93:40]
          when _T_16 : @[intervox_transmitter.scala 93:64]
            node _T_17 = sub(dataIndex, UInt<5>("h17")) @[intervox_transmitter.scala 95:51]
            node _T_18 = tail(_T_17, 1) @[intervox_transmitter.scala 95:51]
            node _T_19 = sub(UInt<7>("h40"), _T_18) @[intervox_transmitter.scala 95:38]
            node _T_20 = tail(_T_19, 1) @[intervox_transmitter.scala 95:38]
            node _T_21 = dshr(stereoData, _T_20) @[intervox_transmitter.scala 95:31]
            node _T_22 = bits(_T_21, 0, 0) @[intervox_transmitter.scala 95:31]
            node _T_23 = eq(_T_22, UInt<1>("h0")) @[intervox_transmitter.scala 95:62]
            when _T_23 : @[intervox_transmitter.scala 95:71]
              hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 96:25]
          node _T_24 = geq(bitCntr_enc, UInt<7>("h65")) @[intervox_transmitter.scala 103:31]
          node _T_25 = leq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 103:56]
          node _T_26 = and(_T_24, _T_25) @[intervox_transmitter.scala 103:41]
          when _T_26 : @[intervox_transmitter.scala 103:66]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 107:23]
          node _T_27 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 111:26]
          when _T_27 : @[intervox_transmitter.scala 111:34]
            outReg <= outReg @[intervox_transmitter.scala 113:22]
            hasNone <= UInt<1>("h0") @[intervox_transmitter.scala 114:23]
          else :
            node _outReg_T_2 = not(outReg) @[intervox_transmitter.scala 118:25]
            outReg <= _outReg_T_2 @[intervox_transmitter.scala 118:22]
        node _bitCntr_enc_T = add(bitCntr_enc, UInt<1>("h1")) @[intervox_transmitter.scala 123:38]
        node _bitCntr_enc_T_1 = tail(_bitCntr_enc_T, 1) @[intervox_transmitter.scala 123:38]
        bitCntr_enc <= _bitCntr_enc_T_1 @[intervox_transmitter.scala 123:23]
        node _T_28 = eq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 126:28]
        when _T_28 : @[intervox_transmitter.scala 126:38]
          bitCntr_enc <= UInt<1>("h0") @[intervox_transmitter.scala 127:25]
          dataIndex <= UInt<1>("h0") @[intervox_transmitter.scala 128:23]

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
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 149:34]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 151:34]
    reg DATA_OUT_REG_1B : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 153:34]
    reg FirstFrame : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 155:34]
    reg synced : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 157:34]
    reg bclkR : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[intervox_transmitter.scala 159:34]
    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 161:33]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    reg encoderClk : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 163:34]
    reg bitCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 165:34]
    inst BFR of RWSmem @[intervox_transmitter.scala 167:33]
    BFR.clock <= clock
    BFR.reset <= reset
    inst BFR1 of RWSmem_1 @[intervox_transmitter.scala 168:33]
    BFR1.clock <= clock
    BFR1.reset <= reset
    io.DATA_O <= bi_phase_enc.io.DATA_OUT @[intervox_transmitter.scala 171:25]
    io.MCLK_O <= clock @[intervox_transmitter.scala 172:25]
    io.BCLK_O <= io.BCLK_IN @[intervox_transmitter.scala 173:25]
    io.LRCLK_O <= io.LRCLK_IN @[intervox_transmitter.scala 174:25]
    io.SDATA_O <= io.SDATA_IN @[intervox_transmitter.scala 175:25]
    BFR.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 178:25]
    BFR.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 179:25]
    BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 180:25]
    BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 181:25]
    BFR1.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 182:25]
    BFR1.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 183:25]
    BFR1.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 184:25]
    BFR1.io.dataIn <= BFR.io.dataOut @[intervox_transmitter.scala 185:25]
    io.NXT_FRAME <= bi_phase_enc.io.ENA @[intervox_transmitter.scala 188:31]
    bi_phase_enc.io.TICK <= UInt<1>("h0") @[intervox_transmitter.scala 190:31]
    bi_phase_enc.io.ENA <= UInt<1>("h0") @[intervox_transmitter.scala 191:31]
    bi_phase_enc.io.AUDIOINPUT <= BFR1.io.dataOut @[intervox_transmitter.scala 193:31]
    bi_phase_enc.io.DSPINPUT <= UInt<1>("h0") @[intervox_transmitter.scala 195:31]
    node _T = eq(synced, UInt<1>("h0")) @[intervox_transmitter.scala 212:15]
    when _T : @[intervox_transmitter.scala 212:23]
      node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 214:42]
      node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 214:42]
      BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_1 @[intervox_transmitter.scala 214:22]
      node _T_1 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 216:27]
      when _T_1 : @[intervox_transmitter.scala 216:35]
        BiPhase_CLK_CNTR <= UInt<1>("h0") @[intervox_transmitter.scala 217:24]
        node _T_2 = eq(io.LRCLK_IN, UInt<1>("h1")) @[intervox_transmitter.scala 219:24]
        when _T_2 : @[intervox_transmitter.scala 219:32]
          bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 220:17]
        node _T_3 = eq(io.LRCLK_IN, UInt<1>("h0")) @[intervox_transmitter.scala 223:24]
        when _T_3 : @[intervox_transmitter.scala 223:32]
          node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 226:28]
          node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 226:28]
          bitCntr <= _bitCntr_T_1 @[intervox_transmitter.scala 226:17]
          node _T_4 = eq(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 228:22]
          when _T_4 : @[intervox_transmitter.scala 228:31]
            bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 229:19]
            synced <= UInt<1>("h1") @[intervox_transmitter.scala 230:18]
    node _T_5 = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 243:24]
    when _T_5 : @[intervox_transmitter.scala 243:24]
      current_state <= UInt<2>("h2") @[intervox_transmitter.scala 247:21]
    else :
      node _T_6 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 243:24]
      when _T_6 : @[intervox_transmitter.scala 243:24]
        current_state <= UInt<2>("h2") @[intervox_transmitter.scala 251:21]
      else :
        node _T_7 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 243:24]
        when _T_7 : @[intervox_transmitter.scala 243:24]
          node _T_8 = eq(synced, UInt<1>("h1")) @[intervox_transmitter.scala 255:19]
          when _T_8 : @[intervox_transmitter.scala 255:27]
            bi_phase_enc.io.ENA <= UInt<1>("h1") @[intervox_transmitter.scala 262:29]
            node _encoderClk_T = not(encoderClk) @[intervox_transmitter.scala 265:23]
            encoderClk <= _encoderClk_T @[intervox_transmitter.scala 265:20]
            node _T_9 = eq(encoderClk, UInt<1>("h1")) @[intervox_transmitter.scala 266:25]
            when _T_9 : @[intervox_transmitter.scala 266:33]
              bi_phase_enc.io.TICK <= UInt<1>("h1") @[intervox_transmitter.scala 267:33]
            node _BiPhase_CLK_CNTR_T_2 = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 270:46]
            node _BiPhase_CLK_CNTR_T_3 = tail(_BiPhase_CLK_CNTR_T_2, 1) @[intervox_transmitter.scala 270:46]
            BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_3 @[intervox_transmitter.scala 270:26]
            node _T_10 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 272:31]
            when _T_10 : @[intervox_transmitter.scala 272:39]
              BiPhase_CLK_CNTR <= UInt<1>("h0") @[intervox_transmitter.scala 273:28]
              node _bitCntr_T_2 = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 276:30]
              node _bitCntr_T_3 = tail(_bitCntr_T_2, 1) @[intervox_transmitter.scala 276:30]
              bitCntr <= _bitCntr_T_3 @[intervox_transmitter.scala 276:19]
              node _T_11 = eq(bitCntr, UInt<1>("h0")) @[intervox_transmitter.scala 280:24]
              when _T_11 : @[intervox_transmitter.scala 280:32]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 282:31]
                BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 283:31]
              node _T_12 = gt(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 287:24]
              when _T_12 : @[intervox_transmitter.scala 287:31]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 292:31]
                node _T_13 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 294:30]
                when _T_13 : @[intervox_transmitter.scala 294:38]
                  node _BFR_io_dataIn_T = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 296:67]
                  node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 296:67]
                  node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 296:58]
                  node _BFR_io_dataIn_T_3 = add(BFR.io.dataOut, _BFR_io_dataIn_T_2) @[intervox_transmitter.scala 296:51]
                  node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_transmitter.scala 296:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_4 @[intervox_transmitter.scala 296:33]
                node _T_14 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 299:30]
                when _T_14 : @[intervox_transmitter.scala 299:38]
                  node _BFR_io_dataIn_T_5 = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 300:68]
                  node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_transmitter.scala 300:68]
                  node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 300:58]
                  node _BFR_io_dataIn_T_8 = add(BFR.io.dataOut, _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 300:51]
                  node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 300:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_9 @[intervox_transmitter.scala 300:33]
              else :
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 306:31]
                node _T_15 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 308:30]
                when _T_15 : @[intervox_transmitter.scala 308:39]
                  node _BFR_io_dataIn_T_10 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 310:67]
                  node _BFR_io_dataIn_T_11 = tail(_BFR_io_dataIn_T_10, 1) @[intervox_transmitter.scala 310:67]
                  node _BFR_io_dataIn_T_12 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_11) @[intervox_transmitter.scala 310:58]
                  node _BFR_io_dataIn_T_13 = add(BFR.io.dataOut, _BFR_io_dataIn_T_12) @[intervox_transmitter.scala 310:51]
                  node _BFR_io_dataIn_T_14 = tail(_BFR_io_dataIn_T_13, 1) @[intervox_transmitter.scala 310:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_14 @[intervox_transmitter.scala 310:33]
                node _T_16 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 313:30]
                when _T_16 : @[intervox_transmitter.scala 313:38]
                  node _BFR_io_dataIn_T_15 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 314:67]
                  node _BFR_io_dataIn_T_16 = tail(_BFR_io_dataIn_T_15, 1) @[intervox_transmitter.scala 314:67]
                  node _BFR_io_dataIn_T_17 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_16) @[intervox_transmitter.scala 314:58]
                  node _BFR_io_dataIn_T_18 = add(BFR.io.dataOut, _BFR_io_dataIn_T_17) @[intervox_transmitter.scala 314:51]
                  node _BFR_io_dataIn_T_19 = tail(_BFR_io_dataIn_T_18, 1) @[intervox_transmitter.scala 314:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_19 @[intervox_transmitter.scala 314:33]
              node _T_17 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 318:24]
              when _T_17 : @[intervox_transmitter.scala 318:33]
                BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 321:31]
                BFR1.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 322:31]
                BFR1.io.dataIn <= BFR.io.dataOut @[intervox_transmitter.scala 323:31]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 326:28]
                BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 327:28]
                bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 329:21]

