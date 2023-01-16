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
    output io : { DATA_OUT : UInt<1>, flip AUDIOINPUT : UInt<64>, flip DSPINPUT : UInt<64>, flip ENA : UInt<1>, flip CLK : UInt<1>}

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
    reg zeroFlip : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 43:32]
    reg dataIndex : UInt<6>, clock with :
      reset => (reset, UInt<6>("h0")) @[intervox_transmitter.scala 44:32]
    reg ndexR : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 45:32]
    reg enabled : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 46:32]
    io.DATA_OUT <= outReg @[intervox_transmitter.scala 48:17]
    stereoData <= io.AUDIOINPUT @[intervox_transmitter.scala 50:17]
    dspData <= io.DSPINPUT @[intervox_transmitter.scala 51:17]
    enabled <= io.ENA @[intervox_transmitter.scala 52:17]
    node _T = eq(io.CLK, UInt<1>("h1")) @[intervox_transmitter.scala 55:17]
    when _T : @[intervox_transmitter.scala 55:25]
      node _T_1 = eq(enabled, UInt<1>("h1")) @[intervox_transmitter.scala 57:20]
      when _T_1 : @[intervox_transmitter.scala 57:28]
        node _bitCntr_enc_T = add(bitCntr_enc, UInt<1>("h1")) @[intervox_transmitter.scala 60:38]
        node _bitCntr_enc_T_1 = tail(_bitCntr_enc_T, 1) @[intervox_transmitter.scala 60:38]
        bitCntr_enc <= _bitCntr_enc_T_1 @[intervox_transmitter.scala 60:23]
        node _T_2 = eq(bitCntr_enc, UInt<2>("h3")) @[intervox_transmitter.scala 69:28]
        when _T_2 : @[intervox_transmitter.scala 69:36]
          node _outReg_T = not(outReg) @[intervox_transmitter.scala 70:23]
          outReg <= _outReg_T @[intervox_transmitter.scala 70:20]
        node _T_3 = eq(bitCntr_enc, UInt<3>("h4")) @[intervox_transmitter.scala 73:28]
        when _T_3 : @[intervox_transmitter.scala 73:36]
          node _outReg_T_1 = not(outReg) @[intervox_transmitter.scala 74:23]
          outReg <= _outReg_T_1 @[intervox_transmitter.scala 74:20]
        node _T_4 = eq(bitCntr_enc, UInt<3>("h5")) @[intervox_transmitter.scala 76:28]
        when _T_4 : @[intervox_transmitter.scala 76:36]
          node _outReg_T_2 = not(outReg) @[intervox_transmitter.scala 77:23]
          outReg <= _outReg_T_2 @[intervox_transmitter.scala 77:20]
        node _T_5 = gt(bitCntr_enc, UInt<3>("h5")) @[intervox_transmitter.scala 81:29]
        when _T_5 : @[intervox_transmitter.scala 81:36]
          node _ndexR_T = not(ndexR) @[intervox_transmitter.scala 84:22]
          ndexR <= _ndexR_T @[intervox_transmitter.scala 84:19]
          node _T_6 = eq(ndexR, UInt<1>("h1")) @[intervox_transmitter.scala 85:24]
          when _T_6 : @[intervox_transmitter.scala 85:32]
            node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 87:38]
            node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 87:38]
            dataIndex <= _dataIndex_T_1 @[intervox_transmitter.scala 87:25]
          node _T_7 = lt(bitCntr_enc, UInt<6>("h35")) @[intervox_transmitter.scala 103:30]
          when _T_7 : @[intervox_transmitter.scala 103:37]
            node _T_8 = eq(ndexR, UInt<1>("h1")) @[intervox_transmitter.scala 105:28]
            when _T_8 : @[intervox_transmitter.scala 105:36]
              node _T_9 = sub(UInt<6>("h3e"), dataIndex) @[intervox_transmitter.scala 106:41]
              node _T_10 = tail(_T_9, 1) @[intervox_transmitter.scala 106:41]
              node _T_11 = dshr(stereoData, _T_10) @[intervox_transmitter.scala 106:35]
              node _T_12 = bits(_T_11, 0, 0) @[intervox_transmitter.scala 106:35]
              node _T_13 = eq(_T_12, UInt<1>("h0")) @[intervox_transmitter.scala 106:57]
              when _T_13 : @[intervox_transmitter.scala 106:66]
                hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 108:29]
          node _T_14 = geq(bitCntr_enc, UInt<6>("h35")) @[intervox_transmitter.scala 117:31]
          node _T_15 = lt(bitCntr_enc, UInt<7>("h65")) @[intervox_transmitter.scala 117:55]
          node _T_16 = and(_T_14, _T_15) @[intervox_transmitter.scala 117:40]
          when _T_16 : @[intervox_transmitter.scala 117:64]
            node _T_17 = eq(ndexR, UInt<1>("h1")) @[intervox_transmitter.scala 119:26]
            when _T_17 : @[intervox_transmitter.scala 119:34]
              node _T_18 = sub(dataIndex, UInt<5>("h18")) @[intervox_transmitter.scala 120:53]
              node _T_19 = tail(_T_18, 1) @[intervox_transmitter.scala 120:53]
              node _T_20 = sub(UInt<6>("h26"), _T_19) @[intervox_transmitter.scala 120:40]
              node _T_21 = tail(_T_20, 1) @[intervox_transmitter.scala 120:40]
              node _T_22 = dshr(stereoData, _T_21) @[intervox_transmitter.scala 120:33]
              node _T_23 = bits(_T_22, 0, 0) @[intervox_transmitter.scala 120:33]
              node _T_24 = eq(_T_23, UInt<1>("h0")) @[intervox_transmitter.scala 120:64]
              when _T_24 : @[intervox_transmitter.scala 120:73]
                hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 121:27]
          node _T_25 = geq(bitCntr_enc, UInt<7>("h65")) @[intervox_transmitter.scala 130:31]
          node _T_26 = leq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 130:56]
          node _T_27 = and(_T_25, _T_26) @[intervox_transmitter.scala 130:41]
          when _T_27 : @[intervox_transmitter.scala 130:66]
            node _T_28 = eq(ndexR, UInt<1>("h1")) @[intervox_transmitter.scala 131:26]
            when _T_28 : @[intervox_transmitter.scala 131:34]
              node _T_29 = sub(dataIndex, UInt<6>("h30")) @[intervox_transmitter.scala 132:42]
              node _T_30 = tail(_T_29, 1) @[intervox_transmitter.scala 132:42]
              node _T_31 = dshr(dspData, _T_30) @[intervox_transmitter.scala 132:30]
              node _T_32 = bits(_T_31, 0, 0) @[intervox_transmitter.scala 132:30]
              node _T_33 = eq(_T_32, UInt<1>("h0")) @[intervox_transmitter.scala 132:53]
              when _T_33 : @[intervox_transmitter.scala 132:62]
                hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 133:27]
          node _T_34 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 143:26]
          when _T_34 : @[intervox_transmitter.scala 143:34]
            outReg <= outReg @[intervox_transmitter.scala 145:22]
            hasNone <= UInt<1>("h0") @[intervox_transmitter.scala 146:23]
          else :
            node _outReg_T_3 = not(outReg) @[intervox_transmitter.scala 150:27]
            outReg <= _outReg_T_3 @[intervox_transmitter.scala 150:24]
        node _T_35 = eq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 155:28]
        when _T_35 : @[intervox_transmitter.scala 155:38]
          bitCntr_enc <= UInt<1>("h0") @[intervox_transmitter.scala 156:25]
          dataIndex <= UInt<1>("h0") @[intervox_transmitter.scala 157:23]
          enabled <= UInt<1>("h0") @[intervox_transmitter.scala 158:21]

  module edgeDetector :
    input clock : Clock
    input reset : Reset
    output io : { flip INPUT : UInt<1>, TRAIL : UInt<1>, RISE : UInt<1>, CHANGE : UInt<1>}

    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 172:34]
    reg inBufrPrev : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 173:34]
    reg trailing : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 174:34]
    reg rising : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 175:34]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 176:34]
    reg changed : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 177:34]
    node _T = eq(UInt<1>("h1"), io.INPUT) @[intervox_transmitter.scala 182:21]
    when _T : @[intervox_transmitter.scala 182:21]
      node _T_1 = lt(inBufr, UInt<2>("h2")) @[intervox_transmitter.scala 184:21]
      when _T_1 : @[intervox_transmitter.scala 184:27]
        node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 186:35]
        node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_transmitter.scala 186:35]
        inBufr <= _inBufr_T_1 @[intervox_transmitter.scala 186:25]
        inBufrPrev <= inBufr @[intervox_transmitter.scala 187:25]
    else :
      node _T_2 = eq(UInt<1>("h0"), io.INPUT) @[intervox_transmitter.scala 182:21]
      when _T_2 : @[intervox_transmitter.scala 182:21]
        node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_transmitter.scala 191:21]
        when _T_3 : @[intervox_transmitter.scala 191:27]
          node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 193:35]
          node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_transmitter.scala 193:35]
          inBufr <= _inBufr_T_3 @[intervox_transmitter.scala 193:25]
          inBufrPrev <= inBufr @[intervox_transmitter.scala 194:25]
    node _T_4 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 199:18]
    node _T_5 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 199:39]
    node _T_6 = or(_T_4, _T_5) @[intervox_transmitter.scala 199:27]
    when _T_6 : @[intervox_transmitter.scala 199:48]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 200:17]
    node _T_7 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_transmitter.scala 203:22]
    node _T_8 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 203:41]
    node _T_9 = and(_T_7, _T_8) @[intervox_transmitter.scala 203:31]
    when _T_9 : @[intervox_transmitter.scala 203:50]
      trailing <= UInt<1>("h0") @[intervox_transmitter.scala 204:17]
      rising <= UInt<1>("h1") @[intervox_transmitter.scala 205:17]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 206:17]
    node _T_10 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_transmitter.scala 209:22]
    node _T_11 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 209:41]
    node _T_12 = and(_T_10, _T_11) @[intervox_transmitter.scala 209:31]
    when _T_12 : @[intervox_transmitter.scala 209:50]
      trailing <= UInt<1>("h1") @[intervox_transmitter.scala 210:17]
      rising <= UInt<1>("h0") @[intervox_transmitter.scala 211:17]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 212:17]
    node _T_13 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 215:19]
    when _T_13 : @[intervox_transmitter.scala 215:27]
      trailing <= UInt<1>("h0") @[intervox_transmitter.scala 215:37]
    node _T_14 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 216:17]
    when _T_14 : @[intervox_transmitter.scala 216:27]
      rising <= UInt<1>("h0") @[intervox_transmitter.scala 216:37]
    node _T_15 = eq(change, UInt<1>("h1")) @[intervox_transmitter.scala 218:17]
    when _T_15 : @[intervox_transmitter.scala 218:25]
      reg change_REG : UInt, clock with :
        reset => (UInt<1>("h0"), change_REG) @[intervox_transmitter.scala 219:26]
      change_REG <= UInt<1>("h0") @[intervox_transmitter.scala 219:26]
      change <= change_REG @[intervox_transmitter.scala 219:16]
    io.CHANGE <= change @[intervox_transmitter.scala 222:13]
    io.TRAIL <= trailing @[intervox_transmitter.scala 223:13]
    io.RISE <= rising @[intervox_transmitter.scala 224:13]

  module edgeDetector_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip INPUT : UInt<1>, TRAIL : UInt<1>, RISE : UInt<1>, CHANGE : UInt<1>}

    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 172:34]
    reg inBufrPrev : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 173:34]
    reg trailing : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 174:34]
    reg rising : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 175:34]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 176:34]
    reg changed : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 177:34]
    node _T = eq(UInt<1>("h1"), io.INPUT) @[intervox_transmitter.scala 182:21]
    when _T : @[intervox_transmitter.scala 182:21]
      node _T_1 = lt(inBufr, UInt<2>("h2")) @[intervox_transmitter.scala 184:21]
      when _T_1 : @[intervox_transmitter.scala 184:27]
        node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 186:35]
        node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_transmitter.scala 186:35]
        inBufr <= _inBufr_T_1 @[intervox_transmitter.scala 186:25]
        inBufrPrev <= inBufr @[intervox_transmitter.scala 187:25]
    else :
      node _T_2 = eq(UInt<1>("h0"), io.INPUT) @[intervox_transmitter.scala 182:21]
      when _T_2 : @[intervox_transmitter.scala 182:21]
        node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_transmitter.scala 191:21]
        when _T_3 : @[intervox_transmitter.scala 191:27]
          node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 193:35]
          node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_transmitter.scala 193:35]
          inBufr <= _inBufr_T_3 @[intervox_transmitter.scala 193:25]
          inBufrPrev <= inBufr @[intervox_transmitter.scala 194:25]
    node _T_4 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 199:18]
    node _T_5 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 199:39]
    node _T_6 = or(_T_4, _T_5) @[intervox_transmitter.scala 199:27]
    when _T_6 : @[intervox_transmitter.scala 199:48]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 200:17]
    node _T_7 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_transmitter.scala 203:22]
    node _T_8 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 203:41]
    node _T_9 = and(_T_7, _T_8) @[intervox_transmitter.scala 203:31]
    when _T_9 : @[intervox_transmitter.scala 203:50]
      trailing <= UInt<1>("h0") @[intervox_transmitter.scala 204:17]
      rising <= UInt<1>("h1") @[intervox_transmitter.scala 205:17]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 206:17]
    node _T_10 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_transmitter.scala 209:22]
    node _T_11 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 209:41]
    node _T_12 = and(_T_10, _T_11) @[intervox_transmitter.scala 209:31]
    when _T_12 : @[intervox_transmitter.scala 209:50]
      trailing <= UInt<1>("h1") @[intervox_transmitter.scala 210:17]
      rising <= UInt<1>("h0") @[intervox_transmitter.scala 211:17]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 212:17]
    node _T_13 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 215:19]
    when _T_13 : @[intervox_transmitter.scala 215:27]
      trailing <= UInt<1>("h0") @[intervox_transmitter.scala 215:37]
    node _T_14 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 216:17]
    when _T_14 : @[intervox_transmitter.scala 216:27]
      rising <= UInt<1>("h0") @[intervox_transmitter.scala 216:37]
    node _T_15 = eq(change, UInt<1>("h1")) @[intervox_transmitter.scala 218:17]
    when _T_15 : @[intervox_transmitter.scala 218:25]
      reg change_REG : UInt, clock with :
        reset => (UInt<1>("h0"), change_REG) @[intervox_transmitter.scala 219:26]
      change_REG <= UInt<1>("h0") @[intervox_transmitter.scala 219:26]
      change <= change_REG @[intervox_transmitter.scala 219:16]
    io.CHANGE <= change @[intervox_transmitter.scala 222:13]
    io.TRAIL <= trailing @[intervox_transmitter.scala 223:13]
    io.RISE <= rising @[intervox_transmitter.scala 224:13]

  module edgeDetector_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip INPUT : UInt<1>, TRAIL : UInt<1>, RISE : UInt<1>, CHANGE : UInt<1>}

    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 172:34]
    reg inBufrPrev : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 173:34]
    reg trailing : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 174:34]
    reg rising : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 175:34]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 176:34]
    reg changed : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 177:34]
    node _T = eq(UInt<1>("h1"), io.INPUT) @[intervox_transmitter.scala 182:21]
    when _T : @[intervox_transmitter.scala 182:21]
      node _T_1 = lt(inBufr, UInt<2>("h2")) @[intervox_transmitter.scala 184:21]
      when _T_1 : @[intervox_transmitter.scala 184:27]
        node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 186:35]
        node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_transmitter.scala 186:35]
        inBufr <= _inBufr_T_1 @[intervox_transmitter.scala 186:25]
        inBufrPrev <= inBufr @[intervox_transmitter.scala 187:25]
    else :
      node _T_2 = eq(UInt<1>("h0"), io.INPUT) @[intervox_transmitter.scala 182:21]
      when _T_2 : @[intervox_transmitter.scala 182:21]
        node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_transmitter.scala 191:21]
        when _T_3 : @[intervox_transmitter.scala 191:27]
          node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 193:35]
          node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_transmitter.scala 193:35]
          inBufr <= _inBufr_T_3 @[intervox_transmitter.scala 193:25]
          inBufrPrev <= inBufr @[intervox_transmitter.scala 194:25]
    node _T_4 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 199:18]
    node _T_5 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 199:39]
    node _T_6 = or(_T_4, _T_5) @[intervox_transmitter.scala 199:27]
    when _T_6 : @[intervox_transmitter.scala 199:48]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 200:17]
    node _T_7 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_transmitter.scala 203:22]
    node _T_8 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 203:41]
    node _T_9 = and(_T_7, _T_8) @[intervox_transmitter.scala 203:31]
    when _T_9 : @[intervox_transmitter.scala 203:50]
      trailing <= UInt<1>("h0") @[intervox_transmitter.scala 204:17]
      rising <= UInt<1>("h1") @[intervox_transmitter.scala 205:17]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 206:17]
    node _T_10 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_transmitter.scala 209:22]
    node _T_11 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 209:41]
    node _T_12 = and(_T_10, _T_11) @[intervox_transmitter.scala 209:31]
    when _T_12 : @[intervox_transmitter.scala 209:50]
      trailing <= UInt<1>("h1") @[intervox_transmitter.scala 210:17]
      rising <= UInt<1>("h0") @[intervox_transmitter.scala 211:17]
      change <= UInt<1>("h1") @[intervox_transmitter.scala 212:17]
    node _T_13 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 215:19]
    when _T_13 : @[intervox_transmitter.scala 215:27]
      trailing <= UInt<1>("h0") @[intervox_transmitter.scala 215:37]
    node _T_14 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 216:17]
    when _T_14 : @[intervox_transmitter.scala 216:27]
      rising <= UInt<1>("h0") @[intervox_transmitter.scala 216:37]
    node _T_15 = eq(change, UInt<1>("h1")) @[intervox_transmitter.scala 218:17]
    when _T_15 : @[intervox_transmitter.scala 218:25]
      reg change_REG : UInt, clock with :
        reset => (UInt<1>("h0"), change_REG) @[intervox_transmitter.scala 219:26]
      change_REG <= UInt<1>("h0") @[intervox_transmitter.scala 219:26]
      change <= change_REG @[intervox_transmitter.scala 219:16]
    io.CHANGE <= change @[intervox_transmitter.scala 222:13]
    io.TRAIL <= trailing @[intervox_transmitter.scala 223:13]
    io.RISE <= rising @[intervox_transmitter.scala 224:13]

  module interVox_Encoder :
    input clock : Clock
    input reset : UInt<1>
    output io : { MCLK_O : Clock, flip BCLK_IN : UInt<1>, flip LRCLK_IN : UInt<1>, flip SDATA_IN : UInt<1>, DATA_O : UInt<1>, LRCLK_O : UInt<1>, BCLK_O : UInt<1>, SDATA_O : UInt<1>, NXT_FRAME : UInt<1>, flip SW : UInt<16>, LED : UInt<16>, flip BTN_C : UInt<1>, flip BTN_D : UInt<1>, flip BTN_L : UInt<1>, flip BTN_R : UInt<1>}

    reg currentState : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 248:33]
    reg syncing : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 250:34]
    reg synced : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 251:34]
    reg biPhaseEna : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 252:34]
    reg leds : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[intervox_transmitter.scala 255:34]
    reg left : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[intervox_transmitter.scala 256:34]
    reg right : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[intervox_transmitter.scala 257:34]
    reg dspData : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[intervox_transmitter.scala 258:34]
    reg bclkR : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[intervox_transmitter.scala 260:34]
    reg encoderClk : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 262:34]
    reg bitCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 264:34]
    inst BFR of RWSmem @[intervox_transmitter.scala 266:33]
    BFR.clock <= clock
    BFR.reset <= reset
    inst BFR1 of RWSmem_1 @[intervox_transmitter.scala 267:33]
    BFR1.clock <= clock
    BFR1.reset <= reset
    inst biPhaseEncoder of biPhaseEncoder @[intervox_transmitter.scala 269:35]
    biPhaseEncoder.clock <= clock
    biPhaseEncoder.reset <= reset
    inst LREDGE of edgeDetector @[intervox_transmitter.scala 271:33]
    LREDGE.clock <= clock
    LREDGE.reset <= reset
    LREDGE.io.INPUT <= io.LRCLK_IN @[intervox_transmitter.scala 272:25]
    inst BCLKEDGE of edgeDetector_1 @[intervox_transmitter.scala 273:33]
    BCLKEDGE.clock <= clock
    BCLKEDGE.reset <= reset
    BCLKEDGE.io.INPUT <= io.BCLK_IN @[intervox_transmitter.scala 274:25]
    inst DATAEDGE of edgeDetector_2 @[intervox_transmitter.scala 275:33]
    DATAEDGE.clock <= clock
    DATAEDGE.reset <= reset
    DATAEDGE.io.INPUT <= io.SDATA_IN @[intervox_transmitter.scala 276:25]
    io.DATA_O <= biPhaseEncoder.io.DATA_OUT @[intervox_transmitter.scala 279:25]
    io.MCLK_O <= clock @[intervox_transmitter.scala 280:25]
    io.BCLK_O <= io.BCLK_IN @[intervox_transmitter.scala 281:25]
    io.LRCLK_O <= io.LRCLK_IN @[intervox_transmitter.scala 282:25]
    io.SDATA_O <= io.SDATA_IN @[intervox_transmitter.scala 283:25]
    io.LED <= leds @[intervox_transmitter.scala 284:25]
    BFR.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 287:25]
    BFR.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 288:25]
    BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 289:25]
    BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 290:25]
    BFR1.io.enable <= UInt<1>("h1") @[intervox_transmitter.scala 291:25]
    BFR1.io.addr <= UInt<1>("h1") @[intervox_transmitter.scala 292:25]
    BFR1.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 293:25]
    BFR1.io.dataIn <= BFR.io.dataOut @[intervox_transmitter.scala 294:25]
    io.NXT_FRAME <= BCLKEDGE.io.CHANGE @[intervox_transmitter.scala 297:33]
    biPhaseEncoder.io.CLK <= BCLKEDGE.io.CHANGE @[intervox_transmitter.scala 299:33]
    biPhaseEncoder.io.ENA <= biPhaseEna @[intervox_transmitter.scala 300:33]
    biPhaseEncoder.io.AUDIOINPUT <= BFR1.io.dataOut @[intervox_transmitter.scala 302:33]
    biPhaseEncoder.io.DSPINPUT <= dspData @[intervox_transmitter.scala 304:33]
    node _T = eq(synced, UInt<1>("h0")) @[intervox_transmitter.scala 321:15]
    when _T : @[intervox_transmitter.scala 321:23]
      node _T_1 = eq(LREDGE.io.TRAIL, UInt<1>("h1")) @[intervox_transmitter.scala 323:26]
      when _T_1 : @[intervox_transmitter.scala 323:34]
        syncing <= UInt<1>("h1") @[intervox_transmitter.scala 324:15]
      node _T_2 = eq(syncing, UInt<1>("h1")) @[intervox_transmitter.scala 326:19]
      when _T_2 : @[intervox_transmitter.scala 326:27]
        node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 327:30]
        node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 327:30]
        bitCntr <= _bitCntr_T_1 @[intervox_transmitter.scala 327:19]
        node _T_3 = eq(LREDGE.io.RISE, UInt<1>("h1")) @[intervox_transmitter.scala 329:27]
        when _T_3 : @[intervox_transmitter.scala 329:35]
          synced <= UInt<1>("h1") @[intervox_transmitter.scala 330:19]
          bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 331:19]
    node _T_4 = eq(UInt<2>("h0"), currentState) @[intervox_transmitter.scala 343:23]
    when _T_4 : @[intervox_transmitter.scala 343:23]
      currentState <= UInt<2>("h2") @[intervox_transmitter.scala 347:20]
    else :
      node _T_5 = eq(UInt<2>("h1"), currentState) @[intervox_transmitter.scala 343:23]
      when _T_5 : @[intervox_transmitter.scala 343:23]
        currentState <= UInt<2>("h2") @[intervox_transmitter.scala 351:20]
      else :
        node _T_6 = eq(UInt<2>("h2"), currentState) @[intervox_transmitter.scala 343:23]
        when _T_6 : @[intervox_transmitter.scala 343:23]
          node _T_7 = eq(synced, UInt<1>("h1")) @[intervox_transmitter.scala 355:20]
          when _T_7 : @[intervox_transmitter.scala 355:29]
            node _encoderClk_T = not(encoderClk) @[intervox_transmitter.scala 362:23]
            encoderClk <= _encoderClk_T @[intervox_transmitter.scala 362:20]
            node _T_8 = eq(BCLKEDGE.io.RISE, UInt<1>("h1")) @[intervox_transmitter.scala 365:31]
            when _T_8 : @[intervox_transmitter.scala 365:39]
              biPhaseEna <= UInt<1>("h1") @[intervox_transmitter.scala 368:23]
              node _bitCntr_T_2 = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 371:30]
              node _bitCntr_T_3 = tail(_bitCntr_T_2, 1) @[intervox_transmitter.scala 371:30]
              bitCntr <= _bitCntr_T_3 @[intervox_transmitter.scala 371:19]
              node _T_9 = eq(io.SW, UInt<1>("h0")) @[intervox_transmitter.scala 381:22]
              when _T_9 : @[intervox_transmitter.scala 381:30]
                node _T_10 = gt(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 383:26]
                when _T_10 : @[intervox_transmitter.scala 383:33]
                  BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 386:33]
                  node _T_11 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 387:33]
                  when _T_11 : @[intervox_transmitter.scala 387:42]
                    node _BFR_io_dataIn_T = sub(bitCntr, UInt<5>("h1e")) @[intervox_transmitter.scala 391:80]
                    node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 391:80]
                    node _BFR_io_dataIn_T_2 = sub(UInt<6>("h27"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 391:69]
                    node _BFR_io_dataIn_T_3 = tail(_BFR_io_dataIn_T_2, 1) @[intervox_transmitter.scala 391:69]
                    node _BFR_io_dataIn_T_4 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_3) @[intervox_transmitter.scala 391:60]
                    node _BFR_io_dataIn_T_5 = or(BFR.io.dataOut, _BFR_io_dataIn_T_4) @[intervox_transmitter.scala 391:53]
                    BFR.io.dataIn <= _BFR_io_dataIn_T_5 @[intervox_transmitter.scala 391:35]
                  node _T_12 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 393:33]
                  when _T_12 : @[intervox_transmitter.scala 393:42]
                    node _BFR_io_dataIn_T_6 = sub(bitCntr, UInt<5>("h1e")) @[intervox_transmitter.scala 394:81]
                    node _BFR_io_dataIn_T_7 = tail(_BFR_io_dataIn_T_6, 1) @[intervox_transmitter.scala 394:81]
                    node _BFR_io_dataIn_T_8 = sub(UInt<6>("h27"), _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 394:70]
                    node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 394:70]
                    node _BFR_io_dataIn_T_10 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_9) @[intervox_transmitter.scala 394:60]
                    node _BFR_io_dataIn_T_11 = or(BFR.io.dataOut, _BFR_io_dataIn_T_10) @[intervox_transmitter.scala 394:53]
                    BFR.io.dataIn <= _BFR_io_dataIn_T_11 @[intervox_transmitter.scala 394:35]
                else :
                  BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 398:33]
                  node _T_13 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 399:33]
                  when _T_13 : @[intervox_transmitter.scala 399:43]
                    node _BFR_io_dataIn_T_12 = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 402:80]
                    node _BFR_io_dataIn_T_13 = tail(_BFR_io_dataIn_T_12, 1) @[intervox_transmitter.scala 402:80]
                    node _BFR_io_dataIn_T_14 = sub(UInt<6>("h3f"), _BFR_io_dataIn_T_13) @[intervox_transmitter.scala 402:69]
                    node _BFR_io_dataIn_T_15 = tail(_BFR_io_dataIn_T_14, 1) @[intervox_transmitter.scala 402:69]
                    node _BFR_io_dataIn_T_16 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_15) @[intervox_transmitter.scala 402:60]
                    node _BFR_io_dataIn_T_17 = or(BFR.io.dataOut, _BFR_io_dataIn_T_16) @[intervox_transmitter.scala 402:53]
                    BFR.io.dataIn <= _BFR_io_dataIn_T_17 @[intervox_transmitter.scala 402:35]
                  node _T_14 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 404:33]
                  when _T_14 : @[intervox_transmitter.scala 404:42]
                    node _BFR_io_dataIn_T_18 = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 405:81]
                    node _BFR_io_dataIn_T_19 = tail(_BFR_io_dataIn_T_18, 1) @[intervox_transmitter.scala 405:81]
                    node _BFR_io_dataIn_T_20 = sub(UInt<6>("h3f"), _BFR_io_dataIn_T_19) @[intervox_transmitter.scala 405:70]
                    node _BFR_io_dataIn_T_21 = tail(_BFR_io_dataIn_T_20, 1) @[intervox_transmitter.scala 405:70]
                    node _BFR_io_dataIn_T_22 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_21) @[intervox_transmitter.scala 405:61]
                    node _BFR_io_dataIn_T_23 = or(BFR.io.dataOut, _BFR_io_dataIn_T_22) @[intervox_transmitter.scala 405:53]
                    BFR.io.dataIn <= _BFR_io_dataIn_T_23 @[intervox_transmitter.scala 405:35]
              else :
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 411:27]
                node _T_15 = eq(io.BTN_L, UInt<1>("h1")) @[intervox_transmitter.scala 416:27]
                when _T_15 : @[intervox_transmitter.scala 416:35]
                  left <= io.SW @[intervox_transmitter.scala 418:23]
                  leds <= left @[intervox_transmitter.scala 419:23]
                node _T_16 = eq(io.BTN_R, UInt<1>("h1")) @[intervox_transmitter.scala 421:27]
                when _T_16 : @[intervox_transmitter.scala 421:35]
                  right <= io.SW @[intervox_transmitter.scala 423:23]
                  leds <= right @[intervox_transmitter.scala 424:23]
                node _T_17 = eq(io.BTN_C, UInt<1>("h1")) @[intervox_transmitter.scala 426:27]
                when _T_17 : @[intervox_transmitter.scala 426:35]
                  dspData <= io.SW @[intervox_transmitter.scala 428:23]
                  leds <= dspData @[intervox_transmitter.scala 429:23]
                node _BFR_io_dataIn_T_24 = dshl(left, UInt<6>("h2f")) @[intervox_transmitter.scala 436:36]
                node _BFR_io_dataIn_T_25 = dshl(right, UInt<5>("h17")) @[intervox_transmitter.scala 436:56]
                node _BFR_io_dataIn_T_26 = or(_BFR_io_dataIn_T_24, _BFR_io_dataIn_T_25) @[intervox_transmitter.scala 436:47]
                BFR.io.dataIn <= _BFR_io_dataIn_T_26 @[intervox_transmitter.scala 436:27]
              node _T_18 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 439:24]
              when _T_18 : @[intervox_transmitter.scala 439:33]
                BFR.io.write <= UInt<1>("h0") @[intervox_transmitter.scala 443:31]
                BFR1.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 444:31]
                BFR1.io.dataIn <= BFR.io.dataOut @[intervox_transmitter.scala 445:32]
                BFR.io.write <= UInt<1>("h1") @[intervox_transmitter.scala 448:28]
                BFR.io.dataIn <= UInt<1>("h0") @[intervox_transmitter.scala 449:28]
                node _T_19 = eq(io.BTN_D, UInt<1>("h1")) @[intervox_transmitter.scala 453:27]
                when _T_19 : @[intervox_transmitter.scala 453:35]
                  node _leds_T = dshr(BFR1.io.dataOut, UInt<6>("h2f")) @[intervox_transmitter.scala 455:40]
                  node _leds_T_1 = and(_leds_T, UInt<16>("hffff")) @[intervox_transmitter.scala 455:49]
                  leds <= _leds_T_1 @[intervox_transmitter.scala 455:20]
                bitCntr <= UInt<1>("h0") @[intervox_transmitter.scala 458:21]

