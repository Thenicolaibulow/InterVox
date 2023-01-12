module bi_phase_encoder(
  input         clock,
  input         reset,
  output        io_DATA_OUT,
  input  [63:0] io_AUDIOINPUT,
  input         io_ENA,
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
  reg [63:0] stereoData; // @[intervox_transmitter.scala 39:32]
  reg [7:0] bitCntr_enc; // @[intervox_transmitter.scala 41:32]
  reg  hasNone; // @[intervox_transmitter.scala 42:32]
  reg [5:0] dataIndex; // @[intervox_transmitter.scala 43:32]
  reg  ndexR; // @[intervox_transmitter.scala 50:32]
  wire  _outReg_T = ~outReg; // @[intervox_transmitter.scala 62:23]
  wire  _GEN_0 = bitCntr_enc == 8'h3 ? ~outReg : outReg; // @[intervox_transmitter.scala 61:36 62:20 38:32]
  wire  _GEN_1 = bitCntr_enc == 8'h4 ? _outReg_T : _GEN_0; // @[intervox_transmitter.scala 65:36 66:20]
  wire  _GEN_2 = bitCntr_enc == 8'h4 ? 1'h0 : hasNone; // @[intervox_transmitter.scala 65:36 68:21 42:32]
  wire  _ndexR_T = ~ndexR; // @[intervox_transmitter.scala 76:22]
  wire [5:0] _dataIndex_T_1 = dataIndex + 6'h1; // @[intervox_transmitter.scala 79:38]
  wire [5:0] _GEN_3 = _ndexR_T ? _dataIndex_T_1 : dataIndex; // @[intervox_transmitter.scala 77:32 79:25 43:32]
  wire [6:0] _GEN_27 = {{1'd0}, _dataIndex_T_1}; // @[intervox_transmitter.scala 86:37]
  wire [6:0] _T_10 = 7'h40 - _GEN_27; // @[intervox_transmitter.scala 86:37]
  wire [63:0] _T_11 = stereoData >> _T_10; // @[intervox_transmitter.scala 86:31]
  wire  _GEN_4 = ~_T_11[0] | _GEN_2; // @[intervox_transmitter.scala 86:68 88:25]
  wire  _GEN_5 = bitCntr_enc < 8'h35 ? _GEN_4 : _GEN_2; // @[intervox_transmitter.scala 84:37]
  wire [5:0] _T_18 = dataIndex - 6'h17; // @[intervox_transmitter.scala 95:51]
  wire [6:0] _GEN_28 = {{1'd0}, _T_18}; // @[intervox_transmitter.scala 95:38]
  wire [6:0] _T_20 = 7'h40 - _GEN_28; // @[intervox_transmitter.scala 95:38]
  wire [63:0] _T_21 = stereoData >> _T_20; // @[intervox_transmitter.scala 95:31]
  wire  _GEN_6 = ~_T_21[0] | _GEN_5; // @[intervox_transmitter.scala 95:71 96:25]
  wire  _GEN_7 = bitCntr_enc >= 8'h35 & bitCntr_enc < 8'h65 ? _GEN_6 : _GEN_5; // @[intervox_transmitter.scala 93:64]
  wire  _GEN_8 = bitCntr_enc >= 8'h65 & bitCntr_enc <= 8'h7f | _GEN_7; // @[intervox_transmitter.scala 103:66 107:23]
  wire  _GEN_9 = hasNone ? outReg : _outReg_T; // @[intervox_transmitter.scala 111:34 113:22 118:22]
  wire  _GEN_10 = hasNone ? 1'h0 : _GEN_8; // @[intervox_transmitter.scala 111:34 114:23]
  wire [5:0] _GEN_12 = bitCntr_enc > 8'h4 ? _GEN_3 : dataIndex; // @[intervox_transmitter.scala 43:32 72:36]
  wire [7:0] _bitCntr_enc_T_1 = bitCntr_enc + 8'h1; // @[intervox_transmitter.scala 123:38]
  assign io_DATA_OUT = outReg; // @[intervox_transmitter.scala 45:17]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 38:32]
      outReg <= 1'h0; // @[intervox_transmitter.scala 38:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 52:25]
      if (io_TICK) begin // @[intervox_transmitter.scala 56:28]
        if (bitCntr_enc > 8'h4) begin // @[intervox_transmitter.scala 72:36]
          outReg <= _GEN_9;
        end else begin
          outReg <= _GEN_1;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 39:32]
      stereoData <= 64'h0; // @[intervox_transmitter.scala 39:32]
    end else begin
      stereoData <= io_AUDIOINPUT; // @[intervox_transmitter.scala 47:17]
    end
    if (reset) begin // @[intervox_transmitter.scala 41:32]
      bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 41:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 52:25]
      if (io_TICK) begin // @[intervox_transmitter.scala 56:28]
        if (bitCntr_enc == 8'h7f) begin // @[intervox_transmitter.scala 126:38]
          bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 127:25]
        end else begin
          bitCntr_enc <= _bitCntr_enc_T_1; // @[intervox_transmitter.scala 123:23]
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 42:32]
      hasNone <= 1'h0; // @[intervox_transmitter.scala 42:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 52:25]
      if (io_TICK) begin // @[intervox_transmitter.scala 56:28]
        if (bitCntr_enc > 8'h4) begin // @[intervox_transmitter.scala 72:36]
          hasNone <= _GEN_10;
        end else begin
          hasNone <= _GEN_2;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 43:32]
      dataIndex <= 6'h0; // @[intervox_transmitter.scala 43:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 52:25]
      if (io_TICK) begin // @[intervox_transmitter.scala 56:28]
        if (bitCntr_enc == 8'h7f) begin // @[intervox_transmitter.scala 126:38]
          dataIndex <= 6'h0; // @[intervox_transmitter.scala 128:23]
        end else begin
          dataIndex <= _GEN_12;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 50:32]
      ndexR <= 1'h0; // @[intervox_transmitter.scala 50:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 52:25]
      if (io_TICK) begin // @[intervox_transmitter.scala 56:28]
        if (bitCntr_enc > 8'h4) begin // @[intervox_transmitter.scala 72:36]
          ndexR <= ~ndexR; // @[intervox_transmitter.scala 76:19]
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
  wire  bi_phase_enc_clock; // @[intervox_transmitter.scala 161:33]
  wire  bi_phase_enc_reset; // @[intervox_transmitter.scala 161:33]
  wire  bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 161:33]
  wire [63:0] bi_phase_enc_io_AUDIOINPUT; // @[intervox_transmitter.scala 161:33]
  wire  bi_phase_enc_io_ENA; // @[intervox_transmitter.scala 161:33]
  wire  bi_phase_enc_io_TICK; // @[intervox_transmitter.scala 161:33]
  wire  BFR_clock; // @[intervox_transmitter.scala 167:33]
  wire  BFR_io_write; // @[intervox_transmitter.scala 167:33]
  wire [63:0] BFR_io_dataIn; // @[intervox_transmitter.scala 167:33]
  wire [63:0] BFR_io_dataOut; // @[intervox_transmitter.scala 167:33]
  wire  BFR1_clock; // @[intervox_transmitter.scala 168:33]
  wire  BFR1_io_write; // @[intervox_transmitter.scala 168:33]
  wire [63:0] BFR1_io_dataIn; // @[intervox_transmitter.scala 168:33]
  wire [63:0] BFR1_io_dataOut; // @[intervox_transmitter.scala 168:33]
  reg [1:0] current_state; // @[intervox_transmitter.scala 149:34]
  reg [7:0] BiPhase_CLK_CNTR; // @[intervox_transmitter.scala 151:34]
  reg  synced; // @[intervox_transmitter.scala 157:34]
  reg  encoderClk; // @[intervox_transmitter.scala 163:34]
  reg [7:0] bitCntr; // @[intervox_transmitter.scala 165:34]
  wire [7:0] _BiPhase_CLK_CNTR_T_1 = BiPhase_CLK_CNTR + 8'h1; // @[intervox_transmitter.scala 214:42]
  wire  _T_1 = BiPhase_CLK_CNTR == 8'h3; // @[intervox_transmitter.scala 216:27]
  wire [7:0] _GEN_0 = io_LRCLK_IN ? 8'h0 : bitCntr; // @[intervox_transmitter.scala 219:32 220:17 165:34]
  wire [7:0] _bitCntr_T_1 = bitCntr + 8'h1; // @[intervox_transmitter.scala 226:28]
  wire [7:0] _GEN_1 = bitCntr == 8'h1f ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 226:17 228:31 229:19]
  wire  _GEN_2 = bitCntr == 8'h1f | synced; // @[intervox_transmitter.scala 228:31 230:18 157:34]
  wire [7:0] _GEN_3 = ~io_LRCLK_IN ? _GEN_1 : _GEN_0; // @[intervox_transmitter.scala 223:32]
  wire [7:0] _GEN_5 = BiPhase_CLK_CNTR == 8'h3 ? 8'h0 : _BiPhase_CLK_CNTR_T_1; // @[intervox_transmitter.scala 214:22 216:35 217:24]
  wire [7:0] _GEN_6 = BiPhase_CLK_CNTR == 8'h3 ? _GEN_3 : bitCntr; // @[intervox_transmitter.scala 165:34 216:35]
  wire [7:0] _GEN_8 = ~synced ? _GEN_5 : BiPhase_CLK_CNTR; // @[intervox_transmitter.scala 212:23 151:34]
  wire [7:0] _GEN_9 = ~synced ? _GEN_6 : bitCntr; // @[intervox_transmitter.scala 212:23 165:34]
  wire  _T_13 = ~io_SDATA_IN; // @[intervox_transmitter.scala 294:30]
  wire [7:0] _BFR_io_dataIn_T_1 = 8'h48 - bitCntr; // @[intervox_transmitter.scala 296:67]
  wire [255:0] _BFR_io_dataIn_T_2 = 256'h0 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 296:58]
  wire [255:0] _GEN_69 = {{192'd0}, BFR_io_dataOut}; // @[intervox_transmitter.scala 296:51]
  wire [255:0] _BFR_io_dataIn_T_4 = _GEN_69 + _BFR_io_dataIn_T_2; // @[intervox_transmitter.scala 296:51]
  wire [255:0] _GEN_14 = ~io_SDATA_IN ? _BFR_io_dataIn_T_4 : 256'h0; // @[intervox_transmitter.scala 294:38 296:33]
  wire [255:0] _BFR_io_dataIn_T_7 = 256'h1 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 300:58]
  wire [255:0] _BFR_io_dataIn_T_9 = _GEN_69 + _BFR_io_dataIn_T_7; // @[intervox_transmitter.scala 300:51]
  wire [255:0] _GEN_15 = io_SDATA_IN ? _BFR_io_dataIn_T_9 : _GEN_14; // @[intervox_transmitter.scala 299:38 300:33]
  wire [7:0] _BFR_io_dataIn_T_11 = 8'h40 - bitCntr; // @[intervox_transmitter.scala 310:67]
  wire [255:0] _BFR_io_dataIn_T_12 = 256'h0 << _BFR_io_dataIn_T_11; // @[intervox_transmitter.scala 310:58]
  wire [255:0] _BFR_io_dataIn_T_14 = _GEN_69 + _BFR_io_dataIn_T_12; // @[intervox_transmitter.scala 310:51]
  wire [255:0] _GEN_16 = _T_13 ? _BFR_io_dataIn_T_14 : 256'h0; // @[intervox_transmitter.scala 308:39 310:33]
  wire [255:0] _BFR_io_dataIn_T_17 = 256'h1 << _BFR_io_dataIn_T_11; // @[intervox_transmitter.scala 314:58]
  wire [255:0] _BFR_io_dataIn_T_19 = _GEN_69 + _BFR_io_dataIn_T_17; // @[intervox_transmitter.scala 314:51]
  wire [255:0] _GEN_17 = io_SDATA_IN ? _BFR_io_dataIn_T_19 : _GEN_16; // @[intervox_transmitter.scala 313:38 314:33]
  wire [255:0] _GEN_19 = bitCntr > 8'h1f ? _GEN_15 : _GEN_17; // @[intervox_transmitter.scala 287:31]
  wire  _T_17 = bitCntr == 8'h3f; // @[intervox_transmitter.scala 318:24]
  wire [63:0] _GEN_22 = BFR_io_dataOut; // @[intervox_transmitter.scala 185:25 318:33 323:31]
  wire [255:0] _GEN_23 = bitCntr == 8'h3f ? 256'h0 : _GEN_19; // @[intervox_transmitter.scala 318:33 327:28]
  wire [7:0] _GEN_24 = bitCntr == 8'h3f ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 276:19 318:33 329:21]
  wire [7:0] _GEN_26 = _T_1 ? _GEN_24 : _GEN_9; // @[intervox_transmitter.scala 272:39]
  wire [255:0] _GEN_28 = _T_1 ? _GEN_23 : 256'h0; // @[intervox_transmitter.scala 181:25 272:39]
  wire  _GEN_29 = _T_1 & _T_17; // @[intervox_transmitter.scala 184:25 272:39]
  wire [63:0] _GEN_30 = _T_1 ? _GEN_22 : BFR_io_dataOut; // @[intervox_transmitter.scala 185:25 272:39]
  wire  _GEN_32 = synced ? ~encoderClk : encoderClk; // @[intervox_transmitter.scala 255:27 265:20 163:34]
  wire  _GEN_33 = synced & encoderClk; // @[intervox_transmitter.scala 255:27 190:31]
  wire [7:0] _GEN_34 = synced ? _GEN_5 : _GEN_8; // @[intervox_transmitter.scala 255:27]
  wire [7:0] _GEN_35 = synced ? _GEN_26 : _GEN_9; // @[intervox_transmitter.scala 255:27]
  wire  _GEN_36 = synced & _T_1; // @[intervox_transmitter.scala 180:25 255:27]
  wire [255:0] _GEN_37 = synced ? _GEN_28 : 256'h0; // @[intervox_transmitter.scala 181:25 255:27]
  wire  _GEN_38 = synced & _GEN_29; // @[intervox_transmitter.scala 184:25 255:27]
  wire [63:0] _GEN_39 = synced ? _GEN_30 : BFR_io_dataOut; // @[intervox_transmitter.scala 185:25 255:27]
  wire [255:0] _GEN_46 = 2'h2 == current_state ? _GEN_37 : 256'h0; // @[intervox_transmitter.scala 243:24 181:25]
  wire [63:0] _GEN_48 = 2'h2 == current_state ? _GEN_39 : BFR_io_dataOut; // @[intervox_transmitter.scala 243:24 185:25]
  wire  _GEN_50 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & synced; // @[intervox_transmitter.scala 243:24 191:31]
  wire  _GEN_52 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _GEN_33; // @[intervox_transmitter.scala 243:24 190:31]
  wire  _GEN_55 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _GEN_36; // @[intervox_transmitter.scala 243:24 180:25]
  wire [255:0] _GEN_56 = 2'h1 == current_state ? 256'h0 : _GEN_46; // @[intervox_transmitter.scala 243:24 181:25]
  wire  _GEN_57 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _GEN_38; // @[intervox_transmitter.scala 243:24 184:25]
  wire [63:0] _GEN_58 = 2'h1 == current_state ? BFR_io_dataOut : _GEN_48; // @[intervox_transmitter.scala 243:24 185:25]
  wire [255:0] _GEN_66 = 2'h0 == current_state ? 256'h0 : _GEN_56; // @[intervox_transmitter.scala 243:24 181:25]
  bi_phase_encoder bi_phase_enc ( // @[intervox_transmitter.scala 161:33]
    .clock(bi_phase_enc_clock),
    .reset(bi_phase_enc_reset),
    .io_DATA_OUT(bi_phase_enc_io_DATA_OUT),
    .io_AUDIOINPUT(bi_phase_enc_io_AUDIOINPUT),
    .io_ENA(bi_phase_enc_io_ENA),
    .io_TICK(bi_phase_enc_io_TICK)
  );
  RWSmem BFR ( // @[intervox_transmitter.scala 167:33]
    .clock(BFR_clock),
    .io_write(BFR_io_write),
    .io_dataIn(BFR_io_dataIn),
    .io_dataOut(BFR_io_dataOut)
  );
  RWSmem BFR1 ( // @[intervox_transmitter.scala 168:33]
    .clock(BFR1_clock),
    .io_write(BFR1_io_write),
    .io_dataIn(BFR1_io_dataIn),
    .io_dataOut(BFR1_io_dataOut)
  );
  assign io_MCLK_O = clock; // @[intervox_transmitter.scala 172:25]
  assign io_DATA_O = bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 171:25]
  assign io_LRCLK_O = io_LRCLK_IN; // @[intervox_transmitter.scala 174:25]
  assign io_BCLK_O = io_BCLK_IN; // @[intervox_transmitter.scala 173:25]
  assign io_SDATA_O = io_SDATA_IN; // @[intervox_transmitter.scala 175:25]
  assign io_NXT_FRAME = bi_phase_enc_io_ENA; // @[intervox_transmitter.scala 188:31]
  assign bi_phase_enc_clock = clock;
  assign bi_phase_enc_reset = reset;
  assign bi_phase_enc_io_AUDIOINPUT = BFR1_io_dataOut; // @[intervox_transmitter.scala 193:31]
  assign bi_phase_enc_io_ENA = 2'h0 == current_state ? 1'h0 : _GEN_50; // @[intervox_transmitter.scala 243:24 191:31]
  assign bi_phase_enc_io_TICK = 2'h0 == current_state ? 1'h0 : _GEN_52; // @[intervox_transmitter.scala 243:24 190:31]
  assign BFR_clock = clock;
  assign BFR_io_write = 2'h0 == current_state ? 1'h0 : _GEN_55; // @[intervox_transmitter.scala 243:24 180:25]
  assign BFR_io_dataIn = _GEN_66[63:0];
  assign BFR1_clock = clock;
  assign BFR1_io_write = 2'h0 == current_state ? 1'h0 : _GEN_57; // @[intervox_transmitter.scala 243:24 184:25]
  assign BFR1_io_dataIn = 2'h0 == current_state ? BFR_io_dataOut : _GEN_58; // @[intervox_transmitter.scala 243:24 185:25]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 149:34]
      current_state <= 2'h0; // @[intervox_transmitter.scala 149:34]
    end else if (2'h0 == current_state) begin // @[intervox_transmitter.scala 243:24]
      current_state <= 2'h2; // @[intervox_transmitter.scala 247:21]
    end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 243:24]
      current_state <= 2'h2; // @[intervox_transmitter.scala 251:21]
    end
    if (reset) begin // @[intervox_transmitter.scala 151:34]
      BiPhase_CLK_CNTR <= 8'h0; // @[intervox_transmitter.scala 151:34]
    end else if (2'h0 == current_state) begin // @[intervox_transmitter.scala 243:24]
      BiPhase_CLK_CNTR <= _GEN_8;
    end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 243:24]
      BiPhase_CLK_CNTR <= _GEN_8;
    end else if (2'h2 == current_state) begin // @[intervox_transmitter.scala 243:24]
      BiPhase_CLK_CNTR <= _GEN_34;
    end else begin
      BiPhase_CLK_CNTR <= _GEN_8;
    end
    if (reset) begin // @[intervox_transmitter.scala 157:34]
      synced <= 1'h0; // @[intervox_transmitter.scala 157:34]
    end else if (~synced) begin // @[intervox_transmitter.scala 212:23]
      if (BiPhase_CLK_CNTR == 8'h3) begin // @[intervox_transmitter.scala 216:35]
        if (~io_LRCLK_IN) begin // @[intervox_transmitter.scala 223:32]
          synced <= _GEN_2;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 163:34]
      encoderClk <= 1'h0; // @[intervox_transmitter.scala 163:34]
    end else if (!(2'h0 == current_state)) begin // @[intervox_transmitter.scala 243:24]
      if (!(2'h1 == current_state)) begin // @[intervox_transmitter.scala 243:24]
        if (2'h2 == current_state) begin // @[intervox_transmitter.scala 243:24]
          encoderClk <= _GEN_32;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 165:34]
      bitCntr <= 8'h0; // @[intervox_transmitter.scala 165:34]
    end else if (2'h0 == current_state) begin // @[intervox_transmitter.scala 243:24]
      bitCntr <= _GEN_9;
    end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 243:24]
      bitCntr <= _GEN_9;
    end else if (2'h2 == current_state) begin // @[intervox_transmitter.scala 243:24]
      bitCntr <= _GEN_35;
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
  encoderClk = _RAND_3[0:0];
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
