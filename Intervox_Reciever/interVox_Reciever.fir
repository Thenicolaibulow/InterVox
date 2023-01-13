circuit interVox_Reciever :
  module clock_Recovery :
    input clock : Clock
    input reset : Reset
    output io : { flip DATA_IN : UInt<1>, CLK_OUT : UInt<1>, DATA_OUT : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LEDS : UInt<16>}

    reg edgeState : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[intervox_receiver.scala 27:30]
    reg deltaCntr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[intervox_receiver.scala 28:30]
    reg lastOne : UInt<8>, clock with :
      reset => (reset, UInt<8>("hf")) @[intervox_receiver.scala 29:30]
    reg clkRec : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 30:30]
    reg change : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 31:30]
    reg changed : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 32:30]
    reg dataOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 33:30]
    reg zeroPeriode : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 34:30]
    reg syncWord : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 35:30]
    reg syncFlipped : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 36:30]
    reg syncFlipped1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 37:30]
    io.CLK_OUT <= clkRec @[intervox_receiver.scala 39:21]
    io.DATA_OUT <= dataOut @[intervox_receiver.scala 40:21]
    io.DBUG <= change @[intervox_receiver.scala 41:21]
    io.DBUG1 <= syncWord @[intervox_receiver.scala 42:21]
    io.LEDS <= lastOne @[intervox_receiver.scala 43:21]
    node _deltaCntr_T = add(deltaCntr, UInt<1>("h1")) @[intervox_receiver.scala 46:31]
    node _deltaCntr_T_1 = tail(_deltaCntr_T, 1) @[intervox_receiver.scala 46:31]
    deltaCntr <= _deltaCntr_T_1 @[intervox_receiver.scala 46:18]
    node _T = eq(UInt<2>("h0"), edgeState) @[intervox_receiver.scala 49:22]
    when _T : @[intervox_receiver.scala 49:22]
      node _T_1 = eq(io.DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 51:29]
      when _T_1 : @[intervox_receiver.scala 51:37]
        edgeState <= UInt<2>("h1") @[intervox_receiver.scala 52:27]
    else :
      node _T_2 = eq(UInt<2>("h1"), edgeState) @[intervox_receiver.scala 49:22]
      when _T_2 : @[intervox_receiver.scala 49:22]
        node _T_3 = eq(io.DATA_IN, UInt<1>("h1")) @[intervox_receiver.scala 56:29]
        when _T_3 : @[intervox_receiver.scala 56:37]
          edgeState <= UInt<2>("h2") @[intervox_receiver.scala 57:27]
          change <= UInt<1>("h1") @[intervox_receiver.scala 58:24]
        else :
          edgeState <= UInt<2>("h0") @[intervox_receiver.scala 60:27]
          change <= UInt<1>("h1") @[intervox_receiver.scala 61:24]
      else :
        node _T_4 = eq(UInt<2>("h2"), edgeState) @[intervox_receiver.scala 49:22]
        when _T_4 : @[intervox_receiver.scala 49:22]
          node _T_5 = eq(io.DATA_IN, UInt<1>("h0")) @[intervox_receiver.scala 65:29]
          when _T_5 : @[intervox_receiver.scala 65:37]
            edgeState <= UInt<2>("h1") @[intervox_receiver.scala 66:27]
    node _T_6 = eq(change, UInt<1>("h1")) @[intervox_receiver.scala 71:17]
    when _T_6 : @[intervox_receiver.scala 71:25]
      reg change_REG : UInt, clock with :
        reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 72:34]
      change_REG <= UInt<1>("h0") @[intervox_receiver.scala 72:34]
      reg change_REG_1 : UInt, clock with :
        reset => (reset, UInt<1>("h0")) @[intervox_receiver.scala 72:26]
      change_REG_1 <= change_REG @[intervox_receiver.scala 72:26]
      change <= change_REG_1 @[intervox_receiver.scala 72:16]
      changed <= UInt<1>("h0") @[intervox_receiver.scala 74:21]
      node _clkRec_T = not(clkRec) @[intervox_receiver.scala 76:24]
      clkRec <= _clkRec_T @[intervox_receiver.scala 76:21]
      syncWord <= UInt<1>("h0") @[intervox_receiver.scala 78:21]
      syncFlipped <= UInt<1>("h0") @[intervox_receiver.scala 79:21]
      syncFlipped1 <= UInt<1>("h0") @[intervox_receiver.scala 80:21]
      deltaCntr <= UInt<1>("h0") @[intervox_receiver.scala 82:21]
      node _T_7 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 86:37]
      node _T_8 = tail(_T_7, 1) @[intervox_receiver.scala 86:37]
      node _T_9 = div(_T_8, UInt<2>("h2")) @[intervox_receiver.scala 86:43]
      node _T_10 = gt(deltaCntr, _T_9) @[intervox_receiver.scala 86:25]
      node _T_11 = add(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 86:74]
      node _T_12 = tail(_T_11, 1) @[intervox_receiver.scala 86:74]
      node _T_13 = lt(deltaCntr, _T_12) @[intervox_receiver.scala 86:63]
      node _T_14 = and(_T_10, _T_13) @[intervox_receiver.scala 86:50]
      when _T_14 : @[intervox_receiver.scala 86:83]
        dataOut <= UInt<1>("h1") @[intervox_receiver.scala 91:25]
        zeroPeriode <= UInt<1>("h0") @[intervox_receiver.scala 93:25]
        lastOne <= deltaCntr @[intervox_receiver.scala 95:25]
    node _T_15 = add(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 101:33]
    node _T_16 = tail(_T_15, 1) @[intervox_receiver.scala 101:33]
    node _T_17 = geq(deltaCntr, _T_16) @[intervox_receiver.scala 101:21]
    node _T_18 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 101:66]
    node _T_19 = add(_T_18, UInt<2>("h2")) @[intervox_receiver.scala 101:74]
    node _T_20 = tail(_T_19, 1) @[intervox_receiver.scala 101:74]
    node _T_21 = lt(deltaCntr, _T_20) @[intervox_receiver.scala 101:54]
    node _T_22 = and(_T_17, _T_21) @[intervox_receiver.scala 101:41]
    when _T_22 : @[intervox_receiver.scala 101:81]
      dataOut <= UInt<1>("h0") @[intervox_receiver.scala 106:25]
      zeroPeriode <= UInt<1>("h1") @[intervox_receiver.scala 108:25]
      syncWord <= UInt<1>("h0") @[intervox_receiver.scala 110:25]
    node _T_23 = mul(lastOne, UInt<2>("h2")) @[intervox_receiver.scala 113:34]
    node _T_24 = add(_T_23, UInt<2>("h2")) @[intervox_receiver.scala 113:41]
    node _T_25 = tail(_T_24, 1) @[intervox_receiver.scala 113:41]
    node _T_26 = geq(deltaCntr, _T_25) @[intervox_receiver.scala 113:21]
    when _T_26 : @[intervox_receiver.scala 113:49]
      syncWord <= UInt<1>("h1") @[intervox_receiver.scala 115:18]
      node _T_27 = eq(syncFlipped, UInt<1>("h0")) @[intervox_receiver.scala 117:26]
      when _T_27 : @[intervox_receiver.scala 117:34]
        node _clkRec_T_1 = not(clkRec) @[intervox_receiver.scala 119:24]
        clkRec <= _clkRec_T_1 @[intervox_receiver.scala 119:21]
        syncFlipped <= UInt<1>("h1") @[intervox_receiver.scala 120:25]
      node _T_28 = mul(lastOne, UInt<2>("h3")) @[intervox_receiver.scala 123:38]
      node _T_29 = add(_T_28, UInt<1>("h1")) @[intervox_receiver.scala 123:45]
      node _T_30 = tail(_T_29, 1) @[intervox_receiver.scala 123:45]
      node _T_31 = geq(deltaCntr, _T_30) @[intervox_receiver.scala 123:25]
      node _T_32 = eq(syncFlipped1, UInt<1>("h0")) @[intervox_receiver.scala 123:69]
      node _T_33 = and(_T_31, _T_32) @[intervox_receiver.scala 123:53]
      when _T_33 : @[intervox_receiver.scala 123:78]
        node _clkRec_T_2 = not(clkRec) @[intervox_receiver.scala 125:24]
        clkRec <= _clkRec_T_2 @[intervox_receiver.scala 125:21]
        syncFlipped1 <= UInt<1>("h1") @[intervox_receiver.scala 126:26]
    node _T_34 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 137:32]
    node _T_35 = tail(_T_34, 1) @[intervox_receiver.scala 137:32]
    node _T_36 = gt(deltaCntr, _T_35) @[intervox_receiver.scala 137:22]
    node _T_37 = eq(changed, UInt<1>("h0")) @[intervox_receiver.scala 137:50]
    node _T_38 = and(_T_36, _T_37) @[intervox_receiver.scala 137:39]
    node _T_39 = neq(change, UInt<1>("h1")) @[intervox_receiver.scala 137:69]
    node _T_40 = and(_T_38, _T_39) @[intervox_receiver.scala 137:59]
    node _T_41 = add(lastOne, UInt<1>("h1")) @[intervox_receiver.scala 137:103]
    node _T_42 = tail(_T_41, 1) @[intervox_receiver.scala 137:103]
    node _T_43 = gt(deltaCntr, _T_42) @[intervox_receiver.scala 137:93]
    node _T_44 = eq(zeroPeriode, UInt<1>("h1")) @[intervox_receiver.scala 137:125]
    node _T_45 = and(_T_43, _T_44) @[intervox_receiver.scala 137:110]
    node _T_46 = eq(changed, UInt<1>("h0")) @[intervox_receiver.scala 137:145]
    node _T_47 = and(_T_45, _T_46) @[intervox_receiver.scala 137:134]
    node _T_48 = or(_T_40, _T_47) @[intervox_receiver.scala 137:79]
    when _T_48 : @[intervox_receiver.scala 137:155]
      node _clkRec_T_3 = not(clkRec) @[intervox_receiver.scala 138:20]
      clkRec <= _clkRec_T_3 @[intervox_receiver.scala 138:17]
      changed <= UInt<1>("h1") @[intervox_receiver.scala 139:17]

  extmodule clk_wiz_0_clk_wiz :
    output CLK_OUT : UInt<1>
    output locked : UInt<1>
    input CLK_IN : UInt<1>
    defname = clk_wiz_0_clk_wiz

  module interVox_Reciever :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip INTERVOX_IN : UInt<1>, CLK_REC : UInt<1>, DATA_OUT : UInt<1>, CLK_DBUG : UInt<1>, DBUG : UInt<1>, DBUG1 : UInt<1>, LEDS : UInt<16>}

    inst clockRec of clock_Recovery @[intervox_receiver.scala 156:26]
    clockRec.clock <= clock
    clockRec.reset <= reset
    clockRec.io.DATA_IN <= io.INTERVOX_IN @[intervox_receiver.scala 158:25]
    io.LEDS <= clockRec.io.LEDS @[intervox_receiver.scala 160:25]
    io.DATA_OUT <= clockRec.io.DATA_OUT @[intervox_receiver.scala 161:25]
    io.CLK_DBUG <= clockRec.io.CLK_OUT @[intervox_receiver.scala 162:25]
    io.DBUG1 <= clockRec.io.DBUG1 @[intervox_receiver.scala 163:25]
    io.DBUG <= clockRec.io.DBUG @[intervox_receiver.scala 164:25]
    io.CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 167:16]
    inst pll of clk_wiz_0_clk_wiz @[intervox_receiver.scala 172:21]
    pll.CLK_IN is invalid
    pll.locked is invalid
    pll.CLK_OUT is invalid
    pll.CLK_IN <= clockRec.io.CLK_OUT @[intervox_receiver.scala 175:19]
    node _T = eq(pll.locked, UInt<1>("h1")) @[intervox_receiver.scala 178:24]
    when _T : @[intervox_receiver.scala 178:32]
      io.CLK_REC <= pll.CLK_OUT @[intervox_receiver.scala 179:20]
    else :
      io.CLK_REC <= UInt<1>("h0") @[intervox_receiver.scala 182:20]

