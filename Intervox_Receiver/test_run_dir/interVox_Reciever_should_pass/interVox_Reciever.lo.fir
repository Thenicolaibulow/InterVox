circuit interVox_Reciever :
  module RWSmem :
    input clock : Clock
    input reset : UInt<1>
    input io_enable : UInt<1>
    input io_write : UInt<1>
    input io_addr : UInt<1>
    input io_dataIn : UInt<64>
    output io_dataOut : UInt<64>

    mem mem : @[intervox_receiver.scala 76:24]
      data-type => UInt<64>
      depth => 1
      read-latency => 1
      write-latency => 1
      readwriter => rdwrPort
      read-under-write => undefined
    node _GEN_0 = validif(io_write, io_dataIn) @[intervox_receiver.scala 82:{21,32}]
    node _GEN_1 = mux(io_write, UInt<1>("h1"), UInt<1>("h0")) @[intervox_receiver.scala 82:21 81:23 82:32]
    node _GEN_2 = validif(eq(io_write, UInt<1>("h0")), mem.rdwrPort.rdata) @[intervox_receiver.scala 82:21 83:34]
    node _GEN_3 = validif(io_enable, UInt<1>("h0")) @[intervox_receiver.scala 80:19 81:23]
    node _GEN_4 = validif(io_enable, clock) @[intervox_receiver.scala 80:19 81:23]
    node _GEN_5 = mux(io_enable, UInt<1>("h1"), UInt<1>("h0")) @[intervox_receiver.scala 80:19 81:23 76:24]
    node _GEN_6 = validif(io_enable, _GEN_1) @[intervox_receiver.scala 80:19]
    node _GEN_7 = validif(io_enable, _GEN_0) @[intervox_receiver.scala 80:19]
    node _GEN_8 = mux(io_enable, _GEN_1, UInt<1>("h0")) @[intervox_receiver.scala 80:19 76:24]
    node _GEN_9 = validif(io_enable, _GEN_2) @[intervox_receiver.scala 80:19]
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
      reset => (UInt<1>("h0"), inBufr) @[intervox_receiver.scala 12:34]
    reg inBufrPrev : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufrPrev) @[intervox_receiver.scala 13:34]
    reg trailing : UInt<1>, clock with :
      reset => (UInt<1>("h0"), trailing) @[intervox_receiver.scala 14:34]
    reg rising : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rising) @[intervox_receiver.scala 15:34]
    reg change : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change) @[intervox_receiver.scala 16:34]
    reg changed : UInt<1>, clock with :
      reset => (UInt<1>("h0"), changed) @[intervox_receiver.scala 17:34]
    node _T = eq(UInt<1>("h1"), io_INPUT) @[intervox_receiver.scala 22:21]
    node _T_1 = lt(inBufr, UInt<2>("h2")) @[intervox_receiver.scala 24:21]
    node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 26:35]
    node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 26:35]
    node _GEN_0 = mux(_T_1, _inBufr_T_1, inBufr) @[intervox_receiver.scala 24:27 26:25 12:34]
    node _GEN_1 = mux(_T_1, inBufr, inBufrPrev) @[intervox_receiver.scala 24:27 27:25 13:34]
    node _T_2 = eq(UInt<1>("h0"), io_INPUT) @[intervox_receiver.scala 22:21]
    node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 31:21]
    node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 33:35]
    node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 33:35]
    node _GEN_2 = mux(_T_3, _inBufr_T_3, inBufr) @[intervox_receiver.scala 31:27 33:25 12:34]
    node _GEN_3 = mux(_T_3, inBufr, inBufrPrev) @[intervox_receiver.scala 31:27 34:25 13:34]
    node _GEN_4 = mux(_T_2, _GEN_2, inBufr) @[intervox_receiver.scala 22:21 12:34]
    node _GEN_5 = mux(_T_2, _GEN_3, inBufrPrev) @[intervox_receiver.scala 22:21 13:34]
    node _GEN_6 = mux(_T, _GEN_0, _GEN_4) @[intervox_receiver.scala 22:21]
    node _GEN_7 = mux(_T, _GEN_1, _GEN_5) @[intervox_receiver.scala 22:21]
    node _T_4 = eq(rising, UInt<1>("h1")) @[intervox_receiver.scala 39:18]
    node _T_5 = eq(trailing, UInt<1>("h1")) @[intervox_receiver.scala 39:39]
    node _T_6 = or(_T_4, _T_5) @[intervox_receiver.scala 39:27]
    node _GEN_8 = mux(_T_6, UInt<1>("h1"), change) @[intervox_receiver.scala 39:48 40:17 16:34]
    node _T_7 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_receiver.scala 43:22]
    node _T_8 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 43:41]
    node _T_9 = and(_T_7, _T_8) @[intervox_receiver.scala 43:31]
    node _GEN_9 = mux(_T_9, UInt<1>("h0"), trailing) @[intervox_receiver.scala 43:50 44:17 14:34]
    node _GEN_10 = mux(_T_9, UInt<1>("h1"), rising) @[intervox_receiver.scala 43:50 45:17 15:34]
    node _GEN_11 = mux(_T_9, UInt<1>("h1"), _GEN_8) @[intervox_receiver.scala 43:50 46:17]
    node _T_10 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_receiver.scala 49:22]
    node _T_11 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 49:41]
    node _T_12 = and(_T_10, _T_11) @[intervox_receiver.scala 49:31]
    node _GEN_12 = mux(_T_12, UInt<1>("h1"), _GEN_9) @[intervox_receiver.scala 49:50 50:17]
    node _GEN_13 = mux(_T_12, UInt<1>("h0"), _GEN_10) @[intervox_receiver.scala 49:50 51:17]
    node _GEN_14 = mux(_T_12, UInt<1>("h1"), _GEN_11) @[intervox_receiver.scala 49:50 52:17]
    node _T_13 = eq(trailing, UInt<1>("h1")) @[intervox_receiver.scala 55:19]
    node _GEN_15 = mux(_T_13, UInt<1>("h0"), _GEN_12) @[intervox_receiver.scala 55:{27,37}]
    node _T_14 = eq(rising, UInt<1>("h1")) @[intervox_receiver.scala 56:17]
    node _GEN_16 = mux(_T_14, UInt<1>("h0"), _GEN_13) @[intervox_receiver.scala 56:{27,37}]
    node _T_15 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 58:17]
    reg change_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change_REG) @[intervox_receiver.scala 59:26]
    node _GEN_17 = mux(_T_15, change_REG, _GEN_14) @[intervox_receiver.scala 58:25 59:16]
    io_TRAIL <= trailing @[intervox_receiver.scala 63:13]
    io_RISE <= rising @[intervox_receiver.scala 64:13]
    io_CHANGE <= change @[intervox_receiver.scala 62:13]
    inBufr <= mux(reset, UInt<2>("h0"), _GEN_6) @[intervox_receiver.scala 12:{34,34}]
    inBufrPrev <= mux(reset, UInt<2>("h0"), _GEN_7) @[intervox_receiver.scala 13:{34,34}]
    trailing <= mux(reset, UInt<1>("h0"), _GEN_15) @[intervox_receiver.scala 14:{34,34}]
    rising <= mux(reset, UInt<1>("h0"), _GEN_16) @[intervox_receiver.scala 15:{34,34}]
    change <= mux(reset, UInt<1>("h0"), _GEN_17) @[intervox_receiver.scala 16:{34,34}]
    changed <= mux(reset, UInt<1>("h0"), changed) @[intervox_receiver.scala 17:{34,34,34}]
    change_REG <= UInt<1>("h0") @[intervox_receiver.scala 59:26]

  module clock_Recovery :
    input clock : Clock
    input reset : UInt<1>
    input io_DATA_IN : UInt<1>
    output io_CLK_OUT : UInt<1>
    output io_DATA_OUT : UInt<1>
    output io_DBUG : UInt<1>
    output io_DBUG1 : UInt<1>
    output io_LEDS : UInt<16>
    output io_DATAREG : UInt<64>

    inst BFR of RWSmem @[intervox_receiver.scala 98:29]
    inst DATAEDGE of edgeDetector @[intervox_receiver.scala 133:38]
    inst CLKREC_EDGE of edgeDetector @[intervox_receiver.scala 137:41]
    reg rising : UInt<2>, clock with :
      reset => (UInt<1>("h0"), rising) @[intervox_receiver.scala 107:30]
    reg trailing : UInt<2>, clock with :
      reset => (UInt<1>("h0"), trailing) @[intervox_receiver.scala 108:30]
    reg lastOne : UInt<8>, clock with :
      reset => (UInt<1>("h0"), lastOne) @[intervox_receiver.scala 109:30]
    reg overSampleCntr : UInt<4>, clock with :
      reset => (UInt<1>("h0"), overSampleCntr) @[intervox_receiver.scala 110:32]
    reg inBufr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufr) @[intervox_receiver.scala 111:30]
    reg deltaCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), deltaCntr) @[intervox_receiver.scala 112:30]
    reg bitCntr : UInt<7>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_receiver.scala 113:30]
    reg clkRec : UInt<1>, clock with :
      reset => (UInt<1>("h0"), clkRec) @[intervox_receiver.scala 114:30]
    reg change : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change) @[intervox_receiver.scala 115:30]
    reg dataOut : UInt<1>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[intervox_receiver.scala 116:30]
    reg dataReg : UInt<64>, clock with :
      reset => (UInt<1>("h0"), dataReg) @[intervox_receiver.scala 117:30]
    reg syncWord : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncWord) @[intervox_receiver.scala 118:30]
    reg zeroFlipped : UInt<1>, clock with :
      reset => (UInt<1>("h0"), zeroFlipped) @[intervox_receiver.scala 119:30]
    reg syncFlipped : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncFlipped) @[intervox_receiver.scala 120:30]
    reg syncFlipped1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncFlipped1) @[intervox_receiver.scala 121:30]
    reg syncFlipped2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncFlipped2) @[intervox_receiver.scala 122:30]
    node _deltaCntr_T = add(deltaCntr, UInt<1>("h1")) @[intervox_receiver.scala 131:31]
    node _deltaCntr_T_1 = tail(_deltaCntr_T, 1) @[intervox_receiver.scala 131:31]
    node _T = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 143:17]
    reg change_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change_REG) @[intervox_receiver.scala 145:34]
    reg change_REG_1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change_REG_1) @[intervox_receiver.scala 145:26]
    node _clkRec_T = not(clkRec) @[intervox_receiver.scala 147:28]
    node _T_1 = eq(syncWord, UInt<1>("h1")) @[intervox_receiver.scala 154:23]
    node _GEN_0 = mux(_T_1, UInt<1>("h0"), syncWord) @[intervox_receiver.scala 154:31 155:25 118:30]
    node _GEN_1 = mux(_T_1, UInt<1>("h0"), bitCntr) @[intervox_receiver.scala 154:31 156:25 113:30]
    node _GEN_2 = mux(_T_1, BFR.io_dataOut, dataReg) @[intervox_receiver.scala 154:31 157:25 117:30]
    node _GEN_3 = mux(_T_1, UInt<1>("h1"), UInt<1>("h0")) @[intervox_receiver.scala 102:27 154:31 159:28]
    node _GEN_4 = mux(_T_1, UInt<1>("h0"), UInt<1>("h0")) @[intervox_receiver.scala 103:27 154:31 160:28]
    node _GEN_5 = mux(_T, change_REG_1, DATAEDGE.io_CHANGE) @[intervox_receiver.scala 143:25 145:16 135:29]
    node _GEN_6 = mux(_T, _clkRec_T, clkRec) @[intervox_receiver.scala 143:25 147:25 114:30]
    node _GEN_7 = mux(_T, UInt<1>("h0"), _deltaCntr_T_1) @[intervox_receiver.scala 131:18 143:25 149:25]
    node _GEN_8 = mux(_T, UInt<1>("h0"), zeroFlipped) @[intervox_receiver.scala 143:25 151:25 119:30]
    node _GEN_9 = mux(_T, UInt<1>("h0"), syncFlipped) @[intervox_receiver.scala 143:25 152:25 120:30]
    node _GEN_10 = mux(_T, UInt<1>("h0"), syncFlipped1) @[intervox_receiver.scala 143:25 153:25 121:30]
    node _GEN_11 = mux(_T, _GEN_0, syncWord) @[intervox_receiver.scala 143:25 118:30]
    node _GEN_12 = mux(_T, _GEN_1, bitCntr) @[intervox_receiver.scala 143:25 113:30]
    node _GEN_13 = mux(_T, _GEN_2, dataReg) @[intervox_receiver.scala 143:25 117:30]
    node _GEN_14 = mux(_T, _GEN_3, UInt<1>("h0")) @[intervox_receiver.scala 143:25 102:27]
    node _GEN_15 = mux(_T, _GEN_4, UInt<1>("h0")) @[intervox_receiver.scala 143:25 103:27]
    node _T_2 = eq(CLKREC_EDGE.io_RISE, UInt<1>("h1")) @[intervox_receiver.scala 164:30]
    node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_receiver.scala 165:28]
    node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_receiver.scala 165:28]
    node _GEN_16 = mux(_T_2, _bitCntr_T_1, _GEN_12) @[intervox_receiver.scala 164:38 165:17]
    node _T_3 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 171:33]
    node _T_4 = tail(_T_3, 1) @[intervox_receiver.scala 171:33]
    node _T_5 = leq(deltaCntr, _T_4) @[intervox_receiver.scala 171:21]
    node _T_6 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 174:21]
    node _BFR_io_dataIn_T = sub(UInt<7>("h40"), bitCntr) @[intervox_receiver.scala 181:65]
    node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_receiver.scala 181:65]
    node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_1) @[intervox_receiver.scala 181:56]
    node _BFR_io_dataIn_T_3 = add(BFR.io_dataOut, _BFR_io_dataIn_T_2) @[intervox_receiver.scala 181:49]
    node _BFR_io_dataIn_T_4 = tail(_BFR_io_dataIn_T_3, 1) @[intervox_receiver.scala 181:49]
    node _GEN_17 = mux(_T_6, UInt<1>("h1"), dataOut) @[intervox_receiver.scala 174:29 177:21 116:30]
    node _GEN_18 = mux(_T_6, UInt<1>("h1"), _GEN_14) @[intervox_receiver.scala 174:29 180:31]
    node _GEN_19 = mux(_T_6, _BFR_io_dataIn_T_4, _GEN_15) @[intervox_receiver.scala 174:29 181:31]
    node _GEN_20 = mux(_T_5, _GEN_17, dataOut) @[intervox_receiver.scala 116:30 171:41]
    node _GEN_21 = mux(_T_5, _GEN_18, _GEN_14) @[intervox_receiver.scala 171:41]
    node _GEN_22 = mux(_T_5, _GEN_19, _GEN_15) @[intervox_receiver.scala 171:41]
    node _T_7 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 191:32]
    node _T_8 = tail(_T_7, 1) @[intervox_receiver.scala 191:32]
    node _T_9 = gt(deltaCntr, _T_8) @[intervox_receiver.scala 191:21]
    node _T_10 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 191:65]
    node _T_11 = add(_T_10, UInt<2>("h2")) @[intervox_receiver.scala 191:72]
    node _T_12 = tail(_T_11, 1) @[intervox_receiver.scala 191:72]
    node _T_13 = lt(deltaCntr, _T_12) @[intervox_receiver.scala 191:53]
    node _T_14 = and(_T_9, _T_13) @[intervox_receiver.scala 191:40]
    node _T_15 = eq(zeroFlipped, UInt<1>("h0")) @[intervox_receiver.scala 194:26]
    node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 197:23]
    node _BFR_io_dataIn_T_5 = sub(UInt<7>("h40"), bitCntr) @[intervox_receiver.scala 201:65]
    node _BFR_io_dataIn_T_6 = tail(_BFR_io_dataIn_T_5, 1) @[intervox_receiver.scala 201:65]
    node _BFR_io_dataIn_T_7 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_6) @[intervox_receiver.scala 201:56]
    node _BFR_io_dataIn_T_8 = add(BFR.io_dataOut, _BFR_io_dataIn_T_7) @[intervox_receiver.scala 201:49]
    node _BFR_io_dataIn_T_9 = tail(_BFR_io_dataIn_T_8, 1) @[intervox_receiver.scala 201:49]
    node _GEN_23 = mux(_T_15, _clkRec_T_1, _GEN_6) @[intervox_receiver.scala 194:34 197:20]
    node _GEN_24 = mux(_T_15, UInt<1>("h1"), _GEN_8) @[intervox_receiver.scala 194:34 198:25]
    node _GEN_25 = mux(_T_15, UInt<1>("h1"), _GEN_21) @[intervox_receiver.scala 194:34 200:31]
    node _GEN_26 = mux(_T_15, _BFR_io_dataIn_T_9, _GEN_22) @[intervox_receiver.scala 194:34 201:31]
    node _GEN_27 = mux(_T_14, _GEN_23, _GEN_6) @[intervox_receiver.scala 191:80]
    node _GEN_28 = mux(_T_14, _GEN_24, _GEN_8) @[intervox_receiver.scala 191:80]
    node _GEN_29 = mux(_T_14, _GEN_25, _GEN_21) @[intervox_receiver.scala 191:80]
    node _GEN_30 = mux(_T_14, _GEN_26, _GEN_22) @[intervox_receiver.scala 191:80]
    node _GEN_31 = mux(_T_14, UInt<1>("h0"), _GEN_20) @[intervox_receiver.scala 191:80 204:17]
    node _T_16 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 211:17]
    node _T_17 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 213:38]
    node _T_18 = add(_T_17, UInt<2>("h2")) @[intervox_receiver.scala 213:45]
    node _T_19 = tail(_T_18, 1) @[intervox_receiver.scala 213:45]
    node _T_20 = eq(deltaCntr, _T_19) @[intervox_receiver.scala 213:24]
    node _T_21 = eq(syncFlipped, UInt<1>("h0")) @[intervox_receiver.scala 220:30]
    node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 222:27]
    node _GEN_32 = mux(_T_21, _clkRec_T_2, _GEN_27) @[intervox_receiver.scala 220:38 222:24]
    node _GEN_33 = mux(_T_21, UInt<1>("h1"), _GEN_9) @[intervox_receiver.scala 220:38 223:29]
    node _GEN_34 = mux(_T_20, _GEN_32, _GEN_27) @[intervox_receiver.scala 213:52]
    node _GEN_35 = mux(_T_20, _GEN_33, _GEN_9) @[intervox_receiver.scala 213:52]
    node _T_22 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 226:38]
    node _T_23 = eq(deltaCntr, _T_22) @[intervox_receiver.scala 226:24]
    node _T_24 = eq(syncFlipped1, UInt<1>("h0")) @[intervox_receiver.scala 234:31]
    node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 236:27]
    node _GEN_36 = mux(_T_24, _clkRec_T_3, _GEN_34) @[intervox_receiver.scala 234:39 236:24]
    node _GEN_37 = mux(_T_24, UInt<1>("h1"), _GEN_10) @[intervox_receiver.scala 234:39 237:30]
    node _GEN_38 = mux(_T_24, UInt<1>("h0"), _GEN_16) @[intervox_receiver.scala 234:39 239:25]
    node _GEN_39 = mux(_T_23, UInt<1>("h1"), _GEN_11) @[intervox_receiver.scala 226:46 233:22]
    node _GEN_40 = mux(_T_23, _GEN_36, _GEN_34) @[intervox_receiver.scala 226:46]
    node _GEN_41 = mux(_T_23, _GEN_37, _GEN_10) @[intervox_receiver.scala 226:46]
    node _GEN_42 = mux(_T_23, _GEN_38, _GEN_16) @[intervox_receiver.scala 226:46]
    node _T_25 = mul(lastOne, UInt<3>("h4")) @[intervox_receiver.scala 242:38]
    node _T_26 = eq(deltaCntr, _T_25) @[intervox_receiver.scala 242:25]
    node _T_27 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 242:56]
    node _T_28 = and(_T_26, _T_27) @[intervox_receiver.scala 242:46]
    node _T_29 = eq(syncFlipped2, UInt<1>("h0")) @[intervox_receiver.scala 249:31]
    node _clkRec_T_4 = not(clkRec) @[intervox_receiver.scala 251:27]
    node _GEN_43 = mux(_T_29, _clkRec_T_4, _GEN_40) @[intervox_receiver.scala 249:39 251:24]
    node _GEN_44 = mux(_T_29, UInt<1>("h1"), syncFlipped2) @[intervox_receiver.scala 122:30 249:39 252:30]
    node _GEN_45 = mux(_T_28, _GEN_43, _GEN_40) @[intervox_receiver.scala 242:65]
    node _GEN_46 = mux(_T_28, _GEN_44, syncFlipped2) @[intervox_receiver.scala 122:30 242:65]
    node _GEN_47 = mux(_T_16, _GEN_45, _GEN_27) @[intervox_receiver.scala 211:25]
    node _GEN_48 = mux(_T_16, _GEN_35, _GEN_9) @[intervox_receiver.scala 211:25]
    node _GEN_49 = mux(_T_16, _GEN_39, _GEN_11) @[intervox_receiver.scala 211:25]
    node _GEN_50 = mux(_T_16, _GEN_41, _GEN_10) @[intervox_receiver.scala 211:25]
    node _GEN_51 = mux(_T_16, _GEN_42, _GEN_16) @[intervox_receiver.scala 211:25]
    node _GEN_52 = mux(_T_16, _GEN_46, syncFlipped2) @[intervox_receiver.scala 211:25 122:30]
    io_CLK_OUT <= clkRec @[intervox_receiver.scala 124:21]
    io_DATA_OUT <= dataOut @[intervox_receiver.scala 125:21]
    io_DBUG <= change @[intervox_receiver.scala 126:21]
    io_DBUG1 <= syncWord @[intervox_receiver.scala 127:21]
    io_LEDS <= pad(lastOne, 16) @[intervox_receiver.scala 128:21]
    io_DATAREG <= dataReg @[intervox_receiver.scala 129:21]
    BFR.clock <= clock
    BFR.reset <= reset
    BFR.io_enable <= UInt<1>("h1") @[intervox_receiver.scala 100:27]
    BFR.io_write <= _GEN_29
    BFR.io_addr <= UInt<1>("h1") @[intervox_receiver.scala 101:27]
    BFR.io_dataIn <= bits(_GEN_30, 63, 0)
    rising <= mux(reset, UInt<2>("h0"), rising) @[intervox_receiver.scala 107:{30,30,30}]
    trailing <= mux(reset, UInt<2>("h0"), trailing) @[intervox_receiver.scala 108:{30,30,30}]
    lastOne <= mux(reset, UInt<8>("hf"), lastOne) @[intervox_receiver.scala 109:{30,30,30}]
    overSampleCntr <= mux(reset, UInt<4>("h0"), overSampleCntr) @[intervox_receiver.scala 110:{32,32,32}]
    inBufr <= mux(reset, UInt<2>("h0"), inBufr) @[intervox_receiver.scala 111:{30,30,30}]
    deltaCntr <= mux(reset, UInt<8>("h0"), _GEN_7) @[intervox_receiver.scala 112:{30,30}]
    bitCntr <= mux(reset, UInt<7>("h0"), _GEN_51) @[intervox_receiver.scala 113:{30,30}]
    clkRec <= mux(reset, UInt<1>("h0"), _GEN_47) @[intervox_receiver.scala 114:{30,30}]
    change <= mux(reset, UInt<1>("h0"), _GEN_5) @[intervox_receiver.scala 115:{30,30}]
    dataOut <= mux(reset, UInt<1>("h0"), _GEN_31) @[intervox_receiver.scala 116:{30,30}]
    dataReg <= mux(reset, UInt<64>("h0"), _GEN_13) @[intervox_receiver.scala 117:{30,30}]
    syncWord <= mux(reset, UInt<1>("h0"), _GEN_49) @[intervox_receiver.scala 118:{30,30}]
    zeroFlipped <= mux(reset, UInt<1>("h0"), _GEN_28) @[intervox_receiver.scala 119:{30,30}]
    syncFlipped <= mux(reset, UInt<1>("h0"), _GEN_48) @[intervox_receiver.scala 120:{30,30}]
    syncFlipped1 <= mux(reset, UInt<1>("h0"), _GEN_50) @[intervox_receiver.scala 121:{30,30}]
    syncFlipped2 <= mux(reset, UInt<1>("h0"), _GEN_52) @[intervox_receiver.scala 122:{30,30}]
    DATAEDGE.clock <= clock
    DATAEDGE.reset <= reset
    DATAEDGE.io_INPUT <= io_DATA_IN @[intervox_receiver.scala 134:29]
    CLKREC_EDGE.clock <= clock
    CLKREC_EDGE.reset <= reset
    CLKREC_EDGE.io_INPUT <= io_DATA_IN @[intervox_receiver.scala 138:32]
    change_REG <= mux(reset, UInt<1>("h0"), UInt<1>("h0")) @[intervox_receiver.scala 145:{34,34,34}]
    change_REG_1 <= mux(reset, UInt<1>("h0"), change_REG) @[intervox_receiver.scala 145:{26,26,26}]

  module i2s_Transmitter :
    input clock : Clock
    input reset : UInt<1>
    input io_CLK_IN : UInt<1>
    input io_DATA_IN : UInt<64>
    input io_NEXT : UInt<1>
    output io_BCLK : UInt<1>
    output io_LRCLK : UInt<1>
    output io_SDATA : UInt<1>

    inst BCLKEDGE of edgeDetector @[intervox_receiver.scala 280:37]
    reg enable : UInt<1>, clock with :
      reset => (UInt<1>("h0"), enable) @[intervox_receiver.scala 268:26]
    reg bitCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_receiver.scala 269:26]
    reg lrclk : UInt<1>, clock with :
      reset => (UInt<1>("h0"), lrclk) @[intervox_receiver.scala 270:26]
    reg bclk : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bclk) @[intervox_receiver.scala 271:26]
    reg sdataO : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sdataO) @[intervox_receiver.scala 272:26]
    reg sdata : UInt<64>, clock with :
      reset => (UInt<1>("h0"), sdata) @[intervox_receiver.scala 273:26]
    node _T = eq(io_NEXT, UInt<1>("h1")) @[intervox_receiver.scala 283:18]
    node _GEN_0 = mux(_T, UInt<1>("h1"), enable) @[intervox_receiver.scala 283:26 284:17 268:26]
    node _GEN_1 = mux(_T, UInt<1>("h0"), bitCntr) @[intervox_receiver.scala 283:26 285:17 269:26]
    node _T_1 = geq(bitCntr, UInt<6>("h3f")) @[intervox_receiver.scala 288:18]
    node _GEN_2 = mux(_T_1, UInt<1>("h0"), _GEN_0) @[intervox_receiver.scala 288:26 289:16]
    node _GEN_3 = mux(_T_1, UInt<1>("h0"), _GEN_1) @[intervox_receiver.scala 288:26 290:17]
    node _T_2 = eq(enable, UInt<1>("h1")) @[intervox_receiver.scala 293:17]
    node _T_3 = eq(BCLKEDGE.io_RISE, UInt<1>("h1")) @[intervox_receiver.scala 295:31]
    node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_receiver.scala 297:32]
    node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_receiver.scala 297:32]
    node _T_4 = eq(bitCntr, UInt<1>("h0")) @[intervox_receiver.scala 299:26]
    node _GEN_4 = mux(_T_4, UInt<1>("h1"), lrclk) @[intervox_receiver.scala 299:34 300:23 270:26]
    node _T_5 = eq(bitCntr, UInt<5>("h1f")) @[intervox_receiver.scala 303:26]
    node _GEN_5 = mux(_T_5, UInt<1>("h0"), _GEN_4) @[intervox_receiver.scala 303:35 304:23]
    node _sdataO_T = dshr(sdata, bitCntr) @[intervox_receiver.scala 307:34]
    node _sdataO_T_1 = bits(_sdataO_T, 0, 0) @[intervox_receiver.scala 307:34]
    node _sdataO_T_2 = and(UInt<1>("h1"), _sdataO_T_1) @[intervox_receiver.scala 307:27]
    node _GEN_6 = mux(_T_3, _bitCntr_T_1, _GEN_3) @[intervox_receiver.scala 295:39 297:21]
    node _GEN_7 = mux(_T_3, _GEN_5, lrclk) @[intervox_receiver.scala 270:26 295:39]
    node _GEN_8 = mux(_T_3, _sdataO_T_2, sdataO) @[intervox_receiver.scala 295:39 307:20 272:26]
    node _GEN_9 = mux(_T_2, _GEN_6, _GEN_3) @[intervox_receiver.scala 293:25]
    node _GEN_10 = mux(_T_2, _GEN_7, lrclk) @[intervox_receiver.scala 293:25 270:26]
    node _GEN_11 = mux(_T_2, _GEN_8, sdataO) @[intervox_receiver.scala 293:25 272:26]
    io_BCLK <= io_CLK_IN @[intervox_receiver.scala 276:17]
    io_LRCLK <= lrclk @[intervox_receiver.scala 277:17]
    io_SDATA <= sdataO @[intervox_receiver.scala 278:17]
    enable <= mux(reset, UInt<1>("h0"), _GEN_2) @[intervox_receiver.scala 268:{26,26}]
    bitCntr <= mux(reset, UInt<8>("h0"), _GEN_9) @[intervox_receiver.scala 269:{26,26}]
    lrclk <= mux(reset, UInt<1>("h0"), _GEN_10) @[intervox_receiver.scala 270:{26,26}]
    bclk <= mux(reset, UInt<1>("h0"), bclk) @[intervox_receiver.scala 271:{26,26,26}]
    sdataO <= mux(reset, UInt<1>("h0"), _GEN_11) @[intervox_receiver.scala 272:{26,26}]
    sdata <= mux(reset, UInt<64>("h0"), io_DATA_IN) @[intervox_receiver.scala 273:{26,26} 275:17]
    BCLKEDGE.clock <= clock
    BCLKEDGE.reset <= reset
    BCLKEDGE.io_INPUT <= io_CLK_IN @[intervox_receiver.scala 281:31]

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    input io_INTERVOX_IN : UInt<1>
    output io_CLK_REC : UInt<1>
    output io_DATA_OUT : UInt<1>
    output io_CLK_DBUG : UInt<1>
    output io_DBUG : UInt<1>
    output io_DBUG1 : UInt<1>
    output io_LEDS : UInt<16>
    output io_BCLK : UInt<1>
    output io_LRCLK : UInt<1>
    output io_SDATA : UInt<1>

    inst clockRec of clock_Recovery @[intervox_receiver.scala 327:29]
    inst i2sTrans of i2s_Transmitter @[intervox_receiver.scala 336:29]
    io_CLK_REC <= clockRec.io_CLK_OUT @[intervox_receiver.scala 332:21]
    io_DATA_OUT <= clockRec.io_DATA_OUT @[intervox_receiver.scala 330:21]
    io_CLK_DBUG <= UInt<1>("h0") @[intervox_receiver.scala 331:21]
    io_DBUG <= clockRec.io_DBUG @[intervox_receiver.scala 334:21]
    io_DBUG1 <= clockRec.io_DBUG1 @[intervox_receiver.scala 333:21]
    io_LEDS <= clockRec.io_LEDS @[intervox_receiver.scala 329:21]
    io_BCLK <= i2sTrans.io_BCLK @[intervox_receiver.scala 340:21]
    io_LRCLK <= i2sTrans.io_LRCLK @[intervox_receiver.scala 342:21]
    io_SDATA <= i2sTrans.io_SDATA @[intervox_receiver.scala 341:21]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io_DATA_IN <= io_INTERVOX_IN @[intervox_receiver.scala 328:29]
    i2sTrans.clock <= clock
    i2sTrans.reset <= reset
    i2sTrans.io_CLK_IN <= clockRec.io_CLK_OUT @[intervox_receiver.scala 337:29]
    i2sTrans.io_DATA_IN <= clockRec.io_DATAREG @[intervox_receiver.scala 338:29]
    i2sTrans.io_NEXT <= clockRec.io_DBUG1 @[intervox_receiver.scala 339:29]
