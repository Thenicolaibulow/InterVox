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
        node _T_6 = lt(bitCntr, UInt<7>("h7f")) @[intervox_transmitter.scala 76:26]
        when _T_6 : @[intervox_transmitter.scala 76:34]
          node _T_7 = sub(dataIndex, UInt<3>("h4")) @[intervox_transmitter.scala 78:43]
          node _T_8 = tail(_T_7, 1) @[intervox_transmitter.scala 78:43]
          node _T_9 = dshr(stereoData, _T_8) @[intervox_transmitter.scala 78:31]
          node _T_10 = bits(_T_9, 0, 0) @[intervox_transmitter.scala 78:31]
          node _T_11 = eq(_T_10, UInt<1>("h0")) @[intervox_transmitter.scala 78:53]
          when _T_11 : @[intervox_transmitter.scala 78:62]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 80:25]
        node _T_12 = gt(bitCntr, UInt<7>("h7f")) @[intervox_transmitter.scala 84:26]
        when _T_12 : @[intervox_transmitter.scala 84:34]
          node _T_13 = sub(dataIndex, UInt<3>("h4")) @[intervox_transmitter.scala 86:42]
          node _T_14 = tail(_T_13, 1) @[intervox_transmitter.scala 86:42]
          node _T_15 = dshr(dspData, _T_14) @[intervox_transmitter.scala 86:30]
          node _T_16 = bits(_T_15, 0, 0) @[intervox_transmitter.scala 86:30]
          node _T_17 = eq(_T_16, UInt<1>("h0")) @[intervox_transmitter.scala 86:52]
          when _T_17 : @[intervox_transmitter.scala 86:61]
            hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 88:25]
        node _T_18 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 92:26]
        when _T_18 : @[intervox_transmitter.scala 92:34]
          outReg <= outReg @[intervox_transmitter.scala 93:22]
          hasNone <= UInt<1>("h0") @[intervox_transmitter.scala 94:23]
        else :
          node _outReg_T = not(outReg) @[intervox_transmitter.scala 98:25]
          outReg <= _outReg_T @[intervox_transmitter.scala 98:22]
      node _T_19 = eq(bitCntr, UInt<8>("hff")) @[intervox_transmitter.scala 102:24]
      when _T_19 : @[intervox_transmitter.scala 102:34]
        bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 103:21]
        stereoData <= UInt<1>("h0") @[intervox_transmitter.scala 104:24]
        next <= UInt<1>("h1") @[intervox_transmitter.scala 105:18]

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
    output io : { flip MCLK_IN : Clock, MCLK_O : Clock, flip BCLK_IN : UInt<1>, flip LRCLK_IN : UInt<1>, flip SDATA_IN : UInt<1>, DATA_O : UInt<1>, LRCLK_O : UInt<1>, BCLK_O : UInt<1>, SDATA_O : UInt<1>, NXT_FRAME : UInt<1>}

    reg current_state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 126:34]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 128:34]
    reg DATA_OUT_REG_1B : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 130:34]
    reg FirstFrame : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 132:34]
    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 134:33]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    reg bitCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 136:34]
    reg LR : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 137:34]
    reg tick : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 138:34]
    reg PROCESSED : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 139:34]
    inst BFR of RWSmem @[intervox_transmitter.scala 142:33]
    BFR.clock <= clock
    BFR.reset <= reset
    inst BFR1 of RWSmem_1 @[intervox_transmitter.scala 143:33]
    BFR1.clock <= clock
    BFR1.reset <= reset
    io.DATA_O <= DATA_OUT_REG_1B @[intervox_transmitter.scala 146:25]
    io.MCLK_O <= io.MCLK_IN @[intervox_transmitter.scala 147:25]
    io.BCLK_O <= io.BCLK_IN @[intervox_transmitter.scala 148:25]
    io.LRCLK_O <= io.LRCLK_IN @[intervox_transmitter.scala 149:25]
    io.SDATA_O <= io.SDATA_IN @[intervox_transmitter.scala 150:25]
    BFR.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 151:25]
    BFR.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 152:25]
    BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 153:25]
    BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 154:25]
    BFR1.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 155:25]
    BFR1.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 156:25]
    BFR1.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 157:25]
    BFR1.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 158:25]
    io.NXT_FRAME <= bi_phase_enc.io.TICK @[intervox_transmitter.scala 159:25]
    bi_phase_enc.io.TICK <= UInt<1>("h0") @[intervox_transmitter.scala 162:31]
    bi_phase_enc.io.AUDIOINPUT <= BFR1.io.dataOut @[intervox_transmitter.scala 163:31]
    bi_phase_enc.io.DSPINPUT <= UInt<1>("h0") @[intervox_transmitter.scala 164:31]
    DATA_OUT_REG_1B <= bi_phase_enc.io.DATA_OUT @[intervox_transmitter.scala 166:19]
    node _T = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 179:24]
    when _T : @[intervox_transmitter.scala 179:24]
      current_state <= UInt<2>("h2") @[intervox_transmitter.scala 182:21]
    else :
      node _T_1 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 179:24]
      when _T_1 : @[intervox_transmitter.scala 179:24]
        current_state <= UInt<2>("h2") @[intervox_transmitter.scala 185:21]
      else :
        node _T_2 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 179:24]
        when _T_2 : @[intervox_transmitter.scala 179:24]
          node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 189:44]
          node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 189:44]
          BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_1 @[intervox_transmitter.scala 189:24]
          node _T_3 = eq(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 191:30]
          node _T_4 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 192:30]
          node _T_5 = or(_T_3, _T_4) @[intervox_transmitter.scala 191:38]
          node _T_6 = eq(BiPhase_CLK_CNTR, UInt<3>("h5")) @[intervox_transmitter.scala 193:30]
          node _T_7 = or(_T_5, _T_6) @[intervox_transmitter.scala 192:38]
          node _T_8 = eq(BiPhase_CLK_CNTR, UInt<3>("h7")) @[intervox_transmitter.scala 194:30]
          node _T_9 = or(_T_7, _T_8) @[intervox_transmitter.scala 193:38]
          when _T_9 : @[intervox_transmitter.scala 194:39]
            bi_phase_enc.io.TICK <= UInt<1>("h1") @[intervox_transmitter.scala 195:30]
          node _T_10 = eq(BiPhase_CLK_CNTR, UInt<3>("h7")) @[intervox_transmitter.scala 198:29]
          when _T_10 : @[intervox_transmitter.scala 198:37]
            node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 201:28]
            node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 201:28]
            bitCntr <= _bitCntr_T_1 @[intervox_transmitter.scala 201:17]
            node _T_11 = gt(bitCntr, UInt<6>("h28")) @[intervox_transmitter.scala 206:22]
            when _T_11 : @[intervox_transmitter.scala 206:29]
              node _T_12 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 209:28]
              when _T_12 : @[intervox_transmitter.scala 209:37]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 211:31]
                node _BFR_io_dataIn_T = sub(bitCntr, UInt<5>("h10")) @[intervox_transmitter.scala 212:68]
                node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 212:68]
                node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 212:56]
                node _BFR_io_dataIn_T_3 = add(BFR.io.dataOut, _BFR_io_dataIn_T_2) @[intervox_transmitter.scala 212:49]
                node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_transmitter.scala 212:49]
                BFR.io.dataIn <= _BFR_io_dataIn_T_4 @[intervox_transmitter.scala 212:31]
              node _T_13 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 215:28]
              when _T_13 : @[intervox_transmitter.scala 215:36]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 217:31]
                node _BFR_io_dataIn_T_5 = sub(bitCntr, UInt<5>("h10")) @[intervox_transmitter.scala 218:68]
                node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_transmitter.scala 218:68]
                node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 218:56]
                node _BFR_io_dataIn_T_8 = add(BFR.io.dataOut, _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 218:49]
                node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 218:49]
                BFR.io.dataIn <= _BFR_io_dataIn_T_9 @[intervox_transmitter.scala 218:31]
            else :
              node _T_14 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 221:28]
              when _T_14 : @[intervox_transmitter.scala 221:37]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 223:31]
                node _BFR_io_dataIn_T_10 = dshl(UInt<1>("h0"), bitCntr) @[intervox_transmitter.scala 224:56]
                node _BFR_io_dataIn_T_11 = add(BFR.io.dataOut, _BFR_io_dataIn_T_10) @[intervox_transmitter.scala 224:49]
                node _BFR_io_dataIn_T_12 = tail(_BFR_io_dataIn_T_11, 1) @[intervox_transmitter.scala 224:49]
                BFR.io.dataIn <= _BFR_io_dataIn_T_12 @[intervox_transmitter.scala 224:31]
              node _T_15 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 227:28]
              when _T_15 : @[intervox_transmitter.scala 227:36]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 229:31]
                node _BFR_io_dataIn_T_13 = dshl(UInt<1>("h1"), bitCntr) @[intervox_transmitter.scala 230:56]
                node _BFR_io_dataIn_T_14 = add(BFR.io.dataOut, _BFR_io_dataIn_T_13) @[intervox_transmitter.scala 230:49]
                node _BFR_io_dataIn_T_15 = tail(_BFR_io_dataIn_T_14, 1) @[intervox_transmitter.scala 230:49]
                BFR.io.dataIn <= _BFR_io_dataIn_T_15 @[intervox_transmitter.scala 230:31]
            node _T_16 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 233:22]
            when _T_16 : @[intervox_transmitter.scala 233:31]
              BFR1.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 236:29]
              BFR1.io.dataIn <= BFR.io.dataOut @[intervox_transmitter.scala 237:29]
              BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 239:29]
              BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 240:29]
              node _T_17 = eq(bi_phase_enc.io.NEXT, UInt<1>("h1")) @[intervox_transmitter.scala 242:37]
              when _T_17 : @[intervox_transmitter.scala 242:45]
                BFR1.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 243:29]
                BFR1.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 244:29]
              bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 246:28]
            BiPhase_CLK_CNTR <= UInt<1>("h0") @[intervox_transmitter.scala 249:26]

