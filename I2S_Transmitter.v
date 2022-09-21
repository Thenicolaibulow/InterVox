module I2S_Transmitter(
  input         clock,
  input         reset,
  input  [31:0] io_Tx,
  output        io_Ready,
  output        io_LRCLK,
  output        io_BCLK,
  output        io_MCLK,
  output [15:0] io_DATA,
  output        io_bDATA,
  output [1:0]  io_State_o,
  output [7:0]  io_BitCntr,
  output        io_tick,
  input  [15:0] io_sw,
  output [15:0] io_CLKR
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg  current_state; // @[Hello.scala 39:30]
  reg [7:0] Bit_Counter; // @[Hello.scala 40:30]
  reg [7:0] ClkCntr; // @[Hello.scala 41:30]
  reg  Tckr; // @[Hello.scala 42:30]
  reg  BCLKTckr; // @[Hello.scala 43:30]
  reg  LRClkr; // @[Hello.scala 44:30]
  reg  MCLKTckr; // @[Hello.scala 45:30]
  reg  bDATA; // @[Hello.scala 46:30]
  reg [15:0] DATA; // @[Hello.scala 47:30]
  reg [31:0] lutOut; // @[Hello.scala 48:30]
  reg [7:0] FRAME_NR; // @[Hello.scala 49:30]
  wire [7:0] _ClkCntr_T_1 = ClkCntr + 8'h1; // @[Hello.scala 55:22]
  wire  _T_1 = ClkCntr == 8'h8; // @[Hello.scala 59:17]
  wire  _T_2 = ClkCntr == 8'h4 | _T_1; // @[Hello.scala 58:27]
  wire  _T_3 = ClkCntr == 8'hc; // @[Hello.scala 60:17]
  wire  _T_4 = _T_2 | _T_3; // @[Hello.scala 59:27]
  wire  _T_5 = ClkCntr == 8'h10; // @[Hello.scala 61:17]
  wire  _T_6 = _T_4 | _T_5; // @[Hello.scala 60:27]
  wire  _T_7 = ClkCntr == 8'h14; // @[Hello.scala 62:17]
  wire  _T_8 = _T_6 | _T_7; // @[Hello.scala 61:27]
  wire  _T_9 = ClkCntr == 8'h18; // @[Hello.scala 63:17]
  wire  _T_10 = _T_8 | _T_9; // @[Hello.scala 62:27]
  wire  _T_11 = ClkCntr == 8'h1c; // @[Hello.scala 64:17]
  wire  _T_12 = _T_10 | _T_11; // @[Hello.scala 63:27]
  wire  _T_13 = ClkCntr == 8'h20; // @[Hello.scala 65:17]
  wire  _T_14 = _T_12 | _T_13; // @[Hello.scala 64:27]
  wire  _T_15 = ClkCntr == 8'h24; // @[Hello.scala 66:17]
  wire  _T_16 = _T_14 | _T_15; // @[Hello.scala 65:27]
  wire  _T_17 = ClkCntr == 8'h28; // @[Hello.scala 67:17]
  wire  _T_18 = _T_16 | _T_17; // @[Hello.scala 66:27]
  wire  _T_19 = ClkCntr == 8'h2c; // @[Hello.scala 68:17]
  wire  _T_20 = _T_18 | _T_19; // @[Hello.scala 67:27]
  wire  _T_21 = ClkCntr == 8'h30; // @[Hello.scala 69:17]
  wire  _T_22 = _T_20 | _T_21; // @[Hello.scala 68:27]
  wire  _T_23 = ClkCntr == 8'h34; // @[Hello.scala 70:17]
  wire  _T_24 = _T_22 | _T_23; // @[Hello.scala 69:27]
  wire  _T_25 = ClkCntr == 8'h38; // @[Hello.scala 71:17]
  wire  _T_26 = _T_24 | _T_25; // @[Hello.scala 70:27]
  wire  _T_27 = ClkCntr == 8'h3c; // @[Hello.scala 72:17]
  wire  _T_28 = _T_26 | _T_27; // @[Hello.scala 71:27]
  wire  _T_29 = ClkCntr == 8'h40; // @[Hello.scala 73:17]
  wire  _T_30 = _T_28 | _T_29; // @[Hello.scala 72:27]
  wire  _T_31 = ClkCntr == 8'h44; // @[Hello.scala 74:17]
  wire  _T_32 = _T_30 | _T_31; // @[Hello.scala 73:27]
  wire  _T_33 = ClkCntr == 8'h48; // @[Hello.scala 75:17]
  wire  _T_34 = _T_32 | _T_33; // @[Hello.scala 74:27]
  wire  _GEN_0 = _T_34 ? ~MCLKTckr : MCLKTckr; // @[Hello.scala 75:27 78:20 45:30]
  wire  _T_37 = _T_13 | _T_29; // @[Hello.scala 83:26]
  wire  _GEN_1 = _T_37 ? ~BCLKTckr : BCLKTckr; // @[Hello.scala 84:27 86:20 43:30]
  wire [7:0] _FRAME_NR_T_1 = FRAME_NR + 8'h1; // @[Hello.scala 101:26]
  wire [5:0] _T_47 = 6'h20 - 6'h1; // @[Hello.scala 147:64]
  wire [7:0] _GEN_249 = {{2'd0}, _T_47}; // @[Hello.scala 147:55]
  wire [15:0] _GEN_7 = 7'h1 == FRAME_NR[6:0] ? $signed(16'sh26a1) : $signed(16'sh0); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_8 = 7'h2 == FRAME_NR[6:0] ? $signed(16'sh4979) : $signed(_GEN_7); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_9 = 7'h3 == FRAME_NR[6:0] ? $signed(16'sh6521) : $signed(_GEN_8); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_10 = 7'h4 == FRAME_NR[6:0] ? $signed(16'sh76e2) : $signed(_GEN_9); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_11 = 7'h5 == FRAME_NR[6:0] ? $signed(16'sh7d00) : $signed(_GEN_10); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_12 = 7'h6 == FRAME_NR[6:0] ? $signed(16'sh76e2) : $signed(_GEN_11); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_13 = 7'h7 == FRAME_NR[6:0] ? $signed(16'sh6521) : $signed(_GEN_12); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_14 = 7'h8 == FRAME_NR[6:0] ? $signed(16'sh4979) : $signed(_GEN_13); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_15 = 7'h9 == FRAME_NR[6:0] ? $signed(16'sh26a1) : $signed(_GEN_14); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_16 = 7'ha == FRAME_NR[6:0] ? $signed(16'sh0) : $signed(_GEN_15); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_17 = 7'hb == FRAME_NR[6:0] ? $signed(-16'sh26a1) : $signed(_GEN_16); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_18 = 7'hc == FRAME_NR[6:0] ? $signed(-16'sh4979) : $signed(_GEN_17); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_19 = 7'hd == FRAME_NR[6:0] ? $signed(-16'sh6521) : $signed(_GEN_18); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_20 = 7'he == FRAME_NR[6:0] ? $signed(-16'sh76e2) : $signed(_GEN_19); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_21 = 7'hf == FRAME_NR[6:0] ? $signed(-16'sh7d00) : $signed(_GEN_20); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_22 = 7'h10 == FRAME_NR[6:0] ? $signed(-16'sh76e2) : $signed(_GEN_21); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_23 = 7'h11 == FRAME_NR[6:0] ? $signed(-16'sh6521) : $signed(_GEN_22); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_24 = 7'h12 == FRAME_NR[6:0] ? $signed(-16'sh4979) : $signed(_GEN_23); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_25 = 7'h13 == FRAME_NR[6:0] ? $signed(-16'sh26a1) : $signed(_GEN_24); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_26 = 7'h14 == FRAME_NR[6:0] ? $signed(16'sh0) : $signed(_GEN_25); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_27 = 7'h15 == FRAME_NR[6:0] ? $signed(16'sh26a1) : $signed(_GEN_26); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_28 = 7'h16 == FRAME_NR[6:0] ? $signed(16'sh4979) : $signed(_GEN_27); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_29 = 7'h17 == FRAME_NR[6:0] ? $signed(16'sh6521) : $signed(_GEN_28); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_30 = 7'h18 == FRAME_NR[6:0] ? $signed(16'sh76e2) : $signed(_GEN_29); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_31 = 7'h19 == FRAME_NR[6:0] ? $signed(16'sh7d00) : $signed(_GEN_30); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_32 = 7'h1a == FRAME_NR[6:0] ? $signed(16'sh76e2) : $signed(_GEN_31); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_33 = 7'h1b == FRAME_NR[6:0] ? $signed(16'sh6521) : $signed(_GEN_32); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_34 = 7'h1c == FRAME_NR[6:0] ? $signed(16'sh4979) : $signed(_GEN_33); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_35 = 7'h1d == FRAME_NR[6:0] ? $signed(16'sh26a1) : $signed(_GEN_34); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_36 = 7'h1e == FRAME_NR[6:0] ? $signed(16'sh0) : $signed(_GEN_35); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_37 = 7'h1f == FRAME_NR[6:0] ? $signed(-16'sh26a1) : $signed(_GEN_36); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_38 = 7'h20 == FRAME_NR[6:0] ? $signed(-16'sh4979) : $signed(_GEN_37); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_39 = 7'h21 == FRAME_NR[6:0] ? $signed(-16'sh6521) : $signed(_GEN_38); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_40 = 7'h22 == FRAME_NR[6:0] ? $signed(-16'sh76e2) : $signed(_GEN_39); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_41 = 7'h23 == FRAME_NR[6:0] ? $signed(-16'sh7d00) : $signed(_GEN_40); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_42 = 7'h24 == FRAME_NR[6:0] ? $signed(-16'sh76e2) : $signed(_GEN_41); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_43 = 7'h25 == FRAME_NR[6:0] ? $signed(-16'sh6521) : $signed(_GEN_42); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_44 = 7'h26 == FRAME_NR[6:0] ? $signed(-16'sh4979) : $signed(_GEN_43); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_45 = 7'h27 == FRAME_NR[6:0] ? $signed(-16'sh26a1) : $signed(_GEN_44); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_46 = 7'h28 == FRAME_NR[6:0] ? $signed(16'sh0) : $signed(_GEN_45); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_47 = 7'h29 == FRAME_NR[6:0] ? $signed(16'sh26a1) : $signed(_GEN_46); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_48 = 7'h2a == FRAME_NR[6:0] ? $signed(16'sh4979) : $signed(_GEN_47); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_49 = 7'h2b == FRAME_NR[6:0] ? $signed(16'sh6521) : $signed(_GEN_48); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_50 = 7'h2c == FRAME_NR[6:0] ? $signed(16'sh76e2) : $signed(_GEN_49); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_51 = 7'h2d == FRAME_NR[6:0] ? $signed(16'sh7d00) : $signed(_GEN_50); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_52 = 7'h2e == FRAME_NR[6:0] ? $signed(16'sh76e2) : $signed(_GEN_51); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_53 = 7'h2f == FRAME_NR[6:0] ? $signed(16'sh6521) : $signed(_GEN_52); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_54 = 7'h30 == FRAME_NR[6:0] ? $signed(16'sh4979) : $signed(_GEN_53); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_55 = 7'h31 == FRAME_NR[6:0] ? $signed(16'sh26a1) : $signed(_GEN_54); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_56 = 7'h32 == FRAME_NR[6:0] ? $signed(16'sh0) : $signed(_GEN_55); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_57 = 7'h33 == FRAME_NR[6:0] ? $signed(-16'sh26a1) : $signed(_GEN_56); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_58 = 7'h34 == FRAME_NR[6:0] ? $signed(-16'sh4979) : $signed(_GEN_57); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_59 = 7'h35 == FRAME_NR[6:0] ? $signed(-16'sh6521) : $signed(_GEN_58); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_60 = 7'h36 == FRAME_NR[6:0] ? $signed(-16'sh76e2) : $signed(_GEN_59); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_61 = 7'h37 == FRAME_NR[6:0] ? $signed(-16'sh7d00) : $signed(_GEN_60); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_62 = 7'h38 == FRAME_NR[6:0] ? $signed(-16'sh76e2) : $signed(_GEN_61); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_63 = 7'h39 == FRAME_NR[6:0] ? $signed(-16'sh6521) : $signed(_GEN_62); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_64 = 7'h3a == FRAME_NR[6:0] ? $signed(-16'sh4979) : $signed(_GEN_63); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_65 = 7'h3b == FRAME_NR[6:0] ? $signed(-16'sh26a1) : $signed(_GEN_64); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_66 = 7'h3c == FRAME_NR[6:0] ? $signed(16'sh0) : $signed(_GEN_65); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_67 = 7'h3d == FRAME_NR[6:0] ? $signed(16'sh26a1) : $signed(_GEN_66); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_68 = 7'h3e == FRAME_NR[6:0] ? $signed(16'sh4979) : $signed(_GEN_67); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_69 = 7'h3f == FRAME_NR[6:0] ? $signed(16'sh6521) : $signed(_GEN_68); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_70 = 7'h40 == FRAME_NR[6:0] ? $signed(16'sh76e2) : $signed(_GEN_69); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_71 = 7'h41 == FRAME_NR[6:0] ? $signed(16'sh7d00) : $signed(_GEN_70); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_72 = 7'h42 == FRAME_NR[6:0] ? $signed(16'sh76e2) : $signed(_GEN_71); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_73 = 7'h43 == FRAME_NR[6:0] ? $signed(16'sh6521) : $signed(_GEN_72); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_74 = 7'h44 == FRAME_NR[6:0] ? $signed(16'sh4979) : $signed(_GEN_73); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_75 = 7'h45 == FRAME_NR[6:0] ? $signed(16'sh26a1) : $signed(_GEN_74); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_76 = 7'h46 == FRAME_NR[6:0] ? $signed(16'sh0) : $signed(_GEN_75); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_77 = 7'h47 == FRAME_NR[6:0] ? $signed(-16'sh26a1) : $signed(_GEN_76); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_78 = 7'h48 == FRAME_NR[6:0] ? $signed(-16'sh4979) : $signed(_GEN_77); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_79 = 7'h49 == FRAME_NR[6:0] ? $signed(-16'sh6521) : $signed(_GEN_78); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_80 = 7'h4a == FRAME_NR[6:0] ? $signed(-16'sh76e2) : $signed(_GEN_79); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_81 = 7'h4b == FRAME_NR[6:0] ? $signed(-16'sh7d00) : $signed(_GEN_80); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_82 = 7'h4c == FRAME_NR[6:0] ? $signed(-16'sh76e2) : $signed(_GEN_81); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_83 = 7'h4d == FRAME_NR[6:0] ? $signed(-16'sh6521) : $signed(_GEN_82); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_84 = 7'h4e == FRAME_NR[6:0] ? $signed(-16'sh4979) : $signed(_GEN_83); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_85 = 7'h4f == FRAME_NR[6:0] ? $signed(-16'sh26a1) : $signed(_GEN_84); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_86 = 7'h50 == FRAME_NR[6:0] ? $signed(16'sh0) : $signed(_GEN_85); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_87 = 7'h51 == FRAME_NR[6:0] ? $signed(16'sh26a1) : $signed(_GEN_86); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_88 = 7'h52 == FRAME_NR[6:0] ? $signed(16'sh4979) : $signed(_GEN_87); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_89 = 7'h53 == FRAME_NR[6:0] ? $signed(16'sh6521) : $signed(_GEN_88); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_90 = 7'h54 == FRAME_NR[6:0] ? $signed(16'sh76e2) : $signed(_GEN_89); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_91 = 7'h55 == FRAME_NR[6:0] ? $signed(16'sh7d00) : $signed(_GEN_90); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_92 = 7'h56 == FRAME_NR[6:0] ? $signed(16'sh76e2) : $signed(_GEN_91); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_93 = 7'h57 == FRAME_NR[6:0] ? $signed(16'sh6521) : $signed(_GEN_92); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_94 = 7'h58 == FRAME_NR[6:0] ? $signed(16'sh4979) : $signed(_GEN_93); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_95 = 7'h59 == FRAME_NR[6:0] ? $signed(16'sh26a1) : $signed(_GEN_94); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_96 = 7'h5a == FRAME_NR[6:0] ? $signed(16'sh0) : $signed(_GEN_95); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_97 = 7'h5b == FRAME_NR[6:0] ? $signed(-16'sh26a1) : $signed(_GEN_96); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_98 = 7'h5c == FRAME_NR[6:0] ? $signed(-16'sh4979) : $signed(_GEN_97); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_99 = 7'h5d == FRAME_NR[6:0] ? $signed(-16'sh6521) : $signed(_GEN_98); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_100 = 7'h5e == FRAME_NR[6:0] ? $signed(-16'sh76e2) : $signed(_GEN_99); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_101 = 7'h5f == FRAME_NR[6:0] ? $signed(-16'sh7d00) : $signed(_GEN_100); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_102 = 7'h60 == FRAME_NR[6:0] ? $signed(-16'sh76e2) : $signed(_GEN_101); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_103 = 7'h61 == FRAME_NR[6:0] ? $signed(-16'sh6521) : $signed(_GEN_102); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_104 = 7'h62 == FRAME_NR[6:0] ? $signed(-16'sh4979) : $signed(_GEN_103); // @[Hello.scala 151:{43,43}]
  wire [15:0] _GEN_105 = 7'h63 == FRAME_NR[6:0] ? $signed(-16'sh26a1) : $signed(_GEN_104); // @[Hello.scala 151:{43,43}]
  wire [31:0] _lutOut_T_1 = {$signed(_GEN_105), 16'h0}; // @[Hello.scala 151:43]
  wire [31:0] _GEN_250 = {{16{_GEN_105[15]}},_GEN_105}; // @[Hello.scala 151:50]
  wire [31:0] _lutOut_T_5 = $signed(_lutOut_T_1) + $signed(_GEN_250); // @[Hello.scala 151:50]
  wire [7:0] _bDATA_T_3 = _GEN_249 - Bit_Counter; // @[Hello.scala 153:44]
  wire [31:0] _bDATA_T_4 = $signed(lutOut) >>> _bDATA_T_3; // @[Hello.scala 153:29]
  wire [31:0] _GEN_206 = Bit_Counter == 8'h0 | Bit_Counter <= _GEN_249 ? $signed(_lutOut_T_5) : $signed(lutOut); // @[Hello.scala 147:71 151:20 48:30]
  wire  _GEN_207 = Bit_Counter == 8'h0 | Bit_Counter <= _GEN_249 ? _bDATA_T_4[0] : bDATA; // @[Hello.scala 147:71 153:19 46:30]
  wire [31:0] _GEN_208 = Bit_Counter == 8'h0 | Bit_Counter <= _GEN_249 ? $signed(lutOut) : $signed({{16{DATA[15]}},DATA}
    ); // @[Hello.scala 147:71 154:19 47:30]
  wire [31:0] sw_msb_lsb_16_R = {$signed(io_sw), 16'h0}; // @[Hello.scala 158:41]
  wire [31:0] _GEN_252 = {{16{io_sw[15]}},io_sw}; // @[Hello.scala 160:50]
  wire [31:0] sw_msb_lsb_32 = $signed(_GEN_252) + $signed(sw_msb_lsb_16_R); // @[Hello.scala 160:50]
  wire [31:0] _bDATA_T_10 = $signed(sw_msb_lsb_32) >>> _bDATA_T_3; // @[Hello.scala 162:36]
  wire [31:0] _GEN_209 = $signed(io_sw) == 16'sh0 ? $signed(_GEN_206) : $signed(lutOut); // @[Hello.scala 145:30 48:30]
  wire  _GEN_210 = $signed(io_sw) == 16'sh0 ? _GEN_207 : _bDATA_T_10[0]; // @[Hello.scala 145:30 162:19]
  wire [31:0] _GEN_211 = $signed(io_sw) == 16'sh0 ? $signed(_GEN_208) : $signed({{16{io_sw[15]}},io_sw}); // @[Hello.scala 145:30 163:19]
  wire [5:0] _T_50 = 6'h20 / 2'h2; // @[Hello.scala 167:38]
  wire [5:0] _T_52 = _T_50 - 6'h1; // @[Hello.scala 167:45]
  wire [7:0] _GEN_254 = {{2'd0}, _T_52}; // @[Hello.scala 167:27]
  wire  _GEN_212 = Bit_Counter >= _GEN_254 | LRClkr; // @[Hello.scala 167:53 168:18 44:30]
  wire  _T_60 = Bit_Counter == _GEN_249; // @[Hello.scala 170:69]
  wire  _GEN_213 = Bit_Counter < _GEN_254 | Bit_Counter == _GEN_249 ? 1'h0 : _GEN_212; // @[Hello.scala 170:89 171:18]
  wire [7:0] _Bit_Counter_T_1 = Bit_Counter + 8'h1; // @[Hello.scala 182:38]
  wire [7:0] _GEN_214 = _T_60 ? 8'h0 : _Bit_Counter_T_1; // @[Hello.scala 175:46 176:23 182:23]
  wire  _GEN_217 = current_state & _T_60; // @[Hello.scala 114:15 124:26]
  wire [31:0] _GEN_220 = current_state ? $signed(_GEN_211) : $signed({{16{DATA[15]}},DATA}); // @[Hello.scala 124:26 47:30]
  wire  _GEN_223 = ~current_state ? 1'h0 : current_state; // @[Hello.scala 124:26 128:21]
  wire  _GEN_224 = ~current_state ? 1'h0 : _GEN_217; // @[Hello.scala 124:26 129:21]
  wire  _GEN_225 = ~current_state ? 1'h0 : LRClkr; // @[Hello.scala 108:15 124:26 130:21]
  wire  _GEN_226 = ~current_state ? 1'h0 : BCLKTckr; // @[Hello.scala 106:15 124:26 131:21]
  wire  _GEN_227 = ~current_state ? 1'h0 : MCLKTckr; // @[Hello.scala 107:15 124:26 132:21]
  wire [15:0] _GEN_228 = ~current_state ? $signed(16'sh0) : $signed(DATA); // @[Hello.scala 110:15 124:26 133:21]
  wire [7:0] _GEN_230 = ~current_state ? 8'h0 : Bit_Counter; // @[Hello.scala 105:15 124:26 135:21]
  wire  _GEN_231 = ~current_state | current_state; // @[Hello.scala 124:26 136:23 39:30]
  wire [31:0] _GEN_234 = ~current_state ? $signed({{16{DATA[15]}},DATA}) : $signed(_GEN_220); // @[Hello.scala 124:26 47:30]
  wire  _GEN_236 = Tckr & _GEN_223; // @[Hello.scala 115:15 122:23]
  wire [31:0] _GEN_247 = Tckr ? $signed(_GEN_234) : $signed({{16{DATA[15]}},DATA}); // @[Hello.scala 122:23 47:30]
  wire [31:0] _GEN_258 = reset ? $signed(32'sh0) : $signed(_GEN_247); // @[Hello.scala 47:{30,30}]
  assign io_Ready = Tckr & _GEN_224; // @[Hello.scala 114:15 122:23]
  assign io_LRCLK = Tckr ? _GEN_225 : LRClkr; // @[Hello.scala 108:15 122:23]
  assign io_BCLK = Tckr ? _GEN_226 : BCLKTckr; // @[Hello.scala 106:15 122:23]
  assign io_MCLK = Tckr ? _GEN_227 : MCLKTckr; // @[Hello.scala 107:15 122:23]
  assign io_DATA = Tckr ? $signed(_GEN_228) : $signed(DATA); // @[Hello.scala 110:15 122:23]
  assign io_bDATA = bDATA; // @[Hello.scala 109:15]
  assign io_State_o = {{1'd0}, _GEN_236};
  assign io_BitCntr = Tckr ? _GEN_230 : Bit_Counter; // @[Hello.scala 105:15 122:23]
  assign io_tick = Tckr; // @[Hello.scala 112:15]
  assign io_CLKR = {{8'd0}, ClkCntr}; // @[Hello.scala 111:15]
  always @(posedge clock) begin
    if (reset) begin // @[Hello.scala 39:30]
      current_state <= 1'h0; // @[Hello.scala 39:30]
    end else if (Tckr) begin // @[Hello.scala 122:23]
      current_state <= _GEN_231;
    end
    if (reset) begin // @[Hello.scala 40:30]
      Bit_Counter <= 8'h0; // @[Hello.scala 40:30]
    end else if (Tckr) begin // @[Hello.scala 122:23]
      if (~current_state) begin // @[Hello.scala 124:26]
        Bit_Counter <= 8'h0; // @[Hello.scala 134:21]
      end else if (current_state) begin // @[Hello.scala 124:26]
        Bit_Counter <= _GEN_214;
      end
    end
    if (reset) begin // @[Hello.scala 41:30]
      ClkCntr <= 8'h0; // @[Hello.scala 41:30]
    end else if (_T_29) begin // @[Hello.scala 91:26]
      ClkCntr <= 8'h0; // @[Hello.scala 94:13]
    end else begin
      ClkCntr <= _ClkCntr_T_1; // @[Hello.scala 55:11]
    end
    if (reset) begin // @[Hello.scala 42:30]
      Tckr <= 1'h0; // @[Hello.scala 42:30]
    end else begin
      Tckr <= _T_29;
    end
    BCLKTckr <= reset | _GEN_1; // @[Hello.scala 43:{30,30}]
    if (reset) begin // @[Hello.scala 44:30]
      LRClkr <= 1'h0; // @[Hello.scala 44:30]
    end else if (Tckr) begin // @[Hello.scala 122:23]
      if (!(~current_state)) begin // @[Hello.scala 124:26]
        if (current_state) begin // @[Hello.scala 124:26]
          LRClkr <= _GEN_213;
        end
      end
    end
    MCLKTckr <= reset | _GEN_0; // @[Hello.scala 45:{30,30}]
    if (reset) begin // @[Hello.scala 46:30]
      bDATA <= 1'h0; // @[Hello.scala 46:30]
    end else if (Tckr) begin // @[Hello.scala 122:23]
      if (!(~current_state)) begin // @[Hello.scala 124:26]
        if (current_state) begin // @[Hello.scala 124:26]
          bDATA <= _GEN_210;
        end
      end
    end
    DATA <= _GEN_258[15:0]; // @[Hello.scala 47:{30,30}]
    if (reset) begin // @[Hello.scala 48:30]
      lutOut <= 32'sh0; // @[Hello.scala 48:30]
    end else if (Tckr) begin // @[Hello.scala 122:23]
      if (!(~current_state)) begin // @[Hello.scala 124:26]
        if (current_state) begin // @[Hello.scala 124:26]
          lutOut <= _GEN_209;
        end
      end
    end
    if (reset) begin // @[Hello.scala 49:30]
      FRAME_NR <= 8'h0; // @[Hello.scala 49:30]
    end else if (FRAME_NR == 8'h19) begin // @[Hello.scala 117:27]
      FRAME_NR <= 8'h0; // @[Hello.scala 118:14]
    end else if (io_Ready) begin // @[Hello.scala 100:26]
      FRAME_NR <= _FRAME_NR_T_1; // @[Hello.scala 101:14]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  current_state = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  Bit_Counter = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  ClkCntr = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  Tckr = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  BCLKTckr = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  LRClkr = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  MCLKTckr = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  bDATA = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  DATA = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  lutOut = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  FRAME_NR = _RAND_10[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
