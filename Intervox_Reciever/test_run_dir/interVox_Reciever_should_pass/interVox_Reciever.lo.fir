circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : UInt<1>
    input io_DATA_IN : UInt<1>
    output io_CLK_OUT : UInt<1>
    output io_DATA_OUT : UInt<1>
    output io_NEXT_FRAME : UInt<1>

    node _expected_cycles_syncword_T = mul(UInt<6>("h20"), UInt<3>("h4")) @[intervox_receiver.scala 13:42]
    node _expected_cycles_syncword_T_1 = sub(_expected_cycles_syncword_T, UInt<1>("h1")) @[intervox_receiver.scala 13:49]
    node expected_cycles_syncword = tail(_expected_cycles_syncword_T_1, 1) @[intervox_receiver.scala 13:49]
    node _expected_cycles_zero_T = sub(UInt<7>("h40"), UInt<1>("h1")) @[intervox_receiver.scala 14:37]
    node expected_cycles_zero = tail(_expected_cycles_zero_T, 1) @[intervox_receiver.scala 14:37]
    node _expected_cycles_one_T = sub(UInt<6>("h20"), UInt<1>("h1")) @[intervox_receiver.scala 15:36]
    node expected_cycles_one = tail(_expected_cycles_one_T, 1) @[intervox_receiver.scala 15:36]
    reg clkCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), clkCntr) @[intervox_receiver.scala 17:30]
    reg inState : UInt<1>, clock with :
      reset => (UInt<1>("h0"), inState) @[intervox_receiver.scala 18:30]
    reg prevInState : UInt<1>, clock with :
      reset => (UInt<1>("h0"), prevInState) @[intervox_receiver.scala 19:30]
    reg inStateWas : UInt<1>, clock with :
      reset => (UInt<1>("h0"), inStateWas) @[intervox_receiver.scala 20:30]
    reg outReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), outReg) @[intervox_receiver.scala 21:30]
    reg dataOut : UInt<1>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[intervox_receiver.scala 22:30]
    reg nextFrame : UInt<1>, clock with :
      reset => (UInt<1>("h0"), nextFrame) @[intervox_receiver.scala 23:30]
    reg noChange : UInt<1>, clock with :
      reset => (UInt<1>("h0"), noChange) @[intervox_receiver.scala 24:29]
    node _T = eq(UInt<1>("h0"), io_DATA_IN) @[intervox_receiver.scala 31:23]
    node _T_1 = eq(inState, UInt<1>("h1")) @[intervox_receiver.scala 35:27]
    node _GEN_0 = mux(_T_1, UInt<1>("h0"), inState) @[intervox_receiver.scala 35:36 37:25 18:30]
    node _clkCntr_T = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 40:32]
    node _clkCntr_T_1 = tail(_clkCntr_T, 1) @[intervox_receiver.scala 40:32]
    node _T_2 = eq(UInt<1>("h1"), io_DATA_IN) @[intervox_receiver.scala 31:23]
    node _T_3 = eq(inState, UInt<1>("h0")) @[intervox_receiver.scala 44:26]
    node _GEN_1 = mux(_T_3, UInt<1>("h1"), inState) @[intervox_receiver.scala 44:34 46:25 18:30]
    node _clkCntr_T_2 = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 49:32]
    node _clkCntr_T_3 = tail(_clkCntr_T_2, 1) @[intervox_receiver.scala 49:32]
    node _GEN_2 = mux(_T_2, _GEN_1, inState) @[intervox_receiver.scala 31:23 18:30]
    node _GEN_3 = mux(_T_2, _clkCntr_T_3, clkCntr) @[intervox_receiver.scala 31:23 49:21 17:30]
    node _GEN_4 = mux(_T, _GEN_0, _GEN_2) @[intervox_receiver.scala 31:23]
    node _GEN_5 = mux(_T, _clkCntr_T_1, _GEN_3) @[intervox_receiver.scala 31:23 40:21]
    node _T_4 = sub(expected_cycles_syncword, UInt<5>("h10")) @[intervox_receiver.scala 53:47]
    node _T_5 = tail(_T_4, 1) @[intervox_receiver.scala 53:47]
    node _T_6 = geq(clkCntr, _T_5) @[intervox_receiver.scala 53:18]
    node _T_7 = eq(inState, UInt<1>("h1")) @[intervox_receiver.scala 55:22]
    node _GEN_6 = mux(_T_7, UInt<1>("h1"), nextFrame) @[intervox_receiver.scala 55:30 57:23 23:30]
    node _T_8 = geq(clkCntr, expected_cycles_syncword) @[intervox_receiver.scala 59:22]
    node _GEN_7 = mux(_T_8, UInt<1>("h0"), _GEN_5) @[intervox_receiver.scala 59:52 61:21]
    node _GEN_8 = mux(_T_6, _GEN_6, nextFrame) @[intervox_receiver.scala 23:30 53:55]
    node _GEN_9 = mux(_T_6, _GEN_7, _GEN_5) @[intervox_receiver.scala 53:55]
    node _T_9 = eq(clkCntr, UInt<5>("h10")) @[intervox_receiver.scala 66:18]
    node _T_10 = eq(clkCntr, UInt<6>("h30")) @[intervox_receiver.scala 66:38]
    node _T_11 = or(_T_9, _T_10) @[intervox_receiver.scala 66:27]
    node _T_12 = eq(inState, io_DATA_IN) @[intervox_receiver.scala 68:22]
    node _GEN_10 = mux(_T_12, UInt<1>("h1"), noChange) @[intervox_receiver.scala 68:37 70:22 24:29]
    node _T_13 = not(io_DATA_IN) @[intervox_receiver.scala 73:26]
    node _T_14 = eq(inState, _T_13) @[intervox_receiver.scala 73:22]
    node _GEN_11 = mux(_T_14, UInt<1>("h0"), _GEN_10) @[intervox_receiver.scala 73:38 75:22]
    node _GEN_12 = mux(_T_11, _GEN_11, noChange) @[intervox_receiver.scala 24:29 66:47]
    node _T_15 = eq(clkCntr, expected_cycles_one) @[intervox_receiver.scala 79:18]
    node _T_16 = eq(noChange, UInt<1>("h0")) @[intervox_receiver.scala 81:23]
    node _GEN_13 = mux(_T_16, UInt<1>("h1"), dataOut) @[intervox_receiver.scala 81:31 83:21 22:30]
    node _GEN_14 = mux(_T_16, UInt<1>("h0"), _GEN_9) @[intervox_receiver.scala 81:31 84:21]
    node _GEN_15 = mux(_T_15, _GEN_13, dataOut) @[intervox_receiver.scala 22:30 79:42]
    node _GEN_16 = mux(_T_15, _GEN_14, _GEN_9) @[intervox_receiver.scala 79:42]
    node _T_17 = gt(clkCntr, expected_cycles_one) @[intervox_receiver.scala 88:18]
    node _T_18 = eq(noChange, UInt<1>("h1")) @[intervox_receiver.scala 90:23]
    node _GEN_17 = mux(_T_18, UInt<1>("h0"), _GEN_15) @[intervox_receiver.scala 90:31 92:21]
    node _T_19 = eq(clkCntr, expected_cycles_zero) @[intervox_receiver.scala 95:22]
    node _GEN_18 = mux(_T_19, UInt<1>("h0"), _GEN_16) @[intervox_receiver.scala 95:47 97:21]
    node _GEN_19 = mux(_T_17, _GEN_17, _GEN_15) @[intervox_receiver.scala 88:40]
    node _GEN_20 = mux(_T_17, _GEN_18, _GEN_16) @[intervox_receiver.scala 88:40]
    node _T_20 = eq(clkCntr, UInt<4>("hf")) @[intervox_receiver.scala 101:19]
    node _T_21 = eq(clkCntr, UInt<5>("h1f")) @[intervox_receiver.scala 101:41]
    node _T_22 = or(_T_20, _T_21) @[intervox_receiver.scala 101:29]
    node _T_23 = eq(clkCntr, UInt<6>("h2f")) @[intervox_receiver.scala 101:63]
    node _T_24 = or(_T_22, _T_23) @[intervox_receiver.scala 101:51]
    node _T_25 = eq(clkCntr, UInt<6>("h3f")) @[intervox_receiver.scala 101:85]
    node _T_26 = or(_T_24, _T_25) @[intervox_receiver.scala 101:73]
    node _outReg_T = not(outReg) @[intervox_receiver.scala 102:19]
    node _GEN_21 = mux(_T_26, _outReg_T, outReg) @[intervox_receiver.scala 101:95 102:16 21:30]
    io_CLK_OUT <= outReg @[intervox_receiver.scala 26:21]
    io_DATA_OUT <= dataOut @[intervox_receiver.scala 27:21]
    io_NEXT_FRAME <= nextFrame @[intervox_receiver.scala 28:21]
    clkCntr <= mux(reset, UInt<8>("h0"), _GEN_20) @[intervox_receiver.scala 17:{30,30}]
    inState <= mux(reset, UInt<1>("h0"), _GEN_4) @[intervox_receiver.scala 18:{30,30}]
    prevInState <= mux(reset, UInt<1>("h0"), prevInState) @[intervox_receiver.scala 19:{30,30,30}]
    inStateWas <= mux(reset, UInt<1>("h0"), inStateWas) @[intervox_receiver.scala 20:{30,30,30}]
    outReg <= mux(reset, UInt<1>("h0"), _GEN_21) @[intervox_receiver.scala 21:{30,30}]
    dataOut <= mux(reset, UInt<1>("h0"), _GEN_19) @[intervox_receiver.scala 22:{30,30}]
    nextFrame <= mux(reset, UInt<1>("h0"), _GEN_8) @[intervox_receiver.scala 23:{30,30}]
    noChange <= mux(reset, UInt<1>("h0"), _GEN_12) @[intervox_receiver.scala 24:{29,29}]

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    input io_INTERVOX_IN : UInt<1>
    output io_CLK_REC : UInt<1>
    output io_DATA_OUT : UInt<1>
    output io_NEXT_FRAME : UInt<1>

    inst clockRec of clock_Recovery @[intervox_receiver.scala 116:26]
    io_CLK_REC <= clockRec.io_CLK_OUT @[intervox_receiver.scala 119:21]
    io_DATA_OUT <= clockRec.io_DATA_OUT @[intervox_receiver.scala 120:22]
    io_NEXT_FRAME <= clockRec.io_NEXT_FRAME @[intervox_receiver.scala 121:21]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io_DATA_IN <= io_INTERVOX_IN @[intervox_receiver.scala 118:25]
