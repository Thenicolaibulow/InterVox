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
    reg bitCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_transmitter.scala 42:32]
    reg hasNone : UInt<1>, clock with :
      reset => (UInt<1>("h0"), hasNone) @[intervox_transmitter.scala 43:32]
    reg dataIndex : UInt<6>, clock with :
      reset => (UInt<1>("h0"), dataIndex) @[intervox_transmitter.scala 44:32]
    node _T = eq(io_TICK, UInt<1>("h1")) @[intervox_transmitter.scala 52:20]
    node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 54:30]
    node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 54:30]
    node _T_1 = rem(bitCntr, UInt<2>("h2")) @[intervox_transmitter.scala 55:24]
    node _T_2 = eq(_T_1, UInt<1>("h0")) @[intervox_transmitter.scala 55:30]
    node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 56:36]
    node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 56:36]
    node _GEN_0 = mux(_T_2, _dataIndex_T_1, dataIndex) @[intervox_transmitter.scala 55:38 56:23 44:32]
    node _T_3 = lt(bitCntr, UInt<3>("h7")) @[intervox_transmitter.scala 60:24]
    node _T_4 = lt(bitCntr, UInt<3>("h6")) @[intervox_transmitter.scala 63:26]
    node _GEN_1 = mux(_T_4, UInt<1>("h0"), UInt<1>("h1")) @[intervox_transmitter.scala 64:13 65:22 69:22]
    node _GEN_2 = mux(_T_3, UInt<1>("h0"), next) @[intervox_transmitter.scala 60:31 61:18 39:32]
    node _GEN_3 = mux(_T_3, _GEN_1, outReg) @[intervox_transmitter.scala 60:31 38:32]
    node _T_5 = gt(bitCntr, UInt<3>("h7")) @[intervox_transmitter.scala 73:25]
    node _T_6 = lt(bitCntr, UInt<6>("h30")) @[intervox_transmitter.scala 76:26]
    node _T_7 = sub(dataIndex, UInt<3>("h4")) @[intervox_transmitter.scala 78:50]
    node _T_8 = tail(_T_7, 1) @[intervox_transmitter.scala 78:50]
    node _T_9 = sub(UInt<6>("h30"), _T_8) @[intervox_transmitter.scala 78:37]
    node _T_10 = tail(_T_9, 1) @[intervox_transmitter.scala 78:37]
    node _T_11 = dshr(stereoData, _T_10) @[intervox_transmitter.scala 78:31]
    node _T_12 = bits(_T_11, 0, 0) @[intervox_transmitter.scala 78:31]
    node _T_13 = eq(_T_12, UInt<1>("h0")) @[intervox_transmitter.scala 78:60]
    node _GEN_4 = mux(_T_13, UInt<1>("h1"), hasNone) @[intervox_transmitter.scala 78:69 80:25 43:32]
    node _GEN_5 = mux(_T_6, _GEN_4, hasNone) @[intervox_transmitter.scala 43:32 76:33]
    node _T_14 = geq(bitCntr, UInt<6>("h30")) @[intervox_transmitter.scala 83:27]
    node _T_15 = lt(bitCntr, UInt<7>("h60")) @[intervox_transmitter.scala 83:47]
    node _T_16 = and(_T_14, _T_15) @[intervox_transmitter.scala 83:36]
    node _T_17 = sub(UInt<6>("h30"), dataIndex) @[intervox_transmitter.scala 85:38]
    node _T_18 = tail(_T_17, 1) @[intervox_transmitter.scala 85:38]
    node _T_19 = sub(_T_18, UInt<5>("h18")) @[intervox_transmitter.scala 85:50]
    node _T_20 = tail(_T_19, 1) @[intervox_transmitter.scala 85:50]
    node _T_21 = dshr(stereoData, _T_20) @[intervox_transmitter.scala 85:31]
    node _T_22 = bits(_T_21, 0, 0) @[intervox_transmitter.scala 85:31]
    node _T_23 = eq(_T_22, UInt<1>("h0")) @[intervox_transmitter.scala 85:61]
    node _GEN_6 = mux(_T_23, UInt<1>("h1"), _GEN_5) @[intervox_transmitter.scala 85:70 87:25]
    node _GEN_7 = mux(_T_16, _GEN_6, _GEN_5) @[intervox_transmitter.scala 83:55]
    node _T_24 = geq(bitCntr, UInt<7>("h60")) @[intervox_transmitter.scala 91:27]
    node _T_25 = lt(bitCntr, UInt<7>("h7f")) @[intervox_transmitter.scala 91:46]
    node _T_26 = and(_T_24, _T_25) @[intervox_transmitter.scala 91:35]
    node _T_27 = sub(dataIndex, UInt<3>("h4")) @[intervox_transmitter.scala 93:42]
    node _T_28 = tail(_T_27, 1) @[intervox_transmitter.scala 93:42]
    node _T_29 = dshr(dspData, _T_28) @[intervox_transmitter.scala 93:30]
    node _T_30 = bits(_T_29, 0, 0) @[intervox_transmitter.scala 93:30]
    node _T_31 = eq(_T_30, UInt<1>("h0")) @[intervox_transmitter.scala 93:52]
    node _GEN_8 = mux(_T_31, UInt<1>("h1"), _GEN_7) @[intervox_transmitter.scala 93:61 95:25]
    node _GEN_9 = mux(_T_26, _GEN_8, _GEN_7) @[intervox_transmitter.scala 91:56]
    node _T_32 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 99:26]
    node _outReg_T = not(outReg) @[intervox_transmitter.scala 105:25]
    node _GEN_10 = mux(_T_32, outReg, _outReg_T) @[intervox_transmitter.scala 100:22 105:22 99:34]
    node _GEN_11 = mux(_T_32, UInt<1>("h0"), _GEN_9) @[intervox_transmitter.scala 101:23 99:34]
    node _GEN_12 = mux(_T_5, _GEN_11, hasNone) @[intervox_transmitter.scala 43:32 73:32]
    node _GEN_13 = mux(_T_5, _GEN_10, _GEN_3) @[intervox_transmitter.scala 73:32]
    node _T_33 = eq(bitCntr, UInt<7>("h7f")) @[intervox_transmitter.scala 109:24]
    node _GEN_14 = mux(_T_33, UInt<1>("h0"), _bitCntr_T_1) @[intervox_transmitter.scala 109:34 110:21 54:19]
    node _GEN_15 = mux(_T_33, UInt<1>("h0"), io_AUDIOINPUT) @[intervox_transmitter.scala 109:34 111:24 48:16]
    node _GEN_16 = mux(_T_33, UInt<1>("h1"), _GEN_2) @[intervox_transmitter.scala 109:34 112:18]
    node _GEN_17 = mux(_T, _GEN_14, bitCntr) @[intervox_transmitter.scala 52:28 42:32]
    node _GEN_18 = mux(_T, _GEN_0, dataIndex) @[intervox_transmitter.scala 52:28 44:32]
    node _GEN_19 = mux(_T, _GEN_16, next) @[intervox_transmitter.scala 52:28 39:32]
    node _GEN_20 = mux(_T, _GEN_13, outReg) @[intervox_transmitter.scala 52:28 38:32]
    node _GEN_21 = mux(_T, _GEN_12, hasNone) @[intervox_transmitter.scala 52:28 43:32]
    node _GEN_22 = mux(_T, _GEN_15, io_AUDIOINPUT) @[intervox_transmitter.scala 48:16 52:28]
    io_DATA_OUT <= outReg @[intervox_transmitter.scala 46:17]
    io_NEXT <= next @[intervox_transmitter.scala 50:13]
    outReg <= mux(reset, UInt<1>("h0"), _GEN_20) @[intervox_transmitter.scala 38:{32,32}]
    next <= mux(reset, UInt<1>("h0"), _GEN_19) @[intervox_transmitter.scala 39:{32,32}]
    stereoData <= mux(reset, UInt<64>("h0"), _GEN_22) @[intervox_transmitter.scala 40:{32,32}]
    dspData <= mux(reset, UInt<16>("h0"), UInt<1>("h0")) @[intervox_transmitter.scala 41:{32,32} 49:13]
    bitCntr <= mux(reset, UInt<8>("h0"), _GEN_17) @[intervox_transmitter.scala 42:{32,32}]
    hasNone <= mux(reset, UInt<1>("h0"), _GEN_21) @[intervox_transmitter.scala 43:{32,32}]
    dataIndex <= mux(reset, UInt<6>("h0"), _GEN_18) @[intervox_transmitter.scala 44:{32,32}]

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
    input io_MCLK_IN : UInt<1>
    output io_MCLK_O : UInt<1>
    input io_BCLK_IN : UInt<1>
    input io_LRCLK_IN : UInt<1>
    input io_SDATA_IN : UInt<1>
    output io_DATA_O : UInt<1>
    output io_LRCLK_O : UInt<1>
    output io_BCLK_O : UInt<1>
    output io_SDATA_O : UInt<1>
    output io_NXT_FRAME : UInt<1>

    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 141:33]
    inst BFR of RWSmem @[intervox_transmitter.scala 149:33]
    inst BFR1 of RWSmem @[intervox_transmitter.scala 150:34]
    reg current_state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), current_state) @[intervox_transmitter.scala 133:34]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (UInt<1>("h0"), BiPhase_CLK_CNTR) @[intervox_transmitter.scala 135:34]
    reg DATA_OUT_REG_1B : UInt<1>, clock with :
      reset => (UInt<1>("h0"), DATA_OUT_REG_1B) @[intervox_transmitter.scala 137:34]
    reg FirstFrame : UInt<1>, clock with :
      reset => (UInt<1>("h0"), FirstFrame) @[intervox_transmitter.scala 139:34]
    reg bitCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_transmitter.scala 143:34]
    reg LR : UInt<1>, clock with :
      reset => (UInt<1>("h0"), LR) @[intervox_transmitter.scala 144:34]
    reg tick : UInt<1>, clock with :
      reset => (UInt<1>("h0"), tick) @[intervox_transmitter.scala 145:34]
    reg PROCESSED : UInt<1>, clock with :
      reset => (UInt<1>("h0"), PROCESSED) @[intervox_transmitter.scala 146:34]
    reg tmpAudio : UInt<32>, clock with :
      reset => (UInt<1>("h0"), tmpAudio) @[intervox_transmitter.scala 147:34]
    node _T = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 188:26]
    node _T_1 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 188:26]
    node _T_2 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 188:26]
    node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 198:46]
    node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 198:46]
    node _T_3 = rem(BiPhase_CLK_CNTR, UInt<2>("h2")) @[intervox_transmitter.scala 201:31]
    node _T_4 = eq(_T_3, UInt<1>("h1")) @[intervox_transmitter.scala 201:37]
    node _GEN_0 = mux(_T_4, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 170:31 201:45 202:32]
    node _T_5 = eq(BiPhase_CLK_CNTR, UInt<3>("h7")) @[intervox_transmitter.scala 205:31]
    node _GEN_1 = mux(_T_5, UInt<1>("h0"), _BiPhase_CLK_CNTR_T_1) @[intervox_transmitter.scala 198:26 205:{39,57}]
    node _T_6 = rem(BiPhase_CLK_CNTR, UInt<3>("h4")) @[intervox_transmitter.scala 207:31]
    node _T_7 = eq(_T_6, UInt<1>("h1")) @[intervox_transmitter.scala 207:37]
    node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 210:30]
    node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 210:30]
    node _T_8 = eq(bitCntr, UInt<1>("h0")) @[intervox_transmitter.scala 214:24]
    node _GEN_2 = mux(_T_8, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 161:25 214:32 216:31]
    node _GEN_3 = mux(_T_8, UInt<1>("h0"), UInt<1>("h0")) @[intervox_transmitter.scala 162:25 214:32 217:31]
    node _T_9 = gt(bitCntr, UInt<5>("h1f")) @[intervox_transmitter.scala 221:24]
    node _T_10 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 227:30]
    node _BFR_io_dataIn_T = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 229:67]
    node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 229:67]
    node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 229:58]
    node _BFR_io_dataIn_T_3 = add(BFR.io_dataOut, _BFR_io_dataIn_T_2) @[intervox_transmitter.scala 229:51]
    node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_transmitter.scala 229:51]
    node _GEN_4 = mux(_T_10, _BFR_io_dataIn_T_4, _GEN_3) @[intervox_transmitter.scala 227:38 229:33]
    node _T_11 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 232:30]
    node _BFR_io_dataIn_T_5 = sub(UInt<7>("h48"), bitCntr) @[intervox_transmitter.scala 233:68]
    node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_transmitter.scala 233:68]
    node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 233:58]
    node _BFR_io_dataIn_T_8 = add(BFR.io_dataOut, _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 233:51]
    node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 233:51]
    node _GEN_5 = mux(_T_11, _BFR_io_dataIn_T_9, _GEN_4) @[intervox_transmitter.scala 232:38 233:33]
    node _T_12 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 240:30]
    node _BFR_io_dataIn_T_10 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 242:67]
    node _BFR_io_dataIn_T_11 = tail(_BFR_io_dataIn_T_10, 1) @[intervox_transmitter.scala 242:67]
    node _BFR_io_dataIn_T_12 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_11) @[intervox_transmitter.scala 242:58]
    node _BFR_io_dataIn_T_13 = add(BFR.io_dataOut, _BFR_io_dataIn_T_12) @[intervox_transmitter.scala 242:51]
    node _BFR_io_dataIn_T_14 = tail(_BFR_io_dataIn_T_13, 1) @[intervox_transmitter.scala 242:51]
    node _GEN_6 = mux(_T_12, _BFR_io_dataIn_T_14, _GEN_3) @[intervox_transmitter.scala 240:39 242:33]
    node _T_13 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 245:30]
    node _BFR_io_dataIn_T_15 = sub(UInt<7>("h40"), bitCntr) @[intervox_transmitter.scala 246:67]
    node _BFR_io_dataIn_T_16 = tail(_BFR_io_dataIn_T_15, 1) @[intervox_transmitter.scala 246:67]
    node _BFR_io_dataIn_T_17 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_16) @[intervox_transmitter.scala 246:58]
    node _BFR_io_dataIn_T_18 = add(BFR.io_dataOut, _BFR_io_dataIn_T_17) @[intervox_transmitter.scala 246:51]
    node _BFR_io_dataIn_T_19 = tail(_BFR_io_dataIn_T_18, 1) @[intervox_transmitter.scala 246:51]
    node _GEN_7 = mux(_T_13, _BFR_io_dataIn_T_19, _GEN_6) @[intervox_transmitter.scala 245:38 246:33]
    node _GEN_8 = mux(_T_9, UInt<1>("h1"), UInt<1>("h1")) @[intervox_transmitter.scala 221:31 225:31 238:31]
    node _GEN_9 = mux(_T_9, _GEN_5, _GEN_7) @[intervox_transmitter.scala 221:31]
    node _T_14 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 250:24]
    node _GEN_10 = mux(_T_14, UInt<1>("h1"), _GEN_8) @[intervox_transmitter.scala 250:33 258:28]
    node _GEN_11 = mux(_T_14, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 165:25 250:33 254:31]
    node _GEN_12 = mux(_T_14, BFR.io_dataOut, BFR.io_dataOut) @[intervox_transmitter.scala 166:25 250:33 255:31]
    node _GEN_13 = mux(_T_14, UInt<1>("h0"), _GEN_9) @[intervox_transmitter.scala 250:33 259:28]
    node _GEN_14 = mux(_T_14, UInt<1>("h0"), _bitCntr_T_1) @[intervox_transmitter.scala 210:19 250:33 261:21]
    node _GEN_15 = mux(_T_7, _GEN_14, bitCntr) @[intervox_transmitter.scala 143:34 207:45]
    node _GEN_16 = mux(_T_7, _GEN_10, UInt<1>("h0")) @[intervox_transmitter.scala 161:25 207:45]
    node _GEN_17 = mux(_T_7, _GEN_13, UInt<1>("h0")) @[intervox_transmitter.scala 162:25 207:45]
    node _GEN_18 = mux(_T_7, _GEN_11, UInt<1>("h0")) @[intervox_transmitter.scala 165:25 207:45]
    node _GEN_19 = mux(_T_7, _GEN_12, BFR.io_dataOut) @[intervox_transmitter.scala 166:25 207:45]
    node _GEN_20 = mux(_T_2, _GEN_1, BiPhase_CLK_CNTR) @[intervox_transmitter.scala 188:26 135:34]
    node _GEN_21 = mux(_T_2, _GEN_0, UInt<1>("h0")) @[intervox_transmitter.scala 188:26 170:31]
    node _GEN_22 = mux(_T_2, _GEN_15, bitCntr) @[intervox_transmitter.scala 188:26 143:34]
    node _GEN_23 = mux(_T_2, _GEN_16, UInt<1>("h0")) @[intervox_transmitter.scala 161:25 188:26]
    node _GEN_24 = mux(_T_2, _GEN_17, UInt<1>("h0")) @[intervox_transmitter.scala 162:25 188:26]
    node _GEN_25 = mux(_T_2, _GEN_18, UInt<1>("h0")) @[intervox_transmitter.scala 165:25 188:26]
    node _GEN_26 = mux(_T_2, _GEN_19, BFR.io_dataOut) @[intervox_transmitter.scala 166:25 188:26]
    node _GEN_27 = mux(_T_1, UInt<2>("h2"), current_state) @[intervox_transmitter.scala 188:26 194:23 133:34]
    node _GEN_28 = mux(_T_1, BiPhase_CLK_CNTR, _GEN_20) @[intervox_transmitter.scala 188:26 135:34]
    node _GEN_29 = mux(_T_1, UInt<1>("h0"), _GEN_21) @[intervox_transmitter.scala 188:26 170:31]
    node _GEN_30 = mux(_T_1, bitCntr, _GEN_22) @[intervox_transmitter.scala 188:26 143:34]
    node _GEN_31 = mux(_T_1, UInt<1>("h0"), _GEN_23) @[intervox_transmitter.scala 161:25 188:26]
    node _GEN_32 = mux(_T_1, UInt<1>("h0"), _GEN_24) @[intervox_transmitter.scala 162:25 188:26]
    node _GEN_33 = mux(_T_1, UInt<1>("h0"), _GEN_25) @[intervox_transmitter.scala 165:25 188:26]
    node _GEN_34 = mux(_T_1, BFR.io_dataOut, _GEN_26) @[intervox_transmitter.scala 166:25 188:26]
    node _GEN_35 = mux(_T, UInt<2>("h2"), _GEN_27) @[intervox_transmitter.scala 188:26 191:23]
    node _GEN_36 = mux(_T, BiPhase_CLK_CNTR, _GEN_28) @[intervox_transmitter.scala 188:26 135:34]
    node _GEN_37 = mux(_T, UInt<1>("h0"), _GEN_29) @[intervox_transmitter.scala 188:26 170:31]
    node _GEN_38 = mux(_T, bitCntr, _GEN_30) @[intervox_transmitter.scala 188:26 143:34]
    node _GEN_39 = mux(_T, UInt<1>("h0"), _GEN_31) @[intervox_transmitter.scala 161:25 188:26]
    node _GEN_40 = mux(_T, UInt<1>("h0"), _GEN_32) @[intervox_transmitter.scala 162:25 188:26]
    node _GEN_41 = mux(_T, UInt<1>("h0"), _GEN_33) @[intervox_transmitter.scala 165:25 188:26]
    node _GEN_42 = mux(_T, BFR.io_dataOut, _GEN_34) @[intervox_transmitter.scala 166:25 188:26]
    io_MCLK_O <= io_MCLK_IN @[intervox_transmitter.scala 154:25]
    io_DATA_O <= DATA_OUT_REG_1B @[intervox_transmitter.scala 153:25]
    io_LRCLK_O <= io_LRCLK_IN @[intervox_transmitter.scala 156:25]
    io_BCLK_O <= io_BCLK_IN @[intervox_transmitter.scala 155:25]
    io_SDATA_O <= io_SDATA_IN @[intervox_transmitter.scala 157:25]
    io_NXT_FRAME <= bi_phase_enc.io_TICK @[intervox_transmitter.scala 168:25]
    current_state <= mux(reset, UInt<2>("h0"), _GEN_35) @[intervox_transmitter.scala 133:{34,34}]
    BiPhase_CLK_CNTR <= mux(reset, UInt<8>("h0"), _GEN_36) @[intervox_transmitter.scala 135:{34,34}]
    DATA_OUT_REG_1B <= mux(reset, UInt<1>("h0"), bi_phase_enc.io_DATA_OUT) @[intervox_transmitter.scala 137:{34,34} 175:19]
    FirstFrame <= mux(reset, UInt<1>("h0"), FirstFrame) @[intervox_transmitter.scala 139:{34,34,34}]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    bi_phase_enc.io_AUDIOINPUT <= BFR1.io_dataOut @[intervox_transmitter.scala 172:31]
    bi_phase_enc.io_DSPINPUT <= UInt<64>("h0") @[intervox_transmitter.scala 173:31]
    bi_phase_enc.io_TICK <= _GEN_37
    bitCntr <= mux(reset, UInt<8>("h0"), _GEN_38) @[intervox_transmitter.scala 143:{34,34}]
    LR <= mux(reset, UInt<1>("h0"), LR) @[intervox_transmitter.scala 144:{34,34,34}]
    tick <= mux(reset, UInt<1>("h0"), tick) @[intervox_transmitter.scala 145:{34,34,34}]
    PROCESSED <= mux(reset, UInt<1>("h0"), PROCESSED) @[intervox_transmitter.scala 146:{34,34,34}]
    tmpAudio <= mux(reset, UInt<32>("h0"), tmpAudio) @[intervox_transmitter.scala 147:{34,34,34}]
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
