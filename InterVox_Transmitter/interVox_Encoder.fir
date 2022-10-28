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
    node _T = eq(io.TICK, UInt<1>("h1")) @[intervox_transmitter.scala 54:20]
    when _T : @[intervox_transmitter.scala 54:28]
      node _bitCntr_enc_T = add(bitCntr_enc, UInt<1>("h1")) @[intervox_transmitter.scala 56:38]
      node _bitCntr_enc_T_1 = tail(_bitCntr_enc_T, 1) @[intervox_transmitter.scala 56:38]
      bitCntr_enc <= _bitCntr_enc_T_1 @[intervox_transmitter.scala 56:23]
      node _T_1 = rem(bitCntr_enc, UInt<2>("h2")) @[intervox_transmitter.scala 57:28]
      node _T_2 = eq(_T_1, UInt<1>("h0")) @[intervox_transmitter.scala 57:34]
      when _T_2 : @[intervox_transmitter.scala 57:42]
        node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 59:36]
        node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 59:36]
        dataIndex <= _dataIndex_T_1 @[intervox_transmitter.scala 59:23]
      node _T_3 = lt(bitCntr_enc, UInt<3>("h7")) @[intervox_transmitter.scala 63:28]
      when _T_3 : @[intervox_transmitter.scala 63:35]
        node _T_4 = lt(bitCntr_enc, UInt<3>("h6")) @[intervox_transmitter.scala 66:30]
        when _T_4 : @[intervox_transmitter.scala 67:13]
          outReg <= UInt<1>("h0") @[intervox_transmitter.scala 68:22]
        else :
          outReg <= UInt<1>("h1") @[intervox_transmitter.scala 72:22]
      node _T_5 = gt(bitCntr_enc, UInt<3>("h7")) @[intervox_transmitter.scala 76:29]
      when _T_5 : @[intervox_transmitter.scala 76:36]
        node _T_6 = lt(bitCntr_enc, UInt<6>("h37")) @[intervox_transmitter.scala 79:30]
        when _T_6 : @[intervox_transmitter.scala 79:37]
          node _T_7 = sub(dataIndex, UInt<2>("h3")) @[intervox_transmitter.scala 81:50]
          node _T_8 = tail(_T_7, 1) @[intervox_transmitter.scala 81:50]
          node _T_9 = sub(UInt<7>("h40"), _T_8) @[intervox_transmitter.scala 81:37]
          node _T_10 = tail(_T_9, 1) @[intervox_transmitter.scala 81:37]
          node _T_11 = dshr(stereoData, _T_10) @[intervox_transmitter.scala 81:31]
          node _T_12 = bits(_T_11, 0, 0) @[intervox_transmitter.scala 81:31]
          node _T_13 = eq(_T_12, UInt<1>("h0")) @[intervox_transmitter.scala 81:60]
          when _T_13 : @[intervox_transmitter.scala 81:69]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 83:25]
        node _T_14 = geq(bitCntr_enc, UInt<6>("h37")) @[intervox_transmitter.scala 86:31]
        node _T_15 = lt(bitCntr_enc, UInt<7>("h67")) @[intervox_transmitter.scala 86:55]
        node _T_16 = and(_T_14, _T_15) @[intervox_transmitter.scala 86:40]
        when _T_16 : @[intervox_transmitter.scala 86:64]
          node _T_17 = sub(dataIndex, UInt<5>("h1b")) @[intervox_transmitter.scala 88:51]
          node _T_18 = tail(_T_17, 1) @[intervox_transmitter.scala 88:51]
          node _T_19 = sub(UInt<7>("h40"), _T_18) @[intervox_transmitter.scala 88:38]
          node _T_20 = tail(_T_19, 1) @[intervox_transmitter.scala 88:38]
          node _T_21 = dshr(stereoData, _T_20) @[intervox_transmitter.scala 88:31]
          node _T_22 = bits(_T_21, 0, 0) @[intervox_transmitter.scala 88:31]
          node _T_23 = eq(_T_22, UInt<1>("h0")) @[intervox_transmitter.scala 88:63]
          when _T_23 : @[intervox_transmitter.scala 88:72]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 90:25]
        node _T_24 = geq(bitCntr_enc, UInt<7>("h67")) @[intervox_transmitter.scala 94:31]
        node _T_25 = lt(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 94:56]
        node _T_26 = and(_T_24, _T_25) @[intervox_transmitter.scala 94:41]
        when _T_26 : @[intervox_transmitter.scala 94:65]
          node _T_27 = sub(dataIndex, UInt<6>("h34")) @[intervox_transmitter.scala 98:42]
          node _T_28 = tail(_T_27, 1) @[intervox_transmitter.scala 98:42]
          node _T_29 = dshr(dspData, _T_28) @[intervox_transmitter.scala 98:30]
          node _T_30 = bits(_T_29, 0, 0) @[intervox_transmitter.scala 98:30]
          node _T_31 = eq(_T_30, UInt<1>("h0")) @[intervox_transmitter.scala 98:53]
          when _T_31 : @[intervox_transmitter.scala 98:62]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 100:25]
        node _T_32 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 104:26]
        when _T_32 : @[intervox_transmitter.scala 104:34]
          outReg <= outReg @[intervox_transmitter.scala 105:22]
          hasNone <= UInt<1>("h0") @[intervox_transmitter.scala 106:23]
        else :
          node _outReg_T = not(outReg) @[intervox_transmitter.scala 110:25]
          outReg <= _outReg_T @[intervox_transmitter.scala 110:22]
      node _T_33 = eq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 114:28]
      when _T_33 : @[intervox_transmitter.scala 114:38]
        bitCntr_enc <= UInt<1>("h0") @[intervox_transmitter.scala 115:25]

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
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 136:34]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 138:34]
    reg DATA_OUT_REG_1B : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 140:34]
    reg FirstFrame : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 142:34]
    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 144:33]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    reg bitCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 146:34]
    inst BFR of RWSmem @[intervox_transmitter.scala 148:33]
    BFR.clock <= clock
    BFR.reset <= reset
    inst BFR1 of RWSmem_1 @[intervox_transmitter.scala 149:33]
    BFR1.clock <= clock
    BFR1.reset <= reset
    io.DATA_O <= bi_phase_enc.io.DATA_OUT @[intervox_transmitter.scala 152:25]
    io.MCLK_O <= clock @[intervox_transmitter.scala 153:25]
    io.BCLK_O <= io.BCLK_IN @[intervox_transmitter.scala 154:25]
    io.LRCLK_O <= io.LRCLK_IN @[intervox_transmitter.scala 155:25]
    io.SDATA_O <= io.SDATA_IN @[intervox_transmitter.scala 156:25]
    BFR.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 159:25]
    BFR.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 160:25]
    BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 161:25]
    BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 162:25]
    BFR1.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 163:25]
    BFR1.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 164:25]
    BFR1.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 165:25]
    BFR1.io.dataIn <= BFR.io.dataOut @[intervox_transmitter.scala 166:25]
    io.NXT_FRAME <= bi_phase_enc.io.TICK @[intervox_transmitter.scala 169:25]
    bi_phase_enc.io.TICK <= UInt<1>("h0") @[intervox_transmitter.scala 172:31]
    bi_phase_enc.io.AUDIOINPUT <= BFR1.io.dataOut @[intervox_transmitter.scala 175:31]
    bi_phase_enc.io.DSPINPUT <= UInt<12>("hfff") @[intervox_transmitter.scala 177:31]
    node _T = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 187:24]
    when _T : @[intervox_transmitter.scala 187:24]
      current_state <= UInt<2>("h2") @[intervox_transmitter.scala 190:21]
    else :
      node _T_1 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 187:24]
      when _T_1 : @[intervox_transmitter.scala 187:24]
        current_state <= UInt<2>("h2") @[intervox_transmitter.scala 193:21]
      else :
        node _T_2 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 187:24]
        when _T_2 : @[intervox_transmitter.scala 187:24]
          node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 197:44]
          node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 197:44]
          BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_1 @[intervox_transmitter.scala 197:24]
          node _T_3 = rem(BiPhase_CLK_CNTR, UInt<2>("h2")) @[intervox_transmitter.scala 200:30]
          node _T_4 = eq(_T_3, UInt<1>("h0")) @[intervox_transmitter.scala 200:36]
          when _T_4 : @[intervox_transmitter.scala 200:45]
            bi_phase_enc.io.TICK <= UInt<1>("h1") @[intervox_transmitter.scala 201:30]
          node _T_5 = eq(BiPhase_CLK_CNTR, UInt<3>("h7")) @[intervox_transmitter.scala 204:29]
          when _T_5 : @[intervox_transmitter.scala 204:37]
            BiPhase_CLK_CNTR <= UInt<1>("h0") @[intervox_transmitter.scala 204:55]
          node _T_6 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 210:30]
          node _T_7 = eq(BiPhase_CLK_CNTR, UInt<3>("h7")) @[intervox_transmitter.scala 210:58]
          node _T_8 = or(_T_6, _T_7) @[intervox_transmitter.scala 210:38]
          when _T_8 : @[intervox_transmitter.scala 210:67]
            node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 213:28]
            node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 213:28]
            bitCntr <= _bitCntr_T_1 @[intervox_transmitter.scala 213:17]
            node _T_9 = eq(bitCntr, UInt<1>("h0")) @[intervox_transmitter.scala 217:22]
            when _T_9 : @[intervox_transmitter.scala 217:30]
              BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 219:29]
              BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 220:29]
            node _T_10 = gt(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 223:22]
            when _T_10 : @[intervox_transmitter.scala 223:29]
              BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 228:29]
              node _T_11 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 230:28]
              when _T_11 : @[intervox_transmitter.scala 230:36]
                node _BFR_io_dataIn_T = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 232:65]
                node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 232:65]
                node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 232:56]
                node _BFR_io_dataIn_T_3 = add(BFR.io.dataOut, _BFR_io_dataIn_T_2) @[intervox_transmitter.scala 232:49]
                node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_transmitter.scala 232:49]
                BFR.io.dataIn <= _BFR_io_dataIn_T_4 @[intervox_transmitter.scala 232:31]
              node _T_12 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 235:28]
              when _T_12 : @[intervox_transmitter.scala 235:36]
                node _BFR_io_dataIn_T_5 = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 236:66]
                node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_transmitter.scala 236:66]
                node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 236:56]
                node _BFR_io_dataIn_T_8 = add(BFR.io.dataOut, _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 236:49]
                node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 236:49]
                BFR.io.dataIn <= _BFR_io_dataIn_T_9 @[intervox_transmitter.scala 236:31]
            else :
              BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 242:29]
              node _T_13 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 244:28]
              when _T_13 : @[intervox_transmitter.scala 244:37]
                node _BFR_io_dataIn_T_10 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 246:65]
                node _BFR_io_dataIn_T_11 = tail(_BFR_io_dataIn_T_10, 1) @[intervox_transmitter.scala 246:65]
                node _BFR_io_dataIn_T_12 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_11) @[intervox_transmitter.scala 246:56]
                node _BFR_io_dataIn_T_13 = add(BFR.io.dataOut, _BFR_io_dataIn_T_12) @[intervox_transmitter.scala 246:49]
                node _BFR_io_dataIn_T_14 = tail(_BFR_io_dataIn_T_13, 1) @[intervox_transmitter.scala 246:49]
                BFR.io.dataIn <= _BFR_io_dataIn_T_14 @[intervox_transmitter.scala 246:31]
              node _T_14 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 249:28]
              when _T_14 : @[intervox_transmitter.scala 249:36]
                node _BFR_io_dataIn_T_15 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 250:65]
                node _BFR_io_dataIn_T_16 = tail(_BFR_io_dataIn_T_15, 1) @[intervox_transmitter.scala 250:65]
                node _BFR_io_dataIn_T_17 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_16) @[intervox_transmitter.scala 250:56]
                node _BFR_io_dataIn_T_18 = add(BFR.io.dataOut, _BFR_io_dataIn_T_17) @[intervox_transmitter.scala 250:49]
                node _BFR_io_dataIn_T_19 = tail(_BFR_io_dataIn_T_18, 1) @[intervox_transmitter.scala 250:49]
                BFR.io.dataIn <= _BFR_io_dataIn_T_19 @[intervox_transmitter.scala 250:31]
            node _T_15 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 254:22]
            when _T_15 : @[intervox_transmitter.scala 254:31]
              BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 257:29]
              BFR1.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 258:29]
              BFR1.io.dataIn <= BFR.io.dataOut @[intervox_transmitter.scala 259:29]
              BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 262:26]
              BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 263:26]
              bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 265:19]

