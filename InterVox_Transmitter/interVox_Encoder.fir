circuit interVox_Encoder :
  module interVox_Encoder :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip MCLK_IN : Clock, flip BCLK_IN : Clock, flip LRCLK_IN : Clock, flip SDATA_IN : UInt<1>, DATA_O : UInt<1>}

    reg current_state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 22:30]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 24:33]
    reg DATA_OUT_REG : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 26:29]
    io.DATA_O <= DATA_OUT_REG @[intervox_transmitter.scala 27:13]
    node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 33:42]
    node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 33:42]
    BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_1 @[intervox_transmitter.scala 33:22]
    node _T = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 35:29]
    when _T : @[intervox_transmitter.scala 35:29]
      current_state <= UInt<2>("h2") @[intervox_transmitter.scala 38:25]
    else :
      node _T_1 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 35:29]
      when _T_1 : @[intervox_transmitter.scala 35:29]
        current_state <= UInt<2>("h2") @[intervox_transmitter.scala 41:25]
      else :
        node _T_2 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 35:29]
        when _T_2 : @[intervox_transmitter.scala 35:29]
          node _T_3 = eq(BiPhase_CLK_CNTR, UInt<2>("h2")) @[intervox_transmitter.scala 45:33]
          when _T_3 : @[intervox_transmitter.scala 45:42]
            node _T_4 = eq(io.SDATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 47:30]
            when _T_4 : @[intervox_transmitter.scala 47:39]
              node _DATA_OUT_REG_T = not(DATA_OUT_REG) @[intervox_transmitter.scala 49:31]
              DATA_OUT_REG <= _DATA_OUT_REG_T @[intervox_transmitter.scala 49:28]
            else :
              node _DATA_OUT_REG_T_1 = xor(DATA_OUT_REG, io.SDATA_IN) @[intervox_transmitter.scala 53:44]
              DATA_OUT_REG <= _DATA_OUT_REG_T_1 @[intervox_transmitter.scala 53:28]
            BiPhase_CLK_CNTR <= UInt<1>("h0") @[intervox_transmitter.scala 56:28]

