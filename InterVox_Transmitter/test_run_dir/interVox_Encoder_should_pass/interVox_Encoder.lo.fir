circuit interVox_Encoder :
  module bi_phase_encoder :
    input clock : Clock
    input reset : UInt<1>
    output io_DATA_OUT : UInt<1>
    input io_AUDIOINPUT : UInt<64>
    input io_DSPINPUT : UInt<64>
    input io_ENA : UInt<1>
    input io_TICK : UInt<1>

    reg outReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), outReg) @[intervox_transmitter.scala 38:32]
    reg stereoData : UInt<64>, clock with :
      reset => (UInt<1>("h0"), stereoData) @[intervox_transmitter.scala 39:32]
    reg dspData : UInt<16>, clock with :
      reset => (UInt<1>("h0"), dspData) @[intervox_transmitter.scala 40:32]
    reg bitCntr_enc : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr_enc) @[intervox_transmitter.scala 41:32]
    reg hasNone : UInt<1>, clock with :
      reset => (UInt<1>("h0"), hasNone) @[intervox_transmitter.scala 42:32]
    reg dataIndex : UInt<6>, clock with :
      reset => (UInt<1>("h0"), dataIndex) @[intervox_transmitter.scala 43:32]
    reg ndexR : UInt<1>, clock with :
      reset => (UInt<1>("h0"), ndexR) @[intervox_transmitter.scala 50:32]
    node _T = eq(io_ENA, UInt<1>("h1")) @[intervox_transmitter.scala 52:17]
    node _T_1 = eq(io_TICK, UInt<1>("h1")) @[intervox_transmitter.scala 56:20]
    node _T_2 = eq(bitCntr_enc, UInt<2>("h3")) @[intervox_transmitter.scala 61:28]
    node _outReg_T = not(outReg) @[intervox_transmitter.scala 62:23]
    node _GEN_0 = mux(_T_2, _outReg_T, outReg) @[intervox_transmitter.scala 61:36 62:20 38:32]
    node _T_3 = eq(bitCntr_enc, UInt<3>("h4")) @[intervox_transmitter.scala 65:28]
    node _outReg_T_1 = not(outReg) @[intervox_transmitter.scala 66:23]
    node _GEN_1 = mux(_T_3, _outReg_T_1, _GEN_0) @[intervox_transmitter.scala 65:36 66:20]
    node _GEN_2 = mux(_T_3, UInt<1>("h0"), hasNone) @[intervox_transmitter.scala 65:36 68:21 42:32]
    node _T_4 = gt(bitCntr_enc, UInt<3>("h4")) @[intervox_transmitter.scala 72:29]
    node _ndexR_T = not(ndexR) @[intervox_transmitter.scala 76:22]
    node _T_5 = eq(ndexR, UInt<1>("h0")) @[intervox_transmitter.scala 77:24]
    node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 79:38]
    node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 79:38]
    node _GEN_3 = mux(_T_5, _dataIndex_T_1, dataIndex) @[intervox_transmitter.scala 77:32 79:25 43:32]
    node _T_6 = lt(bitCntr_enc, UInt<6>("h35")) @[intervox_transmitter.scala 84:30]
    node _T_7 = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 86:50]
    node _T_8 = tail(_T_7, 1) @[intervox_transmitter.scala 86:50]
    node _T_9 = sub(UInt<7>("h40"), _T_8) @[intervox_transmitter.scala 86:37]
    node _T_10 = tail(_T_9, 1) @[intervox_transmitter.scala 86:37]
    node _T_11 = dshr(stereoData, _T_10) @[intervox_transmitter.scala 86:31]
    node _T_12 = bits(_T_11, 0, 0) @[intervox_transmitter.scala 86:31]
    node _T_13 = eq(_T_12, UInt<1>("h0")) @[intervox_transmitter.scala 86:59]
    node _GEN_4 = mux(_T_13, UInt<1>("h1"), _GEN_2) @[intervox_transmitter.scala 86:68 88:25]
    node _GEN_5 = mux(_T_6, _GEN_4, _GEN_2) @[intervox_transmitter.scala 84:37]
    node _T_14 = geq(bitCntr_enc, UInt<6>("h35")) @[intervox_transmitter.scala 93:31]
    node _T_15 = lt(bitCntr_enc, UInt<7>("h65")) @[intervox_transmitter.scala 93:55]
    node _T_16 = and(_T_14, _T_15) @[intervox_transmitter.scala 93:40]
    node _T_17 = sub(dataIndex, UInt<5>("h17")) @[intervox_transmitter.scala 95:51]
    node _T_18 = tail(_T_17, 1) @[intervox_transmitter.scala 95:51]
    node _T_19 = sub(UInt<7>("h40"), _T_18) @[intervox_transmitter.scala 95:38]
    node _T_20 = tail(_T_19, 1) @[intervox_transmitter.scala 95:38]
    node _T_21 = dshr(stereoData, _T_20) @[intervox_transmitter.scala 95:31]
    node _T_22 = bits(_T_21, 0, 0) @[intervox_transmitter.scala 95:31]
    node _T_23 = eq(_T_22, UInt<1>("h0")) @[intervox_transmitter.scala 95:62]
    node _GEN_6 = mux(_T_23, UInt<1>("h1"), _GEN_5) @[intervox_transmitter.scala 95:71 96:25]
    node _GEN_7 = mux(_T_16, _GEN_6, _GEN_5) @[intervox_transmitter.scala 93:64]
    node _T_24 = geq(bitCntr_enc, UInt<7>("h65")) @[intervox_transmitter.scala 103:31]
    node _T_25 = leq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 103:56]
    node _T_26 = and(_T_24, _T_25) @[intervox_transmitter.scala 103:41]
    node _GEN_8 = mux(_T_26, UInt<1>("h1"), _GEN_7) @[intervox_transmitter.scala 103:66 107:23]
    node _T_27 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 111:26]
    node _outReg_T_2 = not(outReg) @[intervox_transmitter.scala 118:25]
    node _GEN_9 = mux(_T_27, outReg, _outReg_T_2) @[intervox_transmitter.scala 111:34 113:22 118:22]
    node _GEN_10 = mux(_T_27, UInt<1>("h0"), _GEN_8) @[intervox_transmitter.scala 111:34 114:23]
    node _GEN_11 = mux(_T_4, _ndexR_T, ndexR) @[intervox_transmitter.scala 72:36 76:19 50:32]
    node _GEN_12 = mux(_T_4, _GEN_3, dataIndex) @[intervox_transmitter.scala 43:32 72:36]
    node _GEN_13 = mux(_T_4, _GEN_10, _GEN_2) @[intervox_transmitter.scala 72:36]
    node _GEN_14 = mux(_T_4, _GEN_9, _GEN_1) @[intervox_transmitter.scala 72:36]
    node _bitCntr_enc_T = add(bitCntr_enc, UInt<1>("h1")) @[intervox_transmitter.scala 123:38]
    node _bitCntr_enc_T_1 = tail(_bitCntr_enc_T, 1) @[intervox_transmitter.scala 123:38]
    node _T_28 = eq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 126:28]
    node _GEN_15 = mux(_T_28, UInt<1>("h0"), _bitCntr_enc_T_1) @[intervox_transmitter.scala 123:23 126:38 127:25]
    node _GEN_16 = mux(_T_28, UInt<1>("h0"), _GEN_12) @[intervox_transmitter.scala 126:38 128:23]
    node _GEN_17 = mux(_T_1, _GEN_14, outReg) @[intervox_transmitter.scala 56:28 38:32]
    node _GEN_18 = mux(_T_1, _GEN_13, hasNone) @[intervox_transmitter.scala 56:28 42:32]
    node _GEN_19 = mux(_T_1, _GEN_11, ndexR) @[intervox_transmitter.scala 56:28 50:32]
    node _GEN_20 = mux(_T_1, _GEN_16, dataIndex) @[intervox_transmitter.scala 56:28 43:32]
    node _GEN_21 = mux(_T_1, _GEN_15, bitCntr_enc) @[intervox_transmitter.scala 56:28 41:32]
    node _GEN_22 = mux(_T, _GEN_17, outReg) @[intervox_transmitter.scala 52:25 38:32]
    node _GEN_23 = mux(_T, _GEN_18, hasNone) @[intervox_transmitter.scala 52:25 42:32]
    node _GEN_24 = mux(_T, _GEN_19, ndexR) @[intervox_transmitter.scala 52:25 50:32]
    node _GEN_25 = mux(_T, _GEN_20, dataIndex) @[intervox_transmitter.scala 52:25 43:32]
    node _GEN_26 = mux(_T, _GEN_21, bitCntr_enc) @[intervox_transmitter.scala 52:25 41:32]
    io_DATA_OUT <= outReg @[intervox_transmitter.scala 45:17]
    outReg <= mux(reset, UInt<1>("h0"), _GEN_22) @[intervox_transmitter.scala 38:{32,32}]
    stereoData <= mux(reset, UInt<64>("h0"), io_AUDIOINPUT) @[intervox_transmitter.scala 39:{32,32} 47:17]
    dspData <= bits(mux(reset, UInt<16>("h0"), io_DSPINPUT), 15, 0) @[intervox_transmitter.scala 40:{32,32} 48:17]
    bitCntr_enc <= mux(reset, UInt<8>("h0"), _GEN_26) @[intervox_transmitter.scala 41:{32,32}]
    hasNone <= mux(reset, UInt<1>("h0"), _GEN_23) @[intervox_transmitter.scala 42:{32,32}]
    dataIndex <= mux(reset, UInt<6>("h0"), _GEN_25) @[intervox_transmitter.scala 43:{32,32}]
    ndexR <= mux(reset, UInt<1>("h0"), _GEN_24) @[intervox_transmitter.scala 50:{32,32}]

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
    input io_sw : UInt<12>

    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 162:33]
    inst BFR of RWSmem @[intervox_transmitter.scala 168:33]
    inst BFR1 of RWSmem @[intervox_transmitter.scala 169:33]
    reg current_state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), current_state) @[intervox_transmitter.scala 150:34]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (UInt<1>("h0"), BiPhase_CLK_CNTR) @[intervox_transmitter.scala 152:34]
    reg DATA_OUT_REG_1B : UInt<1>, clock with :
      reset => (UInt<1>("h0"), DATA_OUT_REG_1B) @[intervox_transmitter.scala 154:34]
    reg FirstFrame : UInt<1>, clock with :
      reset => (UInt<1>("h0"), FirstFrame) @[intervox_transmitter.scala 156:34]
    reg synced : UInt<1>, clock with :
      reset => (UInt<1>("h0"), synced) @[intervox_transmitter.scala 158:34]
    reg bclkR : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bclkR) @[intervox_transmitter.scala 160:34]
    reg encoderClk : UInt<1>, clock with :
      reset => (UInt<1>("h0"), encoderClk) @[intervox_transmitter.scala 164:34]
    reg bitCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_transmitter.scala 166:34]
    node _T = eq(synced, UInt<1>("h0")) @[intervox_transmitter.scala 213:15]
    node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 215:42]
    node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 215:42]
    node _T_1 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 217:27]
    node _T_2 = eq(io_LRCLK_IN, UInt<1>("h1")) @[intervox_transmitter.scala 220:24]
    node _GEN_0 = mux(_T_2, UInt<1>("h0"), bitCntr) @[intervox_transmitter.scala 220:32 221:17 166:34]
    node _T_3 = eq(io_LRCLK_IN, UInt<1>("h0")) @[intervox_transmitter.scala 224:24]
    node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 227:28]
    node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 227:28]
    node _T_4 = eq(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 229:22]
    node _GEN_1 = mux(_T_4, UInt<1>("h0"), _bitCntr_T_1) @[intervox_transmitter.scala 227:17 229:31 230:19]
    node _GEN_2 = mux(_T_4, UInt<1>("h1"), synced) @[intervox_transmitter.scala 229:31 231:18 158:34]
    node _GEN_3 = mux(_T_3, _GEN_1, _GEN_0) @[intervox_transmitter.scala 224:32]
    node _GEN_4 = mux(_T_3, _GEN_2, synced) @[intervox_transmitter.scala 224:32 158:34]
    node _GEN_5 = mux(_T_1, UInt<1>("h0"), _BiPhase_CLK_CNTR_T_1) @[intervox_transmitter.scala 215:22 217:35 218:24]
    node _GEN_6 = mux(_T_1, _GEN_3, bitCntr) @[intervox_transmitter.scala 166:34 217:35]
    node _GEN_7 = mux(_T_1, _GEN_4, synced) @[intervox_transmitter.scala 158:34 217:35]
    node _GEN_8 = mux(_T, _GEN_5, BiPhase_CLK_CNTR) @[intervox_transmitter.scala 213:23 152:34]
    node _GEN_9 = mux(_T, _GEN_6, bitCntr) @[intervox_transmitter.scala 213:23 166:34]
    node _GEN_10 = mux(_T, _GEN_7, synced) @[intervox_transmitter.scala 213:23 158:34]
    node _T_5 = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 244:24]
    node _T_6 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 244:24]
    node _T_7 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 244:24]
    node _T_8 = eq(synced, UInt<1>("h1")) @[intervox_transmitter.scala 256:19]
    node _encoderClk_T = not(encoderClk) @[intervox_transmitter.scala 266:23]
    node _T_9 = eq(encoderClk, UInt<1>("h1")) @[intervox_transmitter.scala 267:25]
    node _GEN_11 = mux(_T_9, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 191:31 267:33 268:33]
    node _BiPhase_CLK_CNTR_T_2 = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 271:46]
    node _BiPhase_CLK_CNTR_T_3 = tail(_BiPhase_CLK_CNTR_T_2, 1) @[intervox_transmitter.scala 271:46]
    node _T_10 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 273:31]
    node _bitCntr_T_2 = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 277:30]
    node _bitCntr_T_3 = tail(_bitCntr_T_2, 1) @[intervox_transmitter.scala 277:30]
    node _T_11 = eq(bitCntr, UInt<1>("h0")) @[intervox_transmitter.scala 281:24]
    node _GEN_12 = mux(_T_11, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 181:25 281:32 283:31]
    node _GEN_13 = mux(_T_11, UInt<1>("h0"), UInt<1>("h0")) @[intervox_transmitter.scala 182:25 281:32 284:31]
    node _T_12 = gt(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 288:24]
    node _T_13 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 295:30]
    node _BFR_io_dataIn_T = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 297:67]
    node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 297:67]
    node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 297:58]
    node _BFR_io_dataIn_T_3 = add(BFR.io_dataOut, _BFR_io_dataIn_T_2) @[intervox_transmitter.scala 297:51]
    node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_transmitter.scala 297:51]
    node _GEN_14 = mux(_T_13, _BFR_io_dataIn_T_4, _GEN_13) @[intervox_transmitter.scala 295:38 297:33]
    node _T_14 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 300:30]
    node _BFR_io_dataIn_T_5 = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 301:68]
    node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_transmitter.scala 301:68]
    node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 301:58]
    node _BFR_io_dataIn_T_8 = add(BFR.io_dataOut, _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 301:51]
    node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 301:51]
    node _GEN_15 = mux(_T_14, _BFR_io_dataIn_T_9, _GEN_14) @[intervox_transmitter.scala 300:38 301:33]
    node _T_15 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 309:30]
    node _BFR_io_dataIn_T_10 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 311:67]
    node _BFR_io_dataIn_T_11 = tail(_BFR_io_dataIn_T_10, 1) @[intervox_transmitter.scala 311:67]
    node _BFR_io_dataIn_T_12 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_11) @[intervox_transmitter.scala 311:58]
    node _BFR_io_dataIn_T_13 = add(BFR.io_dataOut, _BFR_io_dataIn_T_12) @[intervox_transmitter.scala 311:51]
    node _BFR_io_dataIn_T_14 = tail(_BFR_io_dataIn_T_13, 1) @[intervox_transmitter.scala 311:51]
    node _GEN_16 = mux(_T_15, _BFR_io_dataIn_T_14, _GEN_13) @[intervox_transmitter.scala 309:39 311:33]
    node _T_16 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 314:30]
    node _BFR_io_dataIn_T_15 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 315:67]
    node _BFR_io_dataIn_T_16 = tail(_BFR_io_dataIn_T_15, 1) @[intervox_transmitter.scala 315:67]
    node _BFR_io_dataIn_T_17 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_16) @[intervox_transmitter.scala 315:58]
    node _BFR_io_dataIn_T_18 = add(BFR.io_dataOut, _BFR_io_dataIn_T_17) @[intervox_transmitter.scala 315:51]
    node _BFR_io_dataIn_T_19 = tail(_BFR_io_dataIn_T_18, 1) @[intervox_transmitter.scala 315:51]
    node _GEN_17 = mux(_T_16, _BFR_io_dataIn_T_19, _GEN_16) @[intervox_transmitter.scala 314:38 315:33]
    node _GEN_18 = mux(_T_12, UInt<1>("h1"), UInt<1>("h1")) @[intervox_transmitter.scala 288:31 293:31 307:31]
    node _GEN_19 = mux(_T_12, _GEN_15, _GEN_17) @[intervox_transmitter.scala 288:31]
    node _T_17 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 319:24]
    node _GEN_20 = mux(_T_17, UInt<1>("h1"), _GEN_18) @[intervox_transmitter.scala 319:33 327:28]
    node _GEN_21 = mux(_T_17, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 185:25 319:33 323:31]
    node _GEN_22 = mux(_T_17, BFR.io_dataOut, BFR.io_dataOut) @[intervox_transmitter.scala 186:25 319:33 324:31]
    node _GEN_23 = mux(_T_17, UInt<1>("h0"), _GEN_19) @[intervox_transmitter.scala 319:33 328:28]
    node _GEN_24 = mux(_T_17, UInt<1>("h0"), _bitCntr_T_3) @[intervox_transmitter.scala 277:19 319:33 330:21]
    node _GEN_25 = mux(_T_10, UInt<1>("h0"), _BiPhase_CLK_CNTR_T_3) @[intervox_transmitter.scala 271:26 273:39 274:28]
    node _GEN_26 = mux(_T_10, _GEN_24, _GEN_9) @[intervox_transmitter.scala 273:39]
    node _GEN_27 = mux(_T_10, _GEN_20, UInt<1>("h0")) @[intervox_transmitter.scala 181:25 273:39]
    node _GEN_28 = mux(_T_10, _GEN_23, UInt<1>("h0")) @[intervox_transmitter.scala 182:25 273:39]
    node _GEN_29 = mux(_T_10, _GEN_21, UInt<1>("h0")) @[intervox_transmitter.scala 185:25 273:39]
    node _GEN_30 = mux(_T_10, _GEN_22, BFR.io_dataOut) @[intervox_transmitter.scala 186:25 273:39]
    node _GEN_31 = mux(_T_8, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 256:27 263:29 192:31]
    node _GEN_32 = mux(_T_8, _encoderClk_T, encoderClk) @[intervox_transmitter.scala 256:27 266:20 164:34]
    node _GEN_33 = mux(_T_8, _GEN_11, UInt<1>("h0")) @[intervox_transmitter.scala 256:27 191:31]
    node _GEN_34 = mux(_T_8, _GEN_25, _GEN_8) @[intervox_transmitter.scala 256:27]
    node _GEN_35 = mux(_T_8, _GEN_26, _GEN_9) @[intervox_transmitter.scala 256:27]
    node _GEN_36 = mux(_T_8, _GEN_27, UInt<1>("h0")) @[intervox_transmitter.scala 181:25 256:27]
    node _GEN_37 = mux(_T_8, _GEN_28, UInt<1>("h0")) @[intervox_transmitter.scala 182:25 256:27]
    node _GEN_38 = mux(_T_8, _GEN_29, UInt<1>("h0")) @[intervox_transmitter.scala 185:25 256:27]
    node _GEN_39 = mux(_T_8, _GEN_30, BFR.io_dataOut) @[intervox_transmitter.scala 186:25 256:27]
    node _GEN_40 = mux(_T_7, _GEN_31, UInt<1>("h0")) @[intervox_transmitter.scala 244:24 192:31]
    node _GEN_41 = mux(_T_7, _GEN_32, encoderClk) @[intervox_transmitter.scala 244:24 164:34]
    node _GEN_42 = mux(_T_7, _GEN_33, UInt<1>("h0")) @[intervox_transmitter.scala 244:24 191:31]
    node _GEN_43 = mux(_T_7, _GEN_34, _GEN_8) @[intervox_transmitter.scala 244:24]
    node _GEN_44 = mux(_T_7, _GEN_35, _GEN_9) @[intervox_transmitter.scala 244:24]
    node _GEN_45 = mux(_T_7, _GEN_36, UInt<1>("h0")) @[intervox_transmitter.scala 244:24 181:25]
    node _GEN_46 = mux(_T_7, _GEN_37, UInt<1>("h0")) @[intervox_transmitter.scala 244:24 182:25]
    node _GEN_47 = mux(_T_7, _GEN_38, UInt<1>("h0")) @[intervox_transmitter.scala 244:24 185:25]
    node _GEN_48 = mux(_T_7, _GEN_39, BFR.io_dataOut) @[intervox_transmitter.scala 244:24 186:25]
    node _GEN_49 = mux(_T_6, UInt<2>("h2"), current_state) @[intervox_transmitter.scala 244:24 252:21 150:34]
    node _GEN_50 = mux(_T_6, UInt<1>("h0"), _GEN_40) @[intervox_transmitter.scala 244:24 192:31]
    node _GEN_51 = mux(_T_6, encoderClk, _GEN_41) @[intervox_transmitter.scala 244:24 164:34]
    node _GEN_52 = mux(_T_6, UInt<1>("h0"), _GEN_42) @[intervox_transmitter.scala 244:24 191:31]
    node _GEN_53 = mux(_T_6, _GEN_8, _GEN_43) @[intervox_transmitter.scala 244:24]
    node _GEN_54 = mux(_T_6, _GEN_9, _GEN_44) @[intervox_transmitter.scala 244:24]
    node _GEN_55 = mux(_T_6, UInt<1>("h0"), _GEN_45) @[intervox_transmitter.scala 244:24 181:25]
    node _GEN_56 = mux(_T_6, UInt<1>("h0"), _GEN_46) @[intervox_transmitter.scala 244:24 182:25]
    node _GEN_57 = mux(_T_6, UInt<1>("h0"), _GEN_47) @[intervox_transmitter.scala 244:24 185:25]
    node _GEN_58 = mux(_T_6, BFR.io_dataOut, _GEN_48) @[intervox_transmitter.scala 244:24 186:25]
    node _GEN_59 = mux(_T_5, UInt<2>("h2"), _GEN_49) @[intervox_transmitter.scala 244:24 248:21]
    node _GEN_60 = mux(_T_5, UInt<1>("h0"), _GEN_50) @[intervox_transmitter.scala 244:24 192:31]
    node _GEN_61 = mux(_T_5, encoderClk, _GEN_51) @[intervox_transmitter.scala 244:24 164:34]
    node _GEN_62 = mux(_T_5, UInt<1>("h0"), _GEN_52) @[intervox_transmitter.scala 244:24 191:31]
    node _GEN_63 = mux(_T_5, _GEN_8, _GEN_53) @[intervox_transmitter.scala 244:24]
    node _GEN_64 = mux(_T_5, _GEN_9, _GEN_54) @[intervox_transmitter.scala 244:24]
    node _GEN_65 = mux(_T_5, UInt<1>("h0"), _GEN_55) @[intervox_transmitter.scala 244:24 181:25]
    node _GEN_66 = mux(_T_5, UInt<1>("h0"), _GEN_56) @[intervox_transmitter.scala 244:24 182:25]
    node _GEN_67 = mux(_T_5, UInt<1>("h0"), _GEN_57) @[intervox_transmitter.scala 244:24 185:25]
    node _GEN_68 = mux(_T_5, BFR.io_dataOut, _GEN_58) @[intervox_transmitter.scala 244:24 186:25]
    io_MCLK_O <= clock @[intervox_transmitter.scala 173:25]
    io_DATA_O <= bi_phase_enc.io_DATA_OUT @[intervox_transmitter.scala 172:25]
    io_LRCLK_O <= io_LRCLK_IN @[intervox_transmitter.scala 175:25]
    io_BCLK_O <= io_BCLK_IN @[intervox_transmitter.scala 174:25]
    io_SDATA_O <= io_SDATA_IN @[intervox_transmitter.scala 176:25]
    io_NXT_FRAME <= bi_phase_enc.io_ENA @[intervox_transmitter.scala 189:31]
    current_state <= mux(reset, UInt<2>("h0"), _GEN_59) @[intervox_transmitter.scala 150:{34,34}]
    BiPhase_CLK_CNTR <= mux(reset, UInt<8>("h0"), _GEN_63) @[intervox_transmitter.scala 152:{34,34}]
    DATA_OUT_REG_1B <= mux(reset, UInt<1>("h0"), DATA_OUT_REG_1B) @[intervox_transmitter.scala 154:{34,34,34}]
    FirstFrame <= mux(reset, UInt<1>("h0"), FirstFrame) @[intervox_transmitter.scala 156:{34,34,34}]
    synced <= mux(reset, UInt<1>("h0"), _GEN_10) @[intervox_transmitter.scala 158:{34,34}]
    bclkR <= mux(reset, UInt<1>("h1"), bclkR) @[intervox_transmitter.scala 160:{34,34,34}]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    bi_phase_enc.io_AUDIOINPUT <= BFR1.io_dataOut @[intervox_transmitter.scala 194:31]
    bi_phase_enc.io_DSPINPUT <= pad(io_sw, 64) @[intervox_transmitter.scala 196:31]
    bi_phase_enc.io_ENA <= _GEN_60
    bi_phase_enc.io_TICK <= _GEN_62
    encoderClk <= mux(reset, UInt<1>("h0"), _GEN_61) @[intervox_transmitter.scala 164:{34,34}]
    bitCntr <= mux(reset, UInt<8>("h0"), _GEN_64) @[intervox_transmitter.scala 166:{34,34}]
    BFR.clock <= clock
    BFR.reset <= reset
    BFR.io_enable <= UInt<1>("h1") @[intervox_transmitter.scala 179:25]
    BFR.io_write <= _GEN_65
    BFR.io_addr <= UInt<1>("h1") @[intervox_transmitter.scala 180:25]
    BFR.io_dataIn <= bits(_GEN_66, 63, 0)
    BFR1.clock <= clock
    BFR1.reset <= reset
    BFR1.io_enable <= UInt<1>("h1") @[intervox_transmitter.scala 183:25]
    BFR1.io_write <= _GEN_67
    BFR1.io_addr <= UInt<1>("h1") @[intervox_transmitter.scala 184:25]
    BFR1.io_dataIn <= _GEN_68
