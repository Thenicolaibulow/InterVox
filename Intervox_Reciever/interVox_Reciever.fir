circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : Reset
    output io : { flip DATA_IN : UInt<1>, CLK_OUT : UInt<1>, DATA_OUT : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LEDS : UInt<16>}

    reg deltaCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 25:30]
    reg inBufr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 26:30]
    reg lastOne : UInt<8>, clock with :
      reset => (reset, UInt<8>("h1f")) @[intervox_receiver.scala 27:30]
    reg inBufrPrev : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 28:30]
    reg whatChange : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 29:30]
    reg outReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 31:30]
    reg clkRec : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 32:30]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 33:30]
    reg changed : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 34:30]
    reg changedOne : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 35:30]
    reg dataOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 36:30]
    reg zeroPeriode : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 37:30]
    reg syncWord : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 38:30]
    reg zeroClkFlp : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 39:30]
    io.CLK_OUT <= clkRec @[intervox_receiver.scala 41:21]
    io.DATA_OUT <= dataOut @[intervox_receiver.scala 42:21]
    io.DBUG <= zeroPeriode @[intervox_receiver.scala 43:21]
    io.DBUG1 <= syncWord @[intervox_receiver.scala 44:21]
    io.LEDS <= lastOne @[intervox_receiver.scala 45:21]
    node _deltaCntr_T = add(deltaCntr, UInt<1>("h1")) @[intervox_receiver.scala 48:31]
    node _deltaCntr_T_1 = tail(_deltaCntr_T, 1) @[intervox_receiver.scala 48:31]
    deltaCntr <= _deltaCntr_T_1 @[intervox_receiver.scala 48:18]
    node _T = eq(io.DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 51:21]
    when _T : @[intervox_receiver.scala 51:29]
      node _T_1 = eq(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 54:21]
      when _T_1 : @[intervox_receiver.scala 54:29]
        inBufr <= UInt<1>("h1") @[intervox_receiver.scala 55:20]
      node _T_2 = lt(inBufr, UInt<2>("h2")) @[intervox_receiver.scala 58:22]
      node _T_3 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 58:39]
      node _T_4 = and(_T_2, _T_3) @[intervox_receiver.scala 58:29]
      when _T_4 : @[intervox_receiver.scala 58:46]
        inBufrPrev <= inBufr @[intervox_receiver.scala 60:24]
        node _inBufr_T = dshl(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 61:30]
        inBufr <= _inBufr_T @[intervox_receiver.scala 61:20]
      node _T_5 = eq(inBufr, UInt<2>("h2")) @[intervox_receiver.scala 63:21]
      when _T_5 : @[intervox_receiver.scala 63:29]
        inBufrPrev <= inBufr @[intervox_receiver.scala 65:24]
    node _T_6 = eq(io.DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 69:21]
    when _T_6 : @[intervox_receiver.scala 69:29]
      node _T_7 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 72:21]
      when _T_7 : @[intervox_receiver.scala 72:27]
        inBufrPrev <= inBufr @[intervox_receiver.scala 74:24]
        node _inBufr_T_1 = dshr(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 76:30]
        inBufr <= _inBufr_T_1 @[intervox_receiver.scala 76:20]
      node _T_8 = eq(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 78:21]
      when _T_8 : @[intervox_receiver.scala 78:29]
        inBufrPrev <= inBufr @[intervox_receiver.scala 80:24]
    node _T_9 = eq(inBufrPrev, UInt<1>("h0")) @[intervox_receiver.scala 92:22]
    node _T_10 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 92:41]
    node _T_11 = and(_T_9, _T_10) @[intervox_receiver.scala 92:31]
    when _T_11 : @[intervox_receiver.scala 92:50]
      change <= UInt<1>("h1") @[intervox_receiver.scala 94:21]
    node _T_12 = eq(inBufrPrev, UInt<2>("h2")) @[intervox_receiver.scala 101:22]
    node _T_13 = eq(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 101:41]
    node _T_14 = and(_T_12, _T_13) @[intervox_receiver.scala 101:31]
    when _T_14 : @[intervox_receiver.scala 101:50]
      change <= UInt<1>("h1") @[intervox_receiver.scala 103:21]
    node _T_15 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 107:17]
    when _T_15 : @[intervox_receiver.scala 107:25]
      change <= UInt<1>("h0") @[intervox_receiver.scala 108:21]
      changed <= UInt<1>("h0") @[intervox_receiver.scala 109:21]
    node _T_16 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 112:17]
    when _T_16 : @[intervox_receiver.scala 112:25]
      node _T_17 = eq(changedOne, UInt<1>("h0")) @[intervox_receiver.scala 115:25]
      when _T_17 : @[intervox_receiver.scala 115:33]
        changedOne <= UInt<1>("h1") @[intervox_receiver.scala 117:25]
        deltaCntr <= UInt<1>("h0") @[intervox_receiver.scala 119:25]
        syncWord <= UInt<1>("h0") @[intervox_receiver.scala 121:25]
      node _T_18 = add(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 125:36]
      node _T_19 = tail(_T_18, 1) @[intervox_receiver.scala 125:36]
      node _T_20 = leq(deltaCntr, _T_19) @[intervox_receiver.scala 125:25]
      when _T_20 : @[intervox_receiver.scala 125:43]
        dataOut <= UInt<1>("h1") @[intervox_receiver.scala 130:25]
        zeroPeriode <= UInt<1>("h0") @[intervox_receiver.scala 132:25]
        lastOne <= deltaCntr @[intervox_receiver.scala 135:25]
        changedOne <= UInt<1>("h0") @[intervox_receiver.scala 138:25]
        deltaCntr <= UInt<1>("h0") @[intervox_receiver.scala 140:25]
    node _T_21 = add(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 145:32]
    node _T_22 = tail(_T_21, 1) @[intervox_receiver.scala 145:32]
    node _T_23 = gt(deltaCntr, _T_22) @[intervox_receiver.scala 145:21]
    when _T_23 : @[intervox_receiver.scala 145:40]
      dataOut <= UInt<1>("h0") @[intervox_receiver.scala 150:25]
      zeroPeriode <= UInt<1>("h1") @[intervox_receiver.scala 152:25]
      syncWord <= UInt<1>("h0") @[intervox_receiver.scala 154:25]
      changedOne <= UInt<1>("h0") @[intervox_receiver.scala 156:25]
    node _T_24 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 174:18]
    when _T_24 : @[intervox_receiver.scala 174:27]
      node _clkRec_T = not(clkRec) @[intervox_receiver.scala 175:20]
      clkRec <= _clkRec_T @[intervox_receiver.scala 175:17]
    node _T_25 = geq(deltaCntr, lastOne) @[intervox_receiver.scala 181:22]
    node _T_26 = eq(changed, UInt<1>("h0")) @[intervox_receiver.scala 181:45]
    node _T_27 = and(_T_25, _T_26) @[intervox_receiver.scala 181:34]
    node _T_28 = neq(change, UInt<1>("h1")) @[intervox_receiver.scala 181:64]
    node _T_29 = and(_T_27, _T_28) @[intervox_receiver.scala 181:54]
    node _T_30 = geq(deltaCntr, lastOne) @[intervox_receiver.scala 181:88]
    node _T_31 = eq(zeroPeriode, UInt<1>("h1")) @[intervox_receiver.scala 181:115]
    node _T_32 = and(_T_30, _T_31) @[intervox_receiver.scala 181:100]
    node _T_33 = eq(changed, UInt<1>("h0")) @[intervox_receiver.scala 181:135]
    node _T_34 = and(_T_32, _T_33) @[intervox_receiver.scala 181:124]
    node _T_35 = or(_T_29, _T_34) @[intervox_receiver.scala 181:74]
    when _T_35 : @[intervox_receiver.scala 181:145]
      node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 182:20]
      clkRec <= _clkRec_T_1 @[intervox_receiver.scala 182:17]
      changed <= UInt<1>("h1") @[intervox_receiver.scala 183:17]

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, CLK_DBUG : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LEDS : UInt<16>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 200:26]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 202:25]
    io.LEDS <= clockRec.io.LEDS @[intervox_receiver.scala 204:25]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 205:25]
    io.CLK_DBUG <= clockRec.io.CLK_OUT @[intervox_receiver.scala 206:25]
    io.DBUG1 <= clockRec.io.DBUG1 @[intervox_receiver.scala 207:25]
    io.DBUG <= clockRec.io.DBUG @[intervox_receiver.scala 208:25]
    io.CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 211:16]

