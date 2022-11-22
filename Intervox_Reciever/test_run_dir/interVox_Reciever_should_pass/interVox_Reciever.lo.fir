circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : UInt<1>
    input io_DATA_IN : UInt<1>
    output io_CLK_OUT : UInt<1>
    output io_DATA_OUT : UInt<1>
    output io_DBUG : UInt<1>
    output io_DBUG1 : UInt<1>

    reg clkCntr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), clkCntr) @[intervox_receiver.scala 27:30]
    reg clkCntr1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), clkCntr1) @[intervox_receiver.scala 28:30]
    reg clkCntr2 : UInt<4>, clock with :
      reset => (UInt<1>("h0"), clkCntr2) @[intervox_receiver.scala 29:30]
    reg clkCntr3 : UInt<4>, clock with :
      reset => (UInt<1>("h0"), clkCntr3) @[intervox_receiver.scala 30:30]
    reg clkDelta : UInt<8>, clock with :
      reset => (UInt<1>("h0"), clkDelta) @[intervox_receiver.scala 31:30]
    reg lastOne : UInt<8>, clock with :
      reset => (UInt<1>("h0"), lastOne) @[intervox_receiver.scala 32:30]
    reg pllCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pllCntr) @[intervox_receiver.scala 33:30]
    reg inBufr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), inBufr) @[intervox_receiver.scala 34:30]
    reg whatChange : UInt<2>, clock with :
      reset => (UInt<1>("h0"), whatChange) @[intervox_receiver.scala 35:30]
    reg outReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), outReg) @[intervox_receiver.scala 37:30]
    reg clkRec : UInt<1>, clock with :
      reset => (UInt<1>("h0"), clkRec) @[intervox_receiver.scala 38:30]
    reg change : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change) @[intervox_receiver.scala 39:30]
    reg dataOut : UInt<1>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[intervox_receiver.scala 40:30]
    reg nextFrame : UInt<1>, clock with :
      reset => (UInt<1>("h0"), nextFrame) @[intervox_receiver.scala 41:30]
    reg zeroPeriode : UInt<1>, clock with :
      reset => (UInt<1>("h0"), zeroPeriode) @[intervox_receiver.scala 42:30]
    reg syncWord : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncWord) @[intervox_receiver.scala 43:30]
    node _pllCntr_T = add(pllCntr, UInt<1>("h1")) @[intervox_receiver.scala 51:24]
    node _pllCntr_T_1 = tail(_pllCntr_T, 1) @[intervox_receiver.scala 51:24]
    node _T = eq(pllCntr, UInt<3>("h7")) @[intervox_receiver.scala 52:18]
    node _outReg_T = not(outReg) @[intervox_receiver.scala 55:19]
    node _GEN_0 = mux(_T, _outReg_T, outReg) @[intervox_receiver.scala 52:26 55:16 37:30]
    node _GEN_1 = mux(_T, UInt<1>("h0"), _pllCntr_T_1) @[intervox_receiver.scala 51:13 52:26 56:17]
    node _clkCntr_T = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 64:28]
    node _clkCntr_T_1 = tail(_clkCntr_T, 1) @[intervox_receiver.scala 64:28]
    node _clkCntr1_T = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 66:29]
    node _clkCntr1_T_1 = tail(_clkCntr1_T, 1) @[intervox_receiver.scala 66:29]
    node _T_1 = eq(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 68:18]
    node _GEN_2 = mux(_T_1, UInt<1>("h0"), _clkCntr_T_1) @[intervox_receiver.scala 64:17 68:26 69:17]
    node _GEN_3 = mux(_T_1, UInt<1>("h0"), change) @[intervox_receiver.scala 68:26 70:16 39:30]
    node _T_2 = eq(io_DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 73:21]
    node _T_3 = lt(inBufr, UInt<2>("h3")) @[intervox_receiver.scala 74:21]
    node _inBufr_T = add(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 75:30]
    node _inBufr_T_1 = tail(_inBufr_T, 1) @[intervox_receiver.scala 75:30]
    node _GEN_4 = mux(_T_3, _inBufr_T_1, inBufr) @[intervox_receiver.scala 74:27 75:20 34:30]
    node _GEN_5 = mux(_T_2, _GEN_4, inBufr) @[intervox_receiver.scala 73:29 34:30]
    node _T_4 = eq(io_DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 78:21]
    node _T_5 = gt(inBufr, UInt<1>("h0")) @[intervox_receiver.scala 79:21]
    node _inBufr_T_2 = sub(inBufr, UInt<1>("h1")) @[intervox_receiver.scala 80:30]
    node _inBufr_T_3 = tail(_inBufr_T_2, 1) @[intervox_receiver.scala 80:30]
    node _GEN_6 = mux(_T_5, _inBufr_T_3, _GEN_5) @[intervox_receiver.scala 79:27 80:20]
    node _GEN_7 = mux(_T_4, _GEN_6, _GEN_5) @[intervox_receiver.scala 78:29]
    node _T_6 = eq(change, UInt<1>("h0")) @[intervox_receiver.scala 83:17]
    node _T_7 = bits(inBufr, 0, 0) @[intervox_receiver.scala 85:20]
    node _T_8 = bits(inBufr, 1, 1) @[intervox_receiver.scala 85:34]
    node _T_9 = neq(_T_7, _T_8) @[intervox_receiver.scala 85:24]
    node _GEN_8 = mux(_T_9, UInt<1>("h1"), _GEN_3) @[intervox_receiver.scala 85:38 86:20]
    node _GEN_9 = mux(_T_9, UInt<1>("h0"), _clkCntr1_T_1) @[intervox_receiver.scala 66:17 85:38 87:22]
    node _GEN_10 = mux(_T_9, clkCntr1, clkDelta) @[intervox_receiver.scala 85:38 88:22 31:30]
    node _GEN_11 = mux(_T_6, _GEN_8, _GEN_3) @[intervox_receiver.scala 83:25]
    node _GEN_12 = mux(_T_6, _GEN_9, _clkCntr1_T_1) @[intervox_receiver.scala 66:17 83:25]
    node _GEN_13 = mux(_T_6, _GEN_10, clkDelta) @[intervox_receiver.scala 83:25 31:30]
    node _T_10 = gt(clkCntr1, UInt<4>("he")) @[intervox_receiver.scala 97:20]
    node _T_11 = eq(io_DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 97:44]
    node _T_12 = and(_T_10, _T_11) @[intervox_receiver.scala 97:30]
    node _GEN_14 = mux(_T_12, UInt<1>("h1"), syncWord) @[intervox_receiver.scala 97:53 98:18 43:30]
    node _T_13 = gt(clkDelta, UInt<1>("h0")) @[intervox_receiver.scala 101:20]
    node _T_14 = lt(clkDelta, UInt<4>("ha")) @[intervox_receiver.scala 101:39]
    node _T_15 = and(_T_13, _T_14) @[intervox_receiver.scala 101:27]
    node _T_16 = eq(zeroPeriode, UInt<1>("h0")) @[intervox_receiver.scala 103:26]
    node _GEN_15 = mux(_T_16, UInt<1>("h0"), _GEN_14) @[intervox_receiver.scala 103:34 104:22]
    node _GEN_16 = mux(_T_15, UInt<1>("h1"), dataOut) @[intervox_receiver.scala 101:47 102:17 40:30]
    node _GEN_17 = mux(_T_15, _GEN_15, _GEN_14) @[intervox_receiver.scala 101:47]
    node _GEN_18 = mux(_T_15, clkDelta, lastOne) @[intervox_receiver.scala 101:47 108:17 32:30]
    node _T_17 = gt(clkDelta, UInt<4>("ha")) @[intervox_receiver.scala 118:20]
    node _T_18 = lt(clkDelta, UInt<5>("h10")) @[intervox_receiver.scala 118:40]
    node _T_19 = and(_T_17, _T_18) @[intervox_receiver.scala 118:28]
    node _T_20 = eq(zeroPeriode, UInt<1>("h0")) @[intervox_receiver.scala 120:26]
    node _GEN_19 = mux(_T_20, UInt<1>("h0"), _GEN_17) @[intervox_receiver.scala 120:34 121:22]
    node _GEN_20 = mux(_T_19, UInt<1>("h0"), _GEN_16) @[intervox_receiver.scala 118:48 119:17]
    node _GEN_21 = mux(_T_19, _GEN_19, _GEN_17) @[intervox_receiver.scala 118:48]
    node _T_21 = eq(UInt<1>("h1"), change) @[intervox_receiver.scala 129:19]
    node _clkCntr2_T = add(clkCntr2, UInt<1>("h1")) @[intervox_receiver.scala 131:34]
    node _clkCntr2_T_1 = tail(_clkCntr2_T, 1) @[intervox_receiver.scala 131:34]
    node _T_22 = geq(whatChange, UInt<1>("h0")) @[intervox_receiver.scala 132:29]
    node _whatChange_T = sub(whatChange, UInt<1>("h1")) @[intervox_receiver.scala 133:42]
    node _whatChange_T_1 = tail(_whatChange_T, 1) @[intervox_receiver.scala 133:42]
    node _GEN_22 = mux(_T_22, _whatChange_T_1, whatChange) @[intervox_receiver.scala 132:36 133:28 35:30]
    node _T_23 = eq(UInt<1>("h0"), change) @[intervox_receiver.scala 129:19]
    node _whatChange_T_2 = add(whatChange, UInt<1>("h1")) @[intervox_receiver.scala 137:38]
    node _whatChange_T_3 = tail(_whatChange_T_2, 1) @[intervox_receiver.scala 137:38]
    node _clkCntr2_T_2 = add(clkCntr2, UInt<1>("h1")) @[intervox_receiver.scala 139:34]
    node _clkCntr2_T_3 = tail(_clkCntr2_T_2, 1) @[intervox_receiver.scala 139:34]
    node _T_24 = sub(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 140:39]
    node _T_25 = tail(_T_24, 1) @[intervox_receiver.scala 140:39]
    node _T_26 = eq(clkCntr2, _T_25) @[intervox_receiver.scala 140:27]
    node _GEN_23 = mux(_T_26, UInt<1>("h0"), _clkCntr2_T_3) @[intervox_receiver.scala 139:22 140:45 141:29]
    node _GEN_24 = mux(_T_23, _whatChange_T_3, whatChange) @[intervox_receiver.scala 129:19 137:24 35:30]
    node _GEN_25 = mux(_T_23, _GEN_23, clkCntr2) @[intervox_receiver.scala 129:19 29:30]
    node _GEN_26 = mux(_T_21, _clkCntr2_T_1, _GEN_25) @[intervox_receiver.scala 129:19 131:22]
    node _GEN_27 = mux(_T_21, _GEN_22, _GEN_24) @[intervox_receiver.scala 129:19]
    node _T_27 = bits(whatChange, 0, 0) @[intervox_receiver.scala 147:21]
    node _T_28 = eq(_T_27, UInt<1>("h1")) @[intervox_receiver.scala 147:25]
    node _T_29 = bits(whatChange, 1, 1) @[intervox_receiver.scala 147:47]
    node _T_30 = eq(_T_29, UInt<1>("h0")) @[intervox_receiver.scala 147:51]
    node _T_31 = and(_T_28, _T_30) @[intervox_receiver.scala 147:34]
    node _T_32 = lt(clkCntr1, lastOne) @[intervox_receiver.scala 149:23]
    node _GEN_28 = mux(_T_32, UInt<1>("h0"), _GEN_26) @[intervox_receiver.scala 149:33 150:25]
    node _GEN_29 = mux(_T_32, UInt<1>("h0"), zeroPeriode) @[intervox_receiver.scala 149:33 151:25 42:30]
    node _GEN_30 = mux(_T_31, _GEN_28, _GEN_26) @[intervox_receiver.scala 147:60]
    node _GEN_31 = mux(_T_31, _GEN_29, zeroPeriode) @[intervox_receiver.scala 147:60 42:30]
    node _T_33 = lt(clkCntr1, lastOne) @[intervox_receiver.scala 156:19]
    node _T_34 = bits(whatChange, 0, 0) @[intervox_receiver.scala 157:25]
    node _T_35 = eq(_T_34, UInt<1>("h0")) @[intervox_receiver.scala 157:29]
    node _T_36 = bits(whatChange, 1, 1) @[intervox_receiver.scala 157:51]
    node _T_37 = eq(_T_36, UInt<1>("h1")) @[intervox_receiver.scala 157:55]
    node _T_38 = and(_T_35, _T_37) @[intervox_receiver.scala 157:38]
    node _clkRec_T = not(clkRec) @[intervox_receiver.scala 159:23]
    node _GEN_32 = mux(_T_38, _clkRec_T, clkRec) @[intervox_receiver.scala 157:64 159:20 38:30]
    node _GEN_33 = mux(_T_38, UInt<1>("h0"), clkCntr3) @[intervox_receiver.scala 157:64 160:22 30:30]
    node _GEN_34 = mux(_T_38, UInt<1>("h0"), _GEN_21) @[intervox_receiver.scala 157:64 161:22]
    node _GEN_35 = mux(_T_33, _GEN_32, clkRec) @[intervox_receiver.scala 156:29 38:30]
    node _GEN_36 = mux(_T_33, _GEN_33, clkCntr3) @[intervox_receiver.scala 156:29 30:30]
    node _GEN_37 = mux(_T_33, _GEN_34, _GEN_21) @[intervox_receiver.scala 156:29]
    node _T_39 = gt(clkCntr1, lastOne) @[intervox_receiver.scala 165:20]
    node _T_40 = eq(zeroPeriode, UInt<1>("h0")) @[intervox_receiver.scala 169:27]
    node _T_41 = div(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 169:59]
    node _T_42 = geq(clkCntr2, _T_41) @[intervox_receiver.scala 169:48]
    node _T_43 = and(_T_40, _T_42) @[intervox_receiver.scala 169:36]
    node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 170:23]
    node _GEN_38 = mux(_T_43, _clkRec_T_1, _GEN_35) @[intervox_receiver.scala 169:66 170:20]
    node _GEN_39 = mux(_T_43, UInt<1>("h0"), _GEN_36) @[intervox_receiver.scala 169:66 171:22]
    node _T_44 = mul(UInt<2>("h2"), lastOne) @[intervox_receiver.scala 178:33]
    node _T_45 = div(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 178:55]
    node _T_46 = sub(_T_44, _T_45) @[intervox_receiver.scala 178:44]
    node _T_47 = tail(_T_46, 1) @[intervox_receiver.scala 178:44]
    node _T_48 = add(_T_47, UInt<1>("h1")) @[intervox_receiver.scala 178:62]
    node _T_49 = tail(_T_48, 1) @[intervox_receiver.scala 178:62]
    node _T_50 = eq(clkCntr1, _T_49) @[intervox_receiver.scala 178:23]
    node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 179:23]
    node _GEN_40 = mux(_T_50, _clkRec_T_2, _GEN_38) @[intervox_receiver.scala 178:69 179:20]
    node _GEN_41 = mux(_T_39, _GEN_40, _GEN_35) @[intervox_receiver.scala 165:31]
    node _GEN_42 = mux(_T_39, _GEN_39, _GEN_36) @[intervox_receiver.scala 165:31]
    node _GEN_43 = mux(_T_39, UInt<1>("h1"), _GEN_31) @[intervox_receiver.scala 165:31 173:21]
    node _T_51 = eq(syncWord, UInt<1>("h1")) @[intervox_receiver.scala 184:19]
    node _clkCntr3_T = add(clkCntr3, UInt<1>("h1")) @[intervox_receiver.scala 185:30]
    node _clkCntr3_T_1 = tail(_clkCntr3_T, 1) @[intervox_receiver.scala 185:30]
    node _T_52 = eq(clkCntr3, UInt<1>("h0")) @[intervox_receiver.scala 187:23]
    node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 188:23]
    node _GEN_44 = mux(_T_52, _clkRec_T_3, _GEN_41) @[intervox_receiver.scala 187:31 188:20]
    node _T_53 = div(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 190:37]
    node _T_54 = eq(clkCntr3, _T_53) @[intervox_receiver.scala 190:24]
    node _GEN_45 = mux(_T_54, UInt<1>("h0"), _clkCntr3_T_1) @[intervox_receiver.scala 185:18 190:45 191:22]
    node _GEN_46 = mux(_T_51, _GEN_45, _GEN_42) @[intervox_receiver.scala 184:27]
    node _GEN_47 = mux(_T_51, _GEN_44, _GEN_41) @[intervox_receiver.scala 184:27]
    io_CLK_OUT <= clkRec @[intervox_receiver.scala 45:21]
    io_DATA_OUT <= dataOut @[intervox_receiver.scala 46:21]
    io_DBUG <= syncWord @[intervox_receiver.scala 47:21]
    io_DBUG1 <= change @[intervox_receiver.scala 48:21]
    clkCntr <= mux(reset, UInt<2>("h0"), _GEN_2) @[intervox_receiver.scala 27:{30,30}]
    clkCntr1 <= mux(reset, UInt<8>("h0"), _GEN_12) @[intervox_receiver.scala 28:{30,30}]
    clkCntr2 <= mux(reset, UInt<4>("h0"), _GEN_30) @[intervox_receiver.scala 29:{30,30}]
    clkCntr3 <= mux(reset, UInt<4>("h0"), _GEN_46) @[intervox_receiver.scala 30:{30,30}]
    clkDelta <= mux(reset, UInt<8>("h0"), _GEN_13) @[intervox_receiver.scala 31:{30,30}]
    lastOne <= mux(reset, UInt<8>("h7"), _GEN_18) @[intervox_receiver.scala 32:{30,30}]
    pllCntr <= mux(reset, UInt<8>("h0"), _GEN_1) @[intervox_receiver.scala 33:{30,30}]
    inBufr <= mux(reset, UInt<2>("h0"), _GEN_7) @[intervox_receiver.scala 34:{30,30}]
    whatChange <= mux(reset, UInt<2>("h0"), _GEN_27) @[intervox_receiver.scala 35:{30,30}]
    outReg <= mux(reset, UInt<1>("h0"), _GEN_0) @[intervox_receiver.scala 37:{30,30}]
    clkRec <= mux(reset, UInt<1>("h0"), _GEN_47) @[intervox_receiver.scala 38:{30,30}]
    change <= mux(reset, UInt<1>("h0"), _GEN_11) @[intervox_receiver.scala 39:{30,30}]
    dataOut <= mux(reset, UInt<1>("h0"), _GEN_20) @[intervox_receiver.scala 40:{30,30}]
    nextFrame <= mux(reset, UInt<1>("h0"), nextFrame) @[intervox_receiver.scala 41:{30,30,30}]
    zeroPeriode <= mux(reset, UInt<1>("h0"), _GEN_43) @[intervox_receiver.scala 42:{30,30}]
    syncWord <= mux(reset, UInt<1>("h0"), _GEN_37) @[intervox_receiver.scala 43:{30,30}]

  extmodule clk_wiz_0_clk_wiz :
    output PLL_MCLK : UInt<1>
    output locked : UInt<1>
    input PLL_IN : UInt<1>
    defname = clk_wiz_0_clk_wiz

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    input io_INTERVOX_IN : UInt<1>
    output io_CLK_REC : UInt<1>
    output io_DATA_OUT : UInt<1>
    output io_NEXT_FRAME : UInt<1>
    output io_DBUG : UInt<1>
    output io_DBUG1 : UInt<1>

    inst clockRec of clock_Recovery @[intervox_receiver.scala 207:26]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 216:21]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 222:24]
    node _GEN_0 = mux(_T, pll.PLL_MCLK, UInt<1>("h0")) @[intervox_receiver.scala 222:32 223:20 226:20]
    io_CLK_REC <= _GEN_0
    io_DATA_OUT <= clockRec.io_DATA_OUT @[intervox_receiver.scala 210:25]
    io_NEXT_FRAME <= clockRec.io_DBUG @[intervox_receiver.scala 211:25]
    io_DBUG <= clockRec.io_CLK_OUT @[intervox_receiver.scala 213:25]
    io_DBUG1 <= clockRec.io_DBUG1 @[intervox_receiver.scala 212:25]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io_DATA_IN <= io_INTERVOX_IN @[intervox_receiver.scala 209:25]
    pll.PLL_IN <= clockRec.io_CLK_OUT @[intervox_receiver.scala 219:19]
