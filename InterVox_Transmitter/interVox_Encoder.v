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
  wire  _GEN_5 = bitCntr < 8'h7f ? _GEN_4 : hasNone; // @[intervox_transmitter.scala 43:32 76:34]
  wire [15:0] _T_15 = 16'h0 >> _T_8; // @[intervox_transmitter.scala 86:30]
  wire  _GEN_6 = ~_T_15[0] | _GEN_5; // @[intervox_transmitter.scala 86:61 88:25]
  wire  _GEN_7 = bitCntr > 8'h7f ? _GEN_6 : _GEN_5; // @[intervox_transmitter.scala 84:34]
  wire  _GEN_14 = bitCntr == 8'hff | _GEN_2; // @[intervox_transmitter.scala 102:34 105:18]
  assign io_DATA_OUT = outReg; // @[intervox_transmitter.scala 46:17]
  assign io_NEXT = next; // @[intervox_transmitter.scala 50:13]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 38:32]
      outReg <= 1'h0; // @[intervox_transmitter.scala 38:32]
    end else if (io_TICK) begin // @[intervox_transmitter.scala 52:28]
      if (bitCntr > 8'h7) begin // @[intervox_transmitter.scala 73:32]
        if (!(hasNone)) begin // @[intervox_transmitter.scala 92:34]
          outReg <= ~outReg; // @[intervox_transmitter.scala 98:22]
        end
      end else if (bitCntr < 8'h7) begin // @[intervox_transmitter.scala 60:31]
        outReg <= _GEN_1;
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 39:32]
      next <= 1'h0; // @[intervox_transmitter.scala 39:32]
    end else if (io_TICK) begin // @[intervox_transmitter.scala 52:28]
      next <= _GEN_14;
    end
    if (reset) begin // @[intervox_transmitter.scala 40:32]
      stereoData <= 64'h0; // @[intervox_transmitter.scala 40:32]
    end else if (io_TICK) begin // @[intervox_transmitter.scala 52:28]
      if (bitCntr == 8'hff) begin // @[intervox_transmitter.scala 102:34]
        stereoData <= 64'h0; // @[intervox_transmitter.scala 104:24]
      end else begin
        stereoData <= io_AUDIOINPUT; // @[intervox_transmitter.scala 48:16]
      end
    end else begin
      stereoData <= io_AUDIOINPUT; // @[intervox_transmitter.scala 48:16]
    end
    if (reset) begin // @[intervox_transmitter.scala 42:32]
      bitCntr <= 8'h0; // @[intervox_transmitter.scala 42:32]
    end else if (io_TICK) begin // @[intervox_transmitter.scala 52:28]
      if (bitCntr == 8'hff) begin // @[intervox_transmitter.scala 102:34]
        bitCntr <= 8'h0; // @[intervox_transmitter.scala 103:21]
      end else begin
        bitCntr <= _bitCntr_T_1; // @[intervox_transmitter.scala 54:19]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 43:32]
      hasNone <= 1'h0; // @[intervox_transmitter.scala 43:32]
    end else if (io_TICK) begin // @[intervox_transmitter.scala 52:28]
      if (bitCntr > 8'h7) begin // @[intervox_transmitter.scala 73:32]
        if (hasNone) begin // @[intervox_transmitter.scala 92:34]
          hasNone <= 1'h0; // @[intervox_transmitter.scala 94:23]
        end else begin
          hasNone <= _GEN_7;
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
`endif // RANDOMIZE_REG_INIT
  wire  bi_phase_enc_clock; // @[intervox_transmitter.scala 134:33]
  wire  bi_phase_enc_reset; // @[intervox_transmitter.scala 134:33]
  wire  bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 134:33]
  wire [63:0] bi_phase_enc_io_AUDIOINPUT; // @[intervox_transmitter.scala 134:33]
  wire  bi_phase_enc_io_TICK; // @[intervox_transmitter.scala 134:33]
  wire  bi_phase_enc_io_NEXT; // @[intervox_transmitter.scala 134:33]
  wire  BFR_clock; // @[intervox_transmitter.scala 142:33]
  wire  BFR_io_write; // @[intervox_transmitter.scala 142:33]
  wire [63:0] BFR_io_dataIn; // @[intervox_transmitter.scala 142:33]
  wire [63:0] BFR_io_dataOut; // @[intervox_transmitter.scala 142:33]
  wire  BFR1_clock; // @[intervox_transmitter.scala 143:33]
  wire  BFR1_io_write; // @[intervox_transmitter.scala 143:33]
  wire [63:0] BFR1_io_dataIn; // @[intervox_transmitter.scala 143:33]
  wire [63:0] BFR1_io_dataOut; // @[intervox_transmitter.scala 143:33]
  reg [1:0] current_state; // @[intervox_transmitter.scala 126:34]
  reg [7:0] BiPhase_CLK_CNTR; // @[intervox_transmitter.scala 128:34]
  reg  DATA_OUT_REG_1B; // @[intervox_transmitter.scala 130:34]
  reg [7:0] bitCntr; // @[intervox_transmitter.scala 136:34]
  wire [7:0] _BiPhase_CLK_CNTR_T_1 = BiPhase_CLK_CNTR + 8'h1; // @[intervox_transmitter.scala 189:44]
  wire  _T_4 = BiPhase_CLK_CNTR == 8'h3; // @[intervox_transmitter.scala 192:30]
  wire  _T_5 = BiPhase_CLK_CNTR == 8'h1 | _T_4; // @[intervox_transmitter.scala 191:38]
  wire  _T_6 = BiPhase_CLK_CNTR == 8'h5; // @[intervox_transmitter.scala 193:30]
  wire  _T_7 = _T_5 | _T_6; // @[intervox_transmitter.scala 192:38]
  wire  _T_8 = BiPhase_CLK_CNTR == 8'h7; // @[intervox_transmitter.scala 194:30]
  wire  _T_9 = _T_7 | _T_8; // @[intervox_transmitter.scala 193:38]
  wire [7:0] _bitCntr_T_1 = bitCntr + 8'h1; // @[intervox_transmitter.scala 201:28]
  wire  _T_12 = ~io_SDATA_IN; // @[intervox_transmitter.scala 209:28]
  wire [7:0] _BFR_io_dataIn_T_1 = bitCntr - 8'h10; // @[intervox_transmitter.scala 212:68]
  wire [255:0] _BFR_io_dataIn_T_2 = 256'h0 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 212:56]
  wire [255:0] _GEN_47 = {{192'd0}, BFR_io_dataOut}; // @[intervox_transmitter.scala 212:49]
  wire [255:0] _BFR_io_dataIn_T_4 = _GEN_47 + _BFR_io_dataIn_T_2; // @[intervox_transmitter.scala 212:49]
  wire [255:0] _GEN_2 = ~io_SDATA_IN ? _BFR_io_dataIn_T_4 : 256'h0; // @[intervox_transmitter.scala 154:25 209:37 212:31]
  wire [255:0] _BFR_io_dataIn_T_7 = 256'h1 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 218:56]
  wire [255:0] _BFR_io_dataIn_T_9 = _GEN_47 + _BFR_io_dataIn_T_7; // @[intervox_transmitter.scala 218:49]
  wire  _GEN_3 = io_SDATA_IN | _T_12; // @[intervox_transmitter.scala 215:36 217:31]
  wire [255:0] _GEN_4 = io_SDATA_IN ? _BFR_io_dataIn_T_9 : _GEN_2; // @[intervox_transmitter.scala 215:36 218:31]
  wire [255:0] _BFR_io_dataIn_T_10 = 256'h0 << bitCntr; // @[intervox_transmitter.scala 224:56]
  wire [255:0] _BFR_io_dataIn_T_12 = _GEN_47 + _BFR_io_dataIn_T_10; // @[intervox_transmitter.scala 224:49]
  wire [255:0] _GEN_6 = _T_12 ? _BFR_io_dataIn_T_12 : 256'h0; // @[intervox_transmitter.scala 154:25 221:37 224:31]
  wire [255:0] _BFR_io_dataIn_T_13 = 256'h1 << bitCntr; // @[intervox_transmitter.scala 230:56]
  wire [255:0] _BFR_io_dataIn_T_15 = _GEN_47 + _BFR_io_dataIn_T_13; // @[intervox_transmitter.scala 230:49]
  wire [255:0] _GEN_8 = io_SDATA_IN ? _BFR_io_dataIn_T_15 : _GEN_6; // @[intervox_transmitter.scala 227:36 230:31]
  wire  _GEN_9 = bitCntr > 8'h28 ? _GEN_3 : _GEN_3; // @[intervox_transmitter.scala 206:29]
  wire [255:0] _GEN_10 = bitCntr > 8'h28 ? _GEN_4 : _GEN_8; // @[intervox_transmitter.scala 206:29]
  wire  _T_16 = bitCntr == 8'h3f; // @[intervox_transmitter.scala 233:22]
  wire [63:0] _GEN_12 = bi_phase_enc_io_NEXT ? 64'h0 : BFR_io_dataOut; // @[intervox_transmitter.scala 237:29 242:45 244:29]
  wire [63:0] _GEN_14 = bitCntr == 8'h3f ? _GEN_12 : 64'h0; // @[intervox_transmitter.scala 158:25 233:31]
  wire  _GEN_15 = bitCntr == 8'h3f | _GEN_9; // @[intervox_transmitter.scala 233:31 239:29]
  wire [255:0] _GEN_16 = bitCntr == 8'h3f ? 256'h0 : _GEN_10; // @[intervox_transmitter.scala 233:31 240:29]
  wire [7:0] _GEN_17 = bitCntr == 8'h3f ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 201:17 233:31 246:28]
  wire [7:0] _GEN_18 = _T_8 ? _GEN_17 : bitCntr; // @[intervox_transmitter.scala 136:34 198:37]
  wire  _GEN_19 = _T_8 & _GEN_15; // @[intervox_transmitter.scala 153:25 198:37]
  wire [255:0] _GEN_20 = _T_8 ? _GEN_16 : 256'h0; // @[intervox_transmitter.scala 154:25 198:37]
  wire  _GEN_21 = _T_8 & _T_16; // @[intervox_transmitter.scala 157:25 198:37]
  wire [63:0] _GEN_22 = _T_8 ? _GEN_14 : 64'h0; // @[intervox_transmitter.scala 158:25 198:37]
  wire [7:0] _GEN_23 = _T_8 ? 8'h0 : _BiPhase_CLK_CNTR_T_1; // @[intervox_transmitter.scala 189:24 198:37 249:26]
  wire [255:0] _GEN_28 = 2'h2 == current_state ? _GEN_20 : 256'h0; // @[intervox_transmitter.scala 179:24 154:25]
  wire [63:0] _GEN_30 = 2'h2 == current_state ? _GEN_22 : 64'h0; // @[intervox_transmitter.scala 179:24 158:25]
  wire  _GEN_33 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _T_9; // @[intervox_transmitter.scala 179:24 162:31]
  wire  _GEN_35 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _GEN_19; // @[intervox_transmitter.scala 179:24 153:25]
  wire [255:0] _GEN_36 = 2'h1 == current_state ? 256'h0 : _GEN_28; // @[intervox_transmitter.scala 179:24 154:25]
  wire  _GEN_37 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _GEN_21; // @[intervox_transmitter.scala 179:24 157:25]
  wire [63:0] _GEN_38 = 2'h1 == current_state ? 64'h0 : _GEN_30; // @[intervox_transmitter.scala 179:24 158:25]
  wire [255:0] _GEN_44 = 2'h0 == current_state ? 256'h0 : _GEN_36; // @[intervox_transmitter.scala 179:24 154:25]
  bi_phase_encoder bi_phase_enc ( // @[intervox_transmitter.scala 134:33]
    .clock(bi_phase_enc_clock),
    .reset(bi_phase_enc_reset),
    .io_DATA_OUT(bi_phase_enc_io_DATA_OUT),
    .io_AUDIOINPUT(bi_phase_enc_io_AUDIOINPUT),
    .io_TICK(bi_phase_enc_io_TICK),
    .io_NEXT(bi_phase_enc_io_NEXT)
  );
  RWSmem BFR ( // @[intervox_transmitter.scala 142:33]
    .clock(BFR_clock),
    .io_write(BFR_io_write),
    .io_dataIn(BFR_io_dataIn),
    .io_dataOut(BFR_io_dataOut)
  );
  RWSmem BFR1 ( // @[intervox_transmitter.scala 143:33]
    .clock(BFR1_clock),
    .io_write(BFR1_io_write),
    .io_dataIn(BFR1_io_dataIn),
    .io_dataOut(BFR1_io_dataOut)
  );
  assign io_MCLK_O = io_MCLK_IN; // @[intervox_transmitter.scala 147:25]
  assign io_DATA_O = DATA_OUT_REG_1B; // @[intervox_transmitter.scala 146:25]
  assign io_LRCLK_O = io_LRCLK_IN; // @[intervox_transmitter.scala 149:25]
  assign io_BCLK_O = io_BCLK_IN; // @[intervox_transmitter.scala 148:25]
  assign io_SDATA_O = io_SDATA_IN; // @[intervox_transmitter.scala 150:25]
  assign io_NXT_FRAME = bi_phase_enc_io_TICK; // @[intervox_transmitter.scala 159:25]
  assign bi_phase_enc_clock = clock;
  assign bi_phase_enc_reset = reset;
  assign bi_phase_enc_io_AUDIOINPUT = BFR1_io_dataOut; // @[intervox_transmitter.scala 163:31]
  assign bi_phase_enc_io_TICK = 2'h0 == current_state ? 1'h0 : _GEN_33; // @[intervox_transmitter.scala 179:24 162:31]
  assign BFR_clock = clock;
  assign BFR_io_write = 2'h0 == current_state ? 1'h0 : _GEN_35; // @[intervox_transmitter.scala 179:24 153:25]
  assign BFR_io_dataIn = _GEN_44[63:0];
  assign BFR1_clock = clock;
  assign BFR1_io_write = 2'h0 == current_state ? 1'h0 : _GEN_37; // @[intervox_transmitter.scala 179:24 157:25]
  assign BFR1_io_dataIn = 2'h0 == current_state ? 64'h0 : _GEN_38; // @[intervox_transmitter.scala 179:24 158:25]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 126:34]
      current_state <= 2'h0; // @[intervox_transmitter.scala 126:34]
    end else if (2'h0 == current_state) begin // @[intervox_transmitter.scala 179:24]
      current_state <= 2'h2; // @[intervox_transmitter.scala 182:21]
    end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 179:24]
      current_state <= 2'h2; // @[intervox_transmitter.scala 185:21]
    end
    if (reset) begin // @[intervox_transmitter.scala 128:34]
      BiPhase_CLK_CNTR <= 8'h0; // @[intervox_transmitter.scala 128:34]
    end else if (!(2'h0 == current_state)) begin // @[intervox_transmitter.scala 179:24]
      if (!(2'h1 == current_state)) begin // @[intervox_transmitter.scala 179:24]
        if (2'h2 == current_state) begin // @[intervox_transmitter.scala 179:24]
          BiPhase_CLK_CNTR <= _GEN_23;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 130:34]
      DATA_OUT_REG_1B <= 1'h0; // @[intervox_transmitter.scala 130:34]
    end else begin
      DATA_OUT_REG_1B <= bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 166:19]
    end
    if (reset) begin // @[intervox_transmitter.scala 136:34]
      bitCntr <= 8'h0; // @[intervox_transmitter.scala 136:34]
    end else if (!(2'h0 == current_state)) begin // @[intervox_transmitter.scala 179:24]
      if (!(2'h1 == current_state)) begin // @[intervox_transmitter.scala 179:24]
        if (2'h2 == current_state) begin // @[intervox_transmitter.scala 179:24]
          bitCntr <= _GEN_18;
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
  DATA_OUT_REG_1B = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  bitCntr = _RAND_3[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
