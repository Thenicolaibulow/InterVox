import chisel3._
import chisel3.util._

  /*
    The main encoder is a state machine which initialises the interVox clients,
    and encodes I2S data into the interVox format. - A bi-phase mark encoded signal,
    which carries both (up to) 24-bit audio, along side DSP control data.
  */
 
class bi_phase_encoder() extends Module {
  val io = IO(new Bundle {
    val DATA_IN   = Input (UInt(1.W))
    val DATA_OUT  = Output(UInt(1.W))
    val NxtBit    = Input (UInt(1.W))
  })
    val hasNone = RegInit(0.U(1.W))
    val outReg  = RegInit(0.U(1.W))
    io.DATA_OUT := outReg

    when(io.NxtBit === 1.U){  
      // If we recieve a bit from Input:
      when(io.DATA_IN === 0.U) {
        // Then don't change for one cycle
        hasNone := 1.U
      }
      when(hasNone === 1.U){
        outReg := outReg
        hasNone := 0.U
      }
      .otherwise{
        // Otherwise, flip
        outReg := ~outReg
      }
    }
}

class interVox_Encoder(width: UInt) extends Module {
  val io = IO(new Bundle {
    val MCLK_IN   = Input (Clock())   // 256 x fs
    val BCLK_IN   = Input (UInt(1.W)) //  64 x fs
    val LRCLK_IN  = Input (UInt(1.W)) //       fs  
    val SDATA_IN  = Input (UInt(1.W))
    val DATA_O    = Output(UInt(1.W))
    
    val LRCLK_O   = Output(UInt(1.W))    
    val BCLK_O    = Output(UInt(1.W))  
    val MCLK_O    = Output(Clock())  
    val SDATA_O   = Output(UInt(1.W))      
  })

  // Define state enum.. case sentitive!
  val state_Reset :: state_Setup :: state_Transmit :: Nil = Enum(3)
  val current_state = RegInit(state_Reset)  
  // Bi-phase clock counter register.
  val BiPhase_CLK_CNTR = RegInit(0.U(8.W))
  // Output register
  val DATA_OUT_REG = RegInit(0.U(1.W))
  val bi_phase_enc = Module(new bi_phase_encoder())
  
  io.DATA_O := DATA_OUT_REG
  io.MCLK_O := io.MCLK_IN
  io.BCLK_O := io.BCLK_IN 
  io.LRCLK_O := io.LRCLK_IN 
  io.SDATA_O := io.SDATA_IN
  bi_phase_enc.io.DATA_IN := 0.U
  bi_phase_enc.io.NxtBit := 0.U

  // Clock internal logic off of the external I2S MCLK, to keep everything synced.
  withClock(io.MCLK_IN){

    // First we need a clock divider to provide the 2 x BCLK, needed for the bi-phase mark encoding.
    BiPhase_CLK_CNTR := BiPhase_CLK_CNTR + 1.U
    when(BiPhase_CLK_CNTR === 8.U){

      switch(current_state) {

        is(state_Reset) {
          current_state := state_Transmit
        }
        is(state_Setup) {
          current_state := state_Transmit
        }
        is(state_Transmit) {
          // Get the bi-phase encoder ready
          bi_phase_enc.io.NxtBit := 1.U
          // Populate output register with bi-phase encoded data. 
          bi_phase_enc.io.DATA_IN := io.SDATA_IN
          // Recieve encoded data, and clock it out on data_out
          DATA_OUT_REG := bi_phase_enc.io.DATA_OUT 
      }
    }
    BiPhase_CLK_CNTR := 0.U
    }
  }
}

object HelloMain extends App {
  println(".. I will now generate the Verilog file!")
  emitVerilog(new interVox_Encoder(32.U))
}
