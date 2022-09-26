import chisel3._
import chisel3.util._

  /*
    The main encoder is a state machine which initialises the interVox clients,
    and encodes I2S data into the interVox format. - A bi-phase mark encoded signal,
    which carries both (up to) 24-bit audio, along side DSP control data.
  */
 

class interVox_Encoder(width: UInt) extends Module {
  val io = IO(new Bundle {
    //val MCLK_IN   = Input (Clock()) // 256 x fs
    //val BCLK_IN   = Input (Clock()) //  64 x fs
    //val LRCLK_IN  = Input (Clock()) //       fs  
    val SDATA_IN  = Input (UInt(1.W))
    val DATA_O    = Output(UInt(1.W))
  })

  // Define state enum.. case sentitive!
  val state_Reset :: state_Setup :: state_Transmit :: Nil = Enum(3)
  val current_state = RegInit(state_Reset)  
  // Bi-phase clock counter register.
  val BiPhase_CLK_CNTR = RegInit(0.U(8.W))
  val hasOne = RegInit(0.U(1.W))
  // Output register
  val DATA_OUT_REG = RegInit(0.U(1.W))
  io.DATA_O := DATA_OUT_REG

  // Clock internal logic off of the external I2S MCLK, to keep everything synced.
  //withClock(io.MCLK_IN){

    // First we need a clock divider to provide the 2 x BCLK, needed for the bi-phase mark encoding.
    BiPhase_CLK_CNTR := BiPhase_CLK_CNTR + 1.U
    when(BiPhase_CLK_CNTR === 1.U){

      switch(current_state) {

        is(state_Reset) {
          current_state := state_Transmit
        }
        is(state_Setup) {
          current_state := state_Transmit
        }
        is(state_Transmit) {
          // So for bi-phase mark:
          // If we recieve a bit from SDATA:
          when(io.SDATA_IN === 1.U) {
            // Then don't change for one cycle
            hasOne := 1.U
          }
          when(hasOne === 1.U){
            DATA_OUT_REG := DATA_OUT_REG
            hasOne := 0.U
          }
          .otherwise{
            // Otherwise, flip with clock.
            DATA_OUT_REG := ~DATA_OUT_REG
          }
      }
    }
    BiPhase_CLK_CNTR := 0.U
  }
}

object HelloMain extends App {
  println(".. I will now generate the Verilog file!")
  emitVerilog(new interVox_Encoder(32.U))
}
