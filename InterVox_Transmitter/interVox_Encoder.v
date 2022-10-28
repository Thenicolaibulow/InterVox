module bi_phase_encoder(
  input         clock,
  input         reset,
  output        io_DATA_OUT,
  input  [63:0] io_AUDIOINPUT,
  input         io_TICK
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  outReg; // @[intervox_transmitter.scala 38:32]
  reg [63:0] stereoData; // @[intervox_transmitter.scala 40:32]
  reg [15:0] dspData; // @[intervox_transmitter.scala 41:32]
  reg [7:0] bitCntr_enc; // @[intervox_transmitter.scala 42:32]
  reg  hasNone; // @[intervox_transmitter.scala 43:32]
  reg [5:0] dataIndex; // @[intervox_transmitter.scala 44:32]
  wire [7:0] _bitCntr_enc_T_1 = bitCntr_enc + 8'h1; // @[intervox_transmitter.scala 56:38]
  wire [7:0] _GEN_0 = bitCntr_enc % 8'h2; // @[intervox_transmitter.scala 57:28]
  wire [1:0] _T_1 = _GEN_0[1:0]; // @[intervox_transmitter.scala 57:28]
  wire [5:0] _dataIndex_T_1 = dataIndex + 6'h1; // @[intervox_transmitter.scala 59:36]
  wire  _T_4 = bitCntr_enc < 8'h6; // @[intervox_transmitter.scala 66:30]
  wire  _GEN_1 = _T_4 ? 1'h0 : 1'h1; // @[intervox_transmitter.scala 67:13 68:22 72:22]
  wire [5:0] _T_8 = dataIndex - 6'h3; // @[intervox_transmitter.scala 81:50]
  wire [6:0] _GEN_18 = {{1'd0}, _T_8}; // @[intervox_transmitter.scala 81:37]
  wire [6:0] _T_10 = 7'h40 - _GEN_18; // @[intervox_transmitter.scala 81:37]
  wire [63:0] _T_11 = stereoData >> _T_10; // @[intervox_transmitter.scala 81:31]
  wire  _GEN_3 = ~_T_11[0] | hasNone; // @[intervox_transmitter.scala 81:69 83:25 43:32]
  wire  _GEN_4 = bitCntr_enc < 8'h37 ? _GEN_3 : hasNone; // @[intervox_transmitter.scala 43:32 79:37]
  wire [5:0] _T_18 = dataIndex - 6'h1b; // @[intervox_transmitter.scala 88:51]
  wire [6:0] _GEN_19 = {{1'd0}, _T_18}; // @[intervox_transmitter.scala 88:38]
  wire [6:0] _T_20 = 7'h40 - _GEN_19; // @[intervox_transmitter.scala 88:38]
  wire [63:0] _T_21 = stereoData >> _T_20; // @[intervox_transmitter.scala 88:31]
  wire  _GEN_5 = ~_T_21[0] | _GEN_4; // @[intervox_transmitter.scala 88:72 90:25]
  wire  _GEN_6 = bitCntr_enc >= 8'h37 & bitCntr_enc < 8'h67 ? _GEN_5 : _GEN_4; // @[intervox_transmitter.scala 86:64]
  wire [5:0] _T_28 = dataIndex - 6'h34; // @[intervox_transmitter.scala 98:42]
  wire [15:0] _T_29 = dspData >> _T_28; // @[intervox_transmitter.scala 98:30]
  wire  _GEN_7 = ~_T_29[0] | _GEN_6; // @[intervox_transmitter.scala 100:25 98:62]
  wire  _GEN_8 = bitCntr_enc >= 8'h67 & bitCntr_enc < 8'h7f ? _GEN_7 : _GEN_6; // @[intervox_transmitter.scala 94:65]
  wire [63:0] _GEN_20 = reset ? 64'h0 : 64'hfff; // @[intervox_transmitter.scala 41:{32,32} 49:13]
  assign io_DATA_OUT = outReg; // @[intervox_transmitter.scala 46:17]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 38:32]
      outReg <= 1'h0; // @[intervox_transmitter.scala 38:32]
    end else if (io_TICK) begin // @[intervox_transmitter.scala 54:28]
      if (bitCntr_enc > 8'h7) begin // @[intervox_transmitter.scala 76:36]
        if (!(hasNone)) begin // @[intervox_transmitter.scala 104:34]
          outReg <= ~outReg; // @[intervox_transmitter.scala 110:22]
        end
      end else if (bitCntr_enc < 8'h7) begin // @[intervox_transmitter.scala 63:35]
        outReg <= _GEN_1;
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 40:32]
      stereoData <= 64'h0; // @[intervox_transmitter.scala 40:32]
    end else begin
      stereoData <= io_AUDIOINPUT; // @[intervox_transmitter.scala 48:16]
    end
    dspData <= _GEN_20[15:0]; // @[intervox_transmitter.scala 41:{32,32} 49:13]
    if (reset) begin // @[intervox_transmitter.scala 42:32]
      bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 42:32]
    end else if (io_TICK) begin // @[intervox_transmitter.scala 54:28]
      if (bitCntr_enc == 8'h7f) begin // @[intervox_transmitter.scala 114:38]
        bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 115:25]
      end else begin
        bitCntr_enc <= _bitCntr_enc_T_1; // @[intervox_transmitter.scala 56:23]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 43:32]
      hasNone <= 1'h0; // @[intervox_transmitter.scala 43:32]
    end else if (io_TICK) begin // @[intervox_transmitter.scala 54:28]
      if (bitCntr_enc > 8'h7) begin // @[intervox_transmitter.scala 76:36]
        if (hasNone) begin // @[intervox_transmitter.scala 104:34]
          hasNone <= 1'h0; // @[intervox_transmitter.scala 106:23]
        end else begin
          hasNone <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 44:32]
      dataIndex <= 6'h0; // @[intervox_transmitter.scala 44:32]
    end else if (io_TICK) begin // @[intervox_transmitter.scala 54:28]
      if (_T_1 == 2'h0) begin // @[intervox_transmitter.scala 57:42]
        dataIndex <= _dataIndex_T_1; // @[intervox_transmitter.scala 59:23]
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
  outReg = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  stereoData = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  dspData = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  bitCntr_enc = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  hasNone = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  dataIndex = _RAND_5[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RWSmem(
  input         clock,
  input         io_write,
  input  [63:0] io_dataIn,
  output [63:0] io_dataOut
);
`ifdef RANDOMIZE_MEM_INIT
  reg [63:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] mem [0:0]; // @[intervox_transmitter.scala 19:24]
  wire  mem_rdwrPort_r_en; // @[intervox_transmitter.scala 19:24]
  wire  mem_rdwrPort_r_addr; // @[intervox_transmitter.scala 19:24]
  wire [63:0] mem_rdwrPort_r_data; // @[intervox_transmitter.scala 19:24]
  wire [63:0] mem_rdwrPort_w_data; // @[intervox_transmitter.scala 19:24]
  wire  mem_rdwrPort_w_addr; // @[intervox_transmitter.scala 19:24]
  wire  mem_rdwrPort_w_mask; // @[intervox_transmitter.scala 19:24]
  wire  mem_rdwrPort_w_en; // @[intervox_transmitter.scala 19:24]
  reg  mem_rdwrPort_r_en_pipe_0;
  reg  mem_rdwrPort_r_addr_pipe_0;
  assign mem_rdwrPort_r_en = mem_rdwrPort_r_en_pipe_0;
  assign mem_rdwrPort_r_addr = mem_rdwrPort_r_addr_pipe_0;
  assign mem_rdwrPort_r_data = mem[mem_rdwrPort_r_addr]; // @[intervox_transmitter.scala 19:24]
  assign mem_rdwrPort_w_data = io_dataIn;
  assign mem_rdwrPort_w_addr = 1'h0;
  assign mem_rdwrPort_w_mask = io_write;
  assign mem_rdwrPort_w_en = 1'h1 & io_write;
  assign io_dataOut = mem_rdwrPort_r_data; // @[intervox_transmitter.scala 25:21 26:34]
  always @(posedge clock) begin
    if (mem_rdwrPort_w_en & mem_rdwrPort_w_mask) begin
      mem[mem_rdwrPort_w_addr] <= mem_rdwrPort_w_data; // @[intervox_transmitter.scala 19:24]
    end
    mem_rdwrPort_r_en_pipe_0 <= 1'h1 & ~io_write;
    if (1'h1 & ~io_write) begin
      mem_rdwrPort_r_addr_pipe_0 <= 1'h0;
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {2{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    mem[initvar] = _RAND_0[63:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_rdwrPort_r_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_rdwrPort_r_addr_pipe_0 = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module interVox_Encoder(
  input   clock,
  input   reset,
  output  io_MCLK_O,
  input   io_BCLK_IN,
  input   io_LRCLK_IN,
  input   io_SDATA_IN,
  output  io_DATA_O,
  output  io_LRCLK_O,
  output  io_BCLK_O,
  output  io_SDATA_O,
  output  io_NXT_FRAME
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  bi_phase_enc_clock; // @[intervox_transmitter.scala 144:33]
  wire  bi_phase_enc_reset; // @[intervox_transmitter.scala 144:33]
  wire  bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 144:33]
  wire [63:0] bi_phase_enc_io_AUDIOINPUT; // @[intervox_transmitter.scala 144:33]
  wire  bi_phase_enc_io_TICK; // @[intervox_transmitter.scala 144:33]
  wire  BFR_clock; // @[intervox_transmitter.scala 148:33]
  wire  BFR_io_write; // @[intervox_transmitter.scala 148:33]
  wire [63:0] BFR_io_dataIn; // @[intervox_transmitter.scala 148:33]
  wire [63:0] BFR_io_dataOut; // @[intervox_transmitter.scala 148:33]
  wire  BFR1_clock; // @[intervox_transmitter.scala 149:33]
  wire  BFR1_io_write; // @[intervox_transmitter.scala 149:33]
  wire [63:0] BFR1_io_dataIn; // @[intervox_transmitter.scala 149:33]
  wire [63:0] BFR1_io_dataOut; // @[intervox_transmitter.scala 149:33]
  reg [1:0] current_state; // @[intervox_transmitter.scala 136:34]
  reg [7:0] BiPhase_CLK_CNTR; // @[intervox_transmitter.scala 138:34]
  reg [7:0] bitCntr; // @[intervox_transmitter.scala 146:34]
  wire [7:0] _BiPhase_CLK_CNTR_T_1 = BiPhase_CLK_CNTR + 8'h1; // @[intervox_transmitter.scala 197:44]
  wire [7:0] _GEN_0 = BiPhase_CLK_CNTR % 8'h2; // @[intervox_transmitter.scala 200:30]
  wire [1:0] _T_3 = _GEN_0[1:0]; // @[intervox_transmitter.scala 200:30]
  wire  _T_4 = _T_3 == 2'h0; // @[intervox_transmitter.scala 200:36]
  wire  _T_5 = BiPhase_CLK_CNTR == 8'h7; // @[intervox_transmitter.scala 204:29]
  wire [7:0] _GEN_1 = BiPhase_CLK_CNTR == 8'h7 ? 8'h0 : _BiPhase_CLK_CNTR_T_1; // @[intervox_transmitter.scala 197:24 204:{37,55}]
  wire  _T_8 = BiPhase_CLK_CNTR == 8'h3 | _T_5; // @[intervox_transmitter.scala 210:38]
  wire [7:0] _bitCntr_T_1 = bitCntr + 8'h1; // @[intervox_transmitter.scala 213:28]
  wire  _T_11 = ~io_SDATA_IN; // @[intervox_transmitter.scala 230:28]
  wire [7:0] _BFR_io_dataIn_T_1 = 8'h48 - bitCntr; // @[intervox_transmitter.scala 232:65]
  wire [255:0] _BFR_io_dataIn_T_2 = 256'h0 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 232:56]
  wire [255:0] _GEN_43 = {{192'd0}, BFR_io_dataOut}; // @[intervox_transmitter.scala 232:49]
  wire [255:0] _BFR_io_dataIn_T_4 = _GEN_43 + _BFR_io_dataIn_T_2; // @[intervox_transmitter.scala 232:49]
  wire [255:0] _GEN_4 = ~io_SDATA_IN ? _BFR_io_dataIn_T_4 : 256'h0; // @[intervox_transmitter.scala 230:36 232:31]
  wire [255:0] _BFR_io_dataIn_T_7 = 256'h1 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 236:56]
  wire [255:0] _BFR_io_dataIn_T_9 = _GEN_43 + _BFR_io_dataIn_T_7; // @[intervox_transmitter.scala 236:49]
  wire [255:0] _GEN_5 = io_SDATA_IN ? _BFR_io_dataIn_T_9 : _GEN_4; // @[intervox_transmitter.scala 235:36 236:31]
  wire [7:0] _BFR_io_dataIn_T_11 = 8'h40 - bitCntr; // @[intervox_transmitter.scala 246:65]
  wire [255:0] _BFR_io_dataIn_T_12 = 256'h0 << _BFR_io_dataIn_T_11; // @[intervox_transmitter.scala 246:56]
  wire [255:0] _BFR_io_dataIn_T_14 = _GEN_43 + _BFR_io_dataIn_T_12; // @[intervox_transmitter.scala 246:49]
  wire [255:0] _GEN_6 = _T_11 ? _BFR_io_dataIn_T_14 : 256'h0; // @[intervox_transmitter.scala 244:37 246:31]
  wire [255:0] _BFR_io_dataIn_T_17 = 256'h1 << _BFR_io_dataIn_T_11; // @[intervox_transmitter.scala 250:56]
  wire [255:0] _BFR_io_dataIn_T_19 = _GEN_43 + _BFR_io_dataIn_T_17; // @[intervox_transmitter.scala 250:49]
  wire [255:0] _GEN_7 = io_SDATA_IN ? _BFR_io_dataIn_T_19 : _GEN_6; // @[intervox_transmitter.scala 249:36 250:31]
  wire [255:0] _GEN_9 = bitCntr > 8'h1f ? _GEN_5 : _GEN_7; // @[intervox_transmitter.scala 223:29]
  wire  _T_15 = bitCntr == 8'h3f; // @[intervox_transmitter.scala 254:22]
  wire [63:0] _GEN_12 = BFR_io_dataOut; // @[intervox_transmitter.scala 166:25 254:31 259:29]
  wire [255:0] _GEN_13 = bitCntr == 8'h3f ? 256'h0 : _GEN_9; // @[intervox_transmitter.scala 254:31 263:26]
  wire [7:0] _GEN_14 = bitCntr == 8'h3f ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 213:17 254:31 265:19]
  wire [7:0] _GEN_15 = BiPhase_CLK_CNTR == 8'h3 | _T_5 ? _GEN_14 : bitCntr; // @[intervox_transmitter.scala 146:34 210:67]
  wire [255:0] _GEN_17 = BiPhase_CLK_CNTR == 8'h3 | _T_5 ? _GEN_13 : 256'h0; // @[intervox_transmitter.scala 162:25 210:67]
  wire  _GEN_18 = (BiPhase_CLK_CNTR == 8'h3 | _T_5) & _T_15; // @[intervox_transmitter.scala 165:25 210:67]
  wire [63:0] _GEN_19 = BiPhase_CLK_CNTR == 8'h3 | _T_5 ? _GEN_12 : BFR_io_dataOut; // @[intervox_transmitter.scala 166:25 210:67]
  wire [255:0] _GEN_24 = 2'h2 == current_state ? _GEN_17 : 256'h0; // @[intervox_transmitter.scala 187:24 162:25]
  wire [63:0] _GEN_26 = 2'h2 == current_state ? _GEN_19 : BFR_io_dataOut; // @[intervox_transmitter.scala 187:24 166:25]
  wire  _GEN_29 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _T_4; // @[intervox_transmitter.scala 187:24 172:31]
  wire  _GEN_31 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _T_8; // @[intervox_transmitter.scala 187:24 161:25]
  wire [255:0] _GEN_32 = 2'h1 == current_state ? 256'h0 : _GEN_24; // @[intervox_transmitter.scala 187:24 162:25]
  wire  _GEN_33 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _GEN_18; // @[intervox_transmitter.scala 187:24 165:25]
  wire [63:0] _GEN_34 = 2'h1 == current_state ? BFR_io_dataOut : _GEN_26; // @[intervox_transmitter.scala 187:24 166:25]
  wire [255:0] _GEN_40 = 2'h0 == current_state ? 256'h0 : _GEN_32; // @[intervox_transmitter.scala 187:24 162:25]
  bi_phase_encoder bi_phase_enc ( // @[intervox_transmitter.scala 144:33]
    .clock(bi_phase_enc_clock),
    .reset(bi_phase_enc_reset),
    .io_DATA_OUT(bi_phase_enc_io_DATA_OUT),
    .io_AUDIOINPUT(bi_phase_enc_io_AUDIOINPUT),
    .io_TICK(bi_phase_enc_io_TICK)
  );
  RWSmem BFR ( // @[intervox_transmitter.scala 148:33]
    .clock(BFR_clock),
    .io_write(BFR_io_write),
    .io_dataIn(BFR_io_dataIn),
    .io_dataOut(BFR_io_dataOut)
  );
  RWSmem BFR1 ( // @[intervox_transmitter.scala 149:33]
    .clock(BFR1_clock),
    .io_write(BFR1_io_write),
    .io_dataIn(BFR1_io_dataIn),
    .io_dataOut(BFR1_io_dataOut)
  );
  assign io_MCLK_O = clock; // @[intervox_transmitter.scala 153:25]
  assign io_DATA_O = bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 152:25]
  assign io_LRCLK_O = io_LRCLK_IN; // @[intervox_transmitter.scala 155:25]
  assign io_BCLK_O = io_BCLK_IN; // @[intervox_transmitter.scala 154:25]
  assign io_SDATA_O = io_SDATA_IN; // @[intervox_transmitter.scala 156:25]
  assign io_NXT_FRAME = bi_phase_enc_io_TICK; // @[intervox_transmitter.scala 169:25]
  assign bi_phase_enc_clock = clock;
  assign bi_phase_enc_reset = reset;
  assign bi_phase_enc_io_AUDIOINPUT = BFR1_io_dataOut; // @[intervox_transmitter.scala 175:31]
  assign bi_phase_enc_io_TICK = 2'h0 == current_state ? 1'h0 : _GEN_29; // @[intervox_transmitter.scala 187:24 172:31]
  assign BFR_clock = clock;
  assign BFR_io_write = 2'h0 == current_state ? 1'h0 : _GEN_31; // @[intervox_transmitter.scala 187:24 161:25]
  assign BFR_io_dataIn = _GEN_40[63:0];
  assign BFR1_clock = clock;
  assign BFR1_io_write = 2'h0 == current_state ? 1'h0 : _GEN_33; // @[intervox_transmitter.scala 187:24 165:25]
  assign BFR1_io_dataIn = 2'h0 == current_state ? BFR_io_dataOut : _GEN_34; // @[intervox_transmitter.scala 187:24 166:25]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 136:34]
      current_state <= 2'h0; // @[intervox_transmitter.scala 136:34]
    end else if (2'h0 == current_state) begin // @[intervox_transmitter.scala 187:24]
      current_state <= 2'h2; // @[intervox_transmitter.scala 190:21]
    end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 187:24]
      current_state <= 2'h2; // @[intervox_transmitter.scala 193:21]
    end
    if (reset) begin // @[intervox_transmitter.scala 138:34]
      BiPhase_CLK_CNTR <= 8'h0; // @[intervox_transmitter.scala 138:34]
    end else if (!(2'h0 == current_state)) begin // @[intervox_transmitter.scala 187:24]
      if (!(2'h1 == current_state)) begin // @[intervox_transmitter.scala 187:24]
        if (2'h2 == current_state) begin // @[intervox_transmitter.scala 187:24]
          BiPhase_CLK_CNTR <= _GEN_1;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 146:34]
      bitCntr <= 8'h0; // @[intervox_transmitter.scala 146:34]
    end else if (!(2'h0 == current_state)) begin // @[intervox_transmitter.scala 187:24]
      if (!(2'h1 == current_state)) begin // @[intervox_transmitter.scala 187:24]
        if (2'h2 == current_state) begin // @[intervox_transmitter.scala 187:24]
          bitCntr <= _GEN_15;
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
  current_state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  BiPhase_CLK_CNTR = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  bitCntr = _RAND_2[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
