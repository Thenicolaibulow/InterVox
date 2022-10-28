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
    node _T = eq(io_TICK, UInt<1>("h1")) @[intervox_transmitter.scala 54:20]
    node _bitCntr_enc_T = add(bitCntr_enc, UInt<1>("h1")) @[intervox_transmitter.scala 56:38]
    node _bitCntr_enc_T_1 = tail(_bitCntr_enc_T, 1) @[intervox_transmitter.scala 56:38]
    node _T_1 = rem(bitCntr_enc, UInt<2>("h2")) @[intervox_transmitter.scala 57:28]
    node _T_2 = eq(_T_1, UInt<1>("h0")) @[intervox_transmitter.scala 57:34]
    node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 59:36]
    node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 59:36]
    node _GEN_0 = mux(_T_2, _dataIndex_T_1, dataIndex) @[intervox_transmitter.scala 57:42 59:23 44:32]
    node _T_3 = lt(bitCntr_enc, UInt<3>("h7")) @[intervox_transmitter.scala 63:28]
    node _T_4 = lt(bitCntr_enc, UInt<3>("h6")) @[intervox_transmitter.scala 66:30]
    node _GEN_1 = mux(_T_4, UInt<1>("h0"), UInt<1>("h1")) @[intervox_transmitter.scala 67:13 68:22 72:22]
    node _GEN_2 = mux(_T_3, _GEN_1, outReg) @[intervox_transmitter.scala 38:32 63:35]
    node _T_5 = gt(bitCntr_enc, UInt<3>("h7")) @[intervox_transmitter.scala 76:29]
    node _T_6 = lt(bitCntr_enc, UInt<6>("h37")) @[intervox_transmitter.scala 79:30]
    node _T_7 = sub(dataIndex, UInt<2>("h3")) @[intervox_transmitter.scala 81:50]
    node _T_8 = tail(_T_7, 1) @[intervox_transmitter.scala 81:50]
    node _T_9 = sub(UInt<7>("h40"), _T_8) @[intervox_transmitter.scala 81:37]
    node _T_10 = tail(_T_9, 1) @[intervox_transmitter.scala 81:37]
    node _T_11 = dshr(stereoData, _T_10) @[intervox_transmitter.scala 81:31]
    node _T_12 = bits(_T_11, 0, 0) @[intervox_transmitter.scala 81:31]
    node _T_13 = eq(_T_12, UInt<1>("h0")) @[intervox_transmitter.scala 81:60]
    node _GEN_3 = mux(_T_13, UInt<1>("h1"), hasNone) @[intervox_transmitter.scala 81:69 83:25 43:32]
    node _GEN_4 = mux(_T_6, _GEN_3, hasNone) @[intervox_transmitter.scala 43:32 79:37]
    node _T_14 = geq(bitCntr_enc, UInt<6>("h37")) @[intervox_transmitter.scala 86:31]
    node _T_15 = lt(bitCntr_enc, UInt<7>("h67")) @[intervox_transmitter.scala 86:55]
    node _T_16 = and(_T_14, _T_15) @[intervox_transmitter.scala 86:40]
    node _T_17 = sub(dataIndex, UInt<5>("h1b")) @[intervox_transmitter.scala 88:51]
    node _T_18 = tail(_T_17, 1) @[intervox_transmitter.scala 88:51]
    node _T_19 = sub(UInt<7>("h40"), _T_18) @[intervox_transmitter.scala 88:38]
    node _T_20 = tail(_T_19, 1) @[intervox_transmitter.scala 88:38]
    node _T_21 = dshr(stereoData, _T_20) @[intervox_transmitter.scala 88:31]
    node _T_22 = bits(_T_21, 0, 0) @[intervox_transmitter.scala 88:31]
    node _T_23 = eq(_T_22, UInt<1>("h0")) @[intervox_transmitter.scala 88:63]
    node _GEN_5 = mux(_T_23, UInt<1>("h1"), _GEN_4) @[intervox_transmitter.scala 88:72 90:25]
    node _GEN_6 = mux(_T_16, _GEN_5, _GEN_4) @[intervox_transmitter.scala 86:64]
    node _T_24 = geq(bitCntr_enc, UInt<7>("h67")) @[intervox_transmitter.scala 94:31]
    node _T_25 = lt(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 94:56]
    node _T_26 = and(_T_24, _T_25) @[intervox_transmitter.scala 94:41]
    node _T_27 = sub(dataIndex, UInt<6>("h34")) @[intervox_transmitter.scala 98:42]
    node _T_28 = tail(_T_27, 1) @[intervox_transmitter.scala 98:42]
    node _T_29 = dshr(dspData, _T_28) @[intervox_transmitter.scala 98:30]
    node _T_30 = bits(_T_29, 0, 0) @[intervox_transmitter.scala 98:30]
    node _T_31 = eq(_T_30, UInt<1>("h0")) @[intervox_transmitter.scala 98:53]
    node _GEN_7 = mux(_T_31, UInt<1>("h1"), _GEN_6) @[intervox_transmitter.scala 100:25 98:62]
    node _GEN_8 = mux(_T_26, _GEN_7, _GEN_6) @[intervox_transmitter.scala 94:65]
    node _T_32 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 104:26]
    node _outReg_T = not(outReg) @[intervox_transmitter.scala 110:25]
    node _GEN_9 = mux(_T_32, outReg, _outReg_T) @[intervox_transmitter.scala 104:34 105:22 110:22]
    node _GEN_10 = mux(_T_32, UInt<1>("h0"), _GEN_8) @[intervox_transmitter.scala 104:34 106:23]
    node _GEN_11 = mux(_T_5, _GEN_10, hasNone) @[intervox_transmitter.scala 43:32 76:36]
    node _GEN_12 = mux(_T_5, _GEN_9, _GEN_2) @[intervox_transmitter.scala 76:36]
    node _T_33 = eq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 114:28]
    node _GEN_13 = mux(_T_33, UInt<1>("h0"), _bitCntr_enc_T_1) @[intervox_transmitter.scala 114:38 115:25 56:23]
    node _GEN_14 = mux(_T, _GEN_13, bitCntr_enc) @[intervox_transmitter.scala 54:28 42:32]
    node _GEN_15 = mux(_T, _GEN_0, dataIndex) @[intervox_transmitter.scala 54:28 44:32]
    node _GEN_16 = mux(_T, _GEN_12, outReg) @[intervox_transmitter.scala 54:28 38:32]
    node _GEN_17 = mux(_T, _GEN_11, hasNone) @[intervox_transmitter.scala 54:28 43:32]
    io_DATA_OUT <= outReg @[intervox_transmitter.scala 46:17]
    io_NEXT <= next @[intervox_transmitter.scala 50:13]
    outReg <= mux(reset, UInt<1>("h0"), _GEN_16) @[intervox_transmitter.scala 38:{32,32}]
    next <= mux(reset, UInt<1>("h0"), next) @[intervox_transmitter.scala 39:{32,32,32}]
    stereoData <= mux(reset, UInt<64>("h0"), io_AUDIOINPUT) @[intervox_transmitter.scala 40:{32,32} 48:16]
    dspData <= bits(mux(reset, UInt<16>("h0"), io_DSPINPUT), 15, 0) @[intervox_transmitter.scala 41:{32,32} 49:13]
    bitCntr_enc <= mux(reset, UInt<8>("h0"), _GEN_14) @[intervox_transmitter.scala 42:{32,32}]
    hasNone <= mux(reset, UInt<1>("h0"), _GEN_17) @[intervox_transmitter.scala 43:{32,32}]
    dataIndex <= mux(reset, UInt<6>("h0"), _GEN_15) @[intervox_transmitter.scala 44:{32,32}]

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

    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 144:33]
    inst BFR of RWSmem @[intervox_transmitter.scala 148:33]
    inst BFR1 of RWSmem @[intervox_transmitter.scala 149:33]
    reg current_state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), current_state) @[intervox_transmitter.scala 136:34]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (UInt<1>("h0"), BiPhase_CLK_CNTR) @[intervox_transmitter.scala 138:34]
    reg DATA_OUT_REG_1B : UInt<1>, clock with :
      reset => (UInt<1>("h0"), DATA_OUT_REG_1B) @[intervox_transmitter.scala 140:34]
    reg FirstFrame : UInt<1>, clock with :
      reset => (UInt<1>("h0"), FirstFrame) @[intervox_transmitter.scala 142:34]
    reg bitCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_transmitter.scala 146:34]
    node _T = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 187:24]
    node _T_1 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 187:24]
    node _T_2 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 187:24]
    node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 197:44]
    node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 197:44]
    node _T_3 = rem(BiPhase_CLK_CNTR, UInt<2>("h2")) @[intervox_transmitter.scala 200:30]
    node _T_4 = eq(_T_3, UInt<1>("h0")) @[intervox_transmitter.scala 200:36]
    node _GEN_0 = mux(_T_4, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 200:45 201:30 172:31]
    node _T_5 = eq(BiPhase_CLK_CNTR, UInt<3>("h7")) @[intervox_transmitter.scala 204:29]
    node _GEN_1 = mux(_T_5, UInt<1>("h0"), _BiPhase_CLK_CNTR_T_1) @[intervox_transmitter.scala 197:24 204:{37,55}]
    node _T_6 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 210:30]
    node _T_7 = eq(BiPhase_CLK_CNTR, UInt<3>("h7")) @[intervox_transmitter.scala 210:58]
    node _T_8 = or(_T_6, _T_7) @[intervox_transmitter.scala 210:38]
    node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 213:28]
    node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 213:28]
    node _T_9 = eq(bitCntr, UInt<1>("h0")) @[intervox_transmitter.scala 217:22]
    node _GEN_2 = mux(_T_9, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 161:25 217:30 219:29]
    node _GEN_3 = mux(_T_9, UInt<1>("h0"), UInt<1>("h0")) @[intervox_transmitter.scala 162:25 217:30 220:29]
    node _T_10 = gt(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 223:22]
    node _T_11 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 230:28]
    node _BFR_io_dataIn_T = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 232:65]
    node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 232:65]
    node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 232:56]
    node _BFR_io_dataIn_T_3 = add(BFR.io_dataOut, _BFR_io_dataIn_T_2) @[intervox_transmitter.scala 232:49]
    node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_transmitter.scala 232:49]
    node _GEN_4 = mux(_T_11, _BFR_io_dataIn_T_4, _GEN_3) @[intervox_transmitter.scala 230:36 232:31]
    node _T_12 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 235:28]
    node _BFR_io_dataIn_T_5 = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 236:66]
    node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_transmitter.scala 236:66]
    node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 236:56]
    node _BFR_io_dataIn_T_8 = add(BFR.io_dataOut, _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 236:49]
    node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 236:49]
    node _GEN_5 = mux(_T_12, _BFR_io_dataIn_T_9, _GEN_4) @[intervox_transmitter.scala 235:36 236:31]
    node _T_13 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 244:28]
    node _BFR_io_dataIn_T_10 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 246:65]
    node _BFR_io_dataIn_T_11 = tail(_BFR_io_dataIn_T_10, 1) @[intervox_transmitter.scala 246:65]
    node _BFR_io_dataIn_T_12 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_11) @[intervox_transmitter.scala 246:56]
    node _BFR_io_dataIn_T_13 = add(BFR.io_dataOut, _BFR_io_dataIn_T_12) @[intervox_transmitter.scala 246:49]
    node _BFR_io_dataIn_T_14 = tail(_BFR_io_dataIn_T_13, 1) @[intervox_transmitter.scala 246:49]
    node _GEN_6 = mux(_T_13, _BFR_io_dataIn_T_14, _GEN_3) @[intervox_transmitter.scala 244:37 246:31]
    node _T_14 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 249:28]
    node _BFR_io_dataIn_T_15 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 250:65]
    node _BFR_io_dataIn_T_16 = tail(_BFR_io_dataIn_T_15, 1) @[intervox_transmitter.scala 250:65]
    node _BFR_io_dataIn_T_17 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_16) @[intervox_transmitter.scala 250:56]
    node _BFR_io_dataIn_T_18 = add(BFR.io_dataOut, _BFR_io_dataIn_T_17) @[intervox_transmitter.scala 250:49]
    node _BFR_io_dataIn_T_19 = tail(_BFR_io_dataIn_T_18, 1) @[intervox_transmitter.scala 250:49]
    node _GEN_7 = mux(_T_14, _BFR_io_dataIn_T_19, _GEN_6) @[intervox_transmitter.scala 249:36 250:31]
    node _GEN_8 = mux(_T_10, UInt<1>("h1"), UInt<1>("h1")) @[intervox_transmitter.scala 223:29 228:29 242:29]
    node _GEN_9 = mux(_T_10, _GEN_5, _GEN_7) @[intervox_transmitter.scala 223:29]
    node _T_15 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 254:22]
    node _GEN_10 = mux(_T_15, UInt<1>("h1"), _GEN_8) @[intervox_transmitter.scala 254:31 262:26]
    node _GEN_11 = mux(_T_15, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 165:25 254:31 258:29]
    node _GEN_12 = mux(_T_15, BFR.io_dataOut, BFR.io_dataOut) @[intervox_transmitter.scala 166:25 254:31 259:29]
    node _GEN_13 = mux(_T_15, UInt<1>("h0"), _GEN_9) @[intervox_transmitter.scala 254:31 263:26]
    node _GEN_14 = mux(_T_15, UInt<1>("h0"), _bitCntr_T_1) @[intervox_transmitter.scala 213:17 254:31 265:19]
    node _GEN_15 = mux(_T_8, _GEN_14, bitCntr) @[intervox_transmitter.scala 146:34 210:67]
    node _GEN_16 = mux(_T_8, _GEN_10, UInt<1>("h0")) @[intervox_transmitter.scala 161:25 210:67]
    node _GEN_17 = mux(_T_8, _GEN_13, UInt<1>("h0")) @[intervox_transmitter.scala 162:25 210:67]
    node _GEN_18 = mux(_T_8, _GEN_11, UInt<1>("h0")) @[intervox_transmitter.scala 165:25 210:67]
    node _GEN_19 = mux(_T_8, _GEN_12, BFR.io_dataOut) @[intervox_transmitter.scala 166:25 210:67]
    node _GEN_20 = mux(_T_2, _GEN_1, BiPhase_CLK_CNTR) @[intervox_transmitter.scala 187:24 138:34]
    node _GEN_21 = mux(_T_2, _GEN_0, UInt<1>("h0")) @[intervox_transmitter.scala 187:24 172:31]
    node _GEN_22 = mux(_T_2, _GEN_15, bitCntr) @[intervox_transmitter.scala 187:24 146:34]
    node _GEN_23 = mux(_T_2, _GEN_16, UInt<1>("h0")) @[intervox_transmitter.scala 187:24 161:25]
    node _GEN_24 = mux(_T_2, _GEN_17, UInt<1>("h0")) @[intervox_transmitter.scala 187:24 162:25]
    node _GEN_25 = mux(_T_2, _GEN_18, UInt<1>("h0")) @[intervox_transmitter.scala 187:24 165:25]
    node _GEN_26 = mux(_T_2, _GEN_19, BFR.io_dataOut) @[intervox_transmitter.scala 187:24 166:25]
    node _GEN_27 = mux(_T_1, UInt<2>("h2"), current_state) @[intervox_transmitter.scala 187:24 193:21 136:34]
    node _GEN_28 = mux(_T_1, BiPhase_CLK_CNTR, _GEN_20) @[intervox_transmitter.scala 187:24 138:34]
    node _GEN_29 = mux(_T_1, UInt<1>("h0"), _GEN_21) @[intervox_transmitter.scala 187:24 172:31]
    node _GEN_30 = mux(_T_1, bitCntr, _GEN_22) @[intervox_transmitter.scala 187:24 146:34]
    node _GEN_31 = mux(_T_1, UInt<1>("h0"), _GEN_23) @[intervox_transmitter.scala 187:24 161:25]
    node _GEN_32 = mux(_T_1, UInt<1>("h0"), _GEN_24) @[intervox_transmitter.scala 187:24 162:25]
    node _GEN_33 = mux(_T_1, UInt<1>("h0"), _GEN_25) @[intervox_transmitter.scala 187:24 165:25]
    node _GEN_34 = mux(_T_1, BFR.io_dataOut, _GEN_26) @[intervox_transmitter.scala 187:24 166:25]
    node _GEN_35 = mux(_T, UInt<2>("h2"), _GEN_27) @[intervox_transmitter.scala 187:24 190:21]
    node _GEN_36 = mux(_T, BiPhase_CLK_CNTR, _GEN_28) @[intervox_transmitter.scala 187:24 138:34]
    node _GEN_37 = mux(_T, UInt<1>("h0"), _GEN_29) @[intervox_transmitter.scala 187:24 172:31]
    node _GEN_38 = mux(_T, bitCntr, _GEN_30) @[intervox_transmitter.scala 187:24 146:34]
    node _GEN_39 = mux(_T, UInt<1>("h0"), _GEN_31) @[intervox_transmitter.scala 187:24 161:25]
    node _GEN_40 = mux(_T, UInt<1>("h0"), _GEN_32) @[intervox_transmitter.scala 187:24 162:25]
    node _GEN_41 = mux(_T, UInt<1>("h0"), _GEN_33) @[intervox_transmitter.scala 187:24 165:25]
    node _GEN_42 = mux(_T, BFR.io_dataOut, _GEN_34) @[intervox_transmitter.scala 187:24 166:25]
    io_MCLK_O <= clock @[intervox_transmitter.scala 153:25]
    io_DATA_O <= bi_phase_enc.io_DATA_OUT @[intervox_transmitter.scala 152:25]
    io_LRCLK_O <= io_LRCLK_IN @[intervox_transmitter.scala 155:25]
    io_BCLK_O <= io_BCLK_IN @[intervox_transmitter.scala 154:25]
    io_SDATA_O <= io_SDATA_IN @[intervox_transmitter.scala 156:25]
    io_NXT_FRAME <= bi_phase_enc.io_TICK @[intervox_transmitter.scala 169:25]
    current_state <= mux(reset, UInt<2>("h0"), _GEN_35) @[intervox_transmitter.scala 136:{34,34}]
    BiPhase_CLK_CNTR <= mux(reset, UInt<8>("h0"), _GEN_36) @[intervox_transmitter.scala 138:{34,34}]
    DATA_OUT_REG_1B <= mux(reset, UInt<1>("h0"), DATA_OUT_REG_1B) @[intervox_transmitter.scala 140:{34,34,34}]
    FirstFrame <= mux(reset, UInt<1>("h0"), FirstFrame) @[intervox_transmitter.scala 142:{34,34,34}]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    bi_phase_enc.io_AUDIOINPUT <= BFR1.io_dataOut @[intervox_transmitter.scala 175:31]
    bi_phase_enc.io_DSPINPUT <= UInt<64>("hfff") @[intervox_transmitter.scala 177:31]
    bi_phase_enc.io_TICK <= _GEN_37
    bitCntr <= mux(reset, UInt<8>("h0"), _GEN_38) @[intervox_transmitter.scala 146:{34,34}]
    BFR.clock <= clock
    BFR.reset <= reset
    BFR.io_enable <= UInt<1>("h1") @[intervox_transmitter.scala 159:25]
    BFR.io_write <= _GEN_39
    BFR.io_addr <= UInt<1>("h1") @[intervox_transmitter.scala 160:25]
    BFR.io_dataIn <= bits(_GEN_40, 63, 0)
    BFR1.clock <= clock
    BFR1.reset <= reset
    BFR1.io_enable <= UInt<1>("h1") @[intervox_transmitter.scala 163:25]
    BFR1.io_write <= _GEN_41
    BFR1.io_addr <= UInt<1>("h1") @[intervox_transmitter.scala 164:25]
    BFR1.io_dataIn <= _GEN_42
