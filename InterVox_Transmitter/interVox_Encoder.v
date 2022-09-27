module bi_phase_encoder(
  input   clock,
  input   reset,
  input   io_DATA_IN,
  output  io_DATA_OUT,
  input   io_NxtBit
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  hasNone; // @[intervox_transmitter.scala 16:26]
  reg  outReg; // @[intervox_transmitter.scala 17:26]
  wire  _GEN_0 = ~io_DATA_IN | hasNone; // @[intervox_transmitter.scala 22:32 24:17 16:26]
  assign io_DATA_OUT = outReg; // @[intervox_transmitter.scala 18:17]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 16:26]
      hasNone <= 1'h0; // @[intervox_transmitter.scala 16:26]
    end else if (io_NxtBit) begin // @[intervox_transmitter.scala 20:28]
      if (hasNone) begin // @[intervox_transmitter.scala 26:28]
        hasNone <= 1'h0; // @[intervox_transmitter.scala 28:17]
      end else begin
        hasNone <= _GEN_0;
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 17:26]
      outReg <= 1'h0; // @[intervox_transmitter.scala 17:26]
    end else if (io_NxtBit) begin // @[intervox_transmitter.scala 20:28]
      if (!(hasNone)) begin // @[intervox_transmitter.scala 26:28]
        outReg <= ~outReg; // @[intervox_transmitter.scala 32:16]
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
  hasNone = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  outReg = _RAND_1[0:0];
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
  input   io_BCLK_IN,
  input   io_LRCLK_IN,
  input   io_SDATA_IN,
  output  io_DATA_O,
  output  io_LRCLK_O,
  output  io_BCLK_O,
  output  io_MCLK_O,
  output  io_SDATA_O
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  bi_phase_enc_clock; // @[intervox_transmitter.scala 58:28]
  wire  bi_phase_enc_reset; // @[intervox_transmitter.scala 58:28]
  wire  bi_phase_enc_io_DATA_IN; // @[intervox_transmitter.scala 58:28]
  wire  bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 58:28]
  wire  bi_phase_enc_io_NxtBit; // @[intervox_transmitter.scala 58:28]
  reg [1:0] current_state; // @[intervox_transmitter.scala 53:30]
  reg [7:0] BiPhase_CLK_CNTR; // @[intervox_transmitter.scala 55:33]
  reg  DATA_OUT_REG; // @[intervox_transmitter.scala 57:29]
  wire [7:0] _BiPhase_CLK_CNTR_T_1 = BiPhase_CLK_CNTR + 8'h1; // @[intervox_transmitter.scala 72:42]
  wire  _GEN_1 = 2'h2 == current_state & io_SDATA_IN; // @[intervox_transmitter.scala 65:27 75:29 86:35]
  wire  _GEN_2 = 2'h2 == current_state ? bi_phase_enc_io_DATA_OUT : DATA_OUT_REG; // @[intervox_transmitter.scala 75:29 87:24 57:29]
  wire  _GEN_4 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state; // @[intervox_transmitter.scala 66:26 75:29]
  wire  _GEN_5 = 2'h1 == current_state ? 1'h0 : _GEN_1; // @[intervox_transmitter.scala 65:27 75:29]
  wire  _GEN_8 = 2'h0 == current_state ? 1'h0 : _GEN_4; // @[intervox_transmitter.scala 66:26 75:29]
  wire  _GEN_9 = 2'h0 == current_state ? 1'h0 : _GEN_5; // @[intervox_transmitter.scala 65:27 75:29]
  bi_phase_encoder bi_phase_enc ( // @[intervox_transmitter.scala 58:28]
    .clock(bi_phase_enc_clock),
    .reset(bi_phase_enc_reset),
    .io_DATA_IN(bi_phase_enc_io_DATA_IN),
    .io_DATA_OUT(bi_phase_enc_io_DATA_OUT),
    .io_NxtBit(bi_phase_enc_io_NxtBit)
  );
  assign io_DATA_O = DATA_OUT_REG; // @[intervox_transmitter.scala 60:13]
  assign io_LRCLK_O = io_LRCLK_IN; // @[intervox_transmitter.scala 63:14]
  assign io_BCLK_O = io_BCLK_IN; // @[intervox_transmitter.scala 62:13]
  assign io_MCLK_O = io_MCLK_IN; // @[intervox_transmitter.scala 61:13]
  assign io_SDATA_O = io_SDATA_IN; // @[intervox_transmitter.scala 64:14]
  assign bi_phase_enc_clock = clock;
  assign bi_phase_enc_reset = reset;
  assign bi_phase_enc_io_DATA_IN = BiPhase_CLK_CNTR == 8'h8 & _GEN_9; // @[intervox_transmitter.scala 65:27 73:35]
  assign bi_phase_enc_io_NxtBit = BiPhase_CLK_CNTR == 8'h8 & _GEN_8; // @[intervox_transmitter.scala 66:26 73:35]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 53:30]
      current_state <= 2'h0; // @[intervox_transmitter.scala 53:30]
    end else if (BiPhase_CLK_CNTR == 8'h8) begin // @[intervox_transmitter.scala 73:35]
      if (2'h0 == current_state) begin // @[intervox_transmitter.scala 75:29]
        current_state <= 2'h2; // @[intervox_transmitter.scala 78:25]
      end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 75:29]
        current_state <= 2'h2; // @[intervox_transmitter.scala 81:25]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 55:33]
      BiPhase_CLK_CNTR <= 8'h0; // @[intervox_transmitter.scala 55:33]
    end else if (BiPhase_CLK_CNTR == 8'h8) begin // @[intervox_transmitter.scala 73:35]
      BiPhase_CLK_CNTR <= 8'h0; // @[intervox_transmitter.scala 90:22]
    end else begin
      BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_1; // @[intervox_transmitter.scala 72:22]
    end
    if (reset) begin // @[intervox_transmitter.scala 57:29]
      DATA_OUT_REG <= 1'h0; // @[intervox_transmitter.scala 57:29]
    end else if (BiPhase_CLK_CNTR == 8'h8) begin // @[intervox_transmitter.scala 73:35]
      if (!(2'h0 == current_state)) begin // @[intervox_transmitter.scala 75:29]
        if (!(2'h1 == current_state)) begin // @[intervox_transmitter.scala 75:29]
          DATA_OUT_REG <= _GEN_2;
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
  DATA_OUT_REG = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
