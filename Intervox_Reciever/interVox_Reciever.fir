circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : Reset
    output io : { flip DATA_IN : UInt<1>, CLK_OUT : UInt<1>}

    node _expected_cycles_syncword_T = mul(UInt<6>("h20"), UInt<3>("h4")) @[intervox_receiver.scala 11:42]
    node _expected_cycles_syncword_T_1 = sub(_expected_cycles_syncword_T, UInt<1>("h1")) @[intervox_receiver.scala 11:49]
    node expected_cycles_syncword = tail(_expected_cycles_syncword_T_1, 1) @[intervox_receiver.scala 11:49]
    node _expected_cycles_zero_T = sub(UInt<7>("h40"), UInt<1>("h1")) @[intervox_receiver.scala 12:37]
    node expected_cycles_zero = tail(_expected_cycles_zero_T, 1) @[intervox_receiver.scala 12:37]
    node _expected_cycles_one_T = sub(UInt<6>("h20"), UInt<1>("h1")) @[intervox_receiver.scala 13:36]
    node expected_cycles_one = tail(_expected_cycles_one_T, 1) @[intervox_receiver.scala 13:36]
    reg clkCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 15:30]
    reg inState : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 16:30]
    reg inStateWas : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 17:30]
    reg outReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 18:30]
    reg hasOne : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 19:30]
    reg hasZero : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 20:30]
    reg nextFrame : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 21:30]
    io.CLK_OUT <= outReg @[intervox_receiver.scala 23:16]
    node _T = eq(UInt<1>("h0"), io.DATA_IN) @[intervox_receiver.scala 25:23]
    when _T : @[intervox_receiver.scala 25:23]
      node _T_1 = eq(inState, UInt<1>("h1")) @[intervox_receiver.scala 28:27]
      when _T_1 : @[intervox_receiver.scala 28:36]
        inState <= UInt<1>("h0") @[intervox_receiver.scala 29:25]
      node _clkCntr_T = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 31:32]
      node _clkCntr_T_1 = tail(_clkCntr_T, 1) @[intervox_receiver.scala 31:32]
      clkCntr <= _clkCntr_T_1 @[intervox_receiver.scala 31:21]
    else :
      node _T_2 = eq(UInt<1>("h1"), io.DATA_IN) @[intervox_receiver.scala 25:23]
      when _T_2 : @[intervox_receiver.scala 25:23]
        node _T_3 = eq(inState, UInt<1>("h0")) @[intervox_receiver.scala 34:26]
        when _T_3 : @[intervox_receiver.scala 34:34]
          inState <= UInt<1>("h1") @[intervox_receiver.scala 35:25]
        node _clkCntr_T_2 = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 37:32]
        node _clkCntr_T_3 = tail(_clkCntr_T_2, 1) @[intervox_receiver.scala 37:32]
        clkCntr <= _clkCntr_T_3 @[intervox_receiver.scala 37:21]
    node _T_4 = sub(expected_cycles_syncword, UInt<5>("h10")) @[intervox_receiver.scala 42:47]
    node _T_5 = tail(_T_4, 1) @[intervox_receiver.scala 42:47]
    node _T_6 = geq(clkCntr, _T_5) @[intervox_receiver.scala 42:18]
    when _T_6 : @[intervox_receiver.scala 42:55]
      node _T_7 = eq(inState, UInt<1>("h1")) @[intervox_receiver.scala 44:22]
      when _T_7 : @[intervox_receiver.scala 44:30]
        nextFrame <= UInt<1>("h1") @[intervox_receiver.scala 46:23]
      node _T_8 = geq(clkCntr, expected_cycles_syncword) @[intervox_receiver.scala 48:22]
      when _T_8 : @[intervox_receiver.scala 48:52]
        clkCntr <= UInt<1>("h0") @[intervox_receiver.scala 50:21]
    node _T_9 = div(expected_cycles_one, UInt<2>("h2")) @[intervox_receiver.scala 54:42]
    node _T_10 = geq(clkCntr, _T_9) @[intervox_receiver.scala 54:18]
    when _T_10 : @[intervox_receiver.scala 54:49]
      node _T_11 = eq(inState, UInt<1>("h1")) @[intervox_receiver.scala 55:22]
      when _T_11 : @[intervox_receiver.scala 55:30]
        hasOne <= UInt<1>("h1") @[intervox_receiver.scala 56:20]
      node _T_12 = geq(clkCntr, expected_cycles_one) @[intervox_receiver.scala 58:22]
      when _T_12 : @[intervox_receiver.scala 58:47]
        clkCntr <= UInt<1>("h0") @[intervox_receiver.scala 59:21]
    node _T_13 = div(expected_cycles_zero, UInt<2>("h2")) @[intervox_receiver.scala 63:43]
    node _T_14 = geq(clkCntr, _T_13) @[intervox_receiver.scala 63:18]
    when _T_14 : @[intervox_receiver.scala 63:50]
      node _T_15 = eq(inState, UInt<1>("h1")) @[intervox_receiver.scala 64:22]
      when _T_15 : @[intervox_receiver.scala 64:30]
        hasZero <= UInt<1>("h1") @[intervox_receiver.scala 65:21]
      node _T_16 = geq(clkCntr, expected_cycles_zero) @[intervox_receiver.scala 67:22]
      when _T_16 : @[intervox_receiver.scala 67:48]
        clkCntr <= UInt<1>("h0") @[intervox_receiver.scala 68:21]
    node _T_17 = eq(clkCntr, UInt<5>("h10")) @[intervox_receiver.scala 72:18]
    when _T_17 : @[intervox_receiver.scala 72:27]
      node _outReg_T = not(outReg) @[intervox_receiver.scala 73:19]
      outReg <= _outReg_T @[intervox_receiver.scala 73:16]

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 84:26]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 86:25]
    io.CLK_REC <= clockRec.io.CLK_OUT @[intervox_receiver.scala 87:16]

