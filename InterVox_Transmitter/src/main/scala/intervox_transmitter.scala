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

class biPhaseEncoder() extends Module {
  val io = IO(new Bundle {
    val DATA_OUT      = Output(UInt(1.W))
    val AUDIOINPUT    = Input (UInt(64.W))
    val DSPINPUT      = Input (UInt(64.W))
    val ENA           = Input (UInt(1.W))
    val CLK           = Input (UInt(1.W))
  })
    val outReg        = RegInit(0.U(1.W))
    val stereoData    = RegInit(0.U(64.W))
    val dspData       = RegInit(0.U(16.W))
    val bitCntr_enc   = RegInit(0.U(8.W))
    val hasNone       = RegInit(0.U(1.W))
    val zeroFlip      = RegInit(0.U(1.W))
    val dataIndex     = RegInit(0.U(6.W))
    val ndexR         = RegInit(0.U(1.W))    
    val enabled       = RegInit(0.U(1.W))    

    io.DATA_OUT := outReg
    // Every new frame, dump data into the Audio register. 
    stereoData  := io.AUDIOINPUT
    dspData     := io.DSPINPUT
    enabled     := io.ENA

    // Clocked at BCLK x 2, or MCLK / 2
    when(io.CLK === 1.U){

      when(enabled === 1.U){ 
          
          // Count positions ie: 'half-bits'
          bitCntr_enc := bitCntr_enc + 1.U

          /* 
              SYNCWORD
              __ __ /\
              01 23 45            
          */

          // Bit 1:2
          when(bitCntr_enc === 3.U){          
            outReg := ~outReg
          }
          // Bit 3
          when(bitCntr_enc === 4.U){          
            outReg := ~outReg
          }
          when(bitCntr_enc === 5.U){          
            outReg := ~outReg
          }          

          
          when((bitCntr_enc > 5.U)){

            // Count the number of serial data bits. (half rate of bitCntr_enc)
            ndexR := ~ndexR
            when(ndexR === 1.U){
              // Dataindex <-> Bitcount
              dataIndex := dataIndex + 1.U
            }

            /*
                LEFT AUDIO DATA bit: 4:27
                _ _   ^ ^   _ ^   _ ^   _ _   ^ _   _ _  ...  _ _   _ ^   _ ^ 
                6 7   8 9  10 11 12 13 14 15 16 17 18 19     48 49 50 51 52 53
            */

            /*
            
            AUDIO BUFFERING         MSB           LSB MSB            LSB
            [Buffer = 64 bits] === [63, 62, 61... 39] [38, 37, 36... 14] [13, 12... 0]
                                      LEFT 24 Bits      Right 24 Bits       Don't care
            */  

            when(bitCntr_enc < 53.U){         
                // 64th bit - current bit count
                when(ndexR === 1.U){
                  when((stereoData(62.U - (dataIndex))) === 0.U) {
                    // If buffer bit is zero, then don't change for one cycle
                    hasNone := 1.U
                  }
                }
            }

            /*
              RIGHT 24 bit DATA:
              Bit 28:52
            */
            when((bitCntr_enc >= 53.U) & (bitCntr_enc < 101.U)){
              // 64th bit - current bit count - previous 24Bit
              when(ndexR === 1.U){
                when((stereoData((38.U - (dataIndex - 24.U)))) === 0.U) {
                  hasNone := 1.U               
                }
              }
            } 

            /*
              Append DSP data
              Bit 52:64
            */
            when((bitCntr_enc >= 101.U) & (bitCntr_enc <= 127.U)){
              when(ndexR === 1.U){
                when((dspData((dataIndex - 48.U)))  === 0.U) {
                  hasNone := 1.U
                }
              }
            } 

            /*
              BIPHASE ENCODING
            */


            when(hasNone === 1.U){
              // If a zero is encoded, don't change state.
              outReg := outReg
              hasNone := 0.U
            }
            .otherwise{
              // Otherwise, when a one is encoded, change state every cycle.
                outReg := ~outReg
            }
          }
          
          // Reset bitcounter
          when(bitCntr_enc === 127.U){
            bitCntr_enc := 0.U
            dataIndex := 0.U
            enabled := 0.U
          }          
      }      
    }
}

class edgeDetector() extends Module {
  val io = IO(new Bundle{
    val INPUT   = Input(UInt(1.W))
    val TRAIL   = Output(UInt(1.W))
    val RISE    = Output(UInt(1.W))
    val CHANGE  = Output(UInt(1.W))
  })

  val inBufr            = RegInit(0.U(2.W))
  val inBufrPrev        = RegInit(0.U(2.W))
  val trailing          = RegInit(0.U(1.W))  
  val rising            = RegInit(0.U(1.W))
  val change            = RegInit(0.U(1.W))
  val changed           = RegInit(0.U(1.W))

    /*
        EDGE DETECTION
    */  
    switch(io.INPUT){
      is(1.U){
        when(inBufr < 2.U){ // Rising  _/ = inBufr b01 -> b11
            // When rising, incriment inBufr.. looks like: 00 [Rising] 01
            inBufr      := inBufr + 1.U
            inBufrPrev  := inBufr
        }
      }
      is(0.U){
        when(inBufr > 0.U){ // Trailing  \_ = inBufr b10 -> b00
            // When trailing, decrment inBufr.. looks like: 11 [Trailing] 10
            inBufr      := inBufr - 1.U
            inBufrPrev  := inBufr
        }
      }        
    }

    when((inBufr(0)) ^ (inBufr(1))){ // Change
      change    := 1.U
    }        

    when((inBufrPrev === 0.U) & (inBufr === 1.U)){ // Rising
      trailing  := 0.U
      rising    := 1.U
    }

    when((inBufrPrev === 2.U) & (inBufr === 1.U)){ // Trailing
      trailing  := 1.U
      rising    := 0.U
    }

    when(trailing === 1.U){trailing := 0.U}
    when(rising === 1.U)  {rising   := 0.U}  
    
    when(change === 1.U){
      change   := RegNext(0.U)
    }

  io.CHANGE := change
  io.TRAIL  := trailing
  io.RISE   := rising
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
    val SW        = Input (UInt(16.W))  
    val LED       = Output(UInt(16.W))
    val BTN_C     = Input (UInt(1.W))
    val BTN_D     = Input (UInt(1.W))
    val BTN_L     = Input (UInt(1.W))
    val BTN_R     = Input (UInt(1.W))
  })

  // Define state enum.. case sentitive!
  val stateReset :: stateSetup :: stateTransmit :: Nil = Enum(3)
  val currentState     = RegInit(stateReset)  
  // Synchronisation register. Ensure that we start switching on rising LRCLK
  val syncing           = RegInit(0.U(1.W))    
  val synced            = RegInit(0.U(1.W))
  val biPhaseEna        = RegInit(0.U(1.W))

  // Debug:
  val leds              = RegInit(0.U(16.W))
  val left              = RegInit(0.U(16.W))
  val right             = RegInit(0.U(16.W))
  val dspData           = RegInit(0.U(16.W))
  // Flip reg. for creating the bi-phase encoder clock
  val bclkR             = RegInit(1.U(1.W))      
  // Clock divider register for encoder
  val encoderClk        = RegInit(0.U(1.W))  
  // Define the bitcounter
  val bitCntr           = RegInit(0.U(8.W))
  // Instantiate buffers
  val BFR               = Module(new RWSmem())
  val BFR1              = Module(new RWSmem()) 
  // Instantiate bi-phase encoder
  val biPhaseEncoder      = Module(new biPhaseEncoder())  
  // Instatiate the edge detectors.
  val LREDGE            = Module(new edgeDetector())
    LREDGE.io.INPUT     := io.LRCLK_IN
  val BCLKEDGE          = Module(new edgeDetector())
    BCLKEDGE.io.INPUT   := io.BCLK_IN 
  val DATAEDGE          = Module(new edgeDetector())
    DATAEDGE.io.INPUT   := io.SDATA_IN        

  // Assign pins. 
  io.DATA_O             := biPhaseEncoder.io.DATA_OUT
  io.MCLK_O             := clock
  io.BCLK_O             := io.BCLK_IN 
  io.LRCLK_O            := io.LRCLK_IN 
  io.SDATA_O            := io.SDATA_IN
  io.LED                := leds

  // Define buffer default behaviour.
  BFR.io.enable         := 1.U
  BFR.io.addr           := 1.U
  BFR.io.write          := 0.U
  BFR.io.dataIn         := 0.U
  BFR1.io.enable        := 1.U
  BFR1.io.addr          := 1.U
  BFR1.io.write         := 0.U
  BFR1.io.dataIn        := BFR.io.dataOut

  // For debugging: output the biPhaseEncoder trigger signal. 
  io.NXT_FRAME                  := BCLKEDGE.io.CHANGE
  // Get the bi-phase encoder ready
  biPhaseEncoder.io.CLK         := BCLKEDGE.io.CHANGE//encoderClk
  biPhaseEncoder.io.ENA         := biPhaseEna
  // Always feed the bi-phase with the delayed repacked data (BFR1)
  biPhaseEncoder.io.AUDIOINPUT  := BFR1.io.dataOut
  // Hardcode DSP data.
  biPhaseEncoder.io.DSPINPUT    := dspData

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
    
    when(LREDGE.io.TRAIL === 1.U){
      syncing := 1.U
    }  
    when(syncing  === 1.U){
      bitCntr     := bitCntr + 1.U

      when(LREDGE.io.RISE === 1.U){
        synced    := 1.U
        bitCntr   := 0.U
      }
    }
  }

  /*
      Main encoder logic: 
      Receive incoming serial I2S data and repackage it into a buffer, 
      from which the bi-phase mark encoder will read.
  */
  

  switch(currentState){
          
    is(stateReset){
      // Todo, reset state.
      currentState := stateTransmit
    }
    is(stateSetup){
      // Setup state will take care of initializing receiver units, and assigning them unique adresses.
      currentState := stateTransmit
    }
    is(stateTransmit){
      
      when((synced === 1.U)){  // ..And LRCLK.io.RISE === 1.U?

        /*         
            PLAYBACK MODE
        */
        
        // Clock the BiPhase Encoder at MCLK/2, or BCLK x2
        encoderClk := ~encoderClk

        // On rising edge of BCLK:
        when(BCLKEDGE.io.RISE === 1.U){
          
          // Initialize BiPhase Encoder
          biPhaseEna  := 1.U          
          
          // Count incoming I2S bits
          bitCntr := bitCntr + 1.U          

          /*
            
            AUDIO BUFFERING         MSB           LSB MSB            LSB
            [Buffer = 64 bits] === [63, 62, 61... 39] [38, 37, 36... 14] [13, 12... 0]
                                      LEFT 24 Bits      Right 24 Bits       Don't care
          */  

          // If not hardcoded sample is set
          when(io.SW === 0.U){
            // Record the incoming bits at f=BCLK          
            when(bitCntr > 31.U){
              
              // Enable buffer write
              BFR.io.write      := 1.U
              when((io.SDATA_IN === 0.U)){             
                // (63rd position - 24(Left bits)) - (current bit - the 32 left bits)
                // Truncate the last 8 bits of a 32 bit word (start at position 39, not 31). of the left audio channel data.
                // Limits the incoming data to 24 bit pr. channel, purposely. 
                BFR.io.dataIn     := BFR.io.dataOut | (0.U << (39.U - (bitCntr - 30.U)))
              }
              when((io.SDATA_IN === 1.U)){              
                BFR.io.dataIn     := BFR.io.dataOut | (1.U << (39.U  - (bitCntr - 30.U)))
              }
            }.otherwise{ 

              BFR.io.write      := 1.U            
              when((io.SDATA_IN === 0.U)) {
                // 63 (Most Left position in BFR) - current bit.
                // Left channel first.
                BFR.io.dataIn     := BFR.io.dataOut | (0.U << (63.U - (bitCntr + 1.U)))
              }
              when((io.SDATA_IN === 1.U)){
                BFR.io.dataIn     := BFR.io.dataOut | (1.U  << (63.U - (bitCntr + 1.U)))
              }          
            }        

 
          }.otherwise{
            BFR.io.write  := 1.U
            // Create a sample with custom data, based off the hardware switches on the basys3.
            // Repeat that 16bit uint for both left and right channel 

            // Set switches according to wanted bits, and..
            when(io.BTN_L === 1.U){
              // Press the left button for left channel
              left    := io.SW
              leds    := left
            }
            when(io.BTN_R === 1.U){
              // Press the right button for right channel
              right   := io.SW
              leds    := right
            }            
            when(io.BTN_C === 1.U){
              // Press the center button for controldata
              dspData := io.SW
              leds    := dspData
            }
            /*
              AUDIO BUFFERING        16 bit Left   8 bit      16 bit right      8 bit             Dont care
              [Buffer = 64 bits] === [63:48]      [47:40]       [39:24]        [23:16]          [15, 14... 0]
                                                                 
            */
            BFR.io.dataIn := (left << (47.U)) | (right << (23.U))
          }
 
          when(bitCntr === 63.U){ 
            // ^^ Should probably be triggered on LRCLK rising, but I'm unsure with the delay of the rising detect.

            // Dump buffer 0 into buffer 1
            BFR.io.write      := 0.U
            BFR1.io.write     := 1.U
            BFR1.io.dataIn     := BFR.io.dataOut            

            // Clear buffer 0.
            BFR.io.write   := 1.U
            BFR.io.dataIn  := 0.U

            // Assign leds to the buffer output.
            // We have to do some conversion, for it to show up properly.
            when(io.BTN_D === 1.U){
              // Press button down to see left channel buffered audio on the leds
              leds := (BFR1.io.dataOut >> 47.U) & (65535.U)
            }

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
