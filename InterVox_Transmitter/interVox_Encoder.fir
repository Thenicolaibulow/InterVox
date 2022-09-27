circuit interVox_Encoder :
  module bi_phase_encoder :
    input clock : Clock
    input reset : Reset
    output io : { flip DATA_IN : UInt<1>, DATA_OUT : UInt<1>, flip NxtBit : UInt<1>}

    reg hasNone : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 16:26]
    reg outReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 17:26]
    io.DATA_OUT <= outReg @[intervox_transmitter.scala 18:17]
    node _T = eq(io.NxtBit, UInt<1>("h1")) @[intervox_transmitter.scala 20:20]
    when _T : @[intervox_transmitter.scala 20:28]
      node _T_1 = eq(io.DATA_IN, UInt<1>("h0")) @[intervox_transmitter.scala 22:23]
      when _T_1 : @[intervox_transmitter.scala 22:32]
        hasNone <= UInt<1>("h1") @[intervox_transmitter.scala 24:17]
      node _T_2 = eq(hasNone, UInt<1>("h1")) @[intervox_transmitter.scala 26:20]
      when _T_2 : @[intervox_transmitter.scala 26:28]
        outReg <= outReg @[intervox_transmitter.scala 27:16]
        hasNone <= UInt<1>("h0") @[intervox_transmitter.scala 28:17]
      else :
        node _outReg_T = not(outReg) @[intervox_transmitter.scala 32:19]
        outReg <= _outReg_T @[intervox_transmitter.scala 32:16]

  module interVox_Encoder :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip MCLK_IN : Clock, flip BCLK_IN : UInt<1>, flip LRCLK_IN : UInt<1>, flip SDATA_IN : UInt<1>, DATA_O : UInt<1>, LRCLK_O : UInt<1>, BCLK_O : UInt<1>, MCLK_O : Clock, SDATA_O : UInt<1>}

    reg current_state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_transmitter.scala 53:30]
    reg BiPhase_CLK_CNTR : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_transmitter.scala 55:33]
    reg DATA_OUT_REG : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_transmitter.scala 57:29]
    inst bi_phase_enc of bi_phase_encoder @[intervox_transmitter.scala 58:28]
    bi_phase_enc.clock <= clock
    bi_phase_enc.reset <= reset
    io.DATA_O <= DATA_OUT_REG @[intervox_transmitter.scala 60:13]
    io.MCLK_O <= io.MCLK_IN @[intervox_transmitter.scala 61:13]
    io.BCLK_O <= io.BCLK_IN @[intervox_transmitter.scala 62:13]
    io.LRCLK_O <= io.LRCLK_IN @[intervox_transmitter.scala 63:14]
    io.SDATA_O <= io.SDATA_IN @[intervox_transmitter.scala 64:14]
    bi_phase_enc.io.DATA_IN <= UInt<1>("h0") @[intervox_transmitter.scala 65:27]
    bi_phase_enc.io.NxtBit <= UInt<1>("h0") @[intervox_transmitter.scala 66:26]
    node _BiPhase_CLK_CNTR_T = add(BiPhase_CLK_CNTR, UInt<1>("h1")) @[intervox_transmitter.scala 72:42]
    node _BiPhase_CLK_CNTR_T_1 = tail(_BiPhase_CLK_CNTR_T, 1) @[intervox_transmitter.scala 72:42]
    BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_1 @[intervox_transmitter.scala 72:22]
    node _T = eq(BiPhase_CLK_CNTR, UInt<4>("h8")) @[intervox_transmitter.scala 73:27]
    when _T : @[intervox_transmitter.scala 73:35]
      node _T_1 = eq(UInt<2>("h0"), current_state) @[intervox_transmitter.scala 75:29]
      when _T_1 : @[intervox_transmitter.scala 75:29]
        current_state <= UInt<2>("h2") @[intervox_transmitter.scala 78:25]
      else :
        node _T_2 = eq(UInt<2>("h1"), current_state) @[intervox_transmitter.scala 75:29]
        when _T_2 : @[intervox_transmitter.scala 75:29]
          current_state <= UInt<2>("h2") @[intervox_transmitter.scala 81:25]
        else :
          node _T_3 = eq(UInt<2>("h2"), current_state) @[intervox_transmitter.scala 75:29]
          when _T_3 : @[intervox_transmitter.scala 75:29]
            bi_phase_enc.io.NxtBit <= UInt<1>("h1") @[intervox_transmitter.scala 84:34]
            bi_phase_enc.io.DATA_IN <= io.SDATA_IN @[intervox_transmitter.scala 86:35]
            DATA_OUT_REG <= bi_phase_enc.io.DATA_OUT @[intervox_transmitter.scala 87:24]
      BiPhase_CLK_CNTR <= UInt<1>("h0") @[intervox_transmitter.scala 90:22]

