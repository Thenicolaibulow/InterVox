circuit interVox_Encoder :
  module bi_phase_encoder :
    input clock : Clock
    input reset : UInt<1>
    output io_DATA_OUT : UInt<1>
    input io_AUDIOINPUT : UInt<64>
    input io_DSPINPUT : UInt<64>
    input io_ENA : UInt<1>
    output io_NEXT : UInt<1>

    reg outReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), outReg) @[intervox_transmitter.scala 38:32]
    reg next : UInt<1>, clock with :
      reset => (UInt<1>("h0"), next) @[intervox_transmitter.scala 39:32]
    reg stereoData : UInt<64>, clock with :
      reset => (UInt<1>("h0"), stereoData) @[intervox_transmitter.scala 40:32]
    reg dspData : UInt<16>, clock with :
      reset => (UInt<1>("h0"), dspData) @[intervox_transmitter.scala 41:32]
    reg dspData2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), dspData2) @[intervox_transmitter.scala 42:32]
    reg bitCntr_enc : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr_enc) @[intervox_transmitter.scala 43:32]
    reg hasNone : UInt<1>, clock with :
      reset => (UInt<1>("h0"), hasNone) @[intervox_transmitter.scala 44:32]
    reg holdState : UInt<1>, clock with :
      reset => (UInt<1>("h0"), holdState) @[intervox_transmitter.scala 45:32]
    reg dataIndex : UInt<6>, clock with :
      reset => (UInt<1>("h0"), dataIndex) @[intervox_transmitter.scala 46:32]
    reg ndexR : UInt<1>, clock with :
      reset => (UInt<1>("h0"), ndexR) @[intervox_transmitter.scala 55:32]
    node _T = eq(io_ENA, UInt<1>("h1")) @[intervox_transmitter.scala 59:17]
    node _T_1 = eq(bitCntr_enc, UInt<3>("h6")) @[intervox_transmitter.scala 62:26]
    node _outReg_T = not(outReg) @[intervox_transmitter.scala 64:21]
    node _GEN_0 = mux(_T_1, _outReg_T, outReg) @[intervox_transmitter.scala 62:34 64:18 38:32]
    node _T_2 = eq(bitCntr_enc, UInt<3>("h7")) @[intervox_transmitter.scala 66:26]
    node _outReg_T_1 = not(outReg) @[intervox_transmitter.scala 67:21]
    node _GEN_1 = mux(_T_2, _outReg_T_1, _GEN_0) @[intervox_transmitter.scala 66:34 67:18]
    node _T_3 = gt(bitCntr_enc, UInt<3>("h7")) @[intervox_transmitter.scala 71:29]
    node _ndexR_T = not(ndexR) @[intervox_transmitter.scala 74:20]
    node _T_4 = eq(ndexR, UInt<1>("h1")) @[intervox_transmitter.scala 75:22]
    node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 77:36]
    node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 77:36]
    node _GEN_2 = mux(_T_4, _dataIndex_T_1, dataIndex) @[intervox_transmitter.scala 75:30 77:23 46:32]
    node _T_5 = lt(bitCntr_enc, UInt<6>("h38")) @[intervox_transmitter.scala 82:28]
    node _T_6 = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 84:48]
    node _T_7 = tail(_T_6, 1) @[intervox_transmitter.scala 84:48]
    node _T_8 = sub(UInt<7>("h40"), _T_7) @[intervox_transmitter.scala 84:35]
    node _T_9 = tail(_T_8, 1) @[intervox_transmitter.scala 84:35]
    node _T_10 = dshr(stereoData, _T_9) @[intervox_transmitter.scala 84:29]
    node _T_11 = bits(_T_10, 0, 0) @[intervox_transmitter.scala 84:29]
    node _T_12 = eq(_T_11, UInt<1>("h0")) @[intervox_transmitter.scala 84:58]
    node _GEN_3 = mux(_T_12, UInt<1>("h1"), hasNone) @[intervox_transmitter.scala 84:67 86:23 44:32]
    node _GEN_4 = mux(_T_5, _GEN_3, hasNone) @[intervox_transmitter.scala 44:32 82:35]
    node _T_13 = geq(bitCntr_enc, UInt<6>("h38")) @[intervox_transmitter.scala 89:29]
    node _T_14 = lt(bitCntr_enc, UInt<7>("h69")) @[intervox_transmitter.scala 89:53]
    node _T_15 = and(_T_13, _T_14) @[intervox_transmitter.scala 89:38]
    node _T_16 = sub(dataIndex, UInt<5>("h17")) @[intervox_transmitter.scala 91:49]
    node _T_17 = tail(_T_16, 1) @[intervox_transmitter.scala 91:49]
    node _T_18 = sub(UInt<7>("h40"), _T_17) @[intervox_transmitter.scala 91:36]
    node _T_19 = tail(_T_18, 1) @[intervox_transmitter.scala 91:36]
    node _T_20 = dshr(stereoData, _T_19) @[intervox_transmitter.scala 91:29]
    node _T_21 = bits(_T_20, 0, 0) @[intervox_transmitter.scala 91:29]
    node _T_22 = eq(_T_21, UInt<1>("h0")) @[intervox_transmitter.scala 91:61]
    node _GEN_5 = mux(_T_22, UInt<1>("h1"), _GEN_4) @[intervox_transmitter.scala 91:70 93:23]
    node _GEN_6 = mux(_T_15, _GEN_5, _GEN_4) @[intervox_transmitter.scala 89:62]
    node _T_23 = geq(bitCntr_enc, UInt<7>("h69")) @[intervox_transmitter.scala 97:29]
    node _T_24 = lt(bitCntr_enc, UInt<8>("h81")) @[intervox_transmitter.scala 97:54]
    node _T_25 = and(_T_23, _T_24) @[intervox_transmitter.scala 97:39]
    node _T_26 = sub(dataIndex, UInt<6>("h30")) @[intervox_transmitter.scala 101:40]
    node _T_27 = tail(_T_26, 1) @[intervox_transmitter.scala 101:40]
    node _T_28 = dshr(dspData, _T_27) @[intervox_transmitter.scala 101:28]
    node _T_29 = bits(_T_28, 0, 0) @[intervox_transmitter.scala 101:28]
    node _T_30 = eq(_T_29, UInt<1>("h0")) @[intervox_transmitter.scala 101:51]
    node _GEN_7 = mux(_T_30, UInt<1>("h1"), _GEN_6) @[intervox_transmitter.scala 101:60 103:23]
    node _GEN_8 = mux(_T_25, _GEN_7, _GEN_6) @[intervox_transmitter.scala 97:63]
    node _T_31 = geq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 107:29]
    node _T_32 = lt(bitCntr_enc, UInt<8>("hff")) @[intervox_transmitter.scala 107:54]
    node _T_33 = and(_T_31, _T_32) @[intervox_transmitter.scala 107:39]
    node _T_34 = sub(dataIndex, UInt<6>("h3c")) @[intervox_transmitter.scala 111:41]
    node _T_35 = tail(_T_34, 1) @[intervox_transmitter.scala 111:41]
    node _T_36 = dshr(dspData2, _T_35) @[intervox_transmitter.scala 111:29]
    node _T_37 = bits(_T_36, 0, 0) @[intervox_transmitter.scala 111:29]
    node _T_38 = eq(_T_37, UInt<1>("h0")) @[intervox_transmitter.scala 111:52]
    node _GEN_9 = mux(_T_38, UInt<1>("h1"), _GEN_8) @[intervox_transmitter.scala 111:61 113:23]
    node _GEN_10 = mux(_T_33, _GEN_9, _GEN_8) @[intervox_transmitter.scala 107:63]
    node _T_39 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 117:24]
    node _outReg_T_2 = not(outReg) @[intervox_transmitter.scala 123:23]
    node _GEN_11 = mux(_T_39, outReg, _outReg_T_2) @[intervox_transmitter.scala 117:32 118:20 123:20]
    node _GEN_12 = mux(_T_39, UInt<1>("h0"), _GEN_10) @[intervox_transmitter.scala 117:32 119:21]
    node _GEN_13 = mux(_T_3, _ndexR_T, ndexR) @[intervox_transmitter.scala 71:36 74:17 55:32]
    node _GEN_14 = mux(_T_3, _GEN_2, dataIndex) @[intervox_transmitter.scala 46:32 71:36]
    node _GEN_15 = mux(_T_3, UInt<1>("h0"), holdState) @[intervox_transmitter.scala 71:36 80:21 45:32]
    node _GEN_16 = mux(_T_3, _GEN_12, hasNone) @[intervox_transmitter.scala 44:32 71:36]
    node _GEN_17 = mux(_T_3, _GEN_11, _GEN_1) @[intervox_transmitter.scala 71:36]
    node _T_40 = eq(bitCntr_enc, UInt<8>("hff")) @[intervox_transmitter.scala 127:26]
    node _GEN_18 = mux(_T_40, UInt<1>("h0"), bitCntr_enc) @[intervox_transmitter.scala 127:36 128:23 43:32]
    node _GEN_19 = mux(_T_40, UInt<1>("h0"), _GEN_14) @[intervox_transmitter.scala 127:36 129:21]
    node _bitCntr_enc_T = add(bitCntr_enc, UInt<1>("h1")) @[intervox_transmitter.scala 134:36]
    node _bitCntr_enc_T_1 = tail(_bitCntr_enc_T, 1) @[intervox_transmitter.scala 134:36]
    node _GEN_20 = mux(_T, _GEN_17, outReg) @[intervox_transmitter.scala 59:25 38:32]
    node _GEN_21 = mux(_T, _GEN_13, ndexR) @[intervox_transmitter.scala 59:25 55:32]
    node _GEN_22 = mux(_T, _GEN_19, dataIndex) @[intervox_transmitter.scala 59:25 46:32]
    node _GEN_23 = mux(_T, _GEN_15, holdState) @[intervox_transmitter.scala 59:25 45:32]
    node _GEN_24 = mux(_T, _GEN_16, hasNone) @[intervox_transmitter.scala 59:25 44:32]
    node _GEN_25 = mux(_T, _bitCntr_enc_T_1, bitCntr_enc) @[intervox_transmitter.scala 134:21 59:25 43:32]
    io_DATA_OUT <= outReg @[intervox_transmitter.scala 48:17]
    io_NEXT <= next @[intervox_transmitter.scala 53:17]
    outReg <= mux(reset, UInt<1>("h0"), _GEN_20) @[intervox_transmitter.scala 38:{32,32}]
    next <= mux(reset, UInt<1>("h0"), next) @[intervox_transmitter.scala 39:{32,32,32}]
    stereoData <= mux(reset, UInt<64>("h0"), io_AUDIOINPUT) @[intervox_transmitter.scala 40:{32,32} 50:17]
    dspData <= bits(mux(reset, UInt<16>("h0"), io_DSPINPUT), 15, 0) @[intervox_transmitter.scala 41:{32,32} 51:17]
    dspData2 <= mux(reset, UInt<64>("h0"), UInt<1>("h0")) @[intervox_transmitter.scala 42:{32,32} 52:17]
    bitCntr_enc <= mux(reset, UInt<8>("h0"), _GEN_25) @[intervox_transmitter.scala 43:{32,32}]
    hasNone <= mux(reset, UInt<1>("h0"), _GEN_24) @[intervox_transmitter.scala 44:{32,32}]
    holdState <= mux(reset, UInt<1>("h0"), _GEN_23) @[intervox_transmitter.scala 45:{32,32}]
    dataIndex <= mux(reset, UInt<6>("h0"), _GEN_22) @[intervox_transmitter.scala 46:{32,32}]
    ndexR <= mux(reset, UInt<1>("h0"), _GEN_21) @[intervox_transmitter.scala 55:{32,32}]

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

    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 165:33]
    inst BFR of RWSmem @[intervox_transmitter.scala 169:33]
    inst BFR1 of RWSmem @[intervox_transmitter.scala 170:33]
    reg current_state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), current_state) @[intervox_transmitter.scala 153:34]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (UInt<1>("h0"), BiPhase_CLK_CNTR) @[intervox_transmitter.scala 155:34]
    reg DATA_OUT_REG_1B : UInt<1>, clock with :
      reset => (UInt<1>("h0"), DATA_OUT_REG_1B) @[intervox_transmitter.scala 157:34]
    reg FirstFrame : UInt<1>, clock with :
      reset => (UInt<1>("h0"), FirstFrame) @[intervox_transmitter.scala 159:34]
    reg synced : UInt<1>, clock with :
      reset => (UInt<1>("h0"), synced) @[intervox_transmitter.scala 161:34]
    reg bclkR : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bclkR) @[intervox_transmitter.scala 163:34]
    reg bitCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_transmitter.scala 167:34]
    node _T = eq(synced, UInt<1>("h0")) @[intervox_transmitter.scala 214:15]
    node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 216:42]
    node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 216:42]
    node _T_1 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 218:27]
    node _T_2 = eq(io_LRCLK_IN, UInt<1>("h1")) @[intervox_transmitter.scala 221:24]
    node _GEN_0 = mux(_T_2, UInt<1>("h0"), bitCntr) @[intervox_transmitter.scala 221:32 222:17 167:34]
    node _T_3 = eq(io_LRCLK_IN, UInt<1>("h0")) @[intervox_transmitter.scala 225:24]
    node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 228:28]
    node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 228:28]
    node _T_4 = eq(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 230:22]
    node _GEN_1 = mux(_T_4, UInt<1>("h0"), _bitCntr_T_1) @[intervox_transmitter.scala 228:17 230:31 231:19]
    node _GEN_2 = mux(_T_4, UInt<1>("h1"), synced) @[intervox_transmitter.scala 230:31 232:18 161:34]
    node _GEN_3 = mux(_T_3, _GEN_1, _GEN_0) @[intervox_transmitter.scala 225:32]
    node _GEN_4 = mux(_T_3, _GEN_2, synced) @[intervox_transmitter.scala 225:32 161:34]
    node _GEN_5 = mux(_T_1, UInt<1>("h0"), _BiPhase_CLK_CNTR_T_1) @[intervox_transmitter.scala 216:22 218:35 219:24]
    node _GEN_6 = mux(_T_1, _GEN_3, bitCntr) @[intervox_transmitter.scala 167:34 218:35]
    node _GEN_7 = mux(_T_1, _GEN_4, synced) @[intervox_transmitter.scala 161:34 218:35]
    node _GEN_8 = mux(_T, _GEN_5, BiPhase_CLK_CNTR) @[intervox_transmitter.scala 214:23 155:34]
    node _GEN_9 = mux(_T, _GEN_6, bitCntr) @[intervox_transmitter.scala 214:23 167:34]
    node _GEN_10 = mux(_T, _GEN_7, synced) @[intervox_transmitter.scala 214:23 161:34]
    node _T_5 = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 245:24]
    node _T_6 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 245:24]
    node _T_7 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 245:24]
    node _T_8 = eq(synced, UInt<1>("h1")) @[intervox_transmitter.scala 257:19]
    node _BiPhase_CLK_CNTR_T_2 = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 265:46]
    node _BiPhase_CLK_CNTR_T_3 = tail(_BiPhase_CLK_CNTR_T_2, 1) @[intervox_transmitter.scala 265:46]
    node _T_9 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 267:31]
    node _bitCntr_T_2 = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 271:30]
    node _bitCntr_T_3 = tail(_bitCntr_T_2, 1) @[intervox_transmitter.scala 271:30]
    node _T_10 = eq(bitCntr, UInt<1>("h0")) @[intervox_transmitter.scala 275:24]
    node _GEN_11 = mux(_T_10, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 182:25 275:32 277:31]
    node _GEN_12 = mux(_T_10, UInt<1>("h0"), UInt<1>("h0")) @[intervox_transmitter.scala 183:25 275:32 278:31]
    node _T_11 = gt(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 282:24]
    node _T_12 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 289:30]
    node _BFR_io_dataIn_T = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 291:67]
    node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 291:67]
    node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 291:58]
    node _BFR_io_dataIn_T_3 = add(BFR.io_dataOut, _BFR_io_dataIn_T_2) @[intervox_transmitter.scala 291:51]
    node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_transmitter.scala 291:51]
    node _GEN_13 = mux(_T_12, _BFR_io_dataIn_T_4, _GEN_12) @[intervox_transmitter.scala 289:38 291:33]
    node _T_13 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 294:30]
    node _BFR_io_dataIn_T_5 = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 295:68]
    node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_transmitter.scala 295:68]
    node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 295:58]
    node _BFR_io_dataIn_T_8 = add(BFR.io_dataOut, _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 295:51]
    node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 295:51]
    node _GEN_14 = mux(_T_13, _BFR_io_dataIn_T_9, _GEN_13) @[intervox_transmitter.scala 294:38 295:33]
    node _T_14 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 303:30]
    node _BFR_io_dataIn_T_10 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 305:67]
    node _BFR_io_dataIn_T_11 = tail(_BFR_io_dataIn_T_10, 1) @[intervox_transmitter.scala 305:67]
    node _BFR_io_dataIn_T_12 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_11) @[intervox_transmitter.scala 305:58]
    node _BFR_io_dataIn_T_13 = add(BFR.io_dataOut, _BFR_io_dataIn_T_12) @[intervox_transmitter.scala 305:51]
    node _BFR_io_dataIn_T_14 = tail(_BFR_io_dataIn_T_13, 1) @[intervox_transmitter.scala 305:51]
    node _GEN_15 = mux(_T_14, _BFR_io_dataIn_T_14, _GEN_12) @[intervox_transmitter.scala 303:39 305:33]
    node _T_15 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 308:30]
    node _BFR_io_dataIn_T_15 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 309:67]
    node _BFR_io_dataIn_T_16 = tail(_BFR_io_dataIn_T_15, 1) @[intervox_transmitter.scala 309:67]
    node _BFR_io_dataIn_T_17 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_16) @[intervox_transmitter.scala 309:58]
    node _BFR_io_dataIn_T_18 = add(BFR.io_dataOut, _BFR_io_dataIn_T_17) @[intervox_transmitter.scala 309:51]
    node _BFR_io_dataIn_T_19 = tail(_BFR_io_dataIn_T_18, 1) @[intervox_transmitter.scala 309:51]
    node _GEN_16 = mux(_T_15, _BFR_io_dataIn_T_19, _GEN_15) @[intervox_transmitter.scala 308:38 309:33]
    node _GEN_17 = mux(_T_11, UInt<1>("h1"), UInt<1>("h1")) @[intervox_transmitter.scala 282:31 287:31 301:31]
    node _GEN_18 = mux(_T_11, _GEN_14, _GEN_16) @[intervox_transmitter.scala 282:31]
    node _T_16 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 313:24]
    node _GEN_19 = mux(_T_16, UInt<1>("h1"), _GEN_17) @[intervox_transmitter.scala 313:33 321:28]
    node _GEN_20 = mux(_T_16, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 186:25 313:33 317:31]
    node _GEN_21 = mux(_T_16, BFR.io_dataOut, BFR.io_dataOut) @[intervox_transmitter.scala 187:25 313:33 318:31]
    node _GEN_22 = mux(_T_16, UInt<1>("h0"), _GEN_18) @[intervox_transmitter.scala 313:33 322:28]
    node _GEN_23 = mux(_T_16, UInt<1>("h0"), _bitCntr_T_3) @[intervox_transmitter.scala 271:19 313:33 324:21]
    node _GEN_24 = mux(_T_9, UInt<1>("h0"), _BiPhase_CLK_CNTR_T_3) @[intervox_transmitter.scala 265:26 267:39 268:28]
    node _GEN_25 = mux(_T_9, _GEN_23, _GEN_9) @[intervox_transmitter.scala 267:39]
    node _GEN_26 = mux(_T_9, _GEN_19, UInt<1>("h0")) @[intervox_transmitter.scala 182:25 267:39]
    node _GEN_27 = mux(_T_9, _GEN_22, UInt<1>("h0")) @[intervox_transmitter.scala 183:25 267:39]
    node _GEN_28 = mux(_T_9, _GEN_20, UInt<1>("h0")) @[intervox_transmitter.scala 186:25 267:39]
    node _GEN_29 = mux(_T_9, _GEN_21, BFR.io_dataOut) @[intervox_transmitter.scala 187:25 267:39]
    node _GEN_30 = mux(_T_8, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 257:27 264:29 193:31]
    node _GEN_31 = mux(_T_8, _GEN_24, _GEN_8) @[intervox_transmitter.scala 257:27]
    node _GEN_32 = mux(_T_8, _GEN_25, _GEN_9) @[intervox_transmitter.scala 257:27]
    node _GEN_33 = mux(_T_8, _GEN_26, UInt<1>("h0")) @[intervox_transmitter.scala 182:25 257:27]
    node _GEN_34 = mux(_T_8, _GEN_27, UInt<1>("h0")) @[intervox_transmitter.scala 183:25 257:27]
    node _GEN_35 = mux(_T_8, _GEN_28, UInt<1>("h0")) @[intervox_transmitter.scala 186:25 257:27]
    node _GEN_36 = mux(_T_8, _GEN_29, BFR.io_dataOut) @[intervox_transmitter.scala 187:25 257:27]
    node _GEN_37 = mux(_T_7, _GEN_30, UInt<1>("h0")) @[intervox_transmitter.scala 245:24 193:31]
    node _GEN_38 = mux(_T_7, _GEN_31, _GEN_8) @[intervox_transmitter.scala 245:24]
    node _GEN_39 = mux(_T_7, _GEN_32, _GEN_9) @[intervox_transmitter.scala 245:24]
    node _GEN_40 = mux(_T_7, _GEN_33, UInt<1>("h0")) @[intervox_transmitter.scala 245:24 182:25]
    node _GEN_41 = mux(_T_7, _GEN_34, UInt<1>("h0")) @[intervox_transmitter.scala 245:24 183:25]
    node _GEN_42 = mux(_T_7, _GEN_35, UInt<1>("h0")) @[intervox_transmitter.scala 245:24 186:25]
    node _GEN_43 = mux(_T_7, _GEN_36, BFR.io_dataOut) @[intervox_transmitter.scala 245:24 187:25]
    node _GEN_44 = mux(_T_6, UInt<2>("h2"), current_state) @[intervox_transmitter.scala 245:24 253:21 153:34]
    node _GEN_45 = mux(_T_6, UInt<1>("h0"), _GEN_37) @[intervox_transmitter.scala 245:24 193:31]
    node _GEN_46 = mux(_T_6, _GEN_8, _GEN_38) @[intervox_transmitter.scala 245:24]
    node _GEN_47 = mux(_T_6, _GEN_9, _GEN_39) @[intervox_transmitter.scala 245:24]
    node _GEN_48 = mux(_T_6, UInt<1>("h0"), _GEN_40) @[intervox_transmitter.scala 245:24 182:25]
    node _GEN_49 = mux(_T_6, UInt<1>("h0"), _GEN_41) @[intervox_transmitter.scala 245:24 183:25]
    node _GEN_50 = mux(_T_6, UInt<1>("h0"), _GEN_42) @[intervox_transmitter.scala 245:24 186:25]
    node _GEN_51 = mux(_T_6, BFR.io_dataOut, _GEN_43) @[intervox_transmitter.scala 245:24 187:25]
    node _GEN_52 = mux(_T_5, UInt<2>("h2"), _GEN_44) @[intervox_transmitter.scala 245:24 249:21]
    node _GEN_53 = mux(_T_5, UInt<1>("h0"), _GEN_45) @[intervox_transmitter.scala 245:24 193:31]
    node _GEN_54 = mux(_T_5, _GEN_8, _GEN_46) @[intervox_transmitter.scala 245:24]
    node _GEN_55 = mux(_T_5, _GEN_9, _GEN_47) @[intervox_transmitter.scala 245:24]
    node _GEN_56 = mux(_T_5, UInt<1>("h0"), _GEN_48) @[intervox_transmitter.scala 245:24 182:25]
    node _GEN_57 = mux(_T_5, UInt<1>("h0"), _GEN_49) @[intervox_transmitter.scala 245:24 183:25]
    node _GEN_58 = mux(_T_5, UInt<1>("h0"), _GEN_50) @[intervox_transmitter.scala 245:24 186:25]
    node _GEN_59 = mux(_T_5, BFR.io_dataOut, _GEN_51) @[intervox_transmitter.scala 245:24 187:25]
    io_MCLK_O <= clock @[intervox_transmitter.scala 174:25]
    io_DATA_O <= bi_phase_enc.io_DATA_OUT @[intervox_transmitter.scala 173:25]
    io_LRCLK_O <= io_LRCLK_IN @[intervox_transmitter.scala 176:25]
    io_BCLK_O <= io_BCLK_IN @[intervox_transmitter.scala 175:25]
    io_SDATA_O <= io_SDATA_IN @[intervox_transmitter.scala 177:25]
    io_NXT_FRAME <= bi_phase_enc.io_ENA @[intervox_transmitter.scala 190:31]
    current_state <= mux(reset, UInt<2>("h0"), _GEN_52) @[intervox_transmitter.scala 153:{34,34}]
    BiPhase_CLK_CNTR <= mux(reset, UInt<8>("h0"), _GEN_54) @[intervox_transmitter.scala 155:{34,34}]
    DATA_OUT_REG_1B <= mux(reset, UInt<1>("h0"), DATA_OUT_REG_1B) @[intervox_transmitter.scala 157:{34,34,34}]
    FirstFrame <= mux(reset, UInt<1>("h0"), FirstFrame) @[intervox_transmitter.scala 159:{34,34,34}]
    synced <= mux(reset, UInt<1>("h0"), _GEN_10) @[intervox_transmitter.scala 161:{34,34}]
    bclkR <= mux(reset, UInt<1>("h1"), bclkR) @[intervox_transmitter.scala 163:{34,34,34}]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    bi_phase_enc.io_AUDIOINPUT <= BFR1.io_dataOut @[intervox_transmitter.scala 195:31]
    bi_phase_enc.io_DSPINPUT <= UInt<64>("h0") @[intervox_transmitter.scala 197:31]
    bi_phase_enc.io_ENA <= _GEN_53
    bitCntr <= mux(reset, UInt<8>("h0"), _GEN_55) @[intervox_transmitter.scala 167:{34,34}]
    BFR.clock <= clock
    BFR.reset <= reset
    BFR.io_enable <= UInt<1>("h1") @[intervox_transmitter.scala 180:25]
    BFR.io_write <= _GEN_56
    BFR.io_addr <= UInt<1>("h1") @[intervox_transmitter.scala 181:25]
    BFR.io_dataIn <= bits(_GEN_57, 63, 0)
    BFR1.clock <= clock
    BFR1.reset <= reset
    BFR1.io_enable <= UInt<1>("h1") @[intervox_transmitter.scala 184:25]
    BFR1.io_write <= _GEN_58
    BFR1.io_addr <= UInt<1>("h1") @[intervox_transmitter.scala 185:25]
    BFR1.io_dataIn <= _GEN_59
