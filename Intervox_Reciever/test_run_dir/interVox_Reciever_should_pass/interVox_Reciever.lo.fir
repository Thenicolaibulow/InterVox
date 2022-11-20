circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : UInt<1>
    input io_DATA_IN : UInt<1>
    output io_CLK_OUT : UInt<1>
    output io_DATA_OUT : UInt<1>
    output io_NEXT_FRAME : UInt<1>

    node _expected_cycles_zero_T = sub(UInt<6>("h20"), UInt<1>("h1")) @[intervox_receiver.scala 26:37]
    node expected_cycles_zero = tail(_expected_cycles_zero_T, 1) @[intervox_receiver.scala 26:37]
    node _expected_cycles_one_T = sub(UInt<5>("h10"), UInt<1>("h1")) @[intervox_receiver.scala 27:36]
    node expected_cycles_one = tail(_expected_cycles_one_T, 1) @[intervox_receiver.scala 27:36]
    node _expected_nr_of_incoming_bits_T = sub(UInt<7>("h40"), UInt<2>("h3")) @[intervox_receiver.scala 28:45]
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
    reg clkDvdr : UInt<4>, clock with :
      reset => (UInt<1>("h0"), clkDvdr) @[intervox_receiver.scala 35:30]
    reg deltaCntr : UInt<4>, clock with :
      reset => (UInt<1>("h0"), deltaCntr) @[intervox_receiver.scala 36:30]
    reg bitIn : UInt<16>, clock with :
      reset => (UInt<1>("h0"), bitIn) @[intervox_receiver.scala 37:30]
    reg bitInBuf : UInt<16>, clock with :
      reset => (UInt<1>("h0"), bitInBuf) @[intervox_receiver.scala 38:30]
    reg bitCntr : UInt<8>, clock with :
      reset => (UInt<1>("h0"), bitCntr) @[intervox_receiver.scala 39:30]
    reg outReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), outReg) @[intervox_receiver.scala 41:30]
    reg dataOut : UInt<1>, clock with :
      reset => (UInt<1>("h0"), dataOut) @[intervox_receiver.scala 42:30]
    reg sync_lo : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sync_lo) @[intervox_receiver.scala 43:30]
    reg sync_hi : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sync_hi) @[intervox_receiver.scala 44:30]
    reg bitsReady : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bitsReady) @[intervox_receiver.scala 45:30]
    reg change : UInt<1>, clock with :
      reset => (UInt<1>("h0"), change) @[intervox_receiver.scala 46:30]
    reg enaBuf : UInt<1>, clock with :
      reset => (UInt<1>("h0"), enaBuf) @[intervox_receiver.scala 47:30]
    reg nextFrame : UInt<1>, clock with :
      reset => (UInt<1>("h0"), nextFrame) @[intervox_receiver.scala 48:30]
    reg syncWord : UInt<1>, clock with :
      reset => (UInt<1>("h0"), syncWord) @[intervox_receiver.scala 49:30]
    node _pllCntr_T = add(pllCntr, UInt<1>("h1")) @[intervox_receiver.scala 57:24]
    node _pllCntr_T_1 = tail(_pllCntr_T, 1) @[intervox_receiver.scala 57:24]
    node _T = eq(pllCntr, UInt<3>("h7")) @[intervox_receiver.scala 58:18]
    node _outReg_T = not(outReg) @[intervox_receiver.scala 61:19]
    node _GEN_0 = mux(_T, _outReg_T, outReg) @[intervox_receiver.scala 58:26 61:16 41:30]
    node _GEN_1 = mux(_T, UInt<1>("h0"), _pllCntr_T_1) @[intervox_receiver.scala 57:13 58:26 62:17]
    node _T_1 = eq(io_DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 69:22]
    node _T_2 = eq(sync_lo, UInt<1>("h0")) @[intervox_receiver.scala 69:42]
    node _T_3 = and(_T_1, _T_2) @[intervox_receiver.scala 69:31]
    node _clkCntr1_T = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 70:30]
    node _clkCntr1_T_1 = tail(_clkCntr1_T, 1) @[intervox_receiver.scala 70:30]
    node _T_4 = eq(clkCntr1, UInt<6>("h2f")) @[intervox_receiver.scala 72:23]
    node _GEN_2 = mux(_T_4, UInt<1>("h1"), sync_lo) @[intervox_receiver.scala 72:34 73:21 43:30]
    node _GEN_3 = mux(_T_4, UInt<1>("h1"), nextFrame) @[intervox_receiver.scala 72:34 74:23 48:30]
    node _GEN_4 = mux(_T_4, UInt<1>("h0"), _clkCntr1_T_1) @[intervox_receiver.scala 70:18 72:34 75:22]
    node _GEN_5 = mux(_T_3, _GEN_4, clkCntr1) @[intervox_receiver.scala 32:30 69:51]
    node _GEN_6 = mux(_T_3, _GEN_2, sync_lo) @[intervox_receiver.scala 43:30 69:51]
    node _GEN_7 = mux(_T_3, _GEN_3, nextFrame) @[intervox_receiver.scala 48:30 69:51]
    node _T_5 = eq(io_DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 79:22]
    node _T_6 = eq(sync_lo, UInt<1>("h1")) @[intervox_receiver.scala 79:42]
    node _T_7 = and(_T_5, _T_6) @[intervox_receiver.scala 79:31]
    node _clkCntr1_T_2 = add(clkCntr1, UInt<1>("h1")) @[intervox_receiver.scala 81:30]
    node _clkCntr1_T_3 = tail(_clkCntr1_T_2, 1) @[intervox_receiver.scala 81:30]
    node _T_8 = eq(clkCntr1, expected_cycles_one) @[intervox_receiver.scala 83:23]
    node _GEN_8 = mux(_T_8, UInt<1>("h1"), sync_hi) @[intervox_receiver.scala 83:47 84:25 44:30]
    node _GEN_9 = mux(_T_8, UInt<1>("h0"), _clkCntr1_T_3) @[intervox_receiver.scala 81:18 83:47 85:25]
    node _GEN_10 = mux(_T_8, UInt<1>("h0"), _GEN_7) @[intervox_receiver.scala 83:47 86:25]
    node _GEN_11 = mux(_T_8, UInt<1>("h0"), _GEN_6) @[intervox_receiver.scala 83:47 87:25]
    node _GEN_12 = mux(_T_7, _GEN_9, _GEN_5) @[intervox_receiver.scala 79:51]
    node _GEN_13 = mux(_T_7, _GEN_8, sync_hi) @[intervox_receiver.scala 44:30 79:51]
    node _GEN_14 = mux(_T_7, _GEN_10, _GEN_7) @[intervox_receiver.scala 79:51]
    node _GEN_15 = mux(_T_7, _GEN_11, _GEN_6) @[intervox_receiver.scala 79:51]
    node _T_9 = eq(bitCntr, expected_nr_of_incoming_bits) @[intervox_receiver.scala 93:18]
    node _GEN_16 = mux(_T_9, UInt<1>("h0"), bitCntr) @[intervox_receiver.scala 93:51 94:17 39:30]
    node _T_10 = eq(sync_hi, UInt<1>("h1")) @[intervox_receiver.scala 98:19]
    node _clkCntr_T = add(clkCntr, UInt<1>("h1")) @[intervox_receiver.scala 100:28]
    node _clkCntr_T_1 = tail(_clkCntr_T, 1) @[intervox_receiver.scala 100:28]
    node _T_11 = eq(io_DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 103:25]
    node _bitIn_T = dshl(UInt<1>("h1"), clkCntr) @[intervox_receiver.scala 104:35]
    node _bitIn_T_1 = or(bitIn, _bitIn_T) @[intervox_receiver.scala 104:28]
    node _GEN_17 = mux(_T_11, _bitIn_T_1, bitIn) @[intervox_receiver.scala 103:33 104:19 37:30]
    node _T_12 = eq(clkCntr, oversampling_factor) @[intervox_receiver.scala 108:22]
    node _T_13 = leq(bitIn, UInt<15>("h7f00")) @[intervox_receiver.scala 113:25]
    node _T_14 = gt(bitIn, UInt<1>("h0")) @[intervox_receiver.scala 113:46]
    node _T_15 = and(_T_13, _T_14) @[intervox_receiver.scala 113:37]
    node _GEN_18 = mux(_T_15, bitIn, bitInBuf) @[intervox_receiver.scala 113:53 114:26 38:30]
    node _GEN_19 = mux(_T_12, UInt<1>("h1"), enaBuf) @[intervox_receiver.scala 108:46 109:25 47:30]
    node _GEN_20 = mux(_T_12, UInt<1>("h0"), _clkCntr_T_1) @[intervox_receiver.scala 100:17 108:46 110:25]
    node _GEN_21 = mux(_T_12, _GEN_18, bitInBuf) @[intervox_receiver.scala 108:46 38:30]
    node _GEN_22 = mux(_T_12, UInt<1>("h0"), _GEN_17) @[intervox_receiver.scala 108:46 117:25]
    node _T_16 = eq(enaBuf, UInt<1>("h1")) @[intervox_receiver.scala 122:21]
    node _bufCntr_T = add(bufCntr, UInt<1>("h1")) @[intervox_receiver.scala 123:32]
    node _bufCntr_T_1 = tail(_bufCntr_T, 1) @[intervox_receiver.scala 123:32]
    node _T_17 = eq(bufCntr, expected_cycles_one) @[intervox_receiver.scala 138:26]
    node _T_18 = dshr(bitIn, UInt<2>("h3")) @[intervox_receiver.scala 142:27]
    node _T_19 = bits(_T_18, 0, 0) @[intervox_receiver.scala 142:27]
    node _T_20 = dshr(bitIn, UInt<4>("hc")) @[intervox_receiver.scala 142:42]
    node _T_21 = bits(_T_20, 0, 0) @[intervox_receiver.scala 142:42]
    node _T_22 = neq(_T_19, _T_21) @[intervox_receiver.scala 142:33]
    node _GEN_23 = mux(_T_22, UInt<1>("h1"), UInt<1>("h0")) @[intervox_receiver.scala 142:49 143:28 145:28]
    node _GEN_24 = mux(_T_17, UInt<1>("h0"), _bufCntr_T_1) @[intervox_receiver.scala 123:21 138:50 139:25]
    node _GEN_25 = mux(_T_17, _GEN_23, change) @[intervox_receiver.scala 138:50 46:30]
    node _GEN_26 = mux(_T_16, _GEN_24, bufCntr) @[intervox_receiver.scala 122:29 34:30]
    node _GEN_27 = mux(_T_16, _GEN_25, change) @[intervox_receiver.scala 122:29 46:30]
    node _GEN_28 = mux(_T_10, _GEN_20, clkCntr) @[intervox_receiver.scala 98:28 31:30]
    node _GEN_29 = mux(_T_10, _GEN_22, bitIn) @[intervox_receiver.scala 98:28 37:30]
    node _GEN_30 = mux(_T_10, _GEN_19, enaBuf) @[intervox_receiver.scala 98:28 47:30]
    node _GEN_31 = mux(_T_10, _GEN_21, bitInBuf) @[intervox_receiver.scala 98:28 38:30]
    node _GEN_32 = mux(_T_10, _GEN_26, bufCntr) @[intervox_receiver.scala 98:28 34:30]
    node _GEN_33 = mux(_T_10, _GEN_27, change) @[intervox_receiver.scala 98:28 46:30]
    io_CLK_OUT <= outReg @[intervox_receiver.scala 51:21]
    io_DATA_OUT <= change @[intervox_receiver.scala 52:21]
    io_NEXT_FRAME <= nextFrame @[intervox_receiver.scala 53:21]
    clkCntr <= mux(reset, UInt<8>("h0"), _GEN_28) @[intervox_receiver.scala 31:{30,30}]
    clkCntr1 <= mux(reset, UInt<8>("h0"), _GEN_12) @[intervox_receiver.scala 32:{30,30}]
    pllCntr <= mux(reset, UInt<8>("h0"), _GEN_1) @[intervox_receiver.scala 33:{30,30}]
    bufCntr <= mux(reset, UInt<8>("h0"), _GEN_32) @[intervox_receiver.scala 34:{30,30}]
    clkDvdr <= mux(reset, UInt<4>("h0"), clkDvdr) @[intervox_receiver.scala 35:{30,30,30}]
    deltaCntr <= mux(reset, UInt<4>("h0"), deltaCntr) @[intervox_receiver.scala 36:{30,30,30}]
    bitIn <= bits(mux(reset, UInt<16>("h0"), _GEN_29), 15, 0) @[intervox_receiver.scala 37:{30,30}]
    bitInBuf <= mux(reset, UInt<16>("h0"), _GEN_31) @[intervox_receiver.scala 38:{30,30}]
    bitCntr <= mux(reset, UInt<8>("h0"), _GEN_16) @[intervox_receiver.scala 39:{30,30}]
    outReg <= mux(reset, UInt<1>("h0"), _GEN_0) @[intervox_receiver.scala 41:{30,30}]
    dataOut <= mux(reset, UInt<1>("h0"), dataOut) @[intervox_receiver.scala 42:{30,30,30}]
    sync_lo <= mux(reset, UInt<1>("h0"), _GEN_15) @[intervox_receiver.scala 43:{30,30}]
    sync_hi <= mux(reset, UInt<1>("h0"), _GEN_13) @[intervox_receiver.scala 44:{30,30}]
    bitsReady <= mux(reset, UInt<1>("h0"), bitsReady) @[intervox_receiver.scala 45:{30,30,30}]
    change <= mux(reset, UInt<1>("h0"), _GEN_33) @[intervox_receiver.scala 46:{30,30}]
    enaBuf <= mux(reset, UInt<1>("h0"), _GEN_30) @[intervox_receiver.scala 47:{30,30}]
    nextFrame <= mux(reset, UInt<1>("h0"), _GEN_14) @[intervox_receiver.scala 48:{30,30}]
    syncWord <= mux(reset, UInt<1>("h0"), syncWord) @[intervox_receiver.scala 49:{30,30,30}]

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

    inst clockRec of clock_Recovery @[intervox_receiver.scala 171:26]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 179:21]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 185:24]
    node _GEN_0 = mux(_T, pll.PLL_MCLK, UInt<1>("h0")) @[intervox_receiver.scala 185:32 186:20 190:20]
    node _GEN_1 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[intervox_receiver.scala 185:32 187:20 191:20]
    io_CLK_REC <= _GEN_0
    io_DATA_OUT <= clockRec.io_DATA_OUT @[intervox_receiver.scala 174:25]
    io_NEXT_FRAME <= clockRec.io_NEXT_FRAME @[intervox_receiver.scala 175:25]
    io_DBUG <= clockRec.io_CLK_OUT @[intervox_receiver.scala 176:25]
    io_DBUG1 <= _GEN_1
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io_DATA_IN <= io_INTERVOX_IN @[intervox_receiver.scala 173:25]
    pll.PLL_IN <= clockRec.io_CLK_OUT @[intervox_receiver.scala 182:19]
