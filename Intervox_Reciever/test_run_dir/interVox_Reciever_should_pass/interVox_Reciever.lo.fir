circuit interVox_Reciever :
  extmodule clk_wiz_0_clk_wiz :
    output MCLK_48K : UInt<1>
    output MCLK_44K : UInt<1>
    output locked : UInt<1>
    input clk_in1 : UInt<1>
    defname = clk_wiz_0_clk_wiz

  module clock_Recovery :
    input clock : Clock
    input reset : UInt<1>
    input io_DATA_IN : UInt<1>
    output io_CLK_OUT : UInt<1>
    output io_DATA_OUT : UInt<1>
    output io_NEXT_FRAME : UInt<1>

    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 25:21]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 29:24]
    node _GEN_0 = mux(_T, pll.MCLK_48K, UInt<1>("h0")) @[intervox_receiver.scala 29:32 30:20 33:20]
    node _expected_cycles_syncword_T = mul(UInt<6>("h20"), UInt<3>("h4")) @[intervox_receiver.scala 38:42]
    node _expected_cycles_syncword_T_1 = sub(_expected_cycles_syncword_T, UInt<1>("h1")) @[intervox_receiver.scala 38:49]
    node expected_cycles_syncword = tail(_expected_cycles_syncword_T_1, 1) @[intervox_receiver.scala 38:49]
    node _expected_cycles_zero_T = sub(UInt<7>("h40"), UInt<1>("h1")) @[intervox_receiver.scala 39:37]
    node expected_cycles_zero = tail(_expected_cycles_zero_T, 1) @[intervox_receiver.scala 39:37]
    node _expected_cycles_one_T = sub(UInt<6>("h20"), UInt<1>("h1")) @[intervox_receiver.scala 40:36]
    node expected_cycles_one = tail(_expected_cycles_one_T, 1) @[intervox_receiver.scala 40:36]
    reg clkCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), clkCntr) @[intervox_receiver.scala 42:30]
    reg inState : UInt<1>, clock with :
      reset => (UInt<1>("h0"), inState) @[intervox_receiver.scala 43:30]
    reg prevInState : UInt<1>, clock with :
      reset => (UInt<1>("h0"), prevInState) @[intervox_receiver.scala 44:30]
    reg inStateWas : UInt<1>, clock with :
      reset => (UInt<1>("h0"), inStateWas) @[intervox_receiver.scala 45:30]
    reg outReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), outReg) @[intervox_receiver.scala 46:30]
    reg dataOut : UInt<1>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[intervox_receiver.scala 47:30]
    reg nextFrame : UInt<1>, clock with :
      reset => (UInt<1>("h0"), nextFrame) @[intervox_receiver.scala 48:30]
    reg noChange : UInt<1>, clock with :
      reset => (UInt<1>("h0"), noChange) @[intervox_receiver.scala 49:29]
    node _T_1 = eq(UInt<1>("h0"), io_DATA_IN) @[intervox_receiver.scala 56:23]
    node _T_2 = eq(inState, UInt<1>("h1")) @[intervox_receiver.scala 60:27]
    node _GEN_1 = mux(_T_2, UInt<1>("h0"), inState) @[intervox_receiver.scala 60:36 62:25 43:30]
    node _clkCntr_T = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 65:32]
    node _clkCntr_T_1 = tail(_clkCntr_T, 1) @[intervox_receiver.scala 65:32]
    node _T_3 = eq(UInt<1>("h1"), io_DATA_IN) @[intervox_receiver.scala 56:23]
    node _T_4 = eq(inState, UInt<1>("h0")) @[intervox_receiver.scala 69:26]
    node _GEN_2 = mux(_T_4, UInt<1>("h1"), inState) @[intervox_receiver.scala 69:34 71:25 43:30]
    node _clkCntr_T_2 = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 74:32]
    node _clkCntr_T_3 = tail(_clkCntr_T_2, 1) @[intervox_receiver.scala 74:32]
    node _GEN_3 = mux(_T_3, _GEN_2, inState) @[intervox_receiver.scala 56:23 43:30]
    node _GEN_4 = mux(_T_3, _clkCntr_T_3, clkCntr) @[intervox_receiver.scala 56:23 74:21 42:30]
    node _GEN_5 = mux(_T_1, _GEN_1, _GEN_3) @[intervox_receiver.scala 56:23]
    node _GEN_6 = mux(_T_1, _clkCntr_T_1, _GEN_4) @[intervox_receiver.scala 56:23 65:21]
    node _T_5 = sub(expected_cycles_syncword, UInt<5>("h10")) @[intervox_receiver.scala 78:47]
    node _T_6 = tail(_T_5, 1) @[intervox_receiver.scala 78:47]
    node _T_7 = geq(clkCntr, _T_6) @[intervox_receiver.scala 78:18]
    node _T_8 = eq(inState, UInt<1>("h1")) @[intervox_receiver.scala 80:22]
    node _GEN_7 = mux(_T_8, UInt<1>("h1"), nextFrame) @[intervox_receiver.scala 80:30 82:23 48:30]
    node _T_9 = geq(clkCntr, expected_cycles_syncword) @[intervox_receiver.scala 84:22]
    node _GEN_8 = mux(_T_9, UInt<1>("h0"), _GEN_6) @[intervox_receiver.scala 84:52 86:21]
    node _GEN_9 = mux(_T_7, _GEN_7, nextFrame) @[intervox_receiver.scala 48:30 78:55]
    node _GEN_10 = mux(_T_7, _GEN_8, _GEN_6) @[intervox_receiver.scala 78:55]
    node _T_10 = eq(clkCntr, UInt<5>("h10")) @[intervox_receiver.scala 91:18]
    node _T_11 = eq(clkCntr, UInt<6>("h30")) @[intervox_receiver.scala 91:38]
    node _T_12 = or(_T_10, _T_11) @[intervox_receiver.scala 91:27]
    node _T_13 = eq(inState, io_DATA_IN) @[intervox_receiver.scala 93:22]
    node _GEN_11 = mux(_T_13, UInt<1>("h1"), noChange) @[intervox_receiver.scala 93:37 95:22 49:29]
    node _T_14 = not(io_DATA_IN) @[intervox_receiver.scala 98:26]
    node _T_15 = eq(inState, _T_14) @[intervox_receiver.scala 98:22]
    node _GEN_12 = mux(_T_15, UInt<1>("h0"), _GEN_11) @[intervox_receiver.scala 100:22 98:38]
    node _GEN_13 = mux(_T_12, _GEN_12, noChange) @[intervox_receiver.scala 49:29 91:47]
    node _T_16 = eq(clkCntr, expected_cycles_one) @[intervox_receiver.scala 104:18]
    node _T_17 = eq(noChange, UInt<1>("h0")) @[intervox_receiver.scala 106:23]
    node _GEN_14 = mux(_T_17, UInt<1>("h1"), dataOut) @[intervox_receiver.scala 106:31 108:21 47:30]
    node _GEN_15 = mux(_T_17, UInt<1>("h0"), _GEN_10) @[intervox_receiver.scala 106:31 109:21]
    node _GEN_16 = mux(_T_16, _GEN_14, dataOut) @[intervox_receiver.scala 104:42 47:30]
    node _GEN_17 = mux(_T_16, _GEN_15, _GEN_10) @[intervox_receiver.scala 104:42]
    node _T_18 = gt(clkCntr, expected_cycles_one) @[intervox_receiver.scala 113:18]
    node _T_19 = eq(noChange, UInt<1>("h1")) @[intervox_receiver.scala 115:23]
    node _GEN_18 = mux(_T_19, UInt<1>("h0"), _GEN_16) @[intervox_receiver.scala 115:31 117:21]
    node _T_20 = eq(clkCntr, expected_cycles_zero) @[intervox_receiver.scala 120:22]
    node _GEN_19 = mux(_T_20, UInt<1>("h0"), _GEN_17) @[intervox_receiver.scala 120:47 122:21]
    node _GEN_20 = mux(_T_18, _GEN_18, _GEN_16) @[intervox_receiver.scala 113:40]
    node _GEN_21 = mux(_T_18, _GEN_19, _GEN_17) @[intervox_receiver.scala 113:40]
    node _T_21 = eq(clkCntr, UInt<4>("hf")) @[intervox_receiver.scala 126:19]
    node _T_22 = eq(clkCntr, UInt<5>("h1f")) @[intervox_receiver.scala 126:41]
    node _T_23 = or(_T_21, _T_22) @[intervox_receiver.scala 126:29]
    node _T_24 = eq(clkCntr, UInt<6>("h2f")) @[intervox_receiver.scala 126:63]
    node _T_25 = or(_T_23, _T_24) @[intervox_receiver.scala 126:51]
    node _T_26 = eq(clkCntr, UInt<6>("h3f")) @[intervox_receiver.scala 126:85]
    node _T_27 = or(_T_25, _T_26) @[intervox_receiver.scala 126:73]
    node _outReg_T = not(outReg) @[intervox_receiver.scala 127:19]
    node _GEN_22 = mux(_T_27, _outReg_T, outReg) @[intervox_receiver.scala 126:95 127:16 46:30]
    io_CLK_OUT <= _GEN_0
    io_DATA_OUT <= dataOut @[intervox_receiver.scala 52:21]
    io_NEXT_FRAME <= nextFrame @[intervox_receiver.scala 53:21]
    pll.clk_in1 <= io_DATA_IN @[intervox_receiver.scala 27:20]
    clkCntr <= mux(reset, UInt<8>("h0"), _GEN_21) @[intervox_receiver.scala 42:{30,30}]
    inState <= mux(reset, UInt<1>("h0"), _GEN_5) @[intervox_receiver.scala 43:{30,30}]
    prevInState <= mux(reset, UInt<1>("h0"), prevInState) @[intervox_receiver.scala 44:{30,30,30}]
    inStateWas <= mux(reset, UInt<1>("h0"), inStateWas) @[intervox_receiver.scala 45:{30,30,30}]
    outReg <= mux(reset, UInt<1>("h0"), _GEN_22) @[intervox_receiver.scala 46:{30,30}]
    dataOut <= mux(reset, UInt<1>("h0"), _GEN_20) @[intervox_receiver.scala 47:{30,30}]
    nextFrame <= mux(reset, UInt<1>("h0"), _GEN_9) @[intervox_receiver.scala 48:{30,30}]
    noChange <= mux(reset, UInt<1>("h0"), _GEN_13) @[intervox_receiver.scala 49:{29,29}]

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    input io_INTERVOX_IN : UInt<1>
    output io_CLK_REC : UInt<1>
    output io_DATA_OUT : UInt<1>
    output io_NEXT_FRAME : UInt<1>

    inst clockRec of clock_Recovery @[intervox_receiver.scala 141:26]
    io_CLK_REC <= clockRec.io_CLK_OUT @[intervox_receiver.scala 144:21]
    io_DATA_OUT <= clockRec.io_DATA_OUT @[intervox_receiver.scala 145:22]
    io_NEXT_FRAME <= clockRec.io_NEXT_FRAME @[intervox_receiver.scala 146:21]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io_DATA_IN <= io_INTERVOX_IN @[intervox_receiver.scala 143:25]
