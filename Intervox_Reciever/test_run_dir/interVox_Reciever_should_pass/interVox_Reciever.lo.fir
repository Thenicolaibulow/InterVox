circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : UInt<1>
    input io_DATA_IN : UInt<1>
    output io_CLK_OUT : UInt<1>
    output io_DATA_OUT : UInt<1>
    output io_NEXT_FRAME : UInt<1>

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
      reset => (UInt<1>("h0"), clkCntr) @[intervox_receiver.scala 31:30]
    reg clkCntr1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), clkCntr1) @[intervox_receiver.scala 32:30]
    reg pllCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), pllCntr) @[intervox_receiver.scala 33:30]
    reg bufCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bufCntr) @[intervox_receiver.scala 34:30]
    reg bitIn : UInt<16>, clock with :
      reset => (UInt<1>("h0"), bitIn) @[intervox_receiver.scala 35:30]
    reg bitInBuf : UInt<16>, clock with :
      reset => (UInt<1>("h0"), bitInBuf) @[intervox_receiver.scala 36:30]
    reg bitCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_receiver.scala 37:30]
    reg outReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), outReg) @[intervox_receiver.scala 39:30]
    reg dataOut : UInt<1>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[intervox_receiver.scala 40:30]
    reg sync_lo : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sync_lo) @[intervox_receiver.scala 41:30]
    reg sync_hi : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sync_hi) @[intervox_receiver.scala 42:30]
    reg bitsReady : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bitsReady) @[intervox_receiver.scala 43:30]
    reg change : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change) @[intervox_receiver.scala 44:30]
    reg enaBuf : UInt<1>, clock with :
      reset => (UInt<1>("h0"), enaBuf) @[intervox_receiver.scala 45:30]
    node _clkCntr_T = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 59:24]
    node _clkCntr_T_1 = tail(_clkCntr_T, 1) @[intervox_receiver.scala 59:24]
    node _T = eq(clkCntr, expected_cycles_syncword) @[intervox_receiver.scala 61:18]
    node _GEN_0 = mux(_T, UInt<1>("h0"), _clkCntr_T_1) @[intervox_receiver.scala 59:13 61:47 62:17]
    node _T_1 = eq(bitCntr, UInt<1>("h0")) @[intervox_receiver.scala 65:18]
    node _T_2 = eq(io_DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 67:25]
    node _clkCntr1_T = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 68:34]
    node _clkCntr1_T_1 = tail(_clkCntr1_T, 1) @[intervox_receiver.scala 68:34]
    node _T_3 = mul(expected_cycles_one, UInt<2>("h3")) @[intervox_receiver.scala 70:52]
    node _T_4 = eq(clkCntr1, _T_3) @[intervox_receiver.scala 70:27]
    node _GEN_1 = mux(_T_4, UInt<1>("h1"), sync_lo) @[intervox_receiver.scala 70:59 71:25 41:30]
    node _GEN_2 = mux(_T_2, _clkCntr1_T_1, clkCntr1) @[intervox_receiver.scala 67:33 68:22 32:30]
    node _GEN_3 = mux(_T_2, _GEN_1, sync_lo) @[intervox_receiver.scala 41:30 67:33]
    node _T_5 = eq(sync_lo, UInt<1>("h1")) @[intervox_receiver.scala 74:22]
    node _clkCntr1_T_2 = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 75:34]
    node _clkCntr1_T_3 = tail(_clkCntr1_T_2, 1) @[intervox_receiver.scala 75:34]
    node _T_6 = eq(clkCntr1, expected_cycles_syncword) @[intervox_receiver.scala 77:27]
    node _GEN_4 = mux(_T_6, UInt<1>("h1"), sync_hi) @[intervox_receiver.scala 77:56 78:25 42:30]
    node _GEN_5 = mux(_T_6, UInt<1>("h0"), _clkCntr1_T_3) @[intervox_receiver.scala 75:22 77:56 79:26]
    node _GEN_6 = mux(_T_5, _GEN_5, _GEN_2) @[intervox_receiver.scala 74:30]
    node _GEN_7 = mux(_T_5, _GEN_4, sync_hi) @[intervox_receiver.scala 42:30 74:30]
    node _GEN_8 = mux(_T_1, _GEN_6, clkCntr1) @[intervox_receiver.scala 65:26 32:30]
    node _GEN_9 = mux(_T_1, _GEN_3, sync_lo) @[intervox_receiver.scala 65:26 41:30]
    node _GEN_10 = mux(_T_1, _GEN_7, sync_hi) @[intervox_receiver.scala 65:26 42:30]
    node _T_7 = eq(bitCntr, expected_nr_of_incoming_bits) @[intervox_receiver.scala 85:18]
    node _GEN_11 = mux(_T_7, UInt<1>("h0"), bitCntr) @[intervox_receiver.scala 85:51 86:17 37:30]
    node _T_8 = eq(sync_lo, UInt<1>("h1")) @[intervox_receiver.scala 90:19]
    node _T_9 = eq(sync_hi, UInt<1>("h1")) @[intervox_receiver.scala 90:39]
    node _T_10 = and(_T_8, _T_9) @[intervox_receiver.scala 90:28]
    node _clkCntr1_T_4 = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 92:30]
    node _clkCntr1_T_5 = tail(_clkCntr1_T_4, 1) @[intervox_receiver.scala 92:30]
    node _T_11 = eq(io_DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 95:25]
    node _bitIn_T = dshl(UInt<1>("h1"), clkCntr1) @[intervox_receiver.scala 96:35]
    node _bitIn_T_1 = or(bitIn, _bitIn_T) @[intervox_receiver.scala 96:28]
    node _GEN_12 = mux(_T_11, _bitIn_T_1, bitIn) @[intervox_receiver.scala 95:33 96:19 35:30]
    node _T_12 = eq(clkCntr1, oversampling_factor) @[intervox_receiver.scala 100:23]
    node _T_13 = leq(bitIn, UInt<15>("h7f00")) @[intervox_receiver.scala 104:25]
    node _T_14 = gt(bitIn, UInt<1>("h0")) @[intervox_receiver.scala 104:46]
    node _T_15 = and(_T_13, _T_14) @[intervox_receiver.scala 104:37]
    node _GEN_13 = mux(_T_15, bitIn, bitInBuf) @[intervox_receiver.scala 104:53 105:26 36:30]
    node _GEN_14 = mux(_T_12, UInt<1>("h1"), enaBuf) @[intervox_receiver.scala 100:47 101:25 45:30]
    node _GEN_15 = mux(_T_12, UInt<1>("h0"), _clkCntr1_T_5) @[intervox_receiver.scala 100:47 102:25 92:18]
    node _GEN_16 = mux(_T_12, _GEN_13, bitInBuf) @[intervox_receiver.scala 100:47 36:30]
    node _GEN_17 = mux(_T_12, UInt<1>("h0"), _GEN_12) @[intervox_receiver.scala 100:47 108:25]
    node _T_16 = eq(enaBuf, UInt<1>("h1")) @[intervox_receiver.scala 113:21]
    node _bufCntr_T = add(bufCntr, UInt<1>("h1")) @[intervox_receiver.scala 114:32]
    node _bufCntr_T_1 = tail(_bufCntr_T, 1) @[intervox_receiver.scala 114:32]
    node _T_17 = dshr(bitInBuf, bufCntr) @[intervox_receiver.scala 116:26]
    node _T_18 = bits(_T_17, 0, 0) @[intervox_receiver.scala 116:26]
    node _T_19 = sub(bufCntr, UInt<1>("h1")) @[intervox_receiver.scala 116:57]
    node _T_20 = tail(_T_19, 1) @[intervox_receiver.scala 116:57]
    node _T_21 = dshr(bitInBuf, _T_20) @[intervox_receiver.scala 116:48]
    node _T_22 = bits(_T_21, 0, 0) @[intervox_receiver.scala 116:48]
    node _T_23 = neq(_T_18, _T_22) @[intervox_receiver.scala 116:36]
    node _outReg_T = not(outReg) @[intervox_receiver.scala 117:27]
    node _GEN_18 = mux(_T_23, _outReg_T, outReg) @[intervox_receiver.scala 116:64 117:24 39:30]
    node _T_24 = eq(bufCntr, expected_cycles_one) @[intervox_receiver.scala 119:26]
    node _T_25 = dshr(bitIn, UInt<2>("h3")) @[intervox_receiver.scala 123:27]
    node _T_26 = bits(_T_25, 0, 0) @[intervox_receiver.scala 123:27]
    node _T_27 = dshr(bitIn, UInt<4>("hc")) @[intervox_receiver.scala 123:42]
    node _T_28 = bits(_T_27, 0, 0) @[intervox_receiver.scala 123:42]
    node _T_29 = neq(_T_26, _T_28) @[intervox_receiver.scala 123:33]
    node _GEN_19 = mux(_T_29, UInt<1>("h1"), UInt<1>("h0")) @[intervox_receiver.scala 123:49 124:28 126:28]
    node _GEN_20 = mux(_T_24, UInt<1>("h0"), _bufCntr_T_1) @[intervox_receiver.scala 114:21 119:50 120:25]
    node _GEN_21 = mux(_T_24, _GEN_19, change) @[intervox_receiver.scala 119:50 44:30]
    node _GEN_22 = mux(_T_16, _GEN_20, bufCntr) @[intervox_receiver.scala 113:29 34:30]
    node _GEN_23 = mux(_T_16, _GEN_18, outReg) @[intervox_receiver.scala 113:29 39:30]
    node _GEN_24 = mux(_T_16, _GEN_21, change) @[intervox_receiver.scala 113:29 44:30]
    node _GEN_25 = mux(_T_10, _GEN_15, _GEN_8) @[intervox_receiver.scala 90:48]
    node _GEN_26 = mux(_T_10, _GEN_17, bitIn) @[intervox_receiver.scala 35:30 90:48]
    node _GEN_27 = mux(_T_10, _GEN_14, enaBuf) @[intervox_receiver.scala 45:30 90:48]
    node _GEN_28 = mux(_T_10, _GEN_16, bitInBuf) @[intervox_receiver.scala 36:30 90:48]
    node _GEN_29 = mux(_T_10, _GEN_22, bufCntr) @[intervox_receiver.scala 34:30 90:48]
    node _GEN_30 = mux(_T_10, _GEN_23, outReg) @[intervox_receiver.scala 39:30 90:48]
    node _GEN_31 = mux(_T_10, _GEN_24, change) @[intervox_receiver.scala 44:30 90:48]
    io_CLK_OUT <= outReg @[intervox_receiver.scala 47:21]
    io_DATA_OUT <= change @[intervox_receiver.scala 48:21]
    io_NEXT_FRAME <= UInt<1>("h0") @[intervox_receiver.scala 49:21]
    clkCntr <= mux(reset, UInt<8>("h0"), _GEN_0) @[intervox_receiver.scala 31:{30,30}]
    clkCntr1 <= mux(reset, UInt<8>("h0"), _GEN_25) @[intervox_receiver.scala 32:{30,30}]
    pllCntr <= mux(reset, UInt<8>("h0"), pllCntr) @[intervox_receiver.scala 33:{30,30,30}]
    bufCntr <= mux(reset, UInt<8>("h0"), _GEN_29) @[intervox_receiver.scala 34:{30,30}]
    bitIn <= bits(mux(reset, UInt<16>("h0"), _GEN_26), 15, 0) @[intervox_receiver.scala 35:{30,30}]
    bitInBuf <= mux(reset, UInt<16>("h0"), _GEN_28) @[intervox_receiver.scala 36:{30,30}]
    bitCntr <= mux(reset, UInt<8>("h0"), _GEN_11) @[intervox_receiver.scala 37:{30,30}]
    outReg <= mux(reset, UInt<1>("h0"), _GEN_30) @[intervox_receiver.scala 39:{30,30}]
    dataOut <= mux(reset, UInt<1>("h0"), dataOut) @[intervox_receiver.scala 40:{30,30,30}]
    sync_lo <= mux(reset, UInt<1>("h0"), _GEN_9) @[intervox_receiver.scala 41:{30,30}]
    sync_hi <= mux(reset, UInt<1>("h0"), _GEN_10) @[intervox_receiver.scala 42:{30,30}]
    bitsReady <= mux(reset, UInt<1>("h0"), bitsReady) @[intervox_receiver.scala 43:{30,30,30}]
    change <= mux(reset, UInt<1>("h0"), _GEN_31) @[intervox_receiver.scala 44:{30,30}]
    enaBuf <= mux(reset, UInt<1>("h0"), _GEN_27) @[intervox_receiver.scala 45:{30,30}]

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

    inst clockRec of clock_Recovery @[intervox_receiver.scala 152:26]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 160:21]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 166:24]
    node _GEN_0 = mux(_T, pll.PLL_MCLK, UInt<1>("h0")) @[intervox_receiver.scala 166:32 167:20 171:20]
    node _GEN_1 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[intervox_receiver.scala 166:32 168:20 172:20]
    io_CLK_REC <= _GEN_0
    io_DATA_OUT <= clockRec.io_DATA_OUT @[intervox_receiver.scala 155:25]
    io_NEXT_FRAME <= clockRec.io_NEXT_FRAME @[intervox_receiver.scala 156:25]
    io_DBUG <= clockRec.io_CLK_OUT @[intervox_receiver.scala 157:25]
    io_DBUG1 <= _GEN_1
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io_DATA_IN <= io_INTERVOX_IN @[intervox_receiver.scala 154:25]
    pll.PLL_IN <= clockRec.io_CLK_OUT @[intervox_receiver.scala 163:19]
