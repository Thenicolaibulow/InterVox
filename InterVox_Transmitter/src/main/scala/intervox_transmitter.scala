import chisel3._
import chisel3.util._

  /*
    The main encoder is a state machine which initialises the interVox clients,
    and encodes I2S data into the interVox format. - A bi-phase mark encoded signal,
    which carries both (up to) 24-bit audio, along side DSP control data.
  */
 
class RWSmem extends Module {
  val io = IO(new Bundle {
    val enable    = Input(Bool())
    val write     = Input(Bool())
    val addr      = Input(UInt(1.W))
    val dataIn    = Input(UInt(64.W))
    val dataOut   = Output(UInt(64.W))
  })

  val mem = SyncReadMem(1, UInt(64.W))

  io.dataOut := DontCare
  
  when(io.enable) {
    val rdwrPort = mem(io.addr)
    when (io.write) { rdwrPort := io.dataIn }
      .otherwise    { io.dataOut := rdwrPort }
  }
}

class bi_phase_encoder() extends Module {
  val io = IO(new Bundle {
    val DATA_OUT      = Output(UInt(1.W))
    val AUDIOINPUT    = Input (UInt(64.W))
    val DSPINPUT      = Input (UInt(64.W))
    val ENA           = Input (UInt(1.W))
    val NEXT          = Output(UInt(1.W))
  })
    val outReg        = RegInit(0.U(1.W))
    val next          = RegInit(0.U(1.W))
    val stereoData    = RegInit(0.U(64.W))
    val dspData       = RegInit(0.U(16.W))
    val dspData2      = RegInit(0.U(64.W))
    val bitCntr_enc   = RegInit(0.U(8.W))
    val hasNone       = RegInit(0.U(1.W))
    val holdState     = RegInit(0.U(1.W))
    val dataIndex     = RegInit(0.U(6.W))

    io.DATA_OUT := outReg
    // Every new frame, dump data into the Audio register. 
    stereoData  := io.AUDIOINPUT
    dspData     := io.DSPINPUT
    dspData2    := 0.U
    io.NEXT     := next
    // Flip reg. for creating the "data_index".
    val ndexR         = RegInit(0.U(1.W))    

      // bitCntr_enc = BCLK x 2

    when(io.ENA === 1.U){

        // Syncword = 0001 < the header bits
        when(bitCntr_enc === 6.U){  // b4
          // Set the one
          outReg := ~outReg
        }
        when(bitCntr_enc === 7.U){  // b4
          outReg := ~outReg
        }

          // Append audio data
          when((bitCntr_enc > 7.U)){

          // Count the number of serial data bits. (half rate of bitCntr_enc)
          ndexR := ~ndexR
          when(ndexR === 1.U){
            // Dataindex <-> Bitcount
            dataIndex := dataIndex + 1.U
          }

          holdState := 0.U
          // Up to 2 x 24 bits (offset by the header width (4bit, 8 cycles), hence 56)
          when(bitCntr_enc < 56.U){ // b5..29
              // 64th bit - current bit count - 4Bit header
            when((stereoData(64.U - (dataIndex + 1.U)))  === 0.U) {
              // Then don't change for one cycle
              hasNone := 1.U
            }
          }
          when((bitCntr_enc >= 56.U) & (bitCntr_enc < 105.U)){
            // 64th bit - current bit count - previous 24Bit - 4Bit header
            when((stereoData((64.U - (dataIndex - 23.U))))  === 0.U) {
              // Then don't change for one cycle
              hasNone := 1.U
            }              

          } // Append DSP data
          when((bitCntr_enc >= 105.U) & (bitCntr_enc < 129.U)){
              /*
                  DSP 
              */
              when((dspData((dataIndex - 48.U)))  === 0.U) {
              // Then don't change for one cycle
              hasNone := 1.U
            }

          }
          when((bitCntr_enc >= 127.U) & (bitCntr_enc < 255.U)){
              /*
                  DSP 
              */
              when((dspData2((dataIndex - 60.U)))  === 0.U) {
              // Then don't change for one cycle
              hasNone := 1.U
            }

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

        when(bitCntr_enc === 255.U){
          bitCntr_enc := 0.U
          dataIndex := 0.U
          //next := 1.U
        }

        // Count bits
        bitCntr_enc := bitCntr_enc + 1.U
    }
}

class interVox_Encoder(width: UInt) extends Module {
  val io = IO(new Bundle {
    val MCLK_O    = Output(Clock())     // 256 x fs
    val BCLK_IN   = Input (UInt(1.W))   //  64 x fs
    val LRCLK_IN  = Input (UInt(1.W))   //       fs  
    val SDATA_IN  = Input (UInt(1.W))
    val DATA_O    = Output(UInt(1.W))
    val LRCLK_O   = Output(UInt(1.W))    
    val BCLK_O    = Output(UInt(1.W))  
    val SDATA_O   = Output(UInt(1.W))
    val NXT_FRAME = Output(UInt(1.W))      
  })

  // Define state enum.. case sentitive!
  val state_Reset :: state_Setup :: state_Transmit :: Nil = Enum(3)
  val current_state     = RegInit(state_Reset)  
  // Bi-phase clock counter register.
  val BiPhase_CLK_CNTR  = RegInit(0.U(8.W))
  // Output register
  val DATA_OUT_REG_1B   = RegInit(0.U(1.W)) 
  // Frame register. Notifies the Bi_phase_encoder
  val FirstFrame        = RegInit(0.U(1.W))   
  // Synchronisatoin register. Ensure that we start switching on rising LRCLK
  val synced            = RegInit(0.U(1.W))    
  // Flip reg. for creating the bi-phase encoder clock
  val bclkR             = RegInit(1.U(1.W))      
  // Instantiate bi-phase encoder
  val bi_phase_enc      = Module(new bi_phase_encoder())
  // Define the bitcounter
  val bitCntr           = RegInit(0.U(8.W))
  // Define the buffers
  val BFR               = Module(new RWSmem())
  val BFR1              = Module(new RWSmem())

  // Assign pins. 
  io.DATA_O             := bi_phase_enc.io.DATA_OUT
  io.MCLK_O             := clock
  io.BCLK_O             := io.BCLK_IN 
  io.LRCLK_O            := io.LRCLK_IN 
  io.SDATA_O            := io.SDATA_IN

  // Define buffer default behaviour.
  BFR.io.enable         := 1.U
  BFR.io.addr           := 1.U
  BFR.io.write          := 0.U
  BFR.io.dataIn         := 0.U
  BFR1.io.enable        := 1.U
  BFR1.io.addr          := 1.U
  BFR1.io.write         := 0.U
  BFR1.io.dataIn        := BFR.io.dataOut

  // For debugging: output the bi_phase_enc enable signal. 
  io.NXT_FRAME                := bi_phase_enc.io.ENA

  // Get the bi-phase encoder ready
  bi_phase_enc.io.ENA         := 0.U
  // Always feed the bi-phase with the delayed repacked data (BFR1)
  bi_phase_enc.io.AUDIOINPUT  := BFR1.io.dataOut
  // Hardcode DSP data.
  bi_phase_enc.io.DSPINPUT    := 0.U 

  /*
      Functional overview:

      For every frame (ie. LRCLK = ~LRCLK)
      Populate a 32b register with the incoming sdata (offset adequitely). 
      Pad this register with header and DSP data

      { {HEADER + L_CH 24B} + {R_CH 24B + DSP} }
  */

  /*
      In & Out switching synchronizer: 
      We want the output encoded data to always follow the incoming data.
  */

  when(synced === 0.U){

    BiPhase_CLK_CNTR := BiPhase_CLK_CNTR + 1.U

    when(BiPhase_CLK_CNTR === 3.U){
      BiPhase_CLK_CNTR := 0.U

      when(io.LRCLK_IN === 1.U){
        bitCntr := 0.U
      }

      when(io.LRCLK_IN === 0.U){
        // Count clock on the low periode of LRCLK, 
        // inorder to determine when it rises.
        bitCntr := bitCntr + 1.U
        
        when(bitCntr === 31.U){
          bitCntr := 0.U
          synced := 1.U
        }
      }
    }
  }

  /*
      Main encoder logic: 
      Receive incoming serial I2S data and repackage it into a buffer, 
      from which the bi-phase mark encoder will read.
  */
  

  switch(current_state){
          
    is(state_Reset){
      // Todo, reset state.
      current_state := state_Transmit
    }
    is(state_Setup){
      // Setup state will take care of initializing receiver units, and assigning them unique adresses.
      current_state := state_Transmit
    }
    is(state_Transmit){
      
      when(synced === 1.U){ 

        /*         
            I2S "Reciever"
        */

        // Initialize BiPhase Encoder
        bi_phase_enc.io.ENA := 1.U
        BiPhase_CLK_CNTR := BiPhase_CLK_CNTR + 1.U

        when(BiPhase_CLK_CNTR === 3.U){
          BiPhase_CLK_CNTR := 0.U
          
          // Count I2S bits
          bitCntr := bitCntr + 1.U          

          // For each bit, assign it the appropriate bit in the buffer
          // Effectively 'repackaging' the I2S Serial data for use with intervox.          
          when(bitCntr === 0.U){
            // Clear Buffer. 
            BFR.io.write      := 1.U
            BFR.io.dataIn     := 0.U
          }
          
          // Record the incoming bits at f=BCLK          
          when(bitCntr > 31.U){
            // Truncate the last 8 bits of a 32 bit word. of the second audio channel data.
            // Limits the incoming data to 24 bit, purposely. 
            
            // Enable buffer write
            BFR.io.write      := 1.U

            when(io.SDATA_IN === 0.U){             
              // 64 (Reverse MSB/LSB) - Offset by the truncated 8 Bits (64 + 8) - CurrentBit
              BFR.io.dataIn     := BFR.io.dataOut + (0.U << (72.U - bitCntr))
            }

            when(io.SDATA_IN === 1.U){              
              BFR.io.dataIn     := BFR.io.dataOut + (1.U << (72.U  - bitCntr))
            }
          }.otherwise{
            // Truncate the last 8 bits of a 32 bit word. of the first audio channel data.
            // Limits the incoming data to 24 bit, purposely.             

            BFR.io.write      := 1.U            

            when(io.SDATA_IN === 0.U) {
              // 64 - (Reverse MSB/LSB) - CurrentBit
              BFR.io.dataIn     := BFR.io.dataOut + (0.U << (64.U - bitCntr))
            }

            when(io.SDATA_IN === 1.U){
              BFR.io.dataIn     := BFR.io.dataOut + (1.U << (64.U - bitCntr))
            }          
          }        

          when(bitCntr === 63.U){
            // Allows for one sample delay between input and interVox output. 
            // Dump BFR 0 into BFR 1
            BFR.io.write      := 0.U
            BFR1.io.write     := 1.U
            BFR1.io.dataIn    := BFR.io.dataOut

            // Clear buffer
            BFR.io.write   := 1.U
            BFR.io.dataIn  := 0.U

            bitCntr := 0.U
          }  
        }
      }        
    }
  }
}

object HelloMain extends App {
  println(".. I will now generate the Verilog file!")
  emitVerilog(new interVox_Encoder(32.U))
}
