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
    reg clkDvdr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[intervox_receiver.scala 35:30]
    reg deltaCntr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[intervox_receiver.scala 36:30]
    reg bitIn : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[intervox_receiver.scala 37:30]
    reg bitInBuf : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[intervox_receiver.scala 38:30]
    reg bitCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 39:30]
    reg outReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 41:30]
    reg dataOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 42:30]
    reg sync_lo : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 43:30]
    reg sync_hi : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 44:30]
    reg bitsReady : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 45:30]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 46:30]
    reg enaBuf : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 47:30]
    io.CLK_OUT <= outReg @[intervox_receiver.scala 49:21]
    io.DATA_OUT <= change @[intervox_receiver.scala 50:21]
    io.NEXT_FRAME <= UInt<1>("h0") @[intervox_receiver.scala 51:21]
    node _pllCntr_T = add(pllCntr, UInt<1>("h1")) @[intervox_receiver.scala 55:24]
    node _pllCntr_T_1 = tail(_pllCntr_T, 1) @[intervox_receiver.scala 55:24]
    pllCntr <= _pllCntr_T_1 @[intervox_receiver.scala 55:13]
    node _T = eq(pllCntr, UInt<3>("h7")) @[intervox_receiver.scala 56:18]
    when _T : @[intervox_receiver.scala 56:26]
      node _outReg_T = not(outReg) @[intervox_receiver.scala 57:19]
      outReg <= _outReg_T @[intervox_receiver.scala 57:16]
      pllCntr <= UInt<1>("h0") @[intervox_receiver.scala 58:17]
    node _clkCntr_T = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 61:24]
    node _clkCntr_T_1 = tail(_clkCntr_T, 1) @[intervox_receiver.scala 61:24]
    clkCntr <= _clkCntr_T_1 @[intervox_receiver.scala 61:13]
    node _T_1 = eq(clkCntr, expected_cycles_syncword) @[intervox_receiver.scala 63:18]
    when _T_1 : @[intervox_receiver.scala 63:47]
      clkCntr <= UInt<1>("h0") @[intervox_receiver.scala 64:17]
    node _T_2 = eq(bitCntr, UInt<1>("h0")) @[intervox_receiver.scala 67:18]
    when _T_2 : @[intervox_receiver.scala 67:26]
      node _T_3 = eq(io.DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 69:25]
      when _T_3 : @[intervox_receiver.scala 69:33]
        node _clkCntr1_T = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 70:34]
        node _clkCntr1_T_1 = tail(_clkCntr1_T, 1) @[intervox_receiver.scala 70:34]
        clkCntr1 <= _clkCntr1_T_1 @[intervox_receiver.scala 70:22]
        node _T_4 = mul(expected_cycles_one, UInt<2>("h3")) @[intervox_receiver.scala 72:52]
        node _T_5 = eq(clkCntr1, _T_4) @[intervox_receiver.scala 72:27]
        when _T_5 : @[intervox_receiver.scala 72:59]
          sync_lo <= UInt<1>("h1") @[intervox_receiver.scala 73:25]
      node _T_6 = eq(sync_lo, UInt<1>("h1")) @[intervox_receiver.scala 76:22]
      when _T_6 : @[intervox_receiver.scala 76:30]
        node _clkCntr1_T_2 = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 77:34]
        node _clkCntr1_T_3 = tail(_clkCntr1_T_2, 1) @[intervox_receiver.scala 77:34]
        clkCntr1 <= _clkCntr1_T_3 @[intervox_receiver.scala 77:22]
        node _T_7 = eq(clkCntr1, expected_cycles_syncword) @[intervox_receiver.scala 79:27]
        when _T_7 : @[intervox_receiver.scala 79:56]
          sync_hi <= UInt<1>("h1") @[intervox_receiver.scala 80:25]
          clkCntr1 <= UInt<1>("h0") @[intervox_receiver.scala 81:26]
    node _T_8 = eq(bitCntr, expected_nr_of_incoming_bits) @[intervox_receiver.scala 87:18]
    when _T_8 : @[intervox_receiver.scala 87:51]
      bitCntr <= UInt<1>("h0") @[intervox_receiver.scala 88:17]
    node _T_9 = eq(sync_lo, UInt<1>("h1")) @[intervox_receiver.scala 92:19]
    node _T_10 = eq(sync_hi, UInt<1>("h1")) @[intervox_receiver.scala 92:39]
    node _T_11 = and(_T_9, _T_10) @[intervox_receiver.scala 92:28]
    when _T_11 : @[intervox_receiver.scala 92:48]
      node _clkCntr1_T_4 = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 94:30]
      node _clkCntr1_T_5 = tail(_clkCntr1_T_4, 1) @[intervox_receiver.scala 94:30]
      clkCntr1 <= _clkCntr1_T_5 @[intervox_receiver.scala 94:18]
      node _T_12 = eq(io.DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 97:25]
      when _T_12 : @[intervox_receiver.scala 97:33]
        node _bitIn_T = dshl(UInt<1>("h1"), clkCntr1) @[intervox_receiver.scala 98:35]
        node _bitIn_T_1 = or(bitIn, _bitIn_T) @[intervox_receiver.scala 98:28]
        bitIn <= _bitIn_T_1 @[intervox_receiver.scala 98:19]
      node _T_13 = eq(clkCntr1, oversampling_factor) @[intervox_receiver.scala 102:23]
      when _T_13 : @[intervox_receiver.scala 102:47]
        enaBuf <= UInt<1>("h1") @[intervox_receiver.scala 103:25]
        clkCntr1 <= UInt<1>("h0") @[intervox_receiver.scala 104:25]
        node _T_14 = leq(bitIn, UInt<15>("h7f00")) @[intervox_receiver.scala 106:25]
        node _T_15 = gt(bitIn, UInt<1>("h0")) @[intervox_receiver.scala 106:46]
        node _T_16 = and(_T_14, _T_15) @[intervox_receiver.scala 106:37]
        when _T_16 : @[intervox_receiver.scala 106:53]
          bitInBuf <= bitIn @[intervox_receiver.scala 107:26]
        bitIn <= UInt<1>("h0") @[intervox_receiver.scala 110:25]
      node _T_17 = eq(enaBuf, UInt<1>("h1")) @[intervox_receiver.scala 115:21]
      when _T_17 : @[intervox_receiver.scala 115:29]
        node _bufCntr_T = add(bufCntr, UInt<1>("h1")) @[intervox_receiver.scala 116:32]
        node _bufCntr_T_1 = tail(_bufCntr_T, 1) @[intervox_receiver.scala 116:32]
        bufCntr <= _bufCntr_T_1 @[intervox_receiver.scala 116:21]
        node _T_18 = eq(bufCntr, expected_cycles_one) @[intervox_receiver.scala 131:26]
        when _T_18 : @[intervox_receiver.scala 131:50]
          bufCntr <= UInt<1>("h0") @[intervox_receiver.scala 132:25]
          node _T_19 = dshr(bitIn, UInt<2>("h3")) @[intervox_receiver.scala 135:27]
          node _T_20 = bits(_T_19, 0, 0) @[intervox_receiver.scala 135:27]
          node _T_21 = dshr(bitIn, UInt<4>("hc")) @[intervox_receiver.scala 135:42]
          node _T_22 = bits(_T_21, 0, 0) @[intervox_receiver.scala 135:42]
          node _T_23 = neq(_T_20, _T_22) @[intervox_receiver.scala 135:33]
          when _T_23 : @[intervox_receiver.scala 135:49]
            change <= UInt<1>("h1") @[intervox_receiver.scala 136:28]
          else :
            change <= UInt<1>("h0") @[intervox_receiver.scala 138:28]

  extmodule clk_wiz_0_clk_wiz :
    output PLL_MCLK : UInt<1>
    output locked : UInt<1>
    input PLL_IN : UInt<1>
    defname = clk_wiz_0_clk_wiz

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, NEXT_FRAME : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 164:26]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 166:25]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 167:25]
    io.NEXT_FRAME <= clockRec.io.NEXT_FRAME @[intervox_receiver.scala 168:25]
    io.DBUG <= clockRec.io.CLK_OUT @[intervox_receiver.scala 169:25]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 172:21]
    pll.PLL_IN is invalid
    pll.locked is invalid
    pll.PLL_MCLK is invalid
    pll.PLL_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 175:19]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 178:24]
    when _T : @[intervox_receiver.scala 178:32]
      io.CLK_REC <= pll.PLL_MCLK @[intervox_receiver.scala 179:20]
      io.DBUG1 <= UInt<1>("h1") @[intervox_receiver.scala 180:20]
    else :
      io.CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 183:20]
      io.DBUG1 <= UInt<1>("h0") @[intervox_receiver.scala 184:20]

