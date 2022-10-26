module bi_phase_encoder(
  input         clock,
  input         reset,
  output        io_DATA_OUT,
  input  [63:0] io_AUDIOINPUT,
  input         io_TICK,
  output        io_NEXT
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  outReg; // @[intervox_transmitter.scala 38:32]
  reg  next; // @[intervox_transmitter.scala 39:32]
  reg [63:0] stereoData; // @[intervox_transmitter.scala 40:32]
  reg [7:0] bitCntr; // @[intervox_transmitter.scala 42:32]
  reg  hasNone; // @[intervox_transmitter.scala 43:32]
  reg [5:0] dataIndex; // @[intervox_transmitter.scala 44:32]
  wire [7:0] _bitCntr_T_1 = bitCntr + 8'h1; // @[intervox_transmitter.scala 54:30]
  wire [7:0] _GEN_0 = bitCntr % 8'h2; // @[intervox_transmitter.scala 55:24]
  wire [1:0] _T_1 = _GEN_0[1:0]; // @[intervox_transmitter.scala 55:24]
  wire [5:0] _dataIndex_T_1 = dataIndex + 6'h1; // @[intervox_transmitter.scala 56:36]
  wire  _T_4 = bitCntr < 8'h6; // @[intervox_transmitter.scala 63:26]
  wire  _GEN_1 = _T_4 ? 1'h0 : 1'h1; // @[intervox_transmitter.scala 64:13 65:22 69:22]
  wire  _GEN_2 = bitCntr < 8'h7 ? 1'h0 : next; // @[intervox_transmitter.scala 60:31 61:18 39:32]
  wire [5:0] _T_8 = dataIndex - 6'h4; // @[intervox_transmitter.scala 78:43]
  wire [63:0] _T_9 = stereoData >> _T_8; // @[intervox_transmitter.scala 78:31]
  wire  _GEN_4 = ~_T_9[0] | hasNone; // @[intervox_transmitter.scala 78:62 80:25 43:32]
  wire  _GEN_5 = bitCntr < 8'h30 ? _GEN_4 : hasNone; // @[intervox_transmitter.scala 43:32 76:33]
  wire [5:0] _T_18 = _T_8 - 6'h8; // @[intervox_transmitter.scala 85:49]
  wire [63:0] _T_19 = stereoData >> _T_18; // @[intervox_transmitter.scala 85:31]
  wire  _GEN_6 = ~_T_19[0] | _GEN_5; // @[intervox_transmitter.scala 85:68 87:25]
  wire  _GEN_7 = bitCntr >= 8'h30 & bitCntr < 8'h60 ? _GEN_6 : _GEN_5; // @[intervox_transmitter.scala 83:55]
  wire [15:0] _T_27 = 16'h0 >> _T_8; // @[intervox_transmitter.scala 93:30]
  wire  _GEN_8 = ~_T_27[0] | _GEN_7; // @[intervox_transmitter.scala 93:61 95:25]
  wire  _GEN_9 = bitCntr >= 8'h60 & bitCntr < 8'h7f ? _GEN_8 : _GEN_7; // @[intervox_transmitter.scala 91:56]
  wire  _GEN_16 = bitCntr == 8'h7f | _GEN_2; // @[intervox_transmitter.scala 109:34 112:18]
  assign io_DATA_OUT = outReg; // @[intervox_transmitter.scala 46:17]
  assign io_NEXT = next; // @[intervox_transmitter.scala 50:13]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 38:32]
      outReg <= 1'h0; // @[intervox_transmitter.scala 38:32]
    end else if (io_TICK) begin // @[intervox_transmitter.scala 52:28]
      if (bitCntr > 8'h7) begin // @[intervox_transmitter.scala 73:32]
        if (!(hasNone)) begin // @[intervox_transmitter.scala 99:34]
          outReg <= ~outReg; // @[intervox_transmitter.scala 105:22]
        end
      end else if (bitCntr < 8'h7) begin // @[intervox_transmitter.scala 60:31]
        outReg <= _GEN_1;
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 39:32]
      next <= 1'h0; // @[intervox_transmitter.scala 39:32]
    end else if (io_TICK) begin // @[intervox_transmitter.scala 52:28]
      next <= _GEN_16;
    end
    if (reset) begin // @[intervox_transmitter.scala 40:32]
      stereoData <= 64'h0; // @[intervox_transmitter.scala 40:32]
    end else if (io_TICK) begin // @[intervox_transmitter.scala 52:28]
      if (bitCntr == 8'h7f) begin // @[intervox_transmitter.scala 109:34]
        stereoData <= 64'h0; // @[intervox_transmitter.scala 111:24]
      end else begin
        stereoData <= io_AUDIOINPUT; // @[intervox_transmitter.scala 48:16]
      end
    end else begin
      stereoData <= io_AUDIOINPUT; // @[intervox_transmitter.scala 48:16]
    end
    if (reset) begin // @[intervox_transmitter.scala 42:32]
      bitCntr <= 8'h0; // @[intervox_transmitter.scala 42:32]
    end else if (io_TICK) begin // @[intervox_transmitter.scala 52:28]
      if (bitCntr == 8'h7f) begin // @[intervox_transmitter.scala 109:34]
        bitCntr <= 8'h0; // @[intervox_transmitter.scala 110:21]
      end else begin
        bitCntr <= _bitCntr_T_1; // @[intervox_transmitter.scala 54:19]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 43:32]
      hasNone <= 1'h0; // @[intervox_transmitter.scala 43:32]
    end else if (io_TICK) begin // @[intervox_transmitter.scala 52:28]
      if (bitCntr > 8'h7) begin // @[intervox_transmitter.scala 73:32]
        if (hasNone) begin // @[intervox_transmitter.scala 99:34]
          hasNone <= 1'h0; // @[intervox_transmitter.scala 101:23]
        end else begin
          hasNone <= _GEN_9;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 44:32]
      dataIndex <= 6'h0; // @[intervox_transmitter.scala 44:32]
    end else if (io_TICK) begin // @[intervox_transmitter.scala 52:28]
      if (_T_1 == 2'h1) begin // @[intervox_transmitter.scala 55:38]
        dataIndex <= _dataIndex_T_1; // @[intervox_transmitter.scala 56:23]
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
  _RAND_1 = {1{`RANDOM}};
  next = _RAND_1[0:0];
  _RAND_2 = {2{`RANDOM}};
  stereoData = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  bitCntr = _RAND_3[7:0];
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
  input   io_MCLK_IN,
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
  wire  bi_phase_enc_clock; // @[intervox_transmitter.scala 141:33]
  wire  bi_phase_enc_reset; // @[intervox_transmitter.scala 141:33]
  wire  bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 141:33]
  wire [63:0] bi_phase_enc_io_AUDIOINPUT; // @[intervox_transmitter.scala 141:33]
  wire  bi_phase_enc_io_TICK; // @[intervox_transmitter.scala 141:33]
  wire  bi_phase_enc_io_NEXT; // @[intervox_transmitter.scala 141:33]
  wire  BFR_clock; // @[intervox_transmitter.scala 149:33]
  wire  BFR_io_write; // @[intervox_transmitter.scala 149:33]
  wire [63:0] BFR_io_dataIn; // @[intervox_transmitter.scala 149:33]
  wire [63:0] BFR_io_dataOut; // @[intervox_transmitter.scala 149:33]
  wire  BFR1_clock; // @[intervox_transmitter.scala 150:34]
  wire  BFR1_io_write; // @[intervox_transmitter.scala 150:34]
  wire [63:0] BFR1_io_dataIn; // @[intervox_transmitter.scala 150:34]
  wire [63:0] BFR1_io_dataOut; // @[intervox_transmitter.scala 150:34]
  reg [1:0] current_state; // @[intervox_transmitter.scala 133:34]
  reg [7:0] BiPhase_CLK_CNTR; // @[intervox_transmitter.scala 135:34]
  reg  DATA_OUT_REG_1B; // @[intervox_transmitter.scala 137:34]
  reg [7:0] bitCntr; // @[intervox_transmitter.scala 143:34]
  reg [31:0] tmpAudio; // @[intervox_transmitter.scala 147:34]
  wire [7:0] _BiPhase_CLK_CNTR_T_1 = BiPhase_CLK_CNTR + 8'h1; // @[intervox_transmitter.scala 198:46]
  wire [7:0] _GEN_0 = BiPhase_CLK_CNTR % 8'h2; // @[intervox_transmitter.scala 201:31]
  wire [1:0] _T_4 = _GEN_0[1:0]; // @[intervox_transmitter.scala 201:31]
  wire  _T_5 = _T_4 == 2'h1; // @[intervox_transmitter.scala 201:37]
  wire [7:0] _GEN_1 = BiPhase_CLK_CNTR == 8'hf ? 8'h0 : _BiPhase_CLK_CNTR_T_1; // @[intervox_transmitter.scala 198:26 205:{40,58}]
  wire [7:0] _bitCntr_T_1 = bitCntr + 8'h1; // @[intervox_transmitter.scala 210:30]
  wire  _T_9 = ~io_SDATA_IN; // @[intervox_transmitter.scala 222:30]
  wire [7:0] _BFR_io_dataIn_T_1 = bitCntr - 8'h10; // @[intervox_transmitter.scala 223:64]
  wire [255:0] _BFR_io_dataIn_T_2 = 256'h0 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 223:52]
  wire [255:0] _GEN_57 = {{224'd0}, tmpAudio}; // @[intervox_transmitter.scala 223:45]
  wire [255:0] _BFR_io_dataIn_T_4 = _GEN_57 + _BFR_io_dataIn_T_2; // @[intervox_transmitter.scala 223:45]
  wire [255:0] _GEN_2 = ~io_SDATA_IN ? _BFR_io_dataIn_T_4 : 256'h0; // @[intervox_transmitter.scala 162:25 222:38 223:33]
  wire [255:0] _BFR_io_dataIn_T_7 = 256'h1 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 227:52]
  wire [255:0] _BFR_io_dataIn_T_9 = _GEN_57 + _BFR_io_dataIn_T_7; // @[intervox_transmitter.scala 227:45]
  wire [255:0] _GEN_3 = io_SDATA_IN ? _BFR_io_dataIn_T_9 : _GEN_2; // @[intervox_transmitter.scala 226:38 227:33]
  wire [255:0] _BFR_io_dataIn_T_10 = 256'h0 << bitCntr; // @[intervox_transmitter.scala 235:52]
  wire [255:0] _BFR_io_dataIn_T_12 = _GEN_57 + _BFR_io_dataIn_T_10; // @[intervox_transmitter.scala 235:45]
  wire [255:0] _GEN_4 = _T_9 ? _BFR_io_dataIn_T_12 : 256'h0; // @[intervox_transmitter.scala 162:25 234:39 235:33]
  wire [255:0] _BFR_io_dataIn_T_13 = 256'h1 << bitCntr; // @[intervox_transmitter.scala 239:52]
  wire [255:0] _BFR_io_dataIn_T_15 = _GEN_57 + _BFR_io_dataIn_T_13; // @[intervox_transmitter.scala 239:45]
  wire [255:0] _GEN_5 = io_SDATA_IN ? _BFR_io_dataIn_T_15 : _GEN_4; // @[intervox_transmitter.scala 238:38 239:33]
  wire [63:0] _GEN_6 = BFR_io_dataOut; // @[intervox_transmitter.scala 215:31 219:31 231:31]
  wire [255:0] _GEN_8 = bitCntr > 8'h28 ? _GEN_3 : _GEN_5; // @[intervox_transmitter.scala 215:31]
  wire  _T_13 = bi_phase_enc_io_NEXT; // @[intervox_transmitter.scala 243:37]
  wire  _T_14 = bitCntr == 8'h3f; // @[intervox_transmitter.scala 248:24]
  wire [7:0] _GEN_11 = bitCntr == 8'h3f ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 210:19 248:33 249:30]
  wire  _GEN_13 = _T_14 | _T_13; // @[intervox_transmitter.scala 252:33 256:31]
  wire [63:0] _GEN_14 = _T_14 ? BFR_io_dataOut : 64'h0; // @[intervox_transmitter.scala 252:33 257:31]
  wire [255:0] _GEN_15 = _T_14 ? 256'h0 : _GEN_8; // @[intervox_transmitter.scala 252:33 261:31]
  wire [7:0] _GEN_16 = io_BCLK_IN ? _GEN_11 : bitCntr; // @[intervox_transmitter.scala 207:33 143:34]
  wire [63:0] _GEN_17 = io_BCLK_IN ? _GEN_6 : {{32'd0}, tmpAudio}; // @[intervox_transmitter.scala 207:33 147:34]
  wire [255:0] _GEN_19 = io_BCLK_IN ? _GEN_15 : 256'h0; // @[intervox_transmitter.scala 162:25 207:33]
  wire  _GEN_20 = io_BCLK_IN & _GEN_13; // @[intervox_transmitter.scala 165:25 207:33]
  wire [63:0] _GEN_21 = io_BCLK_IN ? _GEN_14 : 64'h0; // @[intervox_transmitter.scala 166:25 207:33]
  wire [7:0] _GEN_22 = 2'h2 == current_state ? _GEN_1 : BiPhase_CLK_CNTR; // @[intervox_transmitter.scala 188:26 135:34]
  wire [7:0] _GEN_24 = 2'h2 == current_state ? _GEN_16 : bitCntr; // @[intervox_transmitter.scala 188:26 143:34]
  wire [63:0] _GEN_25 = 2'h2 == current_state ? _GEN_17 : {{32'd0}, tmpAudio}; // @[intervox_transmitter.scala 188:26 147:34]
  wire [255:0] _GEN_27 = 2'h2 == current_state ? _GEN_19 : 256'h0; // @[intervox_transmitter.scala 162:25 188:26]
  wire [63:0] _GEN_29 = 2'h2 == current_state ? _GEN_21 : 64'h0; // @[intervox_transmitter.scala 166:25 188:26]
  wire  _GEN_32 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _T_5; // @[intervox_transmitter.scala 188:26 170:31]
  wire [63:0] _GEN_34 = 2'h1 == current_state ? {{32'd0}, tmpAudio} : _GEN_25; // @[intervox_transmitter.scala 188:26 147:34]
  wire  _GEN_35 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & io_BCLK_IN; // @[intervox_transmitter.scala 161:25 188:26]
  wire [255:0] _GEN_36 = 2'h1 == current_state ? 256'h0 : _GEN_27; // @[intervox_transmitter.scala 162:25 188:26]
  wire  _GEN_37 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _GEN_20; // @[intervox_transmitter.scala 165:25 188:26]
  wire [63:0] _GEN_38 = 2'h1 == current_state ? 64'h0 : _GEN_29; // @[intervox_transmitter.scala 166:25 188:26]
  wire  _GEN_41 = 2'h0 == current_state ? 1'h0 : _GEN_32; // @[intervox_transmitter.scala 188:26 170:31]
  wire [63:0] _GEN_43 = 2'h0 == current_state ? {{32'd0}, tmpAudio} : _GEN_34; // @[intervox_transmitter.scala 188:26 147:34]
  wire  _GEN_44 = 2'h0 == current_state ? 1'h0 : _GEN_35; // @[intervox_transmitter.scala 161:25 188:26]
  wire [255:0] _GEN_45 = 2'h0 == current_state ? 256'h0 : _GEN_36; // @[intervox_transmitter.scala 162:25 188:26]
  wire  _GEN_46 = 2'h0 == current_state ? 1'h0 : _GEN_37; // @[intervox_transmitter.scala 165:25 188:26]
  wire [63:0] _GEN_47 = 2'h0 == current_state ? 64'h0 : _GEN_38; // @[intervox_transmitter.scala 166:25 188:26]
  wire [63:0] _GEN_52 = io_MCLK_IN ? _GEN_43 : {{32'd0}, tmpAudio}; // @[intervox_transmitter.scala 178:27 147:34]
  wire [255:0] _GEN_54 = io_MCLK_IN ? _GEN_45 : 256'h0; // @[intervox_transmitter.scala 162:25 178:27]
  wire [63:0] _GEN_61 = reset ? 64'h0 : _GEN_52; // @[intervox_transmitter.scala 147:{34,34}]
  bi_phase_encoder bi_phase_enc ( // @[intervox_transmitter.scala 141:33]
    .clock(bi_phase_enc_clock),
    .reset(bi_phase_enc_reset),
    .io_DATA_OUT(bi_phase_enc_io_DATA_OUT),
    .io_AUDIOINPUT(bi_phase_enc_io_AUDIOINPUT),
    .io_TICK(bi_phase_enc_io_TICK),
    .io_NEXT(bi_phase_enc_io_NEXT)
  );
  RWSmem BFR ( // @[intervox_transmitter.scala 149:33]
    .clock(BFR_clock),
    .io_write(BFR_io_write),
    .io_dataIn(BFR_io_dataIn),
    .io_dataOut(BFR_io_dataOut)
  );
  RWSmem BFR1 ( // @[intervox_transmitter.scala 150:34]
    .clock(BFR1_clock),
    .io_write(BFR1_io_write),
    .io_dataIn(BFR1_io_dataIn),
    .io_dataOut(BFR1_io_dataOut)
  );
  assign io_MCLK_O = io_MCLK_IN; // @[intervox_transmitter.scala 154:25]
  assign io_DATA_O = DATA_OUT_REG_1B; // @[intervox_transmitter.scala 153:25]
  assign io_LRCLK_O = io_LRCLK_IN; // @[intervox_transmitter.scala 156:25]
  assign io_BCLK_O = io_BCLK_IN; // @[intervox_transmitter.scala 155:25]
  assign io_SDATA_O = io_SDATA_IN; // @[intervox_transmitter.scala 157:25]
  assign io_NXT_FRAME = bi_phase_enc_io_TICK; // @[intervox_transmitter.scala 168:25]
  assign bi_phase_enc_clock = clock;
  assign bi_phase_enc_reset = reset;
  assign bi_phase_enc_io_AUDIOINPUT = BFR1_io_dataOut; // @[intervox_transmitter.scala 172:31]
  assign bi_phase_enc_io_TICK = io_MCLK_IN & _GEN_41; // @[intervox_transmitter.scala 178:27 170:31]
  assign BFR_clock = clock;
  assign BFR_io_write = io_MCLK_IN & _GEN_44; // @[intervox_transmitter.scala 161:25 178:27]
  assign BFR_io_dataIn = _GEN_54[63:0];
  assign BFR1_clock = clock;
  assign BFR1_io_write = io_MCLK_IN & _GEN_46; // @[intervox_transmitter.scala 165:25 178:27]
  assign BFR1_io_dataIn = io_MCLK_IN ? _GEN_47 : 64'h0; // @[intervox_transmitter.scala 166:25 178:27]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 133:34]
      current_state <= 2'h0; // @[intervox_transmitter.scala 133:34]
    end else if (io_MCLK_IN) begin // @[intervox_transmitter.scala 178:27]
      if (2'h0 == current_state) begin // @[intervox_transmitter.scala 188:26]
        current_state <= 2'h2; // @[intervox_transmitter.scala 191:23]
      end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 188:26]
        current_state <= 2'h2; // @[intervox_transmitter.scala 194:23]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 135:34]
      BiPhase_CLK_CNTR <= 8'h0; // @[intervox_transmitter.scala 135:34]
    end else if (io_MCLK_IN) begin // @[intervox_transmitter.scala 178:27]
      if (!(2'h0 == current_state)) begin // @[intervox_transmitter.scala 188:26]
        if (!(2'h1 == current_state)) begin // @[intervox_transmitter.scala 188:26]
          BiPhase_CLK_CNTR <= _GEN_22;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 137:34]
      DATA_OUT_REG_1B <= 1'h0; // @[intervox_transmitter.scala 137:34]
    end else begin
      DATA_OUT_REG_1B <= bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 175:19]
    end
    if (reset) begin // @[intervox_transmitter.scala 143:34]
      bitCntr <= 8'h0; // @[intervox_transmitter.scala 143:34]
    end else if (io_MCLK_IN) begin // @[intervox_transmitter.scala 178:27]
      if (!(2'h0 == current_state)) begin // @[intervox_transmitter.scala 188:26]
        if (!(2'h1 == current_state)) begin // @[intervox_transmitter.scala 188:26]
          bitCntr <= _GEN_24;
        end
      end
    end
    tmpAudio <= _GEN_61[31:0]; // @[intervox_transmitter.scala 147:{34,34}]
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
  DATA_OUT_REG_1B = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  bitCntr = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  tmpAudio = _RAND_4[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule