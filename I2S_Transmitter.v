module I2S_Transmitter(
  input         clock,
  input         reset,
  input  [31:0] io_Tx,
  output        io_Ready,
  output        io_LRCLK,
  output        io_BCLK,
  output        io_MCLK,
  output [31:0] io_DATA,
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
`endif // RANDOMIZE_REG_INIT
  reg  current_state; // @[Hello.scala 31:30]
  reg [7:0] Bit_Counter; // @[Hello.scala 32:30]
  reg [7:0] ClkCntr; // @[Hello.scala 33:30]
  reg  Tckr; // @[Hello.scala 34:30]
  reg  BCLKTckr; // @[Hello.scala 35:30]
  reg  LRClkr; // @[Hello.scala 36:30]
  reg  MCLKTckr; // @[Hello.scala 37:30]
  reg  bDATA; // @[Hello.scala 38:30]
  reg [31:0] DATA; // @[Hello.scala 39:30]
  wire [7:0] _ClkCntr_T_1 = ClkCntr + 8'h1; // @[Hello.scala 47:22]
  wire  _T_1 = ClkCntr == 8'h8; // @[Hello.scala 51:17]
  wire  _T_2 = ClkCntr == 8'h4 | _T_1; // @[Hello.scala 50:27]
  wire  _T_3 = ClkCntr == 8'hc; // @[Hello.scala 52:17]
  wire  _T_4 = _T_2 | _T_3; // @[Hello.scala 51:27]
  wire  _T_5 = ClkCntr == 8'h10; // @[Hello.scala 53:17]
  wire  _T_6 = _T_4 | _T_5; // @[Hello.scala 52:27]
  wire  _T_7 = ClkCntr == 8'h14; // @[Hello.scala 54:17]
  wire  _T_8 = _T_6 | _T_7; // @[Hello.scala 53:27]
  wire  _T_9 = ClkCntr == 8'h18; // @[Hello.scala 55:17]
  wire  _T_10 = _T_8 | _T_9; // @[Hello.scala 54:27]
  wire  _T_11 = ClkCntr == 8'h1c; // @[Hello.scala 56:17]
  wire  _T_12 = _T_10 | _T_11; // @[Hello.scala 55:27]
  wire  _T_13 = ClkCntr == 8'h20; // @[Hello.scala 57:17]
  wire  _T_14 = _T_12 | _T_13; // @[Hello.scala 56:27]
  wire  _T_15 = ClkCntr == 8'h24; // @[Hello.scala 58:17]
  wire  _T_16 = _T_14 | _T_15; // @[Hello.scala 57:27]
  wire  _T_17 = ClkCntr == 8'h28; // @[Hello.scala 59:17]
  wire  _T_18 = _T_16 | _T_17; // @[Hello.scala 58:27]
  wire  _T_19 = ClkCntr == 8'h2c; // @[Hello.scala 60:17]
  wire  _T_20 = _T_18 | _T_19; // @[Hello.scala 59:27]
  wire  _T_21 = ClkCntr == 8'h30; // @[Hello.scala 61:17]
  wire  _T_22 = _T_20 | _T_21; // @[Hello.scala 60:27]
  wire  _T_23 = ClkCntr == 8'h34; // @[Hello.scala 62:17]
  wire  _T_24 = _T_22 | _T_23; // @[Hello.scala 61:27]
  wire  _T_25 = ClkCntr == 8'h38; // @[Hello.scala 63:17]
  wire  _T_26 = _T_24 | _T_25; // @[Hello.scala 62:27]
  wire  _T_27 = ClkCntr == 8'h3c; // @[Hello.scala 64:17]
  wire  _T_28 = _T_26 | _T_27; // @[Hello.scala 63:27]
  wire  _T_29 = ClkCntr == 8'h40; // @[Hello.scala 65:17]
  wire  _T_30 = _T_28 | _T_29; // @[Hello.scala 64:27]
  wire  _T_31 = ClkCntr == 8'h44; // @[Hello.scala 66:17]
  wire  _T_32 = _T_30 | _T_31; // @[Hello.scala 65:27]
  wire  _T_33 = ClkCntr == 8'h48; // @[Hello.scala 67:17]
  wire  _T_34 = _T_32 | _T_33; // @[Hello.scala 66:27]
  wire  _GEN_0 = _T_34 ? ~MCLKTckr : MCLKTckr; // @[Hello.scala 67:27 70:20 37:30]
  wire  _T_37 = _T_13 | _T_29; // @[Hello.scala 75:26]
  wire  _GEN_1 = _T_37 ? ~BCLKTckr : BCLKTckr; // @[Hello.scala 76:27 78:20 35:30]
  wire [5:0] _T_45 = 6'h20 - 6'h1; // @[Hello.scala 137:64]
  wire [7:0] _GEN_42 = {{2'd0}, _T_45}; // @[Hello.scala 137:55]
  wire [7:0] _bDATA_T_3 = _GEN_42 - Bit_Counter; // @[Hello.scala 141:50]
  wire [23:0] _bDATA_T_4 = 24'h970097 >> _bDATA_T_3; // @[Hello.scala 141:35]
  wire  _GEN_4 = Bit_Counter == 8'h0 | Bit_Counter <= _GEN_42 ? _bDATA_T_4[0] : bDATA; // @[Hello.scala 137:71 141:19 38:30]
  wire [31:0] _GEN_5 = Bit_Counter == 8'h0 | Bit_Counter <= _GEN_42 ? 32'h970097 : DATA; // @[Hello.scala 137:71 142:19 39:30]
  wire [31:0] sw_msb_lsb_16_R = {io_sw, 16'h0}; // @[Hello.scala 148:41]
  wire [31:0] _GEN_44 = {{16'd0}, io_sw}; // @[Hello.scala 150:50]
  wire [31:0] sw_msb_lsb_32 = _GEN_44 + sw_msb_lsb_16_R; // @[Hello.scala 150:50]
  wire [31:0] _bDATA_T_10 = sw_msb_lsb_32 >> _bDATA_T_3; // @[Hello.scala 152:36]
  wire  _GEN_6 = io_sw == 16'h0 ? _GEN_4 : _bDATA_T_10[0]; // @[Hello.scala 135:30 152:19]
  wire [31:0] _GEN_7 = io_sw == 16'h0 ? _GEN_5 : {{16'd0}, io_sw}; // @[Hello.scala 135:30 153:19]
  wire [5:0] _T_48 = 6'h20 / 2'h2; // @[Hello.scala 157:38]
  wire [5:0] _T_50 = _T_48 - 6'h1; // @[Hello.scala 157:45]
  wire [7:0] _GEN_46 = {{2'd0}, _T_50}; // @[Hello.scala 157:27]
  wire  _GEN_8 = Bit_Counter >= _GEN_46 | LRClkr; // @[Hello.scala 157:53 158:18 36:30]
  wire  _T_58 = Bit_Counter == _GEN_42; // @[Hello.scala 160:69]
  wire  _GEN_9 = Bit_Counter < _GEN_46 | Bit_Counter == _GEN_42 ? 1'h0 : _GEN_8; // @[Hello.scala 160:89 161:18]
  wire [7:0] _Bit_Counter_T_1 = Bit_Counter + 8'h1; // @[Hello.scala 172:38]
  wire [7:0] _GEN_10 = _T_58 ? 8'h0 : _Bit_Counter_T_1; // @[Hello.scala 165:46 166:23 172:23]
  wire  _GEN_17 = current_state & _T_58; // @[Hello.scala 103:15 115:26]
  wire  _GEN_18 = ~current_state ? 1'h0 : current_state; // @[Hello.scala 115:26 119:21]
  wire  _GEN_19 = ~current_state ? 1'h0 : _GEN_17; // @[Hello.scala 115:26 120:21]
  wire  _GEN_20 = ~current_state ? 1'h0 : LRClkr; // @[Hello.scala 115:26 121:21 97:15]
  wire  _GEN_21 = ~current_state ? 1'h0 : BCLKTckr; // @[Hello.scala 115:26 122:21 95:15]
  wire  _GEN_22 = ~current_state ? 1'h0 : MCLKTckr; // @[Hello.scala 115:26 123:21 96:15]
  wire [31:0] _GEN_23 = ~current_state ? 32'h0 : DATA; // @[Hello.scala 115:26 124:21 99:15]
  wire [7:0] _GEN_25 = ~current_state ? 8'h0 : Bit_Counter; // @[Hello.scala 115:26 126:21 94:15]
  wire  _GEN_26 = ~current_state | current_state; // @[Hello.scala 115:26 127:23 31:30]
  wire  _GEN_30 = Tckr & _GEN_18; // @[Hello.scala 104:15 113:23]
  assign io_Ready = Tckr & _GEN_19; // @[Hello.scala 103:15 113:23]
  assign io_LRCLK = Tckr ? _GEN_20 : LRClkr; // @[Hello.scala 113:23 97:15]
  assign io_BCLK = Tckr ? _GEN_21 : BCLKTckr; // @[Hello.scala 113:23 95:15]
  assign io_MCLK = Tckr ? _GEN_22 : MCLKTckr; // @[Hello.scala 113:23 96:15]
  assign io_DATA = Tckr ? _GEN_23 : DATA; // @[Hello.scala 113:23 99:15]
  assign io_bDATA = bDATA; // @[Hello.scala 98:15]
  assign io_State_o = {{1'd0}, _GEN_30};
  assign io_BitCntr = Tckr ? _GEN_25 : Bit_Counter; // @[Hello.scala 113:23 94:15]
  assign io_tick = Tckr; // @[Hello.scala 101:15]
  assign io_CLKR = {{8'd0}, ClkCntr}; // @[Hello.scala 100:15]
  always @(posedge clock) begin
    if (reset) begin // @[Hello.scala 31:30]
      current_state <= 1'h0; // @[Hello.scala 31:30]
    end else if (Tckr) begin // @[Hello.scala 113:23]
      current_state <= _GEN_26;
    end
    if (reset) begin // @[Hello.scala 32:30]
      Bit_Counter <= 8'h0; // @[Hello.scala 32:30]
    end else if (Tckr) begin // @[Hello.scala 113:23]
      if (~current_state) begin // @[Hello.scala 115:26]
        Bit_Counter <= 8'h0; // @[Hello.scala 125:21]
      end else if (current_state) begin // @[Hello.scala 115:26]
        Bit_Counter <= _GEN_10;
      end
    end
    if (reset) begin // @[Hello.scala 33:30]
      ClkCntr <= 8'h0; // @[Hello.scala 33:30]
    end else if (_T_29) begin // @[Hello.scala 83:26]
      ClkCntr <= 8'h0; // @[Hello.scala 86:13]
    end else begin
      ClkCntr <= _ClkCntr_T_1; // @[Hello.scala 47:11]
    end
    if (reset) begin // @[Hello.scala 34:30]
      Tckr <= 1'h0; // @[Hello.scala 34:30]
    end else begin
      Tckr <= _T_29;
    end
    BCLKTckr <= reset | _GEN_1; // @[Hello.scala 35:{30,30}]
    if (reset) begin // @[Hello.scala 36:30]
      LRClkr <= 1'h0; // @[Hello.scala 36:30]
    end else if (Tckr) begin // @[Hello.scala 113:23]
      if (!(~current_state)) begin // @[Hello.scala 115:26]
        if (current_state) begin // @[Hello.scala 115:26]
          LRClkr <= _GEN_9;
        end
      end
    end
    MCLKTckr <= reset | _GEN_0; // @[Hello.scala 37:{30,30}]
    if (reset) begin // @[Hello.scala 38:30]
      bDATA <= 1'h0; // @[Hello.scala 38:30]
    end else if (Tckr) begin // @[Hello.scala 113:23]
      if (!(~current_state)) begin // @[Hello.scala 115:26]
        if (current_state) begin // @[Hello.scala 115:26]
          bDATA <= _GEN_6;
        end
      end
    end
    if (reset) begin // @[Hello.scala 39:30]
      DATA <= 32'h0; // @[Hello.scala 39:30]
    end else if (Tckr) begin // @[Hello.scala 113:23]
      if (!(~current_state)) begin // @[Hello.scala 115:26]
        if (current_state) begin // @[Hello.scala 115:26]
          DATA <= _GEN_7;
        end
      end
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
  DATA = _RAND_8[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
