circuit interVox_Encoder :
  module bi_phase_encoder :
    input clock : Clock
    input reset : UInt<1>
    output io_DATA_OUT : UInt<1>
    input io_AUDIOINPUT : UInt<64>
    input io_DSPINPUT : UInt<64>
    input io_TICK : UInt<1>
    output io_NEXT : UInt<1>

    reg outReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), outReg) @[intervox_transmitter.scala 38:32]
    reg next : UInt<1>, clock with :
      reset => (UInt<1>("h0"), next) @[intervox_transmitter.scala 39:32]
    reg stereoData : UInt<64>, clock with :
      reset => (UInt<1>("h0"), stereoData) @[intervox_transmitter.scala 40:32]
    reg dspData : UInt<16>, clock with :
      reset => (UInt<1>("h0"), dspData) @[intervox_transmitter.scala 41:32]
    reg bitCntr_enc : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr_enc) @[intervox_transmitter.scala 42:32]
    reg hasNone : UInt<1>, clock with :
      reset => (UInt<1>("h0"), hasNone) @[intervox_transmitter.scala 43:32]
    reg dataIndex : UInt<6>, clock with :
      reset => (UInt<1>("h0"), dataIndex) @[intervox_transmitter.scala 44:32]
    reg ndexR : UInt<1>, clock with :
      reset => (UInt<1>("h0"), ndexR) @[intervox_transmitter.scala 52:32]
    node _T = eq(io_TICK, UInt<1>("h0")) @[intervox_transmitter.scala 56:18]
    node _bitCntr_enc_T = add(bitCntr_enc, UInt<1>("h1")) @[intervox_transmitter.scala 58:36]
    node _bitCntr_enc_T_1 = tail(_bitCntr_enc_T, 1) @[intervox_transmitter.scala 58:36]
    node _ndexR_T = not(ndexR) @[intervox_transmitter.scala 61:18]
    node _T_1 = eq(ndexR, UInt<1>("h1")) @[intervox_transmitter.scala 62:20]
    node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 64:34]
    node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 64:34]
    node _GEN_0 = mux(_T_1, _dataIndex_T_1, dataIndex) @[intervox_transmitter.scala 62:28 64:21 44:32]
    node _T_2 = lt(bitCntr_enc, UInt<3>("h7")) @[intervox_transmitter.scala 68:26]
    node _T_3 = lt(bitCntr_enc, UInt<3>("h6")) @[intervox_transmitter.scala 71:28]
    node _GEN_1 = mux(_T_3, UInt<1>("h0"), UInt<1>("h1")) @[intervox_transmitter.scala 72:11 73:20 77:20]
    node _GEN_2 = mux(_T_2, _GEN_1, outReg) @[intervox_transmitter.scala 38:32 68:33]
    node _T_4 = gt(bitCntr_enc, UInt<3>("h7")) @[intervox_transmitter.scala 81:27]
    node _T_5 = lt(bitCntr_enc, UInt<6>("h37")) @[intervox_transmitter.scala 84:28]
    node _T_6 = sub(dataIndex, UInt<2>("h3")) @[intervox_transmitter.scala 86:48]
    node _T_7 = tail(_T_6, 1) @[intervox_transmitter.scala 86:48]
    node _T_8 = sub(UInt<7>("h40"), _T_7) @[intervox_transmitter.scala 86:35]
    node _T_9 = tail(_T_8, 1) @[intervox_transmitter.scala 86:35]
    node _T_10 = dshr(stereoData, _T_9) @[intervox_transmitter.scala 86:29]
    node _T_11 = bits(_T_10, 0, 0) @[intervox_transmitter.scala 86:29]
    node _T_12 = eq(_T_11, UInt<1>("h0")) @[intervox_transmitter.scala 86:58]
    node _GEN_3 = mux(_T_12, UInt<1>("h1"), hasNone) @[intervox_transmitter.scala 86:67 88:23 43:32]
    node _GEN_4 = mux(_T_5, _GEN_3, hasNone) @[intervox_transmitter.scala 43:32 84:35]
    node _T_13 = geq(bitCntr_enc, UInt<6>("h37")) @[intervox_transmitter.scala 91:29]
    node _T_14 = lt(bitCntr_enc, UInt<7>("h67")) @[intervox_transmitter.scala 91:53]
    node _T_15 = and(_T_13, _T_14) @[intervox_transmitter.scala 91:38]
    node _T_16 = sub(dataIndex, UInt<5>("h1b")) @[intervox_transmitter.scala 93:49]
    node _T_17 = tail(_T_16, 1) @[intervox_transmitter.scala 93:49]
    node _T_18 = sub(UInt<7>("h40"), _T_17) @[intervox_transmitter.scala 93:36]
    node _T_19 = tail(_T_18, 1) @[intervox_transmitter.scala 93:36]
    node _T_20 = dshr(stereoData, _T_19) @[intervox_transmitter.scala 93:29]
    node _T_21 = bits(_T_20, 0, 0) @[intervox_transmitter.scala 93:29]
    node _T_22 = eq(_T_21, UInt<1>("h0")) @[intervox_transmitter.scala 93:61]
    node _GEN_5 = mux(_T_22, UInt<1>("h1"), _GEN_4) @[intervox_transmitter.scala 93:70 95:23]
    node _GEN_6 = mux(_T_15, _GEN_5, _GEN_4) @[intervox_transmitter.scala 91:62]
    node _T_23 = geq(bitCntr_enc, UInt<7>("h67")) @[intervox_transmitter.scala 99:29]
    node _T_24 = lt(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 99:54]
    node _T_25 = and(_T_23, _T_24) @[intervox_transmitter.scala 99:39]
    node _T_26 = sub(dataIndex, UInt<6>("h34")) @[intervox_transmitter.scala 103:40]
    node _T_27 = tail(_T_26, 1) @[intervox_transmitter.scala 103:40]
    node _T_28 = dshr(dspData, _T_27) @[intervox_transmitter.scala 103:28]
    node _T_29 = bits(_T_28, 0, 0) @[intervox_transmitter.scala 103:28]
    node _T_30 = eq(_T_29, UInt<1>("h0")) @[intervox_transmitter.scala 103:51]
    node _GEN_7 = mux(_T_30, UInt<1>("h1"), _GEN_6) @[intervox_transmitter.scala 103:60 105:23]
    node _GEN_8 = mux(_T_25, _GEN_7, _GEN_6) @[intervox_transmitter.scala 99:63]
    node _T_31 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 109:24]
    node _outReg_T = not(outReg) @[intervox_transmitter.scala 115:23]
    node _GEN_9 = mux(_T_31, outReg, _outReg_T) @[intervox_transmitter.scala 109:32 110:20 115:20]
    node _GEN_10 = mux(_T_31, UInt<1>("h0"), _GEN_8) @[intervox_transmitter.scala 109:32 111:21]
    node _GEN_11 = mux(_T_4, _GEN_10, hasNone) @[intervox_transmitter.scala 43:32 81:34]
    node _GEN_12 = mux(_T_4, _GEN_9, _GEN_2) @[intervox_transmitter.scala 81:34]
    node _T_32 = eq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 119:26]
    node _GEN_13 = mux(_T_32, UInt<1>("h0"), _bitCntr_enc_T_1) @[intervox_transmitter.scala 119:36 120:23 58:21]
    node _GEN_14 = mux(_T, _GEN_13, bitCntr_enc) @[intervox_transmitter.scala 56:26 42:32]
    node _GEN_15 = mux(_T, _ndexR_T, ndexR) @[intervox_transmitter.scala 56:26 61:15 52:32]
    node _GEN_16 = mux(_T, _GEN_0, dataIndex) @[intervox_transmitter.scala 56:26 44:32]
    node _GEN_17 = mux(_T, _GEN_12, outReg) @[intervox_transmitter.scala 56:26 38:32]
    node _GEN_18 = mux(_T, _GEN_11, hasNone) @[intervox_transmitter.scala 56:26 43:32]
    io_DATA_OUT <= outReg @[intervox_transmitter.scala 46:17]
    io_NEXT <= next @[intervox_transmitter.scala 50:13]
    outReg <= mux(reset, UInt<1>("h0"), _GEN_17) @[intervox_transmitter.scala 38:{32,32}]
    next <= mux(reset, UInt<1>("h0"), next) @[intervox_transmitter.scala 39:{32,32,32}]
    stereoData <= mux(reset, UInt<64>("h0"), io_AUDIOINPUT) @[intervox_transmitter.scala 40:{32,32} 48:16]
    dspData <= bits(mux(reset, UInt<16>("h0"), io_DSPINPUT), 15, 0) @[intervox_transmitter.scala 41:{32,32} 49:13]
    bitCntr_enc <= mux(reset, UInt<8>("h0"), _GEN_14) @[intervox_transmitter.scala 42:{32,32}]
    hasNone <= mux(reset, UInt<1>("h0"), _GEN_18) @[intervox_transmitter.scala 43:{32,32}]
    dataIndex <= mux(reset, UInt<6>("h0"), _GEN_16) @[intervox_transmitter.scala 44:{32,32}]
    ndexR <= mux(reset, UInt<1>("h0"), _GEN_15) @[intervox_transmitter.scala 52:{32,32}]

  module RWSmem :
    input clock : Clock
    input reset : UInt<1>
    input io_enable : UInt<1>
    input io_write : UInt<1>
    input io_addr : UInt<1>
    input io_dataIn : UInt<64>
    output io_dataOut : UInt<64>

    mem mem : @[intervox_transmitter.scala 19:24]
      data-type => UInt<64>
      depth => 1
      read-latency => 1
      write-latency => 1
      readwriter => rdwrPort
      read-under-write => undefined
    node _GEN_0 = validif(io_write, io_dataIn) @[intervox_transmitter.scala 25:{21,32}]
    node _GEN_1 = mux(io_write, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 25:21 24:23 25:32]
    node _GEN_2 = validif(eq(io_write, UInt<1>("h0")), mem.rdwrPort.rdata) @[intervox_transmitter.scala 25:21 26:34]
    node _GEN_3 = validif(io_enable, UInt<1>("h0")) @[intervox_transmitter.scala 23:19 24:23]
    node _GEN_4 = validif(io_enable, clock) @[intervox_transmitter.scala 23:19 24:23]
    node _GEN_5 = mux(io_enable, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 23:19 24:23 19:24]
    node _GEN_6 = validif(io_enable, _GEN_1) @[intervox_transmitter.scala 23:19]
    node _GEN_7 = validif(io_enable, _GEN_0) @[intervox_transmitter.scala 23:19]
    node _GEN_8 = mux(io_enable, _GEN_1, UInt<1>("h0")) @[intervox_transmitter.scala 23:19 19:24]
    node _GEN_9 = validif(io_enable, _GEN_2) @[intervox_transmitter.scala 23:19]
    io_dataOut <= _GEN_9
    mem.rdwrPort.addr <= _GEN_3
    mem.rdwrPort.en <= _GEN_5
    mem.rdwrPort.clk <= _GEN_4
    mem.rdwrPort.wmode <= _GEN_8
    mem.rdwrPort.wdata <= _GEN_7
    mem.rdwrPort.wmask <= _GEN_6

  module interVox_Encoder :
    input clock : Clock
    input reset : UInt<1>
    output io_MCLK_O : Clock
    input io_BCLK_IN : UInt<1>
    input io_LRCLK_IN : UInt<1>
    input io_SDATA_IN : UInt<1>
    output io_DATA_O : UInt<1>
    output io_LRCLK_O : UInt<1>
    output io_BCLK_O : UInt<1>
    output io_SDATA_O : UInt<1>
    output io_NXT_FRAME : UInt<1>

    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 153:33]
    inst BFR of RWSmem @[intervox_transmitter.scala 157:33]
    inst BFR1 of RWSmem @[intervox_transmitter.scala 158:33]
    reg current_state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), current_state) @[intervox_transmitter.scala 141:34]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (UInt<1>("h0"), BiPhase_CLK_CNTR) @[intervox_transmitter.scala 143:34]
    reg DATA_OUT_REG_1B : UInt<1>, clock with :
      reset => (UInt<1>("h0"), DATA_OUT_REG_1B) @[intervox_transmitter.scala 145:34]
    reg FirstFrame : UInt<1>, clock with :
      reset => (UInt<1>("h0"), FirstFrame) @[intervox_transmitter.scala 147:34]
    reg synced : UInt<1>, clock with :
      reset => (UInt<1>("h0"), synced) @[intervox_transmitter.scala 149:34]
    reg bclkR : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bclkR) @[intervox_transmitter.scala 151:34]
    reg bitCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_transmitter.scala 155:34]
    node _T = eq(synced, UInt<1>("h0")) @[intervox_transmitter.scala 206:15]
    node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 207:42]
    node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 207:42]
    node _T_1 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 209:27]
    node _T_2 = eq(io_LRCLK_IN, UInt<1>("h1")) @[intervox_transmitter.scala 212:24]
    node _GEN_0 = mux(_T_2, UInt<1>("h0"), bitCntr) @[intervox_transmitter.scala 212:32 213:17 155:34]
    node _T_3 = eq(io_LRCLK_IN, UInt<1>("h0")) @[intervox_transmitter.scala 216:24]
    node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 217:28]
    node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 217:28]
    node _T_4 = eq(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 219:22]
    node _GEN_1 = mux(_T_4, UInt<1>("h0"), _bitCntr_T_1) @[intervox_transmitter.scala 217:17 219:31 220:19]
    node _GEN_2 = mux(_T_4, UInt<1>("h1"), synced) @[intervox_transmitter.scala 219:31 221:18 149:34]
    node _GEN_3 = mux(_T_3, _GEN_1, _GEN_0) @[intervox_transmitter.scala 216:32]
    node _GEN_4 = mux(_T_3, _GEN_2, synced) @[intervox_transmitter.scala 216:32 149:34]
    node _GEN_5 = mux(_T_1, UInt<1>("h0"), _BiPhase_CLK_CNTR_T_1) @[intervox_transmitter.scala 207:22 209:35 210:24]
    node _GEN_6 = mux(_T_1, _GEN_3, bitCntr) @[intervox_transmitter.scala 155:34 209:35]
    node _GEN_7 = mux(_T_1, _GEN_4, synced) @[intervox_transmitter.scala 149:34 209:35]
    node _GEN_8 = mux(_T, _GEN_5, BiPhase_CLK_CNTR) @[intervox_transmitter.scala 206:23 143:34]
    node _GEN_9 = mux(_T, _GEN_6, bitCntr) @[intervox_transmitter.scala 206:23 155:34]
    node _GEN_10 = mux(_T, _GEN_7, synced) @[intervox_transmitter.scala 206:23 149:34]
    node _T_5 = eq(synced, UInt<1>("h1")) @[intervox_transmitter.scala 233:15]
    node _T_6 = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 235:26]
    node _T_7 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 235:26]
    node _T_8 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 235:26]
    node _bclkR_T = not(bclkR) @[intervox_transmitter.scala 247:19]
    node _T_9 = eq(bclkR, UInt<1>("h0")) @[intervox_transmitter.scala 249:20]
    node _GEN_11 = mux(_T_9, UInt<1>("h0"), UInt<1>("h1")) @[intervox_transmitter.scala 249:28 180:31 250:32]
    node _BiPhase_CLK_CNTR_T_2 = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 253:46]
    node _BiPhase_CLK_CNTR_T_3 = tail(_BiPhase_CLK_CNTR_T_2, 1) @[intervox_transmitter.scala 253:46]
    node _T_10 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 259:31]
    node _bitCntr_T_2 = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 263:30]
    node _bitCntr_T_3 = tail(_bitCntr_T_2, 1) @[intervox_transmitter.scala 263:30]
    node _T_11 = eq(bitCntr, UInt<1>("h0")) @[intervox_transmitter.scala 267:24]
    node _GEN_12 = mux(_T_11, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 170:25 267:32 269:31]
    node _GEN_13 = mux(_T_11, UInt<1>("h0"), UInt<1>("h0")) @[intervox_transmitter.scala 171:25 267:32 270:31]
    node _T_12 = gt(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 273:24]
    node _T_13 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 280:30]
    node _BFR_io_dataIn_T = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 282:67]
    node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 282:67]
    node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 282:58]
    node _BFR_io_dataIn_T_3 = add(BFR.io_dataOut, _BFR_io_dataIn_T_2) @[intervox_transmitter.scala 282:51]
    node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_transmitter.scala 282:51]
    node _GEN_14 = mux(_T_13, _BFR_io_dataIn_T_4, _GEN_13) @[intervox_transmitter.scala 280:38 282:33]
    node _T_14 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 285:30]
    node _BFR_io_dataIn_T_5 = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 286:68]
    node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_transmitter.scala 286:68]
    node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 286:58]
    node _BFR_io_dataIn_T_8 = add(BFR.io_dataOut, _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 286:51]
    node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 286:51]
    node _GEN_15 = mux(_T_14, _BFR_io_dataIn_T_9, _GEN_14) @[intervox_transmitter.scala 285:38 286:33]
    node _T_15 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 294:30]
    node _BFR_io_dataIn_T_10 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 296:67]
    node _BFR_io_dataIn_T_11 = tail(_BFR_io_dataIn_T_10, 1) @[intervox_transmitter.scala 296:67]
    node _BFR_io_dataIn_T_12 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_11) @[intervox_transmitter.scala 296:58]
    node _BFR_io_dataIn_T_13 = add(BFR.io_dataOut, _BFR_io_dataIn_T_12) @[intervox_transmitter.scala 296:51]
    node _BFR_io_dataIn_T_14 = tail(_BFR_io_dataIn_T_13, 1) @[intervox_transmitter.scala 296:51]
    node _GEN_16 = mux(_T_15, _BFR_io_dataIn_T_14, _GEN_13) @[intervox_transmitter.scala 294:39 296:33]
    node _T_16 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 299:30]
    node _BFR_io_dataIn_T_15 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 300:67]
    node _BFR_io_dataIn_T_16 = tail(_BFR_io_dataIn_T_15, 1) @[intervox_transmitter.scala 300:67]
    node _BFR_io_dataIn_T_17 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_16) @[intervox_transmitter.scala 300:58]
    node _BFR_io_dataIn_T_18 = add(BFR.io_dataOut, _BFR_io_dataIn_T_17) @[intervox_transmitter.scala 300:51]
    node _BFR_io_dataIn_T_19 = tail(_BFR_io_dataIn_T_18, 1) @[intervox_transmitter.scala 300:51]
    node _GEN_17 = mux(_T_16, _BFR_io_dataIn_T_19, _GEN_16) @[intervox_transmitter.scala 299:38 300:33]
    node _GEN_18 = mux(_T_12, UInt<1>("h1"), UInt<1>("h1")) @[intervox_transmitter.scala 273:31 278:31 292:31]
    node _GEN_19 = mux(_T_12, _GEN_15, _GEN_17) @[intervox_transmitter.scala 273:31]
    node _T_17 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 304:24]
    node _GEN_20 = mux(_T_17, UInt<1>("h1"), _GEN_18) @[intervox_transmitter.scala 304:33 312:28]
    node _GEN_21 = mux(_T_17, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 174:25 304:33 308:31]
    node _GEN_22 = mux(_T_17, BFR.io_dataOut, BFR.io_dataOut) @[intervox_transmitter.scala 175:25 304:33 309:31]
    node _GEN_23 = mux(_T_17, UInt<1>("h0"), _GEN_19) @[intervox_transmitter.scala 304:33 313:28]
    node _GEN_24 = mux(_T_17, UInt<1>("h0"), _bitCntr_T_3) @[intervox_transmitter.scala 263:19 304:33 315:21]
    node _GEN_25 = mux(_T_10, UInt<1>("h0"), _BiPhase_CLK_CNTR_T_3) @[intervox_transmitter.scala 253:26 259:39 260:28]
    node _GEN_26 = mux(_T_10, _GEN_24, _GEN_9) @[intervox_transmitter.scala 259:39]
    node _GEN_27 = mux(_T_10, _GEN_20, UInt<1>("h0")) @[intervox_transmitter.scala 170:25 259:39]
    node _GEN_28 = mux(_T_10, _GEN_23, UInt<1>("h0")) @[intervox_transmitter.scala 171:25 259:39]
    node _GEN_29 = mux(_T_10, _GEN_21, UInt<1>("h0")) @[intervox_transmitter.scala 174:25 259:39]
    node _GEN_30 = mux(_T_10, _GEN_22, BFR.io_dataOut) @[intervox_transmitter.scala 175:25 259:39]
    node _GEN_31 = mux(_T_8, _bclkR_T, bclkR) @[intervox_transmitter.scala 235:26 247:16 151:34]
    node _GEN_32 = mux(_T_8, _GEN_11, UInt<1>("h1")) @[intervox_transmitter.scala 235:26 180:31]
    node _GEN_33 = mux(_T_8, _GEN_25, _GEN_8) @[intervox_transmitter.scala 235:26]
    node _GEN_34 = mux(_T_8, _GEN_26, _GEN_9) @[intervox_transmitter.scala 235:26]
    node _GEN_35 = mux(_T_8, _GEN_27, UInt<1>("h0")) @[intervox_transmitter.scala 170:25 235:26]
    node _GEN_36 = mux(_T_8, _GEN_28, UInt<1>("h0")) @[intervox_transmitter.scala 171:25 235:26]
    node _GEN_37 = mux(_T_8, _GEN_29, UInt<1>("h0")) @[intervox_transmitter.scala 174:25 235:26]
    node _GEN_38 = mux(_T_8, _GEN_30, BFR.io_dataOut) @[intervox_transmitter.scala 175:25 235:26]
    node _GEN_39 = mux(_T_7, UInt<2>("h2"), current_state) @[intervox_transmitter.scala 235:26 243:23 141:34]
    node _GEN_40 = mux(_T_7, bclkR, _GEN_31) @[intervox_transmitter.scala 235:26 151:34]
    node _GEN_41 = mux(_T_7, UInt<1>("h1"), _GEN_32) @[intervox_transmitter.scala 235:26 180:31]
    node _GEN_42 = mux(_T_7, _GEN_8, _GEN_33) @[intervox_transmitter.scala 235:26]
    node _GEN_43 = mux(_T_7, _GEN_9, _GEN_34) @[intervox_transmitter.scala 235:26]
    node _GEN_44 = mux(_T_7, UInt<1>("h0"), _GEN_35) @[intervox_transmitter.scala 170:25 235:26]
    node _GEN_45 = mux(_T_7, UInt<1>("h0"), _GEN_36) @[intervox_transmitter.scala 171:25 235:26]
    node _GEN_46 = mux(_T_7, UInt<1>("h0"), _GEN_37) @[intervox_transmitter.scala 174:25 235:26]
    node _GEN_47 = mux(_T_7, BFR.io_dataOut, _GEN_38) @[intervox_transmitter.scala 175:25 235:26]
    node _GEN_48 = mux(_T_6, UInt<2>("h2"), _GEN_39) @[intervox_transmitter.scala 235:26 239:23]
    node _GEN_49 = mux(_T_6, bclkR, _GEN_40) @[intervox_transmitter.scala 235:26 151:34]
    node _GEN_50 = mux(_T_6, UInt<1>("h1"), _GEN_41) @[intervox_transmitter.scala 235:26 180:31]
    node _GEN_51 = mux(_T_6, _GEN_8, _GEN_42) @[intervox_transmitter.scala 235:26]
    node _GEN_52 = mux(_T_6, _GEN_9, _GEN_43) @[intervox_transmitter.scala 235:26]
    node _GEN_53 = mux(_T_6, UInt<1>("h0"), _GEN_44) @[intervox_transmitter.scala 170:25 235:26]
    node _GEN_54 = mux(_T_6, UInt<1>("h0"), _GEN_45) @[intervox_transmitter.scala 171:25 235:26]
    node _GEN_55 = mux(_T_6, UInt<1>("h0"), _GEN_46) @[intervox_transmitter.scala 174:25 235:26]
    node _GEN_56 = mux(_T_6, BFR.io_dataOut, _GEN_47) @[intervox_transmitter.scala 175:25 235:26]
    node _GEN_57 = mux(_T_5, _GEN_48, current_state) @[intervox_transmitter.scala 233:23 141:34]
    node _GEN_58 = mux(_T_5, _GEN_49, bclkR) @[intervox_transmitter.scala 233:23 151:34]
    node _GEN_59 = mux(_T_5, _GEN_50, UInt<1>("h1")) @[intervox_transmitter.scala 233:23 180:31]
    node _GEN_60 = mux(_T_5, _GEN_51, _GEN_8) @[intervox_transmitter.scala 233:23]
    node _GEN_61 = mux(_T_5, _GEN_52, _GEN_9) @[intervox_transmitter.scala 233:23]
    node _GEN_62 = mux(_T_5, _GEN_53, UInt<1>("h0")) @[intervox_transmitter.scala 233:23 170:25]
    node _GEN_63 = mux(_T_5, _GEN_54, UInt<1>("h0")) @[intervox_transmitter.scala 233:23 171:25]
    node _GEN_64 = mux(_T_5, _GEN_55, UInt<1>("h0")) @[intervox_transmitter.scala 233:23 174:25]
    node _GEN_65 = mux(_T_5, _GEN_56, BFR.io_dataOut) @[intervox_transmitter.scala 233:23 175:25]
    io_MCLK_O <= clock @[intervox_transmitter.scala 162:25]
    io_DATA_O <= bi_phase_enc.io_DATA_OUT @[intervox_transmitter.scala 161:25]
    io_LRCLK_O <= io_LRCLK_IN @[intervox_transmitter.scala 164:25]
    io_BCLK_O <= io_BCLK_IN @[intervox_transmitter.scala 163:25]
    io_SDATA_O <= io_SDATA_IN @[intervox_transmitter.scala 165:25]
    io_NXT_FRAME <= bi_phase_enc.io_TICK @[intervox_transmitter.scala 178:25]
    current_state <= mux(reset, UInt<2>("h0"), _GEN_57) @[intervox_transmitter.scala 141:{34,34}]
    BiPhase_CLK_CNTR <= mux(reset, UInt<8>("h0"), _GEN_60) @[intervox_transmitter.scala 143:{34,34}]
    DATA_OUT_REG_1B <= mux(reset, UInt<1>("h0"), DATA_OUT_REG_1B) @[intervox_transmitter.scala 145:{34,34,34}]
    FirstFrame <= mux(reset, UInt<1>("h0"), FirstFrame) @[intervox_transmitter.scala 147:{34,34,34}]
    synced <= mux(reset, UInt<1>("h0"), _GEN_10) @[intervox_transmitter.scala 149:{34,34}]
    bclkR <= mux(reset, UInt<1>("h1"), _GEN_58) @[intervox_transmitter.scala 151:{34,34}]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    bi_phase_enc.io_AUDIOINPUT <= BFR1.io_dataOut @[intervox_transmitter.scala 182:31]
    bi_phase_enc.io_DSPINPUT <= UInt<64>("h0") @[intervox_transmitter.scala 184:31]
    bi_phase_enc.io_TICK <= _GEN_59
    bitCntr <= mux(reset, UInt<8>("h0"), _GEN_61) @[intervox_transmitter.scala 155:{34,34}]
    BFR.clock <= clock
    BFR.reset <= reset
    BFR.io_enable <= UInt<1>("h1") @[intervox_transmitter.scala 168:25]
    BFR.io_write <= _GEN_62
    BFR.io_addr <= UInt<1>("h1") @[intervox_transmitter.scala 169:25]
    BFR.io_dataIn <= bits(_GEN_63, 63, 0)
    BFR1.clock <= clock
    BFR1.reset <= reset
    BFR1.io_enable <= UInt<1>("h1") @[intervox_transmitter.scala 172:25]
    BFR1.io_write <= _GEN_64
    BFR1.io_addr <= UInt<1>("h1") @[intervox_transmitter.scala 173:25]
    BFR1.io_dataIn <= _GEN_65
