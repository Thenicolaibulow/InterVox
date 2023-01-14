circuit interVox_Encoder :
  module bi_phase_encoder :
    input clock : Clock
    input reset : UInt<1>
    output io_DATA_OUT : UInt<1>
    input io_AUDIOINPUT : UInt<64>
    input io_DSPINPUT : UInt<64>
    input io_ENA : UInt<1>
    input io_CLK : UInt<1>
    input io_TRIG : UInt<1>

    reg outReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), outReg) @[intervox_transmitter.scala 39:32]
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
      reset => (UInt<1>("h0"), ndexR) @[intervox_transmitter.scala 51:32]
    node _T = eq(io_ENA, UInt<1>("h1")) @[intervox_transmitter.scala 53:17]
    node _T_1 = eq(io_CLK, UInt<1>("h1")) @[intervox_transmitter.scala 57:19]
    node _T_2 = eq(bitCntr_enc, UInt<2>("h3")) @[intervox_transmitter.scala 66:28]
    node _outReg_T = not(outReg) @[intervox_transmitter.scala 67:23]
    node _GEN_0 = mux(_T_2, _outReg_T, outReg) @[intervox_transmitter.scala 66:36 67:20 39:32]
    node _T_3 = eq(bitCntr_enc, UInt<3>("h4")) @[intervox_transmitter.scala 70:28]
    node _outReg_T_1 = not(outReg) @[intervox_transmitter.scala 71:23]
    node _GEN_1 = mux(_T_3, _outReg_T_1, _GEN_0) @[intervox_transmitter.scala 70:36 71:20]
    node _GEN_2 = mux(_T_3, UInt<1>("h0"), hasNone) @[intervox_transmitter.scala 70:36 73:21 43:32]
    node _T_4 = geq(bitCntr_enc, UInt<3>("h5")) @[intervox_transmitter.scala 82:29]
    node _ndexR_T = not(ndexR) @[intervox_transmitter.scala 85:22]
    node _T_5 = eq(ndexR, UInt<1>("h0")) @[intervox_transmitter.scala 86:24]
    node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 88:38]
    node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 88:38]
    node _GEN_3 = mux(_T_5, _dataIndex_T_1, dataIndex) @[intervox_transmitter.scala 86:32 88:25 44:32]
    node _T_6 = leq(bitCntr_enc, UInt<6>("h35")) @[intervox_transmitter.scala 95:30]
    node _T_7 = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 97:50]
    node _T_8 = tail(_T_7, 1) @[intervox_transmitter.scala 97:50]
    node _T_9 = sub(UInt<7>("h40"), _T_8) @[intervox_transmitter.scala 97:37]
    node _T_10 = tail(_T_9, 1) @[intervox_transmitter.scala 97:37]
    node _T_11 = dshr(stereoData, _T_10) @[intervox_transmitter.scala 97:31]
    node _T_12 = bits(_T_11, 0, 0) @[intervox_transmitter.scala 97:31]
    node _T_13 = eq(_T_12, UInt<1>("h0")) @[intervox_transmitter.scala 97:59]
    node _GEN_4 = mux(_T_13, UInt<1>("h1"), _GEN_2) @[intervox_transmitter.scala 97:68 99:25]
    node _GEN_5 = mux(_T_6, _GEN_4, _GEN_2) @[intervox_transmitter.scala 95:38]
    node _T_14 = gt(bitCntr_enc, UInt<6>("h35")) @[intervox_transmitter.scala 107:31]
    node _T_15 = leq(bitCntr_enc, UInt<7>("h65")) @[intervox_transmitter.scala 107:54]
    node _T_16 = and(_T_14, _T_15) @[intervox_transmitter.scala 107:39]
    node _T_17 = sub(dataIndex, UInt<5>("h17")) @[intervox_transmitter.scala 109:51]
    node _T_18 = tail(_T_17, 1) @[intervox_transmitter.scala 109:51]
    node _T_19 = sub(UInt<7>("h40"), _T_18) @[intervox_transmitter.scala 109:38]
    node _T_20 = tail(_T_19, 1) @[intervox_transmitter.scala 109:38]
    node _T_21 = dshr(stereoData, _T_20) @[intervox_transmitter.scala 109:31]
    node _T_22 = bits(_T_21, 0, 0) @[intervox_transmitter.scala 109:31]
    node _T_23 = eq(_T_22, UInt<1>("h0")) @[intervox_transmitter.scala 109:62]
    node _GEN_6 = mux(_T_23, UInt<1>("h1"), _GEN_5) @[intervox_transmitter.scala 109:71 110:25]
    node _GEN_7 = mux(_T_16, _GEN_6, _GEN_5) @[intervox_transmitter.scala 107:64]
    node _T_24 = gt(bitCntr_enc, UInt<7>("h65")) @[intervox_transmitter.scala 119:31]
    node _T_25 = lt(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 119:55]
    node _T_26 = and(_T_24, _T_25) @[intervox_transmitter.scala 119:40]
    node _GEN_8 = mux(_T_26, UInt<1>("h1"), _GEN_7) @[intervox_transmitter.scala 119:64 123:23]
    node _T_27 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 130:26]
    node _outReg_T_2 = not(outReg) @[intervox_transmitter.scala 137:27]
    node _GEN_9 = mux(_T_27, outReg, _outReg_T_2) @[intervox_transmitter.scala 130:34 132:22 137:24]
    node _GEN_10 = mux(_T_27, UInt<1>("h0"), _GEN_8) @[intervox_transmitter.scala 130:34 133:23]
    node _GEN_11 = mux(_T_4, _ndexR_T, ndexR) @[intervox_transmitter.scala 82:37 85:19 51:32]
    node _GEN_12 = mux(_T_4, _GEN_3, dataIndex) @[intervox_transmitter.scala 44:32 82:37]
    node _GEN_13 = mux(_T_4, _GEN_10, _GEN_2) @[intervox_transmitter.scala 82:37]
    node _GEN_14 = mux(_T_4, _GEN_9, _GEN_1) @[intervox_transmitter.scala 82:37]
    node _bitCntr_enc_T = add(bitCntr_enc, UInt<1>("h1")) @[intervox_transmitter.scala 141:38]
    node _bitCntr_enc_T_1 = tail(_bitCntr_enc_T, 1) @[intervox_transmitter.scala 141:38]
    node _T_28 = eq(bitCntr_enc, UInt<7>("h7f")) @[intervox_transmitter.scala 144:28]
    node _GEN_15 = mux(_T_28, UInt<1>("h0"), _bitCntr_enc_T_1) @[intervox_transmitter.scala 141:23 144:38 145:25]
    node _GEN_16 = mux(_T_28, UInt<1>("h0"), _GEN_12) @[intervox_transmitter.scala 144:38 146:23]
    node _GEN_17 = mux(_T_1, _GEN_14, outReg) @[intervox_transmitter.scala 57:27 39:32]
    node _GEN_18 = mux(_T_1, _GEN_13, hasNone) @[intervox_transmitter.scala 57:27 43:32]
    node _GEN_19 = mux(_T_1, _GEN_11, ndexR) @[intervox_transmitter.scala 57:27 51:32]
    node _GEN_20 = mux(_T_1, _GEN_16, dataIndex) @[intervox_transmitter.scala 57:27 44:32]
    node _GEN_21 = mux(_T_1, _GEN_15, bitCntr_enc) @[intervox_transmitter.scala 57:27 42:32]
    node _GEN_22 = mux(_T, _GEN_17, outReg) @[intervox_transmitter.scala 53:25 39:32]
    node _GEN_23 = mux(_T, _GEN_18, hasNone) @[intervox_transmitter.scala 53:25 43:32]
    node _GEN_24 = mux(_T, _GEN_19, ndexR) @[intervox_transmitter.scala 53:25 51:32]
    node _GEN_25 = mux(_T, _GEN_20, dataIndex) @[intervox_transmitter.scala 53:25 44:32]
    node _GEN_26 = mux(_T, _GEN_21, bitCntr_enc) @[intervox_transmitter.scala 53:25 42:32]
    io_DATA_OUT <= outReg @[intervox_transmitter.scala 46:17]
    outReg <= mux(reset, UInt<1>("h0"), _GEN_22) @[intervox_transmitter.scala 39:{32,32}]
    stereoData <= mux(reset, UInt<64>("h0"), io_AUDIOINPUT) @[intervox_transmitter.scala 40:{32,32} 48:17]
    dspData <= bits(mux(reset, UInt<16>("h0"), io_DSPINPUT), 15, 0) @[intervox_transmitter.scala 41:{32,32} 49:17]
    bitCntr_enc <= mux(reset, UInt<8>("h0"), _GEN_26) @[intervox_transmitter.scala 42:{32,32}]
    hasNone <= mux(reset, UInt<1>("h0"), _GEN_23) @[intervox_transmitter.scala 43:{32,32}]
    dataIndex <= mux(reset, UInt<6>("h0"), _GEN_25) @[intervox_transmitter.scala 44:{32,32}]
    ndexR <= mux(reset, UInt<1>("h0"), _GEN_24) @[intervox_transmitter.scala 51:{32,32}]

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

  module edgeDetector :
    input clock : Clock
    input reset : UInt<1>
    input io_INPUT : UInt<1>
    output io_TRAIL : UInt<1>
    output io_RISE : UInt<1>
    output io_CHANGE : UInt<1>

    reg inBufr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufr) @[intervox_transmitter.scala 160:34]
    reg inBufrPrev : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufrPrev) @[intervox_transmitter.scala 161:34]
    reg trailing : UInt<1>, clock with :
      reset => (UInt<1>("h0"), trailing) @[intervox_transmitter.scala 162:34]
    reg rising : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rising) @[intervox_transmitter.scala 163:34]
    reg change : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change) @[intervox_transmitter.scala 164:34]
    reg changed : UInt<1>, clock with :
      reset => (UInt<1>("h0"), changed) @[intervox_transmitter.scala 165:34]
    node _T = eq(UInt<1>("h1"), io_INPUT) @[intervox_transmitter.scala 170:21]
    node _T_1 = lt(inBufr, UInt<2>("h2")) @[intervox_transmitter.scala 172:21]
    node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 174:35]
    node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_transmitter.scala 174:35]
    node _GEN_0 = mux(_T_1, _inBufr_T_1, inBufr) @[intervox_transmitter.scala 172:27 174:25 160:34]
    node _GEN_1 = mux(_T_1, inBufr, inBufrPrev) @[intervox_transmitter.scala 172:27 175:25 161:34]
    node _T_2 = eq(UInt<1>("h0"), io_INPUT) @[intervox_transmitter.scala 170:21]
    node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_transmitter.scala 179:21]
    node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 181:35]
    node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_transmitter.scala 181:35]
    node _GEN_2 = mux(_T_3, _inBufr_T_3, inBufr) @[intervox_transmitter.scala 179:27 181:25 160:34]
    node _GEN_3 = mux(_T_3, inBufr, inBufrPrev) @[intervox_transmitter.scala 179:27 182:25 161:34]
    node _GEN_4 = mux(_T_2, _GEN_2, inBufr) @[intervox_transmitter.scala 170:21 160:34]
    node _GEN_5 = mux(_T_2, _GEN_3, inBufrPrev) @[intervox_transmitter.scala 170:21 161:34]
    node _GEN_6 = mux(_T, _GEN_0, _GEN_4) @[intervox_transmitter.scala 170:21]
    node _GEN_7 = mux(_T, _GEN_1, _GEN_5) @[intervox_transmitter.scala 170:21]
    node _T_4 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 187:18]
    node _T_5 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 187:39]
    node _T_6 = or(_T_4, _T_5) @[intervox_transmitter.scala 187:27]
    node _GEN_8 = mux(_T_6, UInt<1>("h1"), change) @[intervox_transmitter.scala 187:48 188:17 164:34]
    node _T_7 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_transmitter.scala 191:22]
    node _T_8 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 191:41]
    node _T_9 = and(_T_7, _T_8) @[intervox_transmitter.scala 191:31]
    node _GEN_9 = mux(_T_9, UInt<1>("h0"), trailing) @[intervox_transmitter.scala 191:50 192:17 162:34]
    node _GEN_10 = mux(_T_9, UInt<1>("h1"), rising) @[intervox_transmitter.scala 191:50 193:17 163:34]
    node _GEN_11 = mux(_T_9, UInt<1>("h1"), _GEN_8) @[intervox_transmitter.scala 191:50 194:17]
    node _T_10 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_transmitter.scala 197:22]
    node _T_11 = eq(inBufr, UInt<1>("h1")) @[intervox_transmitter.scala 197:41]
    node _T_12 = and(_T_10, _T_11) @[intervox_transmitter.scala 197:31]
    node _GEN_12 = mux(_T_12, UInt<1>("h1"), _GEN_9) @[intervox_transmitter.scala 197:50 198:17]
    node _GEN_13 = mux(_T_12, UInt<1>("h0"), _GEN_10) @[intervox_transmitter.scala 197:50 199:17]
    node _GEN_14 = mux(_T_12, UInt<1>("h1"), _GEN_11) @[intervox_transmitter.scala 197:50 200:17]
    node _T_13 = eq(trailing, UInt<1>("h1")) @[intervox_transmitter.scala 203:19]
    node _GEN_15 = mux(_T_13, UInt<1>("h0"), _GEN_12) @[intervox_transmitter.scala 203:{27,37}]
    node _T_14 = eq(rising, UInt<1>("h1")) @[intervox_transmitter.scala 204:17]
    node _GEN_16 = mux(_T_14, UInt<1>("h0"), _GEN_13) @[intervox_transmitter.scala 204:{27,37}]
    node _T_15 = eq(change, UInt<1>("h1")) @[intervox_transmitter.scala 206:17]
    reg change_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change_REG) @[intervox_transmitter.scala 207:26]
    node _GEN_17 = mux(_T_15, change_REG, _GEN_14) @[intervox_transmitter.scala 206:25 207:16]
    io_TRAIL <= trailing @[intervox_transmitter.scala 211:13]
    io_RISE <= rising @[intervox_transmitter.scala 212:13]
    io_CHANGE <= change @[intervox_transmitter.scala 210:13]
    inBufr <= mux(reset, UInt<2>("h0"), _GEN_6) @[intervox_transmitter.scala 160:{34,34}]
    inBufrPrev <= mux(reset, UInt<2>("h0"), _GEN_7) @[intervox_transmitter.scala 161:{34,34}]
    trailing <= mux(reset, UInt<1>("h0"), _GEN_15) @[intervox_transmitter.scala 162:{34,34}]
    rising <= mux(reset, UInt<1>("h0"), _GEN_16) @[intervox_transmitter.scala 163:{34,34}]
    change <= mux(reset, UInt<1>("h0"), _GEN_17) @[intervox_transmitter.scala 164:{34,34}]
    changed <= mux(reset, UInt<1>("h0"), changed) @[intervox_transmitter.scala 165:{34,34,34}]
    change_REG <= UInt<1>("h0") @[intervox_transmitter.scala 207:26]

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
    input io_SW : UInt<16>

    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 245:33]
    inst BFR of RWSmem @[intervox_transmitter.scala 251:33]
    inst BFR1 of RWSmem @[intervox_transmitter.scala 252:33]
    inst LREDGE of edgeDetector @[intervox_transmitter.scala 254:33]
    inst BCLKEDGE of edgeDetector @[intervox_transmitter.scala 256:33]
    reg current_state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), current_state) @[intervox_transmitter.scala 231:34]
    reg syncing : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncing) @[intervox_transmitter.scala 233:34]
    reg synced : UInt<1>, clock with :
      reset => (UInt<1>("h0"), synced) @[intervox_transmitter.scala 234:34]
    reg clkCntr1 : UInt<4>, clock with :
      reset => (UInt<1>("h0"), clkCntr1) @[intervox_transmitter.scala 238:35]
    reg fuckyou : UInt<1>, clock with :
      reset => (UInt<1>("h0"), fuckyou) @[intervox_transmitter.scala 239:35]
    reg bclkR : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bclkR) @[intervox_transmitter.scala 243:34]
    reg encoderClk : UInt<1>, clock with :
      reset => (UInt<1>("h0"), encoderClk) @[intervox_transmitter.scala 247:34]
    reg bitCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_transmitter.scala 249:34]
    node _T = eq(synced, UInt<1>("h0")) @[intervox_transmitter.scala 302:15]
    node _T_1 = eq(LREDGE.io_TRAIL, UInt<1>("h1")) @[intervox_transmitter.scala 304:26]
    node _GEN_0 = mux(_T_1, UInt<1>("h1"), syncing) @[intervox_transmitter.scala 304:34 305:15 233:34]
    node _T_2 = eq(syncing, UInt<1>("h1")) @[intervox_transmitter.scala 307:19]
    node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 308:30]
    node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 308:30]
    node _T_3 = eq(bitCntr, UInt<7>("h7c")) @[intervox_transmitter.scala 310:20]
    node _GEN_1 = mux(_T_3, UInt<1>("h1"), synced) @[intervox_transmitter.scala 310:30 311:19 234:34]
    node _GEN_2 = mux(_T_3, UInt<1>("h0"), _bitCntr_T_1) @[intervox_transmitter.scala 308:19 310:30 312:19]
    node _GEN_3 = mux(_T_2, _GEN_2, bitCntr) @[intervox_transmitter.scala 307:27 249:34]
    node _GEN_4 = mux(_T_2, _GEN_1, synced) @[intervox_transmitter.scala 307:27 234:34]
    node _GEN_5 = mux(_T, _GEN_0, syncing) @[intervox_transmitter.scala 302:23 233:34]
    node _GEN_6 = mux(_T, _GEN_3, bitCntr) @[intervox_transmitter.scala 302:23 249:34]
    node _GEN_7 = mux(_T, _GEN_4, synced) @[intervox_transmitter.scala 302:23 234:34]
    node _T_4 = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 324:24]
    node _T_5 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 324:24]
    node _T_6 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 324:24]
    node _T_7 = eq(synced, UInt<1>("h1")) @[intervox_transmitter.scala 336:19]
    node _encoderClk_T = not(encoderClk) @[intervox_transmitter.scala 346:23]
    node _clkCntr1_T = add(clkCntr1, UInt<1>("h1")) @[intervox_transmitter.scala 348:30]
    node _clkCntr1_T_1 = tail(_clkCntr1_T, 1) @[intervox_transmitter.scala 348:30]
    node _T_8 = eq(clkCntr1, UInt<2>("h3")) @[intervox_transmitter.scala 349:23]
    node _GEN_8 = mux(_T_8, UInt<1>("h0"), _clkCntr1_T_1) @[intervox_transmitter.scala 348:18 349:{31,41}]
    node _T_9 = eq(clkCntr1, UInt<1>("h1")) @[intervox_transmitter.scala 351:23]
    node _bitCntr_T_2 = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 354:30]
    node _bitCntr_T_3 = tail(_bitCntr_T_2, 1) @[intervox_transmitter.scala 354:30]
    node _T_10 = eq(bitCntr, UInt<1>("h0")) @[intervox_transmitter.scala 358:24]
    node _GEN_9 = mux(_T_10, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 269:25 358:32 360:31]
    node _GEN_10 = mux(_T_10, UInt<1>("h0"), UInt<1>("h0")) @[intervox_transmitter.scala 270:25 358:32 361:31]
    node _T_11 = gt(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 365:24]
    node _T_12 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 372:30]
    node _BFR_io_dataIn_T = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 374:67]
    node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 374:67]
    node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 374:58]
    node _BFR_io_dataIn_T_3 = add(BFR.io_dataOut, _BFR_io_dataIn_T_2) @[intervox_transmitter.scala 374:51]
    node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_transmitter.scala 374:51]
    node _GEN_11 = mux(_T_12, _BFR_io_dataIn_T_4, _GEN_10) @[intervox_transmitter.scala 372:38 374:33]
    node _T_13 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 377:30]
    node _BFR_io_dataIn_T_5 = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 378:68]
    node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_transmitter.scala 378:68]
    node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 378:58]
    node _BFR_io_dataIn_T_8 = add(BFR.io_dataOut, _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 378:51]
    node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 378:51]
    node _GEN_12 = mux(_T_13, _BFR_io_dataIn_T_9, _GEN_11) @[intervox_transmitter.scala 377:38 378:33]
    node _T_14 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 386:30]
    node _BFR_io_dataIn_T_10 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 388:67]
    node _BFR_io_dataIn_T_11 = tail(_BFR_io_dataIn_T_10, 1) @[intervox_transmitter.scala 388:67]
    node _BFR_io_dataIn_T_12 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_11) @[intervox_transmitter.scala 388:58]
    node _BFR_io_dataIn_T_13 = add(BFR.io_dataOut, _BFR_io_dataIn_T_12) @[intervox_transmitter.scala 388:51]
    node _BFR_io_dataIn_T_14 = tail(_BFR_io_dataIn_T_13, 1) @[intervox_transmitter.scala 388:51]
    node _GEN_13 = mux(_T_14, _BFR_io_dataIn_T_14, _GEN_10) @[intervox_transmitter.scala 386:39 388:33]
    node _T_15 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 391:30]
    node _BFR_io_dataIn_T_15 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 392:67]
    node _BFR_io_dataIn_T_16 = tail(_BFR_io_dataIn_T_15, 1) @[intervox_transmitter.scala 392:67]
    node _BFR_io_dataIn_T_17 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_16) @[intervox_transmitter.scala 392:58]
    node _BFR_io_dataIn_T_18 = add(BFR.io_dataOut, _BFR_io_dataIn_T_17) @[intervox_transmitter.scala 392:51]
    node _BFR_io_dataIn_T_19 = tail(_BFR_io_dataIn_T_18, 1) @[intervox_transmitter.scala 392:51]
    node _GEN_14 = mux(_T_15, _BFR_io_dataIn_T_19, _GEN_13) @[intervox_transmitter.scala 391:38 392:33]
    node _GEN_15 = mux(_T_11, UInt<1>("h1"), UInt<1>("h1")) @[intervox_transmitter.scala 365:31 370:31 384:31]
    node _GEN_16 = mux(_T_11, _GEN_12, _GEN_14) @[intervox_transmitter.scala 365:31]
    node _T_16 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 397:24]
    node _GEN_17 = mux(_T_16, UInt<1>("h1"), _GEN_15) @[intervox_transmitter.scala 397:33 405:28]
    node _GEN_18 = mux(_T_16, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 273:25 397:33 401:31]
    node _GEN_19 = mux(_T_16, BFR.io_dataOut, BFR.io_dataOut) @[intervox_transmitter.scala 274:25 397:33 402:31]
    node _GEN_20 = mux(_T_16, UInt<1>("h0"), _GEN_16) @[intervox_transmitter.scala 397:33 406:28]
    node _GEN_21 = mux(_T_16, UInt<1>("h0"), _bitCntr_T_3) @[intervox_transmitter.scala 354:19 397:33 408:21]
    node _GEN_22 = mux(_T_9, _GEN_21, _GEN_6) @[intervox_transmitter.scala 351:31]
    node _GEN_23 = mux(_T_9, _GEN_17, UInt<1>("h0")) @[intervox_transmitter.scala 269:25 351:31]
    node _GEN_24 = mux(_T_9, _GEN_20, UInt<1>("h0")) @[intervox_transmitter.scala 270:25 351:31]
    node _GEN_25 = mux(_T_9, _GEN_18, UInt<1>("h0")) @[intervox_transmitter.scala 273:25 351:31]
    node _GEN_26 = mux(_T_9, _GEN_19, BFR.io_dataOut) @[intervox_transmitter.scala 274:25 351:31]
    node _GEN_27 = mux(_T_7, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 336:27 343:29 280:31]
    node _GEN_28 = mux(_T_7, _encoderClk_T, encoderClk) @[intervox_transmitter.scala 336:27 346:20 247:34]
    node _GEN_29 = mux(_T_7, _GEN_8, clkCntr1) @[intervox_transmitter.scala 336:27 238:35]
    node _GEN_30 = mux(_T_7, _GEN_22, _GEN_6) @[intervox_transmitter.scala 336:27]
    node _GEN_31 = mux(_T_7, _GEN_23, UInt<1>("h0")) @[intervox_transmitter.scala 269:25 336:27]
    node _GEN_32 = mux(_T_7, _GEN_24, UInt<1>("h0")) @[intervox_transmitter.scala 270:25 336:27]
    node _GEN_33 = mux(_T_7, _GEN_25, UInt<1>("h0")) @[intervox_transmitter.scala 273:25 336:27]
    node _GEN_34 = mux(_T_7, _GEN_26, BFR.io_dataOut) @[intervox_transmitter.scala 274:25 336:27]
    node _GEN_35 = mux(_T_6, _GEN_27, UInt<1>("h0")) @[intervox_transmitter.scala 324:24 280:31]
    node _GEN_36 = mux(_T_6, _GEN_28, encoderClk) @[intervox_transmitter.scala 324:24 247:34]
    node _GEN_37 = mux(_T_6, _GEN_29, clkCntr1) @[intervox_transmitter.scala 324:24 238:35]
    node _GEN_38 = mux(_T_6, _GEN_30, _GEN_6) @[intervox_transmitter.scala 324:24]
    node _GEN_39 = mux(_T_6, _GEN_31, UInt<1>("h0")) @[intervox_transmitter.scala 324:24 269:25]
    node _GEN_40 = mux(_T_6, _GEN_32, UInt<1>("h0")) @[intervox_transmitter.scala 324:24 270:25]
    node _GEN_41 = mux(_T_6, _GEN_33, UInt<1>("h0")) @[intervox_transmitter.scala 324:24 273:25]
    node _GEN_42 = mux(_T_6, _GEN_34, BFR.io_dataOut) @[intervox_transmitter.scala 324:24 274:25]
    node _GEN_43 = mux(_T_5, UInt<2>("h2"), current_state) @[intervox_transmitter.scala 324:24 332:21 231:34]
    node _GEN_44 = mux(_T_5, UInt<1>("h0"), _GEN_35) @[intervox_transmitter.scala 324:24 280:31]
    node _GEN_45 = mux(_T_5, encoderClk, _GEN_36) @[intervox_transmitter.scala 324:24 247:34]
    node _GEN_46 = mux(_T_5, clkCntr1, _GEN_37) @[intervox_transmitter.scala 324:24 238:35]
    node _GEN_47 = mux(_T_5, _GEN_6, _GEN_38) @[intervox_transmitter.scala 324:24]
    node _GEN_48 = mux(_T_5, UInt<1>("h0"), _GEN_39) @[intervox_transmitter.scala 324:24 269:25]
    node _GEN_49 = mux(_T_5, UInt<1>("h0"), _GEN_40) @[intervox_transmitter.scala 324:24 270:25]
    node _GEN_50 = mux(_T_5, UInt<1>("h0"), _GEN_41) @[intervox_transmitter.scala 324:24 273:25]
    node _GEN_51 = mux(_T_5, BFR.io_dataOut, _GEN_42) @[intervox_transmitter.scala 324:24 274:25]
    node _GEN_52 = mux(_T_4, UInt<2>("h2"), _GEN_43) @[intervox_transmitter.scala 324:24 328:21]
    node _GEN_53 = mux(_T_4, UInt<1>("h0"), _GEN_44) @[intervox_transmitter.scala 324:24 280:31]
    node _GEN_54 = mux(_T_4, encoderClk, _GEN_45) @[intervox_transmitter.scala 324:24 247:34]
    node _GEN_55 = mux(_T_4, clkCntr1, _GEN_46) @[intervox_transmitter.scala 324:24 238:35]
    node _GEN_56 = mux(_T_4, _GEN_6, _GEN_47) @[intervox_transmitter.scala 324:24]
    node _GEN_57 = mux(_T_4, UInt<1>("h0"), _GEN_48) @[intervox_transmitter.scala 324:24 269:25]
    node _GEN_58 = mux(_T_4, UInt<1>("h0"), _GEN_49) @[intervox_transmitter.scala 324:24 270:25]
    node _GEN_59 = mux(_T_4, UInt<1>("h0"), _GEN_50) @[intervox_transmitter.scala 324:24 273:25]
    node _GEN_60 = mux(_T_4, BFR.io_dataOut, _GEN_51) @[intervox_transmitter.scala 324:24 274:25]
    io_MCLK_O <= clock @[intervox_transmitter.scala 261:25]
    io_DATA_O <= bi_phase_enc.io_DATA_OUT @[intervox_transmitter.scala 260:25]
    io_LRCLK_O <= io_LRCLK_IN @[intervox_transmitter.scala 263:25]
    io_BCLK_O <= io_BCLK_IN @[intervox_transmitter.scala 262:25]
    io_SDATA_O <= io_SDATA_IN @[intervox_transmitter.scala 264:25]
    io_NXT_FRAME <= bi_phase_enc.io_TRIG @[intervox_transmitter.scala 277:31]
    current_state <= mux(reset, UInt<2>("h0"), _GEN_52) @[intervox_transmitter.scala 231:{34,34}]
    syncing <= mux(reset, UInt<1>("h0"), _GEN_5) @[intervox_transmitter.scala 233:{34,34}]
    synced <= mux(reset, UInt<1>("h0"), _GEN_7) @[intervox_transmitter.scala 234:{34,34}]
    clkCntr1 <= mux(reset, UInt<4>("h0"), _GEN_55) @[intervox_transmitter.scala 238:{35,35}]
    fuckyou <= mux(reset, UInt<1>("h0"), fuckyou) @[intervox_transmitter.scala 239:{35,35,35}]
    bclkR <= mux(reset, UInt<1>("h1"), bclkR) @[intervox_transmitter.scala 243:{34,34,34}]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    bi_phase_enc.io_AUDIOINPUT <= BFR1.io_dataOut @[intervox_transmitter.scala 283:31]
    bi_phase_enc.io_DSPINPUT <= UInt<64>("h0") @[intervox_transmitter.scala 285:31]
    bi_phase_enc.io_ENA <= _GEN_53
    bi_phase_enc.io_CLK <= encoderClk @[intervox_transmitter.scala 279:31]
    bi_phase_enc.io_TRIG <= BCLKEDGE.io_CHANGE @[intervox_transmitter.scala 281:31]
    encoderClk <= mux(reset, UInt<1>("h0"), _GEN_54) @[intervox_transmitter.scala 247:{34,34}]
    bitCntr <= mux(reset, UInt<8>("h0"), _GEN_56) @[intervox_transmitter.scala 249:{34,34}]
    BFR.clock <= clock
    BFR.reset <= reset
    BFR.io_enable <= UInt<1>("h1") @[intervox_transmitter.scala 267:25]
    BFR.io_write <= _GEN_57
    BFR.io_addr <= UInt<1>("h1") @[intervox_transmitter.scala 268:25]
    BFR.io_dataIn <= bits(_GEN_58, 63, 0)
    BFR1.clock <= clock
    BFR1.reset <= reset
    BFR1.io_enable <= UInt<1>("h1") @[intervox_transmitter.scala 271:25]
    BFR1.io_write <= _GEN_59
    BFR1.io_addr <= UInt<1>("h1") @[intervox_transmitter.scala 272:25]
    BFR1.io_dataIn <= _GEN_60
    LREDGE.clock <= clock
    LREDGE.reset <= reset
    LREDGE.io_INPUT <= io_LRCLK_IN @[intervox_transmitter.scala 255:25]
    BCLKEDGE.clock <= clock
    BCLKEDGE.reset <= reset
    BCLKEDGE.io_INPUT <= io_BCLK_IN @[intervox_transmitter.scala 257:25]
