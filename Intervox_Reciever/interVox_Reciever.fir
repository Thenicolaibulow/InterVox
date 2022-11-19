circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : Reset
    output io : { flip DATA_IN : UInt<1>, CLK_OUT : UInt<1>, DATA_OUT : UInt<1>, NEXT_FRAME : UInt<1>}

    node _expected_cycles_syncword_T = mul(UInt<5>("h10"), UInt<3>("h4")) @[intervox_receiver.scala 25:42]
    node _expected_cycles_syncword_T_1 = sub(_expected_cycles_syncword_T, UInt<1>("h1")) @[intervox_receiver.scala 25:49]
    node expected_cycles_syncword = tail(_expected_cycles_syncword_T_1, 1) @[intervox_receiver.scala 25:49]
    node _expected_cycles_zero_T = sub(UInt<6>("h20"), UInt<1>("h1")) @[intervox_receiver.scala 26:37]
    node expected_cycles_zero = tail(_expected_cycles_zero_T, 1) @[intervox_receiver.scala 26:37]
    node _expected_cycles_one_T = sub(UInt<5>("h10"), UInt<1>("h1")) @[intervox_receiver.scala 27:36]
    node expected_cycles_one = tail(_expected_cycles_one_T, 1) @[intervox_receiver.scala 27:36]
    node _expected_nr_of_incoming_bits_T = sub(UInt<7>("h40"), UInt<1>("h1")) @[intervox_receiver.scala 28:45]
    node expected_nr_of_incoming_bits = tail(_expected_nr_of_incoming_bits_T, 1) @[intervox_receiver.scala 28:45]
    node _oversampling_factor_T = sub(UInt<5>("h10"), UInt<1>("h1")) @[intervox_receiver.scala 29:36]
    node oversampling_factor = tail(_oversampling_factor_T, 1) @[intervox_receiver.scala 29:36]
    reg clkCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 31:30]
    reg clkCntr1 : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 32:30]
    reg pllCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 33:30]
    reg bufCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 34:30]
    reg bitIn : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[intervox_receiver.scala 35:30]
    reg bitInBuf : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[intervox_receiver.scala 36:30]
    reg bitCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 37:30]
    reg outReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 39:30]
    reg dataOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 40:30]
    reg sync_lo : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 41:30]
    reg sync_hi : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 42:30]
    reg bitsReady : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 43:30]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 44:30]
    reg enaBuf : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 45:30]
    io.CLK_OUT <= outReg @[intervox_receiver.scala 47:21]
    io.DATA_OUT <= change @[intervox_receiver.scala 48:21]
    io.NEXT_FRAME <= UInt<1>("h0") @[intervox_receiver.scala 49:21]
    node _pllCntr_T = add(pllCntr, UInt<1>("h1")) @[intervox_receiver.scala 53:24]
    node _pllCntr_T_1 = tail(_pllCntr_T, 1) @[intervox_receiver.scala 53:24]
    pllCntr <= _pllCntr_T_1 @[intervox_receiver.scala 53:13]
    node _T = eq(pllCntr, UInt<4>("h9")) @[intervox_receiver.scala 54:18]
    when _T : @[intervox_receiver.scala 54:26]
      node _outReg_T = not(outReg) @[intervox_receiver.scala 55:19]
      outReg <= _outReg_T @[intervox_receiver.scala 55:16]
      pllCntr <= UInt<2>("h2") @[intervox_receiver.scala 56:17]
    node _clkCntr_T = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 59:24]
    node _clkCntr_T_1 = tail(_clkCntr_T, 1) @[intervox_receiver.scala 59:24]
    clkCntr <= _clkCntr_T_1 @[intervox_receiver.scala 59:13]
    node _T_1 = eq(clkCntr, expected_cycles_syncword) @[intervox_receiver.scala 61:18]
    when _T_1 : @[intervox_receiver.scala 61:47]
      clkCntr <= UInt<1>("h0") @[intervox_receiver.scala 62:17]
    node _T_2 = eq(bitCntr, UInt<1>("h0")) @[intervox_receiver.scala 65:18]
    when _T_2 : @[intervox_receiver.scala 65:26]
      node _T_3 = eq(io.DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 67:25]
      when _T_3 : @[intervox_receiver.scala 67:33]
        node _clkCntr1_T = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 68:34]
        node _clkCntr1_T_1 = tail(_clkCntr1_T, 1) @[intervox_receiver.scala 68:34]
        clkCntr1 <= _clkCntr1_T_1 @[intervox_receiver.scala 68:22]
        node _T_4 = mul(expected_cycles_one, UInt<2>("h3")) @[intervox_receiver.scala 70:52]
        node _T_5 = eq(clkCntr1, _T_4) @[intervox_receiver.scala 70:27]
        when _T_5 : @[intervox_receiver.scala 70:59]
          sync_lo <= UInt<1>("h1") @[intervox_receiver.scala 71:25]
      node _T_6 = eq(sync_lo, UInt<1>("h1")) @[intervox_receiver.scala 74:22]
      when _T_6 : @[intervox_receiver.scala 74:30]
        node _clkCntr1_T_2 = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 75:34]
        node _clkCntr1_T_3 = tail(_clkCntr1_T_2, 1) @[intervox_receiver.scala 75:34]
        clkCntr1 <= _clkCntr1_T_3 @[intervox_receiver.scala 75:22]
        node _T_7 = eq(clkCntr1, expected_cycles_syncword) @[intervox_receiver.scala 77:27]
        when _T_7 : @[intervox_receiver.scala 77:56]
          sync_hi <= UInt<1>("h1") @[intervox_receiver.scala 78:25]
          clkCntr1 <= UInt<1>("h0") @[intervox_receiver.scala 79:26]
    node _T_8 = eq(bitCntr, expected_nr_of_incoming_bits) @[intervox_receiver.scala 85:18]
    when _T_8 : @[intervox_receiver.scala 85:51]
      bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 86:17]
    node _T_9 = eq(sync_lo, UInt<1>("h1")) @[intervox_receiver.scala 90:19]
    node _T_10 = eq(sync_hi, UInt<1>("h1")) @[intervox_receiver.scala 90:39]
    node _T_11 = and(_T_9, _T_10) @[intervox_receiver.scala 90:28]
    when _T_11 : @[intervox_receiver.scala 90:48]
      node _clkCntr1_T_4 = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 92:30]
      node _clkCntr1_T_5 = tail(_clkCntr1_T_4, 1) @[intervox_receiver.scala 92:30]
      clkCntr1 <= _clkCntr1_T_5 @[intervox_receiver.scala 92:18]
      node _T_12 = eq(io.DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 95:25]
      when _T_12 : @[intervox_receiver.scala 95:33]
        node _bitIn_T = dshl(UInt<1>("h1"), clkCntr1) @[intervox_receiver.scala 96:35]
        node _bitIn_T_1 = or(bitIn, _bitIn_T) @[intervox_receiver.scala 96:28]
        bitIn <= _bitIn_T_1 @[intervox_receiver.scala 96:19]
      node _T_13 = eq(clkCntr1, oversampling_factor) @[intervox_receiver.scala 100:23]
      when _T_13 : @[intervox_receiver.scala 100:47]
        enaBuf <= UInt<1>("h1") @[intervox_receiver.scala 101:25]
        clkCntr1 <= UInt<1>("h0") @[intervox_receiver.scala 102:25]
        node _T_14 = leq(bitIn, UInt<15>("h7f00")) @[intervox_receiver.scala 104:25]
        node _T_15 = gt(bitIn, UInt<1>("h0")) @[intervox_receiver.scala 104:46]
        node _T_16 = and(_T_14, _T_15) @[intervox_receiver.scala 104:37]
        when _T_16 : @[intervox_receiver.scala 104:53]
          bitInBuf <= bitIn @[intervox_receiver.scala 105:26]
        bitIn <= UInt<1>("h0") @[intervox_receiver.scala 108:25]
      node _T_17 = eq(enaBuf, UInt<1>("h1")) @[intervox_receiver.scala 113:21]
      when _T_17 : @[intervox_receiver.scala 113:29]
        node _bufCntr_T = add(bufCntr, UInt<1>("h1")) @[intervox_receiver.scala 114:32]
        node _bufCntr_T_1 = tail(_bufCntr_T, 1) @[intervox_receiver.scala 114:32]
        bufCntr <= _bufCntr_T_1 @[intervox_receiver.scala 114:21]
        node _T_18 = dshr(bitInBuf, bufCntr) @[intervox_receiver.scala 116:26]
        node _T_19 = bits(_T_18, 0, 0) @[intervox_receiver.scala 116:26]
        node _T_20 = sub(bufCntr, UInt<1>("h1")) @[intervox_receiver.scala 116:57]
        node _T_21 = tail(_T_20, 1) @[intervox_receiver.scala 116:57]
        node _T_22 = dshr(bitInBuf, _T_21) @[intervox_receiver.scala 116:48]
        node _T_23 = bits(_T_22, 0, 0) @[intervox_receiver.scala 116:48]
        node _T_24 = neq(_T_19, _T_23) @[intervox_receiver.scala 116:36]
        when _T_24 : @[intervox_receiver.scala 116:64]
          node _outReg_T_1 = not(outReg) @[intervox_receiver.scala 117:27]
          outReg <= _outReg_T_1 @[intervox_receiver.scala 117:24]
        node _T_25 = eq(bufCntr, expected_cycles_one) @[intervox_receiver.scala 119:26]
        when _T_25 : @[intervox_receiver.scala 119:50]
          bufCntr <= UInt<1>("h0") @[intervox_receiver.scala 120:25]
          node _T_26 = dshr(bitIn, UInt<2>("h3")) @[intervox_receiver.scala 123:27]
          node _T_27 = bits(_T_26, 0, 0) @[intervox_receiver.scala 123:27]
          node _T_28 = dshr(bitIn, UInt<4>("hc")) @[intervox_receiver.scala 123:42]
          node _T_29 = bits(_T_28, 0, 0) @[intervox_receiver.scala 123:42]
          node _T_30 = neq(_T_27, _T_29) @[intervox_receiver.scala 123:33]
          when _T_30 : @[intervox_receiver.scala 123:49]
            change <= UInt<1>("h1") @[intervox_receiver.scala 124:28]
          else :
            change <= UInt<1>("h0") @[intervox_receiver.scala 126:28]

  extmodule clk_wiz_0_clk_wiz :
    output PLL_MCLK : UInt<1>
    output locked : UInt<1>
    input PLL_IN : UInt<1>
    defname = clk_wiz_0_clk_wiz

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, NEXT_FRAME : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 152:26]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 154:25]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 155:25]
    io.NEXT_FRAME <= clockRec.io.NEXT_FRAME @[intervox_receiver.scala 156:25]
    io.DBUG <= clockRec.io.CLK_OUT @[intervox_receiver.scala 157:25]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 160:21]
    pll.PLL_IN is invalid
    pll.locked is invalid
    pll.PLL_MCLK is invalid
    pll.PLL_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 163:19]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 166:24]
    when _T : @[intervox_receiver.scala 166:32]
      io.CLK_REC <= pll.PLL_MCLK @[intervox_receiver.scala 167:20]
      io.DBUG1 <= UInt<1>("h1") @[intervox_receiver.scala 168:20]
    else :
      io.CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 171:20]
      io.DBUG1 <= UInt<1>("h0") @[intervox_receiver.scala 172:20]

