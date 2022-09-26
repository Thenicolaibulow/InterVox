circuit interVox_Encoder :
  module interVox_Encoder :
    input clock : Clock
    input reset : UInt<1>
    input io_SDATA_IN : UInt<1>
    output io_DATA_O : UInt<1>

    reg current_state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), current_state) @[intervox_transmitter.scala 22:30]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (UInt<1>("h0"), BiPhase_CLK_CNTR) @[intervox_transmitter.scala 24:33]
    reg hasOne : UInt<1>, clock with :
      reset => (UInt<1>("h0"), hasOne) @[intervox_transmitter.scala 25:23]
    reg DATA_OUT_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), DATA_OUT_REG) @[intervox_transmitter.scala 27:29]
    node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 34:42]
    node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 34:42]
    node _T = eq(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 35:27]
    node _T_1 = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 37:29]
    node _T_2 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 37:29]
    node _T_3 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 37:29]
    node _T_4 = eq(io_SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 48:28]
    node _GEN_0 = mux(_T_4, UInt<1>("h1"), hasOne) @[intervox_transmitter.scala 48:37 50:20 25:23]
    node _T_5 = eq(hasOne, UInt<1>("h1")) @[intervox_transmitter.scala 52:23]
    node _DATA_OUT_REG_T = not(DATA_OUT_REG) @[intervox_transmitter.scala 58:29]
    node _GEN_1 = mux(_T_5, DATA_OUT_REG, _DATA_OUT_REG_T) @[intervox_transmitter.scala 52:31 53:26 58:26]
    node _GEN_2 = mux(_T_5, UInt<1>("h0"), _GEN_0) @[intervox_transmitter.scala 52:31 54:20]
    node _GEN_3 = mux(_T_3, _GEN_2, hasOne) @[intervox_transmitter.scala 25:23 37:29]
    node _GEN_4 = mux(_T_3, _GEN_1, DATA_OUT_REG) @[intervox_transmitter.scala 27:29 37:29]
    node _GEN_5 = mux(_T_2, UInt<2>("h2"), current_state) @[intervox_transmitter.scala 37:29 43:25 22:30]
    node _GEN_6 = mux(_T_2, hasOne, _GEN_3) @[intervox_transmitter.scala 25:23 37:29]
    node _GEN_7 = mux(_T_2, DATA_OUT_REG, _GEN_4) @[intervox_transmitter.scala 27:29 37:29]
    node _GEN_8 = mux(_T_1, UInt<2>("h2"), _GEN_5) @[intervox_transmitter.scala 37:29 40:25]
    node _GEN_9 = mux(_T_1, hasOne, _GEN_6) @[intervox_transmitter.scala 25:23 37:29]
    node _GEN_10 = mux(_T_1, DATA_OUT_REG, _GEN_7) @[intervox_transmitter.scala 27:29 37:29]
    node _GEN_11 = mux(_T, _GEN_8, current_state) @[intervox_transmitter.scala 22:30 35:35]
    node _GEN_12 = mux(_T, _GEN_9, hasOne) @[intervox_transmitter.scala 25:23 35:35]
    node _GEN_13 = mux(_T, _GEN_10, DATA_OUT_REG) @[intervox_transmitter.scala 27:29 35:35]
    node _GEN_14 = mux(_T, UInt<1>("h0"), _BiPhase_CLK_CNTR_T_1) @[intervox_transmitter.scala 34:22 35:35 62:22]
    io_DATA_O <= DATA_OUT_REG @[intervox_transmitter.scala 28:13]
    current_state <= mux(reset, UInt<2>("h0"), _GEN_11) @[intervox_transmitter.scala 22:{30,30}]
    BiPhase_CLK_CNTR <= mux(reset, UInt<8>("h0"), _GEN_14) @[intervox_transmitter.scala 24:{33,33}]
    hasOne <= mux(reset, UInt<1>("h0"), _GEN_12) @[intervox_transmitter.scala 25:{23,23}]
    DATA_OUT_REG <= mux(reset, UInt<1>("h0"), _GEN_13) @[intervox_transmitter.scala 27:{29,29}]
