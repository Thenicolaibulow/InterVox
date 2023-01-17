circuit interVox_Receiver :
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
    node _T_4 = bits(inBufr, 0, 0) @[intervox_receiver.scala 39:17]
    node _T_5 = bits(inBufr, 1, 1) @[intervox_receiver.scala 39:31]
    node _T_6 = xor(_T_4, _T_5) @[intervox_receiver.scala 39:22]
    node _GEN_8 = mux(_T_6, UInt<1>("h1"), change) @[intervox_receiver.scala 39:36 40:17 16:34]
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
    output io_LED : UInt<16>
    input io_SW : UInt<16>
    output io_DATAREG : UInt<64>
    input io_BTN_C : UInt<1>

    inst BFR of RWSmem @[intervox_receiver.scala 101:29]
    inst BFR1 of RWSmem @[intervox_receiver.scala 106:30]
    inst DATAEDGE of edgeDetector @[intervox_receiver.scala 140:38]
    reg rising : UInt<2>, clock with :
      reset => (UInt<1>("h0"), rising) @[intervox_receiver.scala 114:30]
    reg trailing : UInt<2>, clock with :
      reset => (UInt<1>("h0"), trailing) @[intervox_receiver.scala 115:30]
    reg lastOne : UInt<8>, clock with :
      reset => (UInt<1>("h0"), lastOne) @[intervox_receiver.scala 116:30]
    reg leds : UInt<16>, clock with :
      reset => (UInt<1>("h0"), leds) @[intervox_receiver.scala 117:30]
    reg overSampleCntr : UInt<4>, clock with :
      reset => (UInt<1>("h0"), overSampleCntr) @[intervox_receiver.scala 118:32]
    reg inBufr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufr) @[intervox_receiver.scala 119:30]
    reg deltaCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), deltaCntr) @[intervox_receiver.scala 120:30]
    reg bitCntr : UInt<7>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_receiver.scala 121:30]
    reg clkRec : UInt<1>, clock with :
      reset => (UInt<1>("h0"), clkRec) @[intervox_receiver.scala 122:30]
    reg change : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change) @[intervox_receiver.scala 123:30]
    reg dataOut : UInt<1>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[intervox_receiver.scala 124:30]
    reg syncWord : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncWord) @[intervox_receiver.scala 125:30]
    reg zeroFlipped : UInt<1>, clock with :
      reset => (UInt<1>("h0"), zeroFlipped) @[intervox_receiver.scala 126:30]
    reg syncFlipped : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncFlipped) @[intervox_receiver.scala 127:30]
    reg syncFlipped1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncFlipped1) @[intervox_receiver.scala 128:30]
    reg syncFlipped2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncFlipped2) @[intervox_receiver.scala 129:30]
    node _deltaCntr_T = add(deltaCntr, UInt<1>("h1")) @[intervox_receiver.scala 138:31]
    node _deltaCntr_T_1 = tail(_deltaCntr_T, 1) @[intervox_receiver.scala 138:31]
    node _T = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 147:17]
    reg change_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change_REG) @[intervox_receiver.scala 149:34]
    reg change_REG_1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change_REG_1) @[intervox_receiver.scala 149:26]
    node _clkRec_T = not(clkRec) @[intervox_receiver.scala 151:28]
    node _GEN_0 = mux(_T, change_REG_1, DATAEDGE.io_CHANGE) @[intervox_receiver.scala 147:25 149:16 142:29]
    node _GEN_1 = mux(_T, _clkRec_T, clkRec) @[intervox_receiver.scala 147:25 151:25 122:30]
    node _GEN_2 = mux(_T, UInt<1>("h0"), _deltaCntr_T_1) @[intervox_receiver.scala 138:18 147:25 153:25]
    node _GEN_3 = mux(_T, UInt<1>("h0"), zeroFlipped) @[intervox_receiver.scala 147:25 155:25 126:30]
    node _GEN_4 = mux(_T, UInt<1>("h0"), syncFlipped) @[intervox_receiver.scala 147:25 156:25 127:30]
    node _GEN_5 = mux(_T, UInt<1>("h0"), syncFlipped1) @[intervox_receiver.scala 147:25 157:25 128:30]
    node _T_1 = eq(syncWord, UInt<1>("h1")) @[intervox_receiver.scala 160:19]
    node _GEN_6 = mux(_T_1, UInt<1>("h0"), syncWord) @[intervox_receiver.scala 160:27 161:21 125:30]
    node _GEN_7 = mux(_T_1, UInt<1>("h0"), bitCntr) @[intervox_receiver.scala 160:27 162:21 121:30]
    node _GEN_8 = mux(_T_1, UInt<1>("h1"), UInt<1>("h0")) @[intervox_receiver.scala 160:27 164:24 104:27]
    node _GEN_9 = mux(_T_1, UInt<1>("h0"), UInt<1>("h0")) @[intervox_receiver.scala 160:27 165:24 105:27]
    node _T_2 = eq(clkRec, UInt<1>("h1")) @[intervox_receiver.scala 168:17]
    node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_receiver.scala 169:28]
    node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_receiver.scala 169:28]
    node _GEN_10 = mux(_T_2, _bitCntr_T_1, _GEN_7) @[intervox_receiver.scala 168:25 169:17]
    node _T_3 = add(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 175:33]
    node _T_4 = tail(_T_3, 1) @[intervox_receiver.scala 175:33]
    node _T_5 = leq(deltaCntr, _T_4) @[intervox_receiver.scala 175:21]
    node _T_6 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 178:21]
    node _BFR_io_dataIn_T = sub(UInt<6>("h3f"), bitCntr) @[intervox_receiver.scala 185:65]
    node _BFR_io_dataIn_T_1 = tail(_BFR_io_dataIn_T, 1) @[intervox_receiver.scala 185:65]
    node _BFR_io_dataIn_T_2 = dshl(UInt<1>("h1"), _BFR_io_dataIn_T_1) @[intervox_receiver.scala 185:56]
    node _BFR_io_dataIn_T_3 = or(BFR.io_dataOut, _BFR_io_dataIn_T_2) @[intervox_receiver.scala 185:49]
    node _GEN_11 = mux(_T_6, UInt<1>("h1"), dataOut) @[intervox_receiver.scala 178:29 181:21 124:30]
    node _GEN_12 = mux(_T_6, UInt<1>("h1"), _GEN_8) @[intervox_receiver.scala 178:29 184:31]
    node _GEN_13 = mux(_T_6, _BFR_io_dataIn_T_3, _GEN_9) @[intervox_receiver.scala 178:29 185:31]
    node _GEN_14 = mux(_T_5, _GEN_11, dataOut) @[intervox_receiver.scala 124:30 175:41]
    node _GEN_15 = mux(_T_5, _GEN_12, _GEN_8) @[intervox_receiver.scala 175:41]
    node _GEN_16 = mux(_T_5, _GEN_13, _GEN_9) @[intervox_receiver.scala 175:41]
    node _T_7 = add(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 195:32]
    node _T_8 = tail(_T_7, 1) @[intervox_receiver.scala 195:32]
    node _T_9 = gt(deltaCntr, _T_8) @[intervox_receiver.scala 195:21]
    node _T_10 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 195:65]
    node _T_11 = lt(deltaCntr, _T_10) @[intervox_receiver.scala 195:53]
    node _T_12 = and(_T_9, _T_11) @[intervox_receiver.scala 195:40]
    node _T_13 = eq(zeroFlipped, UInt<1>("h0")) @[intervox_receiver.scala 198:26]
    node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 201:23]
    node _BFR_io_dataIn_T_4 = sub(UInt<6>("h3f"), bitCntr) @[intervox_receiver.scala 205:65]
    node _BFR_io_dataIn_T_5 = tail(_BFR_io_dataIn_T_4, 1) @[intervox_receiver.scala 205:65]
    node _BFR_io_dataIn_T_6 = dshl(UInt<1>("h0"), _BFR_io_dataIn_T_5) @[intervox_receiver.scala 205:56]
    node _BFR_io_dataIn_T_7 = or(BFR.io_dataOut, _BFR_io_dataIn_T_6) @[intervox_receiver.scala 205:49]
    node _GEN_17 = mux(_T_13, _clkRec_T_1, _GEN_1) @[intervox_receiver.scala 198:34 201:20]
    node _GEN_18 = mux(_T_13, UInt<1>("h1"), _GEN_3) @[intervox_receiver.scala 198:34 202:25]
    node _GEN_19 = mux(_T_13, UInt<1>("h1"), _GEN_15) @[intervox_receiver.scala 198:34 204:31]
    node _GEN_20 = mux(_T_13, _BFR_io_dataIn_T_7, _GEN_16) @[intervox_receiver.scala 198:34 205:31]
    node _GEN_21 = mux(_T_13, UInt<1>("h0"), _GEN_14) @[intervox_receiver.scala 198:34 207:21]
    node _GEN_22 = mux(_T_12, _GEN_17, _GEN_1) @[intervox_receiver.scala 195:74]
    node _GEN_23 = mux(_T_12, _GEN_18, _GEN_3) @[intervox_receiver.scala 195:74]
    node _GEN_24 = mux(_T_12, _GEN_19, _GEN_15) @[intervox_receiver.scala 195:74]
    node _GEN_25 = mux(_T_12, _GEN_20, _GEN_16) @[intervox_receiver.scala 195:74]
    node _GEN_26 = mux(_T_12, _GEN_21, _GEN_14) @[intervox_receiver.scala 195:74]
    node _T_14 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 215:17]
    node _T_15 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 217:38]
    node _T_16 = geq(deltaCntr, _T_15) @[intervox_receiver.scala 217:25]
    node _T_17 = eq(syncFlipped, UInt<1>("h0")) @[intervox_receiver.scala 224:30]
    node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 226:27]
    node _GEN_27 = mux(_T_17, _clkRec_T_2, _GEN_22) @[intervox_receiver.scala 224:38 226:24]
    node _GEN_28 = mux(_T_17, UInt<1>("h1"), _GEN_4) @[intervox_receiver.scala 224:38 227:29]
    node _GEN_29 = mux(_T_16, _GEN_27, _GEN_22) @[intervox_receiver.scala 217:47]
    node _GEN_30 = mux(_T_16, _GEN_28, _GEN_4) @[intervox_receiver.scala 217:47]
    node _T_18 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 230:38]
    node _T_19 = geq(deltaCntr, _T_18) @[intervox_receiver.scala 230:25]
    node _T_20 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 230:57]
    node _T_21 = and(_T_19, _T_20) @[intervox_receiver.scala 230:47]
    node _T_22 = eq(syncFlipped1, UInt<1>("h0")) @[intervox_receiver.scala 238:31]
    node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 240:27]
    node _leds_T = dshr(BFR.io_dataOut, UInt<6>("h2e")) @[intervox_receiver.scala 249:44]
    node _leds_T_1 = and(_leds_T, UInt<16>("hffff")) @[intervox_receiver.scala 249:53]
    node _GEN_31 = mux(_T_22, _clkRec_T_3, _GEN_29) @[intervox_receiver.scala 238:39 240:24]
    node _GEN_32 = mux(_T_22, UInt<1>("h1"), _GEN_5) @[intervox_receiver.scala 238:39 241:30]
    node _GEN_33 = mux(_T_22, UInt<1>("h0"), _GEN_10) @[intervox_receiver.scala 238:39 243:25]
    node _GEN_34 = mux(_T_22, UInt<1>("h1"), UInt<1>("h0")) @[intervox_receiver.scala 109:28 238:39 246:33]
    node _GEN_35 = mux(_T_22, BFR.io_dataOut, UInt<1>("h0")) @[intervox_receiver.scala 110:28 238:39 247:33]
    node _GEN_36 = mux(_T_22, _leds_T_1, leds) @[intervox_receiver.scala 238:39 249:25 117:30]
    node _GEN_37 = mux(_T_21, UInt<1>("h1"), _GEN_6) @[intervox_receiver.scala 230:66 237:22]
    node _GEN_38 = mux(_T_21, _GEN_31, _GEN_29) @[intervox_receiver.scala 230:66]
    node _GEN_39 = mux(_T_21, _GEN_32, _GEN_5) @[intervox_receiver.scala 230:66]
    node _GEN_40 = mux(_T_21, _GEN_33, _GEN_10) @[intervox_receiver.scala 230:66]
    node _GEN_41 = mux(_T_21, _GEN_34, UInt<1>("h0")) @[intervox_receiver.scala 109:28 230:66]
    node _GEN_42 = mux(_T_21, _GEN_35, UInt<1>("h0")) @[intervox_receiver.scala 110:28 230:66]
    node _GEN_43 = mux(_T_21, _GEN_36, leds) @[intervox_receiver.scala 117:30 230:66]
    node _GEN_44 = mux(_T_14, _GEN_38, _GEN_22) @[intervox_receiver.scala 215:25]
    node _GEN_45 = mux(_T_14, _GEN_30, _GEN_4) @[intervox_receiver.scala 215:25]
    node _GEN_46 = mux(_T_14, _GEN_37, _GEN_6) @[intervox_receiver.scala 215:25]
    node _GEN_47 = mux(_T_14, _GEN_39, _GEN_5) @[intervox_receiver.scala 215:25]
    node _GEN_48 = mux(_T_14, _GEN_40, _GEN_10) @[intervox_receiver.scala 215:25]
    node _GEN_49 = mux(_T_14, _GEN_41, UInt<1>("h0")) @[intervox_receiver.scala 215:25 109:28]
    node _GEN_50 = mux(_T_14, _GEN_42, UInt<1>("h0")) @[intervox_receiver.scala 215:25 110:28]
    node _GEN_51 = mux(_T_14, _GEN_43, leds) @[intervox_receiver.scala 215:25 117:30]
    node _T_23 = gt(io_SW, UInt<1>("h0")) @[intervox_receiver.scala 255:16]
    node _T_24 = eq(io_BTN_C, UInt<1>("h1")) @[intervox_receiver.scala 256:23]
    node _GEN_52 = mux(_T_24, io_SW, lastOne) @[intervox_receiver.scala 256:31 257:21 116:30]
    node _GEN_53 = mux(_T_24, io_SW, _GEN_51) @[intervox_receiver.scala 256:31 258:21]
    node _GEN_54 = mux(_T_23, _GEN_52, lastOne) @[intervox_receiver.scala 255:22 116:30]
    node _GEN_55 = mux(_T_23, _GEN_53, _GEN_51) @[intervox_receiver.scala 255:22]
    io_CLK_OUT <= clkRec @[intervox_receiver.scala 131:21]
    io_DATA_OUT <= dataOut @[intervox_receiver.scala 132:21]
    io_DBUG <= change @[intervox_receiver.scala 133:21]
    io_DBUG1 <= syncWord @[intervox_receiver.scala 134:21]
    io_LED <= leds @[intervox_receiver.scala 135:21]
    io_DATAREG <= BFR1.io_dataOut @[intervox_receiver.scala 136:21]
    BFR.clock <= clock
    BFR.reset <= reset
    BFR.io_enable <= UInt<1>("h1") @[intervox_receiver.scala 102:27]
    BFR.io_write <= _GEN_24
    BFR.io_addr <= UInt<1>("h1") @[intervox_receiver.scala 103:27]
    BFR.io_dataIn <= bits(_GEN_25, 63, 0)
    BFR1.clock <= clock
    BFR1.reset <= reset
    BFR1.io_enable <= UInt<1>("h1") @[intervox_receiver.scala 107:28]
    BFR1.io_write <= _GEN_49
    BFR1.io_addr <= UInt<1>("h1") @[intervox_receiver.scala 108:28]
    BFR1.io_dataIn <= _GEN_50
    rising <= mux(reset, UInt<2>("h0"), rising) @[intervox_receiver.scala 114:{30,30,30}]
    trailing <= mux(reset, UInt<2>("h0"), trailing) @[intervox_receiver.scala 115:{30,30,30}]
    lastOne <= bits(mux(reset, UInt<8>("hf"), _GEN_54), 7, 0) @[intervox_receiver.scala 116:{30,30}]
    leds <= bits(mux(reset, UInt<16>("h0"), _GEN_55), 15, 0) @[intervox_receiver.scala 117:{30,30}]
    overSampleCntr <= mux(reset, UInt<4>("h0"), overSampleCntr) @[intervox_receiver.scala 118:{32,32,32}]
    inBufr <= mux(reset, UInt<2>("h0"), inBufr) @[intervox_receiver.scala 119:{30,30,30}]
    deltaCntr <= mux(reset, UInt<8>("h0"), _GEN_2) @[intervox_receiver.scala 120:{30,30}]
    bitCntr <= mux(reset, UInt<7>("h0"), _GEN_48) @[intervox_receiver.scala 121:{30,30}]
    clkRec <= mux(reset, UInt<1>("h0"), _GEN_44) @[intervox_receiver.scala 122:{30,30}]
    change <= mux(reset, UInt<1>("h0"), _GEN_0) @[intervox_receiver.scala 123:{30,30}]
    dataOut <= mux(reset, UInt<1>("h0"), _GEN_26) @[intervox_receiver.scala 124:{30,30}]
    syncWord <= mux(reset, UInt<1>("h0"), _GEN_46) @[intervox_receiver.scala 125:{30,30}]
    zeroFlipped <= mux(reset, UInt<1>("h0"), _GEN_23) @[intervox_receiver.scala 126:{30,30}]
    syncFlipped <= mux(reset, UInt<1>("h0"), _GEN_45) @[intervox_receiver.scala 127:{30,30}]
    syncFlipped1 <= mux(reset, UInt<1>("h0"), _GEN_47) @[intervox_receiver.scala 128:{30,30}]
    syncFlipped2 <= mux(reset, UInt<1>("h0"), syncFlipped2) @[intervox_receiver.scala 129:{30,30,30}]
    DATAEDGE.clock <= clock
    DATAEDGE.reset <= reset
    DATAEDGE.io_INPUT <= io_DATA_IN @[intervox_receiver.scala 141:29]
    change_REG <= mux(reset, UInt<1>("h0"), UInt<1>("h0")) @[intervox_receiver.scala 149:{34,34,34}]
    change_REG_1 <= mux(reset, UInt<1>("h0"), change_REG) @[intervox_receiver.scala 149:{26,26,26}]

  module i2s_Transmitter :
    input clock : Clock
    input reset : UInt<1>
    input io_CLK_IN : UInt<1>
    input io_DATA_IN : UInt<64>
    input io_NEXT : UInt<1>
    output io_BCLK : UInt<1>
    output io_LRCLK : UInt<1>
    output io_SDATA : UInt<1>

    reg bitCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_receiver.scala 273:26]
    reg lrclk : UInt<1>, clock with :
      reset => (UInt<1>("h0"), lrclk) @[intervox_receiver.scala 274:26]
    reg sdataO : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sdataO) @[intervox_receiver.scala 275:26]
    reg sdata : UInt<64>, clock with :
      reset => (UInt<1>("h0"), sdata) @[intervox_receiver.scala 276:26]
    node _T = eq(io_NEXT, UInt<1>("h1")) @[intervox_receiver.scala 284:18]
    node _GEN_0 = mux(_T, UInt<1>("h0"), bitCntr) @[intervox_receiver.scala 284:26 285:17 273:26]
    node _T_1 = eq(io_CLK_IN, UInt<1>("h1")) @[intervox_receiver.scala 288:20]
    node _bitCntr_T = add(bitCntr, UInt<1>("h1")) @[intervox_receiver.scala 291:28]
    node _bitCntr_T_1 = tail(_bitCntr_T, 1) @[intervox_receiver.scala 291:28]
    node _T_2 = eq(bitCntr, UInt<1>("h0")) @[intervox_receiver.scala 293:22]
    node _GEN_1 = mux(_T_2, UInt<1>("h1"), lrclk) @[intervox_receiver.scala 293:30 295:19 274:26]
    node _T_3 = gt(bitCntr, UInt<5>("h1f")) @[intervox_receiver.scala 297:22]
    node _GEN_2 = mux(_T_3, UInt<1>("h0"), _GEN_1) @[intervox_receiver.scala 297:29 299:19]
    node _T_4 = leq(bitCntr, UInt<5>("h18")) @[intervox_receiver.scala 301:23]
    node _GEN_3 = mux(_T_4, UInt<1>("h1"), sdataO) @[intervox_receiver.scala 301:32 303:20 275:26]
    node _T_5 = gt(bitCntr, UInt<5>("h18")) @[intervox_receiver.scala 305:23]
    node _T_6 = leq(bitCntr, UInt<5>("h1f")) @[intervox_receiver.scala 305:42]
    node _T_7 = and(_T_5, _T_6) @[intervox_receiver.scala 305:31]
    node _GEN_4 = mux(_T_7, UInt<1>("h0"), _GEN_3) @[intervox_receiver.scala 305:51 307:20]
    node _T_8 = leq(bitCntr, UInt<6>("h38")) @[intervox_receiver.scala 309:23]
    node _T_9 = gt(bitCntr, UInt<5>("h1f")) @[intervox_receiver.scala 309:43]
    node _T_10 = and(_T_8, _T_9) @[intervox_receiver.scala 309:32]
    node _GEN_5 = mux(_T_10, UInt<1>("h1"), _GEN_4) @[intervox_receiver.scala 309:51 311:20]
    node _T_11 = gt(bitCntr, UInt<6>("h38")) @[intervox_receiver.scala 313:23]
    node _GEN_6 = mux(_T_11, UInt<1>("h0"), _GEN_5) @[intervox_receiver.scala 313:31 315:20]
    node _GEN_7 = mux(_T_1, _bitCntr_T_1, _GEN_0) @[intervox_receiver.scala 288:28 291:17]
    node _GEN_8 = mux(_T_1, _GEN_2, lrclk) @[intervox_receiver.scala 274:26 288:28]
    node _GEN_9 = mux(_T_1, _GEN_6, sdataO) @[intervox_receiver.scala 275:26 288:28]
    io_BCLK <= io_CLK_IN @[intervox_receiver.scala 281:17]
    io_LRCLK <= lrclk @[intervox_receiver.scala 279:17]
    io_SDATA <= sdataO @[intervox_receiver.scala 280:17]
    bitCntr <= mux(reset, UInt<8>("h0"), _GEN_7) @[intervox_receiver.scala 273:{26,26}]
    lrclk <= mux(reset, UInt<1>("h0"), _GEN_8) @[intervox_receiver.scala 274:{26,26}]
    sdataO <= mux(reset, UInt<1>("h0"), _GEN_9) @[intervox_receiver.scala 275:{26,26}]
    sdata <= mux(reset, UInt<64>("h0"), io_DATA_IN) @[intervox_receiver.scala 276:{26,26} 278:17]

  module interVox_Receiver :
    input clock : Clock
    input reset : UInt<1>
    input io_INTERVOX_IN : UInt<1>
    output io_CLK_REC : UInt<1>
    output io_DATA_OUT : UInt<1>
    output io_CLK_DBUG : UInt<1>
    output io_DBUG : UInt<1>
    output io_DBUG1 : UInt<1>
    output io_LED : UInt<16>
    input io_SW : UInt<16>
    output io_BCLK : UInt<1>
    output io_LRCLK : UInt<1>
    output io_SDATA : UInt<1>
    input io_BTN_C : UInt<1>
    input io_BTN_D : UInt<1>
    input io_BTN_L : UInt<1>
    input io_BTN_R : UInt<1>

    inst clockRec of clock_Recovery @[intervox_receiver.scala 339:29]
    inst i2sTrans of i2s_Transmitter @[intervox_receiver.scala 350:29]
    io_CLK_REC <= clockRec.io_CLK_OUT @[intervox_receiver.scala 346:21]
    io_DATA_OUT <= clockRec.io_DATA_OUT @[intervox_receiver.scala 344:21]
    io_CLK_DBUG <= UInt<1>("h0") @[intervox_receiver.scala 345:21]
    io_DBUG <= clockRec.io_DBUG @[intervox_receiver.scala 348:21]
    io_DBUG1 <= clockRec.io_DBUG1 @[intervox_receiver.scala 347:21]
    io_LED <= clockRec.io_LED @[intervox_receiver.scala 343:21]
    io_BCLK <= i2sTrans.io_BCLK @[intervox_receiver.scala 354:21]
    io_LRCLK <= i2sTrans.io_LRCLK @[intervox_receiver.scala 356:21]
    io_SDATA <= i2sTrans.io_SDATA @[intervox_receiver.scala 355:21]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io_DATA_IN <= io_INTERVOX_IN @[intervox_receiver.scala 340:29]
    clockRec.io_SW <= io_SW @[intervox_receiver.scala 341:29]
    clockRec.io_BTN_C <= io_BTN_C @[intervox_receiver.scala 342:29]
    i2sTrans.clock <= clock
    i2sTrans.reset <= reset
    i2sTrans.io_CLK_IN <= clockRec.io_CLK_OUT @[intervox_receiver.scala 351:29]
    i2sTrans.io_DATA_IN <= clockRec.io_DATAREG @[intervox_receiver.scala 352:29]
    i2sTrans.io_NEXT <= clockRec.io_DBUG1 @[intervox_receiver.scala 353:29]
