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
    node _T_2 = eq(_T_1, UInt<1>("h1")) @[intervox_transmitter.scala 55:30]
    node _dataIndex_T = add(dataIndex, UInt<1>("h1")) @[intervox_transmitter.scala 56:36]
    node _dataIndex_T_1 = tail(_dataIndex_T, 1) @[intervox_transmitter.scala 56:36]
    node _GEN_0 = mux(_T_2, _dataIndex_T_1, dataIndex) @[intervox_transmitter.scala 55:38 56:23 44:32]
    node _T_3 = lt(bitCntr, UInt<3>("h7")) @[intervox_transmitter.scala 60:24]
    node _T_4 = lt(bitCntr, UInt<3>("h6")) @[intervox_transmitter.scala 63:26]
    node _GEN_1 = mux(_T_4, UInt<1>("h0"), UInt<1>("h1")) @[intervox_transmitter.scala 64:13 65:22 69:22]
    node _GEN_2 = mux(_T_3, UInt<1>("h0"), next) @[intervox_transmitter.scala 60:31 61:18 39:32]
    node _GEN_3 = mux(_T_3, _GEN_1, outReg) @[intervox_transmitter.scala 60:31 38:32]
    node _T_5 = gt(bitCntr, UInt<3>("h7")) @[intervox_transmitter.scala 73:25]
    node _T_6 = lt(bitCntr, UInt<7>("h7f")) @[intervox_transmitter.scala 76:26]
    node _T_7 = sub(dataIndex, UInt<2>("h3")) @[intervox_transmitter.scala 78:43]
    node _T_8 = tail(_T_7, 1) @[intervox_transmitter.scala 78:43]
    node _T_9 = dshr(stereoData, _T_8) @[intervox_transmitter.scala 78:31]
    node _T_10 = bits(_T_9, 0, 0) @[intervox_transmitter.scala 78:31]
    node _T_11 = eq(_T_10, UInt<1>("h0")) @[intervox_transmitter.scala 78:53]
    node _GEN_4 = mux(_T_11, UInt<1>("h1"), hasNone) @[intervox_transmitter.scala 78:62 80:25 43:32]
    node _GEN_5 = mux(_T_6, _GEN_4, hasNone) @[intervox_transmitter.scala 43:32 76:34]
    node _T_12 = gt(bitCntr, UInt<7>("h7f")) @[intervox_transmitter.scala 84:26]
    node _T_13 = sub(dataIndex, UInt<2>("h3")) @[intervox_transmitter.scala 86:42]
    node _T_14 = tail(_T_13, 1) @[intervox_transmitter.scala 86:42]
    node _T_15 = dshr(dspData, _T_14) @[intervox_transmitter.scala 86:30]
    node _T_16 = bits(_T_15, 0, 0) @[intervox_transmitter.scala 86:30]
    node _T_17 = eq(_T_16, UInt<1>("h0")) @[intervox_transmitter.scala 86:52]
    node _GEN_6 = mux(_T_17, UInt<1>("h1"), _GEN_5) @[intervox_transmitter.scala 86:61 88:25]
    node _GEN_7 = mux(_T_12, _GEN_6, _GEN_5) @[intervox_transmitter.scala 84:34]
    node _T_18 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 92:26]
    node _outReg_T = not(outReg) @[intervox_transmitter.scala 98:25]
    node _GEN_8 = mux(_T_18, outReg, _outReg_T) @[intervox_transmitter.scala 92:34 93:22 98:22]
    node _GEN_9 = mux(_T_18, UInt<1>("h0"), _GEN_7) @[intervox_transmitter.scala 92:34 94:23]
    node _GEN_10 = mux(_T_5, _GEN_9, hasNone) @[intervox_transmitter.scala 43:32 73:32]
    node _GEN_11 = mux(_T_5, _GEN_8, _GEN_3) @[intervox_transmitter.scala 73:32]
    node _T_19 = eq(bitCntr, UInt<8>("hff")) @[intervox_transmitter.scala 102:24]
    node _GEN_12 = mux(_T_19, UInt<1>("h0"), _bitCntr_T_1) @[intervox_transmitter.scala 102:34 103:21 54:19]
    node _GEN_13 = mux(_T_19, UInt<1>("h0"), io_AUDIOINPUT) @[intervox_transmitter.scala 102:34 104:24 48:16]
    node _GEN_14 = mux(_T_19, UInt<1>("h1"), _GEN_2) @[intervox_transmitter.scala 102:34 105:18]
    node _GEN_15 = mux(_T, _GEN_12, bitCntr) @[intervox_transmitter.scala 52:28 42:32]
    node _GEN_16 = mux(_T, _GEN_0, dataIndex) @[intervox_transmitter.scala 52:28 44:32]
    node _GEN_17 = mux(_T, _GEN_14, next) @[intervox_transmitter.scala 52:28 39:32]
    node _GEN_18 = mux(_T, _GEN_11, outReg) @[intervox_transmitter.scala 52:28 38:32]
    node _GEN_19 = mux(_T, _GEN_10, hasNone) @[intervox_transmitter.scala 52:28 43:32]
    node _GEN_20 = mux(_T, _GEN_13, io_AUDIOINPUT) @[intervox_transmitter.scala 48:16 52:28]
    io_DATA_OUT <= outReg @[intervox_transmitter.scala 46:17]
    io_NEXT <= next @[intervox_transmitter.scala 50:13]
    outReg <= mux(reset, UInt<1>("h0"), _GEN_18) @[intervox_transmitter.scala 38:{32,32}]
    next <= mux(reset, UInt<1>("h0"), _GEN_17) @[intervox_transmitter.scala 39:{32,32}]
    stereoData <= mux(reset, UInt<64>("h0"), _GEN_20) @[intervox_transmitter.scala 40:{32,32}]
    dspData <= mux(reset, UInt<16>("h0"), UInt<1>("h0")) @[intervox_transmitter.scala 41:{32,32} 49:13]
    bitCntr <= mux(reset, UInt<8>("h0"), _GEN_15) @[intervox_transmitter.scala 42:{32,32}]
    hasNone <= mux(reset, UInt<1>("h0"), _GEN_19) @[intervox_transmitter.scala 43:{32,32}]
    dataIndex <= mux(reset, UInt<6>("h0"), _GEN_16) @[intervox_transmitter.scala 44:{32,32}]

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
    input io_BCLK_IN : UInt<1>
    input io_LRCLK_IN : UInt<1>
    input io_SDATA_IN : UInt<1>
    output io_DATA_O : UInt<1>
    output io_LRCLK_O : UInt<1>
    output io_BCLK_O : UInt<1>
    output io_SDATA_O : UInt<1>
    output io_NXT_FRAME : UInt<1>

    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 134:33]
    inst BFR of RWSmem @[intervox_transmitter.scala 142:33]
    inst BFR1 of RWSmem @[intervox_transmitter.scala 143:33]
    reg current_state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), current_state) @[intervox_transmitter.scala 126:34]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (UInt<1>("h0"), BiPhase_CLK_CNTR) @[intervox_transmitter.scala 128:34]
    reg DATA_OUT_REG_1B : UInt<1>, clock with :
      reset => (UInt<1>("h0"), DATA_OUT_REG_1B) @[intervox_transmitter.scala 130:34]
    reg FirstFrame : UInt<1>, clock with :
      reset => (UInt<1>("h0"), FirstFrame) @[intervox_transmitter.scala 132:34]
    reg bitCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_transmitter.scala 136:34]
    reg LR : UInt<1>, clock with :
      reset => (UInt<1>("h0"), LR) @[intervox_transmitter.scala 137:34]
    reg tick : UInt<1>, clock with :
      reset => (UInt<1>("h0"), tick) @[intervox_transmitter.scala 138:34]
    reg PROCESSED : UInt<1>, clock with :
      reset => (UInt<1>("h0"), PROCESSED) @[intervox_transmitter.scala 139:34]
    node _T = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 179:24]
    node _T_1 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 179:24]
    node _T_2 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 179:24]
    node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 189:44]
    node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 189:44]
    node _T_3 = eq(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 191:30]
    node _T_4 = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 192:30]
    node _T_5 = or(_T_3, _T_4) @[intervox_transmitter.scala 191:38]
    node _T_6 = eq(BiPhase_CLK_CNTR, UInt<3>("h5")) @[intervox_transmitter.scala 193:30]
    node _T_7 = or(_T_5, _T_6) @[intervox_transmitter.scala 192:38]
    node _T_8 = eq(BiPhase_CLK_CNTR, UInt<3>("h7")) @[intervox_transmitter.scala 194:30]
    node _T_9 = or(_T_7, _T_8) @[intervox_transmitter.scala 193:38]
    node _GEN_0 = mux(_T_9, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 194:39 195:30 162:31]
    node _T_10 = eq(BiPhase_CLK_CNTR, UInt<3>("h7")) @[intervox_transmitter.scala 198:29]
    node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_transmitter.scala 201:28]
    node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_transmitter.scala 201:28]
    node _T_11 = gt(bitCntr, UInt<6>("h28")) @[intervox_transmitter.scala 206:22]
    node _T_12 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 209:28]
    node _BFR_io_dataIn_T = sub(bitCntr, UInt<5>("h10")) @[intervox_transmitter.scala 212:68]
    node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_transmitter.scala 212:68]
    node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_1) @[intervox_transmitter.scala 212:56]
    node _BFR_io_dataIn_T_3 = add(BFR.io_dataOut, _BFR_io_dataIn_T_2) @[intervox_transmitter.scala 212:49]
    node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_transmitter.scala 212:49]
    node _GEN_1 = mux(_T_12, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 153:25 209:37 211:31]
    node _GEN_2 = mux(_T_12, _BFR_io_dataIn_T_4, UInt<1>("h0")) @[intervox_transmitter.scala 154:25 209:37 212:31]
    node _T_13 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 215:28]
    node _BFR_io_dataIn_T_5 = sub(bitCntr, UInt<5>("h10")) @[intervox_transmitter.scala 218:68]
    node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_transmitter.scala 218:68]
    node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_6) @[intervox_transmitter.scala 218:56]
    node _BFR_io_dataIn_T_8 = add(BFR.io_dataOut, _BFR_io_dataIn_T_7) @[intervox_transmitter.scala 218:49]
    node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_transmitter.scala 218:49]
    node _GEN_3 = mux(_T_13, UInt<1>("h1"), _GEN_1) @[intervox_transmitter.scala 215:36 217:31]
    node _GEN_4 = mux(_T_13, _BFR_io_dataIn_T_9, _GEN_2) @[intervox_transmitter.scala 215:36 218:31]
    node _T_14 = eq(io_SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 221:28]
    node _BFR_io_dataIn_T_10 = dshl(UInt<1>("h0"), bitCntr) @[intervox_transmitter.scala 224:56]
    node _BFR_io_dataIn_T_11 = add(BFR.io_dataOut, _BFR_io_dataIn_T_10) @[intervox_transmitter.scala 224:49]
    node _BFR_io_dataIn_T_12 = tail(_BFR_io_dataIn_T_11, 1) @[intervox_transmitter.scala 224:49]
    node _GEN_5 = mux(_T_14, UInt<1>("h1"), UInt<1>("h0")) @[intervox_transmitter.scala 153:25 221:37 223:31]
    node _GEN_6 = mux(_T_14, _BFR_io_dataIn_T_12, UInt<1>("h0")) @[intervox_transmitter.scala 154:25 221:37 224:31]
    node _T_15 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 227:28]
    node _BFR_io_dataIn_T_13 = dshl(UInt<1>("h1"), bitCntr) @[intervox_transmitter.scala 230:56]
    node _BFR_io_dataIn_T_14 = add(BFR.io_dataOut, _BFR_io_dataIn_T_13) @[intervox_transmitter.scala 230:49]
    node _BFR_io_dataIn_T_15 = tail(_BFR_io_dataIn_T_14, 1) @[intervox_transmitter.scala 230:49]
    node _GEN_7 = mux(_T_15, UInt<1>("h1"), _GEN_5) @[intervox_transmitter.scala 227:36 229:31]
    node _GEN_8 = mux(_T_15, _BFR_io_dataIn_T_15, _GEN_6) @[intervox_transmitter.scala 227:36 230:31]
    node _GEN_9 = mux(_T_11, _GEN_3, _GEN_7) @[intervox_transmitter.scala 206:29]
    node _GEN_10 = mux(_T_11, _GEN_4, _GEN_8) @[intervox_transmitter.scala 206:29]
    node _T_16 = eq(bitCntr, UInt<6>("h3f")) @[intervox_transmitter.scala 233:22]
    node _T_17 = eq(bi_phase_enc.io_NEXT, UInt<1>("h1")) @[intervox_transmitter.scala 242:37]
    node _GEN_11 = mux(_T_17, UInt<1>("h1"), UInt<1>("h1")) @[intervox_transmitter.scala 236:29 242:45 243:29]
    node _GEN_12 = mux(_T_17, UInt<1>("h0"), BFR.io_dataOut) @[intervox_transmitter.scala 237:29 242:45 244:29]
    node _GEN_13 = mux(_T_16, _GEN_11, UInt<1>("h0")) @[intervox_transmitter.scala 157:25 233:31]
    node _GEN_14 = mux(_T_16, _GEN_12, UInt<1>("h0")) @[intervox_transmitter.scala 158:25 233:31]
    node _GEN_15 = mux(_T_16, UInt<1>("h1"), _GEN_9) @[intervox_transmitter.scala 233:31 239:29]
    node _GEN_16 = mux(_T_16, UInt<1>("h0"), _GEN_10) @[intervox_transmitter.scala 233:31 240:29]
    node _GEN_17 = mux(_T_16, UInt<1>("h0"), _bitCntr_T_1) @[intervox_transmitter.scala 201:17 233:31 246:28]
    node _GEN_18 = mux(_T_10, _GEN_17, bitCntr) @[intervox_transmitter.scala 136:34 198:37]
    node _GEN_19 = mux(_T_10, _GEN_15, UInt<1>("h0")) @[intervox_transmitter.scala 153:25 198:37]
    node _GEN_20 = mux(_T_10, _GEN_16, UInt<1>("h0")) @[intervox_transmitter.scala 154:25 198:37]
    node _GEN_21 = mux(_T_10, _GEN_13, UInt<1>("h0")) @[intervox_transmitter.scala 157:25 198:37]
    node _GEN_22 = mux(_T_10, _GEN_14, UInt<1>("h0")) @[intervox_transmitter.scala 158:25 198:37]
    node _GEN_23 = mux(_T_10, UInt<1>("h0"), _BiPhase_CLK_CNTR_T_1) @[intervox_transmitter.scala 189:24 198:37 249:26]
    node _GEN_24 = mux(_T_2, _GEN_23, BiPhase_CLK_CNTR) @[intervox_transmitter.scala 179:24 128:34]
    node _GEN_25 = mux(_T_2, _GEN_0, UInt<1>("h0")) @[intervox_transmitter.scala 179:24 162:31]
    node _GEN_26 = mux(_T_2, _GEN_18, bitCntr) @[intervox_transmitter.scala 179:24 136:34]
    node _GEN_27 = mux(_T_2, _GEN_19, UInt<1>("h0")) @[intervox_transmitter.scala 179:24 153:25]
    node _GEN_28 = mux(_T_2, _GEN_20, UInt<1>("h0")) @[intervox_transmitter.scala 179:24 154:25]
    node _GEN_29 = mux(_T_2, _GEN_21, UInt<1>("h0")) @[intervox_transmitter.scala 179:24 157:25]
    node _GEN_30 = mux(_T_2, _GEN_22, UInt<1>("h0")) @[intervox_transmitter.scala 179:24 158:25]
    node _GEN_31 = mux(_T_1, UInt<2>("h2"), current_state) @[intervox_transmitter.scala 179:24 185:21 126:34]
    node _GEN_32 = mux(_T_1, BiPhase_CLK_CNTR, _GEN_24) @[intervox_transmitter.scala 179:24 128:34]
    node _GEN_33 = mux(_T_1, UInt<1>("h0"), _GEN_25) @[intervox_transmitter.scala 179:24 162:31]
    node _GEN_34 = mux(_T_1, bitCntr, _GEN_26) @[intervox_transmitter.scala 179:24 136:34]
    node _GEN_35 = mux(_T_1, UInt<1>("h0"), _GEN_27) @[intervox_transmitter.scala 179:24 153:25]
    node _GEN_36 = mux(_T_1, UInt<1>("h0"), _GEN_28) @[intervox_transmitter.scala 179:24 154:25]
    node _GEN_37 = mux(_T_1, UInt<1>("h0"), _GEN_29) @[intervox_transmitter.scala 179:24 157:25]
    node _GEN_38 = mux(_T_1, UInt<1>("h0"), _GEN_30) @[intervox_transmitter.scala 179:24 158:25]
    node _GEN_39 = mux(_T, UInt<2>("h2"), _GEN_31) @[intervox_transmitter.scala 179:24 182:21]
    node _GEN_40 = mux(_T, BiPhase_CLK_CNTR, _GEN_32) @[intervox_transmitter.scala 179:24 128:34]
    node _GEN_41 = mux(_T, UInt<1>("h0"), _GEN_33) @[intervox_transmitter.scala 179:24 162:31]
    node _GEN_42 = mux(_T, bitCntr, _GEN_34) @[intervox_transmitter.scala 179:24 136:34]
    node _GEN_43 = mux(_T, UInt<1>("h0"), _GEN_35) @[intervox_transmitter.scala 179:24 153:25]
    node _GEN_44 = mux(_T, UInt<1>("h0"), _GEN_36) @[intervox_transmitter.scala 179:24 154:25]
    node _GEN_45 = mux(_T, UInt<1>("h0"), _GEN_37) @[intervox_transmitter.scala 179:24 157:25]
    node _GEN_46 = mux(_T, UInt<1>("h0"), _GEN_38) @[intervox_transmitter.scala 179:24 158:25]
    io_DATA_O <= DATA_OUT_REG_1B @[intervox_transmitter.scala 146:25]
    io_LRCLK_O <= io_LRCLK_IN @[intervox_transmitter.scala 149:25]
    io_BCLK_O <= io_BCLK_IN @[intervox_transmitter.scala 148:25]
    io_SDATA_O <= io_SDATA_IN @[intervox_transmitter.scala 150:25]
    io_NXT_FRAME <= bi_phase_enc.io_TICK @[intervox_transmitter.scala 159:25]
    current_state <= mux(reset, UInt<2>("h0"), _GEN_39) @[intervox_transmitter.scala 126:{34,34}]
    BiPhase_CLK_CNTR <= mux(reset, UInt<8>("h0"), _GEN_40) @[intervox_transmitter.scala 128:{34,34}]
    DATA_OUT_REG_1B <= mux(reset, UInt<1>("h0"), bi_phase_enc.io_DATA_OUT) @[intervox_transmitter.scala 130:{34,34} 166:19]
    FirstFrame <= mux(reset, UInt<1>("h0"), FirstFrame) @[intervox_transmitter.scala 132:{34,34,34}]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    bi_phase_enc.io_AUDIOINPUT <= BFR1.io_dataOut @[intervox_transmitter.scala 163:31]
    bi_phase_enc.io_DSPINPUT <= UInt<64>("h0") @[intervox_transmitter.scala 164:31]
    bi_phase_enc.io_TICK <= _GEN_41
    bitCntr <= mux(reset, UInt<8>("h0"), _GEN_42) @[intervox_transmitter.scala 136:{34,34}]
    LR <= mux(reset, UInt<1>("h0"), LR) @[intervox_transmitter.scala 137:{34,34,34}]
    tick <= mux(reset, UInt<1>("h0"), tick) @[intervox_transmitter.scala 138:{34,34,34}]
    PROCESSED <= mux(reset, UInt<1>("h0"), PROCESSED) @[intervox_transmitter.scala 139:{34,34,34}]
    BFR.clock <= clock
    BFR.reset <= reset
    BFR.io_enable <= UInt<1>("h1") @[intervox_transmitter.scala 152:25]
    BFR.io_write <= _GEN_43
    BFR.io_addr <= UInt<1>("h1") @[intervox_transmitter.scala 151:25]
    BFR.io_dataIn <= bits(_GEN_44, 63, 0)
    BFR1.clock <= clock
    BFR1.reset <= reset
    BFR1.io_enable <= UInt<1>("h1") @[intervox_transmitter.scala 156:25]
    BFR1.io_write <= _GEN_45
    BFR1.io_addr <= UInt<1>("h1") @[intervox_transmitter.scala 155:25]
    BFR1.io_dataIn <= _GEN_46
