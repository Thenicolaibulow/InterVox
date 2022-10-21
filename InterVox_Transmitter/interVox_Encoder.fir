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
    reg bitCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 42:32]
    reg hasNone : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 43:32]
    reg dataIndex : UInt<6>, clock with :
      reset => (reset, UInt<6>("h0")) @[intervox_transmitter.scala 44:32]
    io.DATA_OUT <= outReg @[intervox_transmitter.scala 46:17]
    stereoData <= io.AUDIOINPUT @[intervox_transmitter.scala 48:16]
    dspData <= UInt<1>("h0") @[intervox_transmitter.scala 49:13]
    io.NEXT <= next @[intervox_transmitter.scala 50:13]
    node _T = eq(io.TICK, UInt<1>("h1")) @[intervox_transmitter.scala 52:20]
    when _T : @[intervox_transmitter.scala 52:28]
      node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 54:30]
      node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 54:30]
      bitCntr <= _bitCntr_T_1 @[intervox_transmitter.scala 54:19]
      node _T_1 = rem(bitCntr, UInt<2>("h2")) @[intervox_transmitter.scala 55:24]
      node _T_2 = eq(_T_1, UInt<1>("h1")) @[intervox_transmitter.scala 55:30]
      when _T_2 : @[intervox_transmitter.scala 55:38]
        node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 56:36]
        node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 56:36]
        dataIndex <= _dataIndex_T_1 @[intervox_transmitter.scala 56:23]
      node _T_3 = lt(bitCntr, UInt<3>("h7")) @[intervox_transmitter.scala 60:24]
      when _T_3 : @[intervox_transmitter.scala 60:31]
        next <= UInt<1>("h0") @[intervox_transmitter.scala 61:18]
        node _T_4 = lt(bitCntr, UInt<3>("h6")) @[intervox_transmitter.scala 63:26]
        when _T_4 : @[intervox_transmitter.scala 64:13]
          outReg <= UInt<1>("h0") @[intervox_transmitter.scala 65:22]
        else :
          outReg <= UInt<1>("h1") @[intervox_transmitter.scala 69:22]
      node _T_5 = gt(bitCntr, UInt<3>("h7")) @[intervox_transmitter.scala 73:25]
      when _T_5 : @[intervox_transmitter.scala 73:32]
        node _T_6 = lt(bitCntr, UInt<6>("h30")) @[intervox_transmitter.scala 76:26]
        when _T_6 : @[intervox_transmitter.scala 76:33]
          node _T_7 = sub(dataIndex, UInt<3>("h4")) @[intervox_transmitter.scala 78:43]
          node _T_8 = tail(_T_7, 1) @[intervox_transmitter.scala 78:43]
          node _T_9 = dshr(stereoData, _T_8) @[intervox_transmitter.scala 78:31]
          node _T_10 = bits(_T_9, 0, 0) @[intervox_transmitter.scala 78:31]
          node _T_11 = eq(_T_10, UInt<1>("h0")) @[intervox_transmitter.scala 78:53]
          when _T_11 : @[intervox_transmitter.scala 78:62]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 80:25]
        node _T_12 = gt(bitCntr, UInt<6>("h30")) @[intervox_transmitter.scala 83:27]
        node _T_13 = lt(bitCntr, UInt<7>("h60")) @[intervox_transmitter.scala 83:46]
        node _T_14 = and(_T_12, _T_13) @[intervox_transmitter.scala 83:35]
        when _T_14 : @[intervox_transmitter.scala 83:54]
          node _T_15 = sub(dataIndex, UInt<3>("h4")) @[intervox_transmitter.scala 85:43]
          node _T_16 = tail(_T_15, 1) @[intervox_transmitter.scala 85:43]
          node _T_17 = sub(_T_16, UInt<4>("h8")) @[intervox_transmitter.scala 85:49]
          node _T_18 = tail(_T_17, 1) @[intervox_transmitter.scala 85:49]
          node _T_19 = dshr(stereoData, _T_18) @[intervox_transmitter.scala 85:31]
          node _T_20 = bits(_T_19, 0, 0) @[intervox_transmitter.scala 85:31]
          node _T_21 = eq(_T_20, UInt<1>("h0")) @[intervox_transmitter.scala 85:59]
          when _T_21 : @[intervox_transmitter.scala 85:68]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 87:25]
        node _T_22 = gt(bitCntr, UInt<7>("h60")) @[intervox_transmitter.scala 91:27]
        node _T_23 = lt(bitCntr, UInt<7>("h7f")) @[intervox_transmitter.scala 91:45]
        node _T_24 = and(_T_22, _T_23) @[intervox_transmitter.scala 91:34]
        when _T_24 : @[intervox_transmitter.scala 91:55]
          node _T_25 = sub(dataIndex, UInt<3>("h4")) @[intervox_transmitter.scala 93:42]
          node _T_26 = tail(_T_25, 1) @[intervox_transmitter.scala 93:42]
          node _T_27 = dshr(dspData, _T_26) @[intervox_transmitter.scala 93:30]
          node _T_28 = bits(_T_27, 0, 0) @[intervox_transmitter.scala 93:30]
          node _T_29 = eq(_T_28, UInt<1>("h0")) @[intervox_transmitter.scala 93:52]
          when _T_29 : @[intervox_transmitter.scala 93:61]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 95:25]
        node _T_30 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 99:26]
        when _T_30 : @[intervox_transmitter.scala 99:34]
          outReg <= outReg @[intervox_transmitter.scala 100:22]
          hasNone <= UInt<1>("h0") @[intervox_transmitter.scala 101:23]
        else :
          node _outReg_T = not(outReg) @[intervox_transmitter.scala 105:25]
          outReg <= _outReg_T @[intervox_transmitter.scala 105:22]
      node _T_31 = eq(bitCntr, UInt<7>("h7f")) @[intervox_transmitter.scala 109:24]
      when _T_31 : @[intervox_transmitter.scala 109:34]
        bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 110:21]
        stereoData <= UInt<1>("h0") @[intervox_transmitter.scala 111:24]
        next <= UInt<1>("h1") @[intervox_transmitter.scala 112:18]

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
    output io : { flip MCLK_IN : UInt<1>, MCLK_O : UInt<1>, flip BCLK_IN : UInt<1>, flip LRCLK_IN : UInt<1>, flip SDATA_IN : UInt<1>, DATA_O : UInt<1>, LRCLK_O : UInt<1>, BCLK_O : UInt<1>, SDATA_O : UInt<1>, NXT_FRAME : UInt<1>}

    reg current_state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 133:34]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 135:34]
    reg DATA_OUT_REG_1B : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 137:34]
    reg FirstFrame : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 139:34]
    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 141:33]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    reg bitCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 143:34]
    reg LR : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 144:34]
    reg tick : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 145:34]
    reg PROCESSED : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 146:34]
    inst BFR of RWSmem @[intervox_transmitter.scala 149:33]
    BFR.clock <= clock
    BFR.reset <= reset
    inst BFR1 of RWSmem_1 @[intervox_transmitter.scala 150:33]
    BFR1.clock <= clock
    BFR1.reset <= reset
    io.DATA_O <= DATA_OUT_REG_1B @[intervox_transmitter.scala 153:25]
    io.MCLK_O <= io.MCLK_IN @[intervox_transmitter.scala 154:25]
    io.BCLK_O <= io.BCLK_IN @[intervox_transmitter.scala 155:25]
    io.LRCLK_O <= io.LRCLK_IN @[intervox_transmitter.scala 156:25]
    io.SDATA_O <= io.SDATA_IN @[intervox_transmitter.scala 157:25]
    BFR.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 158:25]
    BFR.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 159:25]
    BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 160:25]
    BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 161:25]
    BFR1.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 162:25]
    BFR1.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 163:25]
    BFR1.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 164:25]
    BFR1.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 165:25]
    io.NXT_FRAME <= bi_phase_enc.io.TICK @[intervox_transmitter.scala 166:25]
    bi_phase_enc.io.TICK <= UInt<1>("h0") @[intervox_transmitter.scala 169:31]
    bi_phase_enc.io.AUDIOINPUT <= BFR1.io.dataOut @[intervox_transmitter.scala 170:31]
    bi_phase_enc.io.DSPINPUT <= UInt<1>("h0") @[intervox_transmitter.scala 171:31]
    DATA_OUT_REG_1B <= bi_phase_enc.io.DATA_OUT @[intervox_transmitter.scala 173:19]
    node _T = eq(io.MCLK_IN, UInt<1>("h1")) @[intervox_transmitter.scala 176:19]
    when _T : @[intervox_transmitter.scala 176:27]
      node _T_1 = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 186:26]
      when _T_1 : @[intervox_transmitter.scala 186:26]
        current_state <= UInt<2>("h2") @[intervox_transmitter.scala 189:23]
      else :
        node _T_2 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 186:26]
        when _T_2 : @[intervox_transmitter.scala 186:26]
          current_state <= UInt<2>("h2") @[intervox_transmitter.scala 192:23]
        else :
          node _T_3 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 186:26]
          when _T_3 : @[intervox_transmitter.scala 186:26]
            node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 196:46]
            node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 196:46]
            BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_1 @[intervox_transmitter.scala 196:26]
            node _T_4 = rem(BiPhase_CLK_CNTR, UInt<2>("h2")) @[intervox_transmitter.scala 199:31]
            node _T_5 = eq(_T_4, UInt<1>("h1")) @[intervox_transmitter.scala 199:37]
            when _T_5 : @[intervox_transmitter.scala 199:45]
              bi_phase_enc.io.TICK <= UInt<1>("h1") @[intervox_transmitter.scala 200:32]
            node _T_6 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 204:31]
            when _T_6 : @[intervox_transmitter.scala 204:39]
              BiPhase_CLK_CNTR <= UInt<1>("h0") @[intervox_transmitter.scala 204:57]
            node _T_7 = eq(io.BCLK_IN, UInt<1>("h1")) @[intervox_transmitter.scala 206:25]
            when _T_7 : @[intervox_transmitter.scala 206:33]
              node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 209:30]
              node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 209:30]
              bitCntr <= _bitCntr_T_1 @[intervox_transmitter.scala 209:19]
              node _T_8 = gt(bitCntr, UInt<6>("h28")) @[intervox_transmitter.scala 214:24]
              when _T_8 : @[intervox_transmitter.scala 214:31]
                node _T_9 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 217:30]
                when _T_9 : @[intervox_transmitter.scala 217:39]
                  BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 219:33]
                  node _BFR_io_dataIn_T = sub(bitCntr, UInt<5>("h10")) @[intervox_transmitter.scala 220:70]
                  node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 220:70]
                  node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 220:58]
                  node _BFR_io_dataIn_T_3 = add(BFR.io.dataOut, _BFR_io_dataIn_T_2) @[intervox_transmitter.scala 220:51]
                  node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_transmitter.scala 220:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_4 @[intervox_transmitter.scala 220:33]
                node _T_10 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 223:30]
                when _T_10 : @[intervox_transmitter.scala 223:38]
                  BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 225:33]
                  node _BFR_io_dataIn_T_5 = sub(bitCntr, UInt<5>("h10")) @[intervox_transmitter.scala 226:70]
                  node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_transmitter.scala 226:70]
                  node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 226:58]
                  node _BFR_io_dataIn_T_8 = add(BFR.io.dataOut, _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 226:51]
                  node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 226:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_9 @[intervox_transmitter.scala 226:33]
              else :
                node _T_11 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 229:30]
                when _T_11 : @[intervox_transmitter.scala 229:39]
                  BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 231:33]
                  node _BFR_io_dataIn_T_10 = dshl(UInt<1>("h0"), bitCntr) @[intervox_transmitter.scala 232:58]
                  node _BFR_io_dataIn_T_11 = add(BFR.io.dataOut, _BFR_io_dataIn_T_10) @[intervox_transmitter.scala 232:51]
                  node _BFR_io_dataIn_T_12 = tail(_BFR_io_dataIn_T_11, 1) @[intervox_transmitter.scala 232:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_12 @[intervox_transmitter.scala 232:33]
                node _T_12 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 235:30]
                when _T_12 : @[intervox_transmitter.scala 235:38]
                  BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 237:33]
                  node _BFR_io_dataIn_T_13 = dshl(UInt<1>("h1"), bitCntr) @[intervox_transmitter.scala 238:58]
                  node _BFR_io_dataIn_T_14 = add(BFR.io.dataOut, _BFR_io_dataIn_T_13) @[intervox_transmitter.scala 238:51]
                  node _BFR_io_dataIn_T_15 = tail(_BFR_io_dataIn_T_14, 1) @[intervox_transmitter.scala 238:51]
                  BFR.io.dataIn <= _BFR_io_dataIn_T_15 @[intervox_transmitter.scala 238:33]
              node _T_13 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 241:24]
              when _T_13 : @[intervox_transmitter.scala 241:33]
                BFR1.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 244:31]
                BFR1.io.dataIn <= BFR.io.dataOut @[intervox_transmitter.scala 245:31]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 247:31]
                BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 248:31]
                node _T_14 = eq(bi_phase_enc.io.NEXT, UInt<1>("h1")) @[intervox_transmitter.scala 250:39]
                when _T_14 : @[intervox_transmitter.scala 250:47]
                  BFR1.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 251:31]
                  BFR1.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 252:31]
                bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 254:30]

