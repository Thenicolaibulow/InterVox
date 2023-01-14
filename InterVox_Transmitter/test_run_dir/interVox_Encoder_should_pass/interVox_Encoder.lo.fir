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
    node _T_2 = eq(bitCntr_enc, UInt<2>("h3")) @[intervox_transmitter.scala 65:28]
    node _outReg_T = not(outReg) @[intervox_transmitter.scala 66:23]
    node _GEN_0 = mux(_T_2, _outReg_T, outReg) @[intervox_transmitter.scala 65:36 66:20 38:32]
    node _T_3 = eq(bitCntr_enc, UInt<3>("h4")) @[intervox_transmitter.scala 69:28]
    node _outReg_T_1 = not(outReg) @[intervox_transmitter.scala 70:23]
    node _GEN_1 = mux(_T_3, _outReg_T_1, _GEN_0) @[intervox_transmitter.scala 69:36 70:20]
    node _GEN_2 = mux(_T_3, UInt<1>("h0"), hasNone) @[intervox_transmitter.scala 69:36 72:21 42:32]
    node _T_4 = geq(bitCntr_enc, UInt<3>("h5")) @[intervox_transmitter.scala 81:29]
    node _ndexR_T = not(ndexR) @[intervox_transmitter.scala 84:22]
    node _T_5 = eq(ndexR, UInt<1>("h0")) @[intervox_transmitter.scala 85:24]
    node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 87:38]
    node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 87:38]
    node _GEN_3 = mux(_T_5, _dataIndex_T_1, dataIndex) @[intervox_transmitter.scala 85:32 87:25 43:32]
    node _T_6 = leq(bitCntr_enc, UInt<6>("h35")) @[intervox_transmitter.scala 94:30]
    node _T_7 = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 96:50]
    node _T_8 = tail(_T_7, 1) @[intervox_transmitter.scala 96:50]
    node _T_9 = sub(UInt<7>("h40"), _T_8) @[intervox_transmitter.scala 96:37]
    node _T_10 = tail(_T_9, 1) @[intervox_transmitter.scala 96:37]
    node _T_11 = dshr(stereoData, _T_10) @[intervox_transmitter.scala 96:31]
    node _T_12 = bits(_T_11, 0, 0) @[intervox_transmitter.scala 96:31]
    node _T_13 = eq(_T_12, UInt<1>("h0")) @[intervox_transmitter.scala 96:59]
    node _GEN_4 = mux(_T_13, UInt<1>("h1"), _GEN_2) @[intervox_transmitter.scala 96:68 98:25]
    node _GEN_5 = mux(_T_6, _GEN_4, _GEN_2) @[intervox_transmitter.scala 94:38]
    node _T_14 = gt(bitCntr_enc, UInt<6>("h35")) @[intervox_transmitter.scala 106:31]
    node _T_15 = leq(bitCntr_enc, UInt<7>("h65")) @[intervox_transmitter.scala 106:54]
    node _T_16 = and(_T_14, _T_15) @[intervox_transmitter.scala 106:39]
    node _T_17 = sub(dataIndex, UInt<5>("h17")) @[intervox_transmitter.scala 108:51]
    node _T_18 = tail(_T_17, 1) @[intervox_transmitter.scala 108:51]
    node _T_19 = sub(UInt<7>("h40"), _T_18) @[intervox_transmitter.scala 108:38]
    node _T_20 = tail(_T_19, 1) @[intervox_transmitter.scala 108:38]
    node _T_21 = dshr(stereoData, _T_20) @[intervox_transmitter.scala 108:31]
    node _T_22 = bits(_T_21, 0, 0) @[intervox_transmitter.scala 108:31]
    node _T_23 = eq(_T_22, UInt<1>("h0")) @[intervox_transmitter.scala 108:62]
    node _GEN_6 = mux(_T_23, UInt<1>("h1"), _GEN_5) @[intervox_transmitter.scala 108:71 109:25]
    node _GEN_7 = mux(_T_16, _GEN_6, _GEN_5) @[intervox_transmitter.scala 106:64]
    node _T_24 = gt(bitCntr_enc, UInt<7>("h65")) @[intervox_transmitter.scala 118:31]
    node _T_25 = lt(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 118:55]
    node _T_26 = and(_T_24, _T_25) @[intervox_transmitter.scala 118:40]
    node _GEN_8 = mux(_T_26, UInt<1>("h1"), _GEN_7) @[intervox_transmitter.scala 118:64 122:23]
    node _T_27 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 129:26]
    node _outReg_T_2 = not(outReg) @[intervox_transmitter.scala 136:25]
    node _GEN_9 = mux(_T_27, outReg, _outReg_T_2) @[intervox_transmitter.scala 129:34 131:22 136:22]
    node _GEN_10 = mux(_T_27, UInt<1>("h0"), _GEN_8) @[intervox_transmitter.scala 129:34 132:23]
    node _GEN_11 = mux(_T_4, _ndexR_T, ndexR) @[intervox_transmitter.scala 81:37 84:19 50:32]
    node _GEN_12 = mux(_T_4, _GEN_3, dataIndex) @[intervox_transmitter.scala 43:32 81:37]
    node _GEN_13 = mux(_T_4, _GEN_10, _GEN_2) @[intervox_transmitter.scala 81:37]
    node _GEN_14 = mux(_T_4, _GEN_9, _GEN_1) @[intervox_transmitter.scala 81:37]
    node _bitCntr_enc_T = add(bitCntr_enc, UInt<1>("h1")) @[intervox_transmitter.scala 141:38]
    node _bitCntr_enc_T_1 = tail(_bitCntr_enc_T, 1) @[intervox_transmitter.scala 141:38]
    node _T_28 = eq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 144:28]
    node _GEN_15 = mux(_T_28, UInt<1>("h0"), _bitCntr_enc_T_1) @[intervox_transmitter.scala 141:23 144:38 145:25]
    node _GEN_16 = mux(_T_28, UInt<1>("h0"), _GEN_12) @[intervox_transmitter.scala 144:38 146:23]
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

    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 173:33]
    inst BFR of RWSmem @[intervox_transmitter.scala 179:33]
    inst BFR1 of RWSmem @[intervox_transmitter.scala 180:33]
    reg current_state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), current_state) @[intervox_transmitter.scala 167:34]
    reg synced : UInt<1>, clock with :
      reset => (UInt<1>("h0"), synced) @[intervox_transmitter.scala 169:34]
    reg bclkR : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bclkR) @[intervox_transmitter.scala 171:34]
    reg encoderClk : UInt<1>, clock with :
      reset => (UInt<1>("h0"), encoderClk) @[intervox_transmitter.scala 175:34]
    reg bitCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_transmitter.scala 177:34]
    reg inBufr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufr) @[intervox_transmitter.scala 182:34]
    reg trailing : UInt<1>, clock with :
      reset => (UInt<1>("h0"), trailing) @[intervox_transmitter.scala 183:34]
    reg rising : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rising) @[intervox_transmitter.scala 184:34]
    node _T = eq(synced, UInt<1>("h0")) @[intervox_transmitter.scala 228:15]
    node _T_1 = eq(UInt<1>("h1"), io_LRCLK_IN) @[intervox_transmitter.scala 234:24]
    node _T_2 = lt(inBufr, UInt<2>("h3")) @[intervox_transmitter.scala 236:25]
    node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 238:34]
    node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_transmitter.scala 238:34]
    node _GEN_0 = mux(_T_2, _inBufr_T_1, inBufr) @[intervox_transmitter.scala 236:31 238:24 182:34]
    node _T_3 = eq(UInt<1>("h0"), io_LRCLK_IN) @[intervox_transmitter.scala 234:24]
    node _T_4 = gt(inBufr, UInt<1>("h0")) @[intervox_transmitter.scala 242:25]
    node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 244:34]
    node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_transmitter.scala 244:34]
    node _GEN_1 = mux(_T_4, _inBufr_T_3, inBufr) @[intervox_transmitter.scala 242:31 244:24 182:34]
    node _GEN_2 = mux(_T_3, _GEN_1, inBufr) @[intervox_transmitter.scala 234:24 182:34]
    node _GEN_3 = mux(_T_1, _GEN_0, _GEN_2) @[intervox_transmitter.scala 234:24]
    node _T_5 = bits(inBufr, 0, 0) @[intervox_transmitter.scala 249:17]
    node _T_6 = eq(_T_5, UInt<1>("h0")) @[intervox_transmitter.scala 249:21]
    node _T_7 = bits(inBufr, 1, 1) @[intervox_transmitter.scala 249:39]
    node _T_8 = eq(_T_7, UInt<1>("h1")) @[intervox_transmitter.scala 249:43]
    node _T_9 = and(_T_6, _T_8) @[intervox_transmitter.scala 249:30]
    node _GEN_4 = mux(_T_9, UInt<1>("h1"), rising) @[intervox_transmitter.scala 249:52 250:17 184:34]
    node _GEN_5 = mux(_T_9, UInt<1>("h0"), trailing) @[intervox_transmitter.scala 249:52 251:17 183:34]
    node _T_10 = bits(inBufr, 0, 0) @[intervox_transmitter.scala 254:17]
    node _T_11 = eq(_T_10, UInt<1>("h1")) @[intervox_transmitter.scala 254:21]
    node _T_12 = bits(inBufr, 1, 1) @[intervox_transmitter.scala 254:39]
    node _T_13 = eq(_T_12, UInt<1>("h0")) @[intervox_transmitter.scala 254:43]
    node _T_14 = and(_T_11, _T_13) @[intervox_transmitter.scala 254:30]
    node _GEN_6 = mux(_T_14, UInt<1>("h1"), _GEN_5) @[intervox_transmitter.scala 254:52 255:17]
    node _GEN_7 = mux(_T_14, UInt<1>("h0"), _GEN_4) @[intervox_transmitter.scala 254:52 256:17]
    node _T_15 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 259:19]
    node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 261:30]
    node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 261:30]
    node _T_16 = eq(bitCntr, UInt<7>("h7e")) @[intervox_transmitter.scala 263:20]
    node _GEN_8 = mux(_T_16, UInt<1>("h1"), synced) @[intervox_transmitter.scala 263:30 264:19 169:34]
    node _GEN_9 = mux(_T_16, UInt<1>("h0"), _bitCntr_T_1) @[intervox_transmitter.scala 261:19 263:30 265:19]
    node _GEN_10 = mux(_T_15, _GEN_9, bitCntr) @[intervox_transmitter.scala 259:27 177:34]
    node _GEN_11 = mux(_T_15, _GEN_8, synced) @[intervox_transmitter.scala 259:27 169:34]
    node _GEN_12 = mux(_T, _GEN_3, inBufr) @[intervox_transmitter.scala 228:23 182:34]
    node _GEN_13 = mux(_T, _GEN_7, rising) @[intervox_transmitter.scala 228:23 184:34]
    node _GEN_14 = mux(_T, _GEN_6, trailing) @[intervox_transmitter.scala 228:23 183:34]
    node _GEN_15 = mux(_T, _GEN_10, bitCntr) @[intervox_transmitter.scala 228:23 177:34]
    node _GEN_16 = mux(_T, _GEN_11, synced) @[intervox_transmitter.scala 228:23 169:34]
    node _T_17 = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 277:24]
    node _T_18 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 277:24]
    node _T_19 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 277:24]
    node _T_20 = eq(synced, UInt<1>("h1")) @[intervox_transmitter.scala 289:19]
    node _encoderClk_T = not(encoderClk) @[intervox_transmitter.scala 299:23]
    node _T_21 = eq(io_BCLK_IN, UInt<1>("h1")) @[intervox_transmitter.scala 301:25]
    node _bclkR_T = not(bclkR) @[intervox_transmitter.scala 302:20]
    node _GEN_17 = mux(_T_21, _bclkR_T, bclkR) @[intervox_transmitter.scala 301:33 302:17 171:34]
    node _T_22 = eq(bclkR, UInt<1>("h1")) @[intervox_transmitter.scala 306:20]
    node _bitCntr_T_2 = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 309:30]
    node _bitCntr_T_3 = tail(_bitCntr_T_2, 1) @[intervox_transmitter.scala 309:30]
    node _T_23 = eq(bitCntr, UInt<1>("h0")) @[intervox_transmitter.scala 313:24]
    node _GEN_18 = mux(_T_23, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 196:25 313:32 315:31]
    node _GEN_19 = mux(_T_23, UInt<1>("h0"), UInt<1>("h0")) @[intervox_transmitter.scala 197:25 313:32 316:31]
    node _T_24 = gt(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 320:24]
    node _T_25 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 327:30]
    node _BFR_io_dataIn_T = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 329:67]
    node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 329:67]
    node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 329:58]
    node _BFR_io_dataIn_T_3 = add(BFR.io_dataOut, _BFR_io_dataIn_T_2) @[intervox_transmitter.scala 329:51]
    node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_transmitter.scala 329:51]
    node _GEN_20 = mux(_T_25, _BFR_io_dataIn_T_4, _GEN_19) @[intervox_transmitter.scala 327:38 329:33]
    node _T_26 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 332:30]
    node _BFR_io_dataIn_T_5 = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 333:68]
    node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_transmitter.scala 333:68]
    node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 333:58]
    node _BFR_io_dataIn_T_8 = add(BFR.io_dataOut, _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 333:51]
    node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 333:51]
    node _GEN_21 = mux(_T_26, _BFR_io_dataIn_T_9, _GEN_20) @[intervox_transmitter.scala 332:38 333:33]
    node _T_27 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 341:30]
    node _BFR_io_dataIn_T_10 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 343:67]
    node _BFR_io_dataIn_T_11 = tail(_BFR_io_dataIn_T_10, 1) @[intervox_transmitter.scala 343:67]
    node _BFR_io_dataIn_T_12 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_11) @[intervox_transmitter.scala 343:58]
    node _BFR_io_dataIn_T_13 = add(BFR.io_dataOut, _BFR_io_dataIn_T_12) @[intervox_transmitter.scala 343:51]
    node _BFR_io_dataIn_T_14 = tail(_BFR_io_dataIn_T_13, 1) @[intervox_transmitter.scala 343:51]
    node _GEN_22 = mux(_T_27, _BFR_io_dataIn_T_14, _GEN_19) @[intervox_transmitter.scala 341:39 343:33]
    node _T_28 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 346:30]
    node _BFR_io_dataIn_T_15 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 347:67]
    node _BFR_io_dataIn_T_16 = tail(_BFR_io_dataIn_T_15, 1) @[intervox_transmitter.scala 347:67]
    node _BFR_io_dataIn_T_17 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_16) @[intervox_transmitter.scala 347:58]
    node _BFR_io_dataIn_T_18 = add(BFR.io_dataOut, _BFR_io_dataIn_T_17) @[intervox_transmitter.scala 347:51]
    node _BFR_io_dataIn_T_19 = tail(_BFR_io_dataIn_T_18, 1) @[intervox_transmitter.scala 347:51]
    node _GEN_23 = mux(_T_28, _BFR_io_dataIn_T_19, _GEN_22) @[intervox_transmitter.scala 346:38 347:33]
    node _GEN_24 = mux(_T_24, UInt<1>("h1"), UInt<1>("h1")) @[intervox_transmitter.scala 320:31 325:31 339:31]
    node _GEN_25 = mux(_T_24, _GEN_21, _GEN_23) @[intervox_transmitter.scala 320:31]
    node _T_29 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 351:24]
    node _GEN_26 = mux(_T_29, UInt<1>("h1"), _GEN_24) @[intervox_transmitter.scala 351:33 359:28]
    node _GEN_27 = mux(_T_29, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 200:25 351:33 355:31]
    node _GEN_28 = mux(_T_29, BFR.io_dataOut, BFR.io_dataOut) @[intervox_transmitter.scala 201:25 351:33 356:31]
    node _GEN_29 = mux(_T_29, UInt<1>("h0"), _GEN_25) @[intervox_transmitter.scala 351:33 360:28]
    node _GEN_30 = mux(_T_29, UInt<1>("h0"), _bitCntr_T_3) @[intervox_transmitter.scala 309:19 351:33 362:21]
    node _GEN_31 = mux(_T_22, _GEN_30, _GEN_15) @[intervox_transmitter.scala 306:28]
    node _GEN_32 = mux(_T_22, _GEN_26, UInt<1>("h0")) @[intervox_transmitter.scala 196:25 306:28]
    node _GEN_33 = mux(_T_22, _GEN_29, UInt<1>("h0")) @[intervox_transmitter.scala 197:25 306:28]
    node _GEN_34 = mux(_T_22, _GEN_27, UInt<1>("h0")) @[intervox_transmitter.scala 200:25 306:28]
    node _GEN_35 = mux(_T_22, _GEN_28, BFR.io_dataOut) @[intervox_transmitter.scala 201:25 306:28]
    node _GEN_36 = mux(_T_20, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 289:27 296:29 207:31]
    node _GEN_37 = mux(_T_20, _encoderClk_T, encoderClk) @[intervox_transmitter.scala 289:27 299:20 175:34]
    node _GEN_38 = mux(_T_20, _GEN_17, bclkR) @[intervox_transmitter.scala 289:27 171:34]
    node _GEN_39 = mux(_T_20, _GEN_31, _GEN_15) @[intervox_transmitter.scala 289:27]
    node _GEN_40 = mux(_T_20, _GEN_32, UInt<1>("h0")) @[intervox_transmitter.scala 196:25 289:27]
    node _GEN_41 = mux(_T_20, _GEN_33, UInt<1>("h0")) @[intervox_transmitter.scala 197:25 289:27]
    node _GEN_42 = mux(_T_20, _GEN_34, UInt<1>("h0")) @[intervox_transmitter.scala 200:25 289:27]
    node _GEN_43 = mux(_T_20, _GEN_35, BFR.io_dataOut) @[intervox_transmitter.scala 201:25 289:27]
    node _GEN_44 = mux(_T_19, _GEN_36, UInt<1>("h0")) @[intervox_transmitter.scala 277:24 207:31]
    node _GEN_45 = mux(_T_19, _GEN_37, encoderClk) @[intervox_transmitter.scala 277:24 175:34]
    node _GEN_46 = mux(_T_19, _GEN_38, bclkR) @[intervox_transmitter.scala 277:24 171:34]
    node _GEN_47 = mux(_T_19, _GEN_39, _GEN_15) @[intervox_transmitter.scala 277:24]
    node _GEN_48 = mux(_T_19, _GEN_40, UInt<1>("h0")) @[intervox_transmitter.scala 277:24 196:25]
    node _GEN_49 = mux(_T_19, _GEN_41, UInt<1>("h0")) @[intervox_transmitter.scala 277:24 197:25]
    node _GEN_50 = mux(_T_19, _GEN_42, UInt<1>("h0")) @[intervox_transmitter.scala 277:24 200:25]
    node _GEN_51 = mux(_T_19, _GEN_43, BFR.io_dataOut) @[intervox_transmitter.scala 277:24 201:25]
    node _GEN_52 = mux(_T_18, UInt<2>("h2"), current_state) @[intervox_transmitter.scala 277:24 285:21 167:34]
    node _GEN_53 = mux(_T_18, UInt<1>("h0"), _GEN_44) @[intervox_transmitter.scala 277:24 207:31]
    node _GEN_54 = mux(_T_18, encoderClk, _GEN_45) @[intervox_transmitter.scala 277:24 175:34]
    node _GEN_55 = mux(_T_18, bclkR, _GEN_46) @[intervox_transmitter.scala 277:24 171:34]
    node _GEN_56 = mux(_T_18, _GEN_15, _GEN_47) @[intervox_transmitter.scala 277:24]
    node _GEN_57 = mux(_T_18, UInt<1>("h0"), _GEN_48) @[intervox_transmitter.scala 277:24 196:25]
    node _GEN_58 = mux(_T_18, UInt<1>("h0"), _GEN_49) @[intervox_transmitter.scala 277:24 197:25]
    node _GEN_59 = mux(_T_18, UInt<1>("h0"), _GEN_50) @[intervox_transmitter.scala 277:24 200:25]
    node _GEN_60 = mux(_T_18, BFR.io_dataOut, _GEN_51) @[intervox_transmitter.scala 277:24 201:25]
    node _GEN_61 = mux(_T_17, UInt<2>("h2"), _GEN_52) @[intervox_transmitter.scala 277:24 281:21]
    node _GEN_62 = mux(_T_17, UInt<1>("h0"), _GEN_53) @[intervox_transmitter.scala 277:24 207:31]
    node _GEN_63 = mux(_T_17, encoderClk, _GEN_54) @[intervox_transmitter.scala 277:24 175:34]
    node _GEN_64 = mux(_T_17, bclkR, _GEN_55) @[intervox_transmitter.scala 277:24 171:34]
    node _GEN_65 = mux(_T_17, _GEN_15, _GEN_56) @[intervox_transmitter.scala 277:24]
    node _GEN_66 = mux(_T_17, UInt<1>("h0"), _GEN_57) @[intervox_transmitter.scala 277:24 196:25]
    node _GEN_67 = mux(_T_17, UInt<1>("h0"), _GEN_58) @[intervox_transmitter.scala 277:24 197:25]
    node _GEN_68 = mux(_T_17, UInt<1>("h0"), _GEN_59) @[intervox_transmitter.scala 277:24 200:25]
    node _GEN_69 = mux(_T_17, BFR.io_dataOut, _GEN_60) @[intervox_transmitter.scala 277:24 201:25]
    io_MCLK_O <= clock @[intervox_transmitter.scala 188:25]
    io_DATA_O <= bi_phase_enc.io_DATA_OUT @[intervox_transmitter.scala 187:25]
    io_LRCLK_O <= io_LRCLK_IN @[intervox_transmitter.scala 190:25]
    io_BCLK_O <= io_BCLK_IN @[intervox_transmitter.scala 189:25]
    io_SDATA_O <= io_SDATA_IN @[intervox_transmitter.scala 191:25]
    io_NXT_FRAME <= bi_phase_enc.io_ENA @[intervox_transmitter.scala 204:31]
    current_state <= mux(reset, UInt<2>("h0"), _GEN_61) @[intervox_transmitter.scala 167:{34,34}]
    synced <= mux(reset, UInt<1>("h0"), _GEN_16) @[intervox_transmitter.scala 169:{34,34}]
    bclkR <= mux(reset, UInt<1>("h1"), _GEN_64) @[intervox_transmitter.scala 171:{34,34}]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    bi_phase_enc.io_AUDIOINPUT <= BFR1.io_dataOut @[intervox_transmitter.scala 209:31]
    bi_phase_enc.io_DSPINPUT <= UInt<64>("h0") @[intervox_transmitter.scala 211:31]
    bi_phase_enc.io_ENA <= _GEN_62
    bi_phase_enc.io_TICK <= encoderClk @[intervox_transmitter.scala 206:31]
    encoderClk <= mux(reset, UInt<1>("h0"), _GEN_63) @[intervox_transmitter.scala 175:{34,34}]
    bitCntr <= mux(reset, UInt<8>("h0"), _GEN_65) @[intervox_transmitter.scala 177:{34,34}]
    BFR.clock <= clock
    BFR.reset <= reset
    BFR.io_enable <= UInt<1>("h1") @[intervox_transmitter.scala 194:25]
    BFR.io_write <= _GEN_66
    BFR.io_addr <= UInt<1>("h1") @[intervox_transmitter.scala 195:25]
    BFR.io_dataIn <= bits(_GEN_67, 63, 0)
    BFR1.clock <= clock
    BFR1.reset <= reset
    BFR1.io_enable <= UInt<1>("h1") @[intervox_transmitter.scala 198:25]
    BFR1.io_write <= _GEN_68
    BFR1.io_addr <= UInt<1>("h1") @[intervox_transmitter.scala 199:25]
    BFR1.io_dataIn <= _GEN_69
    inBufr <= mux(reset, UInt<2>("h0"), _GEN_12) @[intervox_transmitter.scala 182:{34,34}]
    trailing <= mux(reset, UInt<1>("h0"), _GEN_14) @[intervox_transmitter.scala 183:{34,34}]
    rising <= mux(reset, UInt<1>("h0"), _GEN_13) @[intervox_transmitter.scala 184:{34,34}]
