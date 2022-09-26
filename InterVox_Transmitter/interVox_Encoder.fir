circuit interVox_Encoder :
  module interVox_Encoder :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip MCLK_IN : Clock, flip BCLK_IN : UInt<1>, flip LRCLK_IN : UInt<1>, flip SDATA_IN : UInt<1>, DATA_O : UInt<1>, LRCLK_O : UInt<1>, BCLK_O : UInt<1>, MCLK_O : Clock, SDATA_O : UInt<1>}

    reg current_state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 27:30]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 29:33]
    reg hasOne : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 30:23]
    reg DATA_OUT_REG : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 32:29]
    io.DATA_O <= DATA_OUT_REG @[intervox_transmitter.scala 33:13]
    io.MCLK_O <= io.MCLK_IN @[intervox_transmitter.scala 35:13]
    io.BCLK_O <= io.BCLK_IN @[intervox_transmitter.scala 36:13]
    io.LRCLK_O <= io.LRCLK_IN @[intervox_transmitter.scala 37:14]
    io.SDATA_O <= io.SDATA_IN @[intervox_transmitter.scala 38:14]
    node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 44:42]
    node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 44:42]
    BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_1 @[intervox_transmitter.scala 44:22]
    node _T = eq(BiPhase_CLK_CNTR, UInt<2>("h3")) @[intervox_transmitter.scala 45:27]
    when _T : @[intervox_transmitter.scala 45:35]
      node _T_1 = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 47:29]
      when _T_1 : @[intervox_transmitter.scala 47:29]
        current_state <= UInt<2>("h2") @[intervox_transmitter.scala 50:25]
      else :
        node _T_2 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 47:29]
        when _T_2 : @[intervox_transmitter.scala 47:29]
          current_state <= UInt<2>("h2") @[intervox_transmitter.scala 53:25]
        else :
          node _T_3 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 47:29]
          when _T_3 : @[intervox_transmitter.scala 47:29]
            node _T_4 = eq(io.SDATA_IN, UInt<1>("h1")) @[intervox_transmitter.scala 58:28]
            when _T_4 : @[intervox_transmitter.scala 58:37]
              hasOne <= UInt<1>("h1") @[intervox_transmitter.scala 60:20]
            node _T_5 = eq(hasOne, UInt<1>("h1")) @[intervox_transmitter.scala 62:23]
            when _T_5 : @[intervox_transmitter.scala 62:31]
              DATA_OUT_REG <= DATA_OUT_REG @[intervox_transmitter.scala 63:26]
              hasOne <= UInt<1>("h0") @[intervox_transmitter.scala 64:20]
            else :
              node _DATA_OUT_REG_T = not(DATA_OUT_REG) @[intervox_transmitter.scala 68:29]
              DATA_OUT_REG <= _DATA_OUT_REG_T @[intervox_transmitter.scala 68:26]
      BiPhase_CLK_CNTR <= UInt<1>("h0") @[intervox_transmitter.scala 72:22]

