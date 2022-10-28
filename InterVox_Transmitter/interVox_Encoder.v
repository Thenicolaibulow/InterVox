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
  reg [7:0] bitCntr_enc; // @[intervox_transmitter.scala 42:32]
  reg  hasNone; // @[intervox_transmitter.scala 43:32]
  reg [5:0] dataIndex; // @[intervox_transmitter.scala 44:32]
  reg  ndexR; // @[intervox_transmitter.scala 52:32]
  wire [7:0] _bitCntr_enc_T_1 = bitCntr_enc + 8'h1; // @[intervox_transmitter.scala 58:36]
  wire [5:0] _dataIndex_T_1 = dataIndex + 6'h1; // @[intervox_transmitter.scala 64:34]
  wire  _T_3 = bitCntr_enc < 8'h6; // @[intervox_transmitter.scala 71:28]
  wire  _GEN_1 = _T_3 ? 1'h0 : 1'h1; // @[intervox_transmitter.scala 72:11 73:20 77:20]
  wire [5:0] _T_7 = dataIndex - 6'h3; // @[intervox_transmitter.scala 86:48]
  wire [6:0] _GEN_19 = {{1'd0}, _T_7}; // @[intervox_transmitter.scala 86:35]
  wire [6:0] _T_9 = 7'h40 - _GEN_19; // @[intervox_transmitter.scala 86:35]
  wire [63:0] _T_10 = stereoData >> _T_9; // @[intervox_transmitter.scala 86:29]
  wire  _GEN_3 = ~_T_10[0] | hasNone; // @[intervox_transmitter.scala 86:67 88:23 43:32]
  wire  _GEN_4 = bitCntr_enc < 8'h37 ? _GEN_3 : hasNone; // @[intervox_transmitter.scala 43:32 84:35]
  wire [5:0] _T_17 = dataIndex - 6'h1b; // @[intervox_transmitter.scala 93:49]
  wire [6:0] _GEN_20 = {{1'd0}, _T_17}; // @[intervox_transmitter.scala 93:36]
  wire [6:0] _T_19 = 7'h40 - _GEN_20; // @[intervox_transmitter.scala 93:36]
  wire [63:0] _T_20 = stereoData >> _T_19; // @[intervox_transmitter.scala 93:29]
  wire  _GEN_5 = ~_T_20[0] | _GEN_4; // @[intervox_transmitter.scala 93:70 95:23]
  wire  _GEN_6 = bitCntr_enc >= 8'h37 & bitCntr_enc < 8'h67 ? _GEN_5 : _GEN_4; // @[intervox_transmitter.scala 91:62]
  wire [5:0] _T_27 = dataIndex - 6'h34; // @[intervox_transmitter.scala 103:40]
  wire [15:0] _T_28 = 16'h0 >> _T_27; // @[intervox_transmitter.scala 103:28]
  wire  _GEN_7 = ~_T_28[0] | _GEN_6; // @[intervox_transmitter.scala 103:60 105:23]
  wire  _GEN_8 = bitCntr_enc >= 8'h67 & bitCntr_enc < 8'h7f ? _GEN_7 : _GEN_6; // @[intervox_transmitter.scala 99:63]
  assign io_DATA_OUT = outReg; // @[intervox_transmitter.scala 46:17]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 38:32]
      outReg <= 1'h0; // @[intervox_transmitter.scala 38:32]
    end else if (~io_TICK) begin // @[intervox_transmitter.scala 56:26]
      if (bitCntr_enc > 8'h7) begin // @[intervox_transmitter.scala 81:34]
        if (!(hasNone)) begin // @[intervox_transmitter.scala 109:32]
          outReg <= ~outReg; // @[intervox_transmitter.scala 115:20]
        end
      end else if (bitCntr_enc < 8'h7) begin // @[intervox_transmitter.scala 68:33]
        outReg <= _GEN_1;
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 40:32]
      stereoData <= 64'h0; // @[intervox_transmitter.scala 40:32]
    end else begin
      stereoData <= io_AUDIOINPUT; // @[intervox_transmitter.scala 48:16]
    end
    if (reset) begin // @[intervox_transmitter.scala 42:32]
      bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 42:32]
    end else if (~io_TICK) begin // @[intervox_transmitter.scala 56:26]
      if (bitCntr_enc == 8'h7f) begin // @[intervox_transmitter.scala 119:36]
        bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 120:23]
      end else begin
        bitCntr_enc <= _bitCntr_enc_T_1; // @[intervox_transmitter.scala 58:21]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 43:32]
      hasNone <= 1'h0; // @[intervox_transmitter.scala 43:32]
    end else if (~io_TICK) begin // @[intervox_transmitter.scala 56:26]
      if (bitCntr_enc > 8'h7) begin // @[intervox_transmitter.scala 81:34]
        if (hasNone) begin // @[intervox_transmitter.scala 109:32]
          hasNone <= 1'h0; // @[intervox_transmitter.scala 111:21]
        end else begin
          hasNone <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 44:32]
      dataIndex <= 6'h0; // @[intervox_transmitter.scala 44:32]
    end else if (~io_TICK) begin // @[intervox_transmitter.scala 56:26]
      if (ndexR) begin // @[intervox_transmitter.scala 62:28]
        dataIndex <= _dataIndex_T_1; // @[intervox_transmitter.scala 64:21]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 52:32]
      ndexR <= 1'h0; // @[intervox_transmitter.scala 52:32]
    end else if (~io_TICK) begin // @[intervox_transmitter.scala 56:26]
      ndexR <= ~ndexR; // @[intervox_transmitter.scala 61:15]
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
  bitCntr_enc = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  hasNone = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  dataIndex = _RAND_4[5:0];
  _RAND_5 = {1{`RANDOM}};
  ndexR = _RAND_5[0:0];
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
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  wire  bi_phase_enc_clock; // @[intervox_transmitter.scala 153:33]
  wire  bi_phase_enc_reset; // @[intervox_transmitter.scala 153:33]
  wire  bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 153:33]
  wire [63:0] bi_phase_enc_io_AUDIOINPUT; // @[intervox_transmitter.scala 153:33]
  wire  bi_phase_enc_io_TICK; // @[intervox_transmitter.scala 153:33]
  wire  BFR_clock; // @[intervox_transmitter.scala 157:33]
  wire  BFR_io_write; // @[intervox_transmitter.scala 157:33]
  wire [63:0] BFR_io_dataIn; // @[intervox_transmitter.scala 157:33]
  wire [63:0] BFR_io_dataOut; // @[intervox_transmitter.scala 157:33]
  wire  BFR1_clock; // @[intervox_transmitter.scala 158:33]
  wire  BFR1_io_write; // @[intervox_transmitter.scala 158:33]
  wire [63:0] BFR1_io_dataIn; // @[intervox_transmitter.scala 158:33]
  wire [63:0] BFR1_io_dataOut; // @[intervox_transmitter.scala 158:33]
  reg [1:0] current_state; // @[intervox_transmitter.scala 141:34]
  reg [7:0] BiPhase_CLK_CNTR; // @[intervox_transmitter.scala 143:34]
  reg  synced; // @[intervox_transmitter.scala 149:34]
  reg  bclkR; // @[intervox_transmitter.scala 151:34]
  reg [7:0] bitCntr; // @[intervox_transmitter.scala 155:34]
  wire [7:0] _BiPhase_CLK_CNTR_T_1 = BiPhase_CLK_CNTR + 8'h1; // @[intervox_transmitter.scala 207:42]
  wire  _T_1 = BiPhase_CLK_CNTR == 8'h3; // @[intervox_transmitter.scala 209:27]
  wire [7:0] _GEN_0 = io_LRCLK_IN ? 8'h0 : bitCntr; // @[intervox_transmitter.scala 212:32 213:17 155:34]
  wire [7:0] _bitCntr_T_1 = bitCntr + 8'h1; // @[intervox_transmitter.scala 217:28]
  wire [7:0] _GEN_1 = bitCntr == 8'h1f ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 217:17 219:31 220:19]
  wire  _GEN_2 = bitCntr == 8'h1f | synced; // @[intervox_transmitter.scala 219:31 221:18 149:34]
  wire [7:0] _GEN_3 = ~io_LRCLK_IN ? _GEN_1 : _GEN_0; // @[intervox_transmitter.scala 216:32]
  wire [7:0] _GEN_5 = BiPhase_CLK_CNTR == 8'h3 ? 8'h0 : _BiPhase_CLK_CNTR_T_1; // @[intervox_transmitter.scala 207:22 209:35 210:24]
  wire [7:0] _GEN_6 = BiPhase_CLK_CNTR == 8'h3 ? _GEN_3 : bitCntr; // @[intervox_transmitter.scala 155:34 209:35]
  wire [7:0] _GEN_8 = ~synced ? _GEN_5 : BiPhase_CLK_CNTR; // @[intervox_transmitter.scala 206:23 143:34]
  wire [7:0] _GEN_9 = ~synced ? _GEN_6 : bitCntr; // @[intervox_transmitter.scala 206:23 155:34]
  wire  _bclkR_T = ~bclkR; // @[intervox_transmitter.scala 247:19]
  wire  _GEN_11 = _bclkR_T ? 1'h0 : 1'h1; // @[intervox_transmitter.scala 249:28 180:31 250:32]
  wire  _T_13 = ~io_SDATA_IN; // @[intervox_transmitter.scala 280:30]
  wire [7:0] _BFR_io_dataIn_T_1 = 8'h48 - bitCntr; // @[intervox_transmitter.scala 282:67]
  wire [255:0] _BFR_io_dataIn_T_2 = 256'h0 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 282:58]
  wire [255:0] _GEN_66 = {{192'd0}, BFR_io_dataOut}; // @[intervox_transmitter.scala 282:51]
  wire [255:0] _BFR_io_dataIn_T_4 = _GEN_66 + _BFR_io_dataIn_T_2; // @[intervox_transmitter.scala 282:51]
  wire [255:0] _GEN_14 = ~io_SDATA_IN ? _BFR_io_dataIn_T_4 : 256'h0; // @[intervox_transmitter.scala 280:38 282:33]
  wire [255:0] _BFR_io_dataIn_T_7 = 256'h1 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 286:58]
  wire [255:0] _BFR_io_dataIn_T_9 = _GEN_66 + _BFR_io_dataIn_T_7; // @[intervox_transmitter.scala 286:51]
  wire [255:0] _GEN_15 = io_SDATA_IN ? _BFR_io_dataIn_T_9 : _GEN_14; // @[intervox_transmitter.scala 285:38 286:33]
  wire [7:0] _BFR_io_dataIn_T_11 = 8'h40 - bitCntr; // @[intervox_transmitter.scala 296:67]
  wire [255:0] _BFR_io_dataIn_T_12 = 256'h0 << _BFR_io_dataIn_T_11; // @[intervox_transmitter.scala 296:58]
  wire [255:0] _BFR_io_dataIn_T_14 = _GEN_66 + _BFR_io_dataIn_T_12; // @[intervox_transmitter.scala 296:51]
  wire [255:0] _GEN_16 = _T_13 ? _BFR_io_dataIn_T_14 : 256'h0; // @[intervox_transmitter.scala 294:39 296:33]
  wire [255:0] _BFR_io_dataIn_T_17 = 256'h1 << _BFR_io_dataIn_T_11; // @[intervox_transmitter.scala 300:58]
  wire [255:0] _BFR_io_dataIn_T_19 = _GEN_66 + _BFR_io_dataIn_T_17; // @[intervox_transmitter.scala 300:51]
  wire [255:0] _GEN_17 = io_SDATA_IN ? _BFR_io_dataIn_T_19 : _GEN_16; // @[intervox_transmitter.scala 299:38 300:33]
  wire [255:0] _GEN_19 = bitCntr > 8'h1f ? _GEN_15 : _GEN_17; // @[intervox_transmitter.scala 273:31]
  wire  _T_17 = bitCntr == 8'h3f; // @[intervox_transmitter.scala 304:24]
  wire [63:0] _GEN_22 = BFR_io_dataOut; // @[intervox_transmitter.scala 175:25 304:33 309:31]
  wire [255:0] _GEN_23 = bitCntr == 8'h3f ? 256'h0 : _GEN_19; // @[intervox_transmitter.scala 304:33 313:28]
  wire [7:0] _GEN_24 = bitCntr == 8'h3f ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 263:19 304:33 315:21]
  wire [7:0] _GEN_26 = _T_1 ? _GEN_24 : _GEN_9; // @[intervox_transmitter.scala 259:39]
  wire [255:0] _GEN_28 = _T_1 ? _GEN_23 : 256'h0; // @[intervox_transmitter.scala 171:25 259:39]
  wire  _GEN_29 = _T_1 & _T_17; // @[intervox_transmitter.scala 174:25 259:39]
  wire [63:0] _GEN_30 = _T_1 ? _GEN_22 : BFR_io_dataOut; // @[intervox_transmitter.scala 175:25 259:39]
  wire  _GEN_31 = 2'h2 == current_state ? ~bclkR : bclkR; // @[intervox_transmitter.scala 235:26 247:16 151:34]
  wire  _GEN_32 = 2'h2 == current_state ? _GEN_11 : 1'h1; // @[intervox_transmitter.scala 235:26 180:31]
  wire [7:0] _GEN_33 = 2'h2 == current_state ? _GEN_5 : _GEN_8; // @[intervox_transmitter.scala 235:26]
  wire [7:0] _GEN_34 = 2'h2 == current_state ? _GEN_26 : _GEN_9; // @[intervox_transmitter.scala 235:26]
  wire [255:0] _GEN_36 = 2'h2 == current_state ? _GEN_28 : 256'h0; // @[intervox_transmitter.scala 171:25 235:26]
  wire [63:0] _GEN_38 = 2'h2 == current_state ? _GEN_30 : BFR_io_dataOut; // @[intervox_transmitter.scala 175:25 235:26]
  wire  _GEN_40 = 2'h1 == current_state ? bclkR : _GEN_31; // @[intervox_transmitter.scala 235:26 151:34]
  wire  _GEN_44 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _T_1; // @[intervox_transmitter.scala 170:25 235:26]
  wire [255:0] _GEN_45 = 2'h1 == current_state ? 256'h0 : _GEN_36; // @[intervox_transmitter.scala 171:25 235:26]
  wire  _GEN_46 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _GEN_29; // @[intervox_transmitter.scala 174:25 235:26]
  wire [63:0] _GEN_47 = 2'h1 == current_state ? BFR_io_dataOut : _GEN_38; // @[intervox_transmitter.scala 175:25 235:26]
  wire  _GEN_49 = 2'h0 == current_state ? bclkR : _GEN_40; // @[intervox_transmitter.scala 235:26 151:34]
  wire  _GEN_50 = 2'h0 == current_state | (2'h1 == current_state | _GEN_32); // @[intervox_transmitter.scala 235:26 180:31]
  wire  _GEN_53 = 2'h0 == current_state ? 1'h0 : _GEN_44; // @[intervox_transmitter.scala 170:25 235:26]
  wire [255:0] _GEN_54 = 2'h0 == current_state ? 256'h0 : _GEN_45; // @[intervox_transmitter.scala 171:25 235:26]
  wire  _GEN_55 = 2'h0 == current_state ? 1'h0 : _GEN_46; // @[intervox_transmitter.scala 174:25 235:26]
  wire [63:0] _GEN_56 = 2'h0 == current_state ? BFR_io_dataOut : _GEN_47; // @[intervox_transmitter.scala 175:25 235:26]
  wire  _GEN_58 = synced ? _GEN_49 : bclkR; // @[intervox_transmitter.scala 233:23 151:34]
  wire [255:0] _GEN_63 = synced ? _GEN_54 : 256'h0; // @[intervox_transmitter.scala 233:23 171:25]
  bi_phase_encoder bi_phase_enc ( // @[intervox_transmitter.scala 153:33]
    .clock(bi_phase_enc_clock),
    .reset(bi_phase_enc_reset),
    .io_DATA_OUT(bi_phase_enc_io_DATA_OUT),
    .io_AUDIOINPUT(bi_phase_enc_io_AUDIOINPUT),
    .io_TICK(bi_phase_enc_io_TICK)
  );
  RWSmem BFR ( // @[intervox_transmitter.scala 157:33]
    .clock(BFR_clock),
    .io_write(BFR_io_write),
    .io_dataIn(BFR_io_dataIn),
    .io_dataOut(BFR_io_dataOut)
  );
  RWSmem BFR1 ( // @[intervox_transmitter.scala 158:33]
    .clock(BFR1_clock),
    .io_write(BFR1_io_write),
    .io_dataIn(BFR1_io_dataIn),
    .io_dataOut(BFR1_io_dataOut)
  );
  assign io_MCLK_O = clock; // @[intervox_transmitter.scala 162:25]
  assign io_DATA_O = bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 161:25]
  assign io_LRCLK_O = io_LRCLK_IN; // @[intervox_transmitter.scala 164:25]
  assign io_BCLK_O = io_BCLK_IN; // @[intervox_transmitter.scala 163:25]
  assign io_SDATA_O = io_SDATA_IN; // @[intervox_transmitter.scala 165:25]
  assign io_NXT_FRAME = bi_phase_enc_io_TICK; // @[intervox_transmitter.scala 178:25]
  assign bi_phase_enc_clock = clock;
  assign bi_phase_enc_reset = reset;
  assign bi_phase_enc_io_AUDIOINPUT = BFR1_io_dataOut; // @[intervox_transmitter.scala 182:31]
  assign bi_phase_enc_io_TICK = synced ? _GEN_50 : 1'h1; // @[intervox_transmitter.scala 233:23 180:31]
  assign BFR_clock = clock;
  assign BFR_io_write = synced & _GEN_53; // @[intervox_transmitter.scala 233:23 170:25]
  assign BFR_io_dataIn = _GEN_63[63:0];
  assign BFR1_clock = clock;
  assign BFR1_io_write = synced & _GEN_55; // @[intervox_transmitter.scala 233:23 174:25]
  assign BFR1_io_dataIn = synced ? _GEN_56 : BFR_io_dataOut; // @[intervox_transmitter.scala 233:23 175:25]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 141:34]
      current_state <= 2'h0; // @[intervox_transmitter.scala 141:34]
    end else if (synced) begin // @[intervox_transmitter.scala 233:23]
      if (2'h0 == current_state) begin // @[intervox_transmitter.scala 235:26]
        current_state <= 2'h2; // @[intervox_transmitter.scala 239:23]
      end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 235:26]
        current_state <= 2'h2; // @[intervox_transmitter.scala 243:23]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 143:34]
      BiPhase_CLK_CNTR <= 8'h0; // @[intervox_transmitter.scala 143:34]
    end else if (synced) begin // @[intervox_transmitter.scala 233:23]
      if (2'h0 == current_state) begin // @[intervox_transmitter.scala 235:26]
        BiPhase_CLK_CNTR <= _GEN_8;
      end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 235:26]
        BiPhase_CLK_CNTR <= _GEN_8;
      end else begin
        BiPhase_CLK_CNTR <= _GEN_33;
      end
    end else begin
      BiPhase_CLK_CNTR <= _GEN_8;
    end
    if (reset) begin // @[intervox_transmitter.scala 149:34]
      synced <= 1'h0; // @[intervox_transmitter.scala 149:34]
    end else if (~synced) begin // @[intervox_transmitter.scala 206:23]
      if (BiPhase_CLK_CNTR == 8'h3) begin // @[intervox_transmitter.scala 209:35]
        if (~io_LRCLK_IN) begin // @[intervox_transmitter.scala 216:32]
          synced <= _GEN_2;
        end
      end
    end
    bclkR <= reset | _GEN_58; // @[intervox_transmitter.scala 151:{34,34}]
    if (reset) begin // @[intervox_transmitter.scala 155:34]
      bitCntr <= 8'h0; // @[intervox_transmitter.scala 155:34]
    end else if (synced) begin // @[intervox_transmitter.scala 233:23]
      if (2'h0 == current_state) begin // @[intervox_transmitter.scala 235:26]
        bitCntr <= _GEN_9;
      end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 235:26]
        bitCntr <= _GEN_9;
      end else begin
        bitCntr <= _GEN_34;
      end
    end else begin
      bitCntr <= _GEN_9;
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
  synced = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  bclkR = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  bitCntr = _RAND_4[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
