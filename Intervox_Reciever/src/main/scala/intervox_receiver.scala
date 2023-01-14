import chisel3._
import chisel3.util._

// Include blackboxed PLL from vivado:
class clk_wiz_0_clk_wiz extends BlackBox with HasBlackBoxResource {
  // Class should have same name, as module in blackbox!
  val io = IO(new Bundle {
    val CLK_OUT  = Output(UInt(1.W))
    val locked    = Output(UInt(1.W))
    val CLK_IN    = Input (UInt(1.W))
  })
  addResource("/clk_wiz_0_clk_wiz.v")
}

class clock_Recovery() extends Module {
    val io = IO(new Bundle{
        val DATA_IN     = Input (UInt(1.W))
        val CLK_OUT     = Output (UInt(1.W))
        val DATA_OUT    = Output (UInt(1.W))
        val DBUG        = Output (UInt(1.W))
        val DBUG1       = Output (UInt(1.W))
        val LEDS        = Output (UInt(16.W))
    })

    val zero :: puls :: one :: Nil = Enum(3)

    val rising      = RegInit(zero)
    val trailing    = RegInit(zero)
    val lastOne     = RegInit(15.U(8.W))
    val overSampleCntr= RegInit(0.U(4.W))
    val inBufr      = RegInit(0.U(2.W))
    val deltaCntr   = RegInit(0.U(8.W))   
    val clkRec      = RegInit(0.U(1.W))
    val change      = RegInit(0.U(1.W))
    val dataOut     = RegInit(0.U(1.W))
    val syncWord    = RegInit(0.U(1.W))
    val zeroFlipped = RegInit(0.U(1.W))
    val syncFlipped = RegInit(0.U(1.W))
    val syncFlipped1= RegInit(0.U(1.W))



    io.CLK_OUT      := clkRec
    io.DATA_OUT     := dataOut
    io.DBUG         := change
    io.DBUG1        := syncWord
    io.LEDS         := lastOne

    deltaCntr    := deltaCntr + 1.U    

    /*
        EDGE DETECTION
    */  
    switch(io.DATA_IN){
        is(1.U){
            when(inBufr < 3.U){ // Rising  _/ = inBufr b01 -> b11
                // When rising, incriment inBufr.. looks like: 00 [Rising] 01
                inBufr := inBufr + 1.U
            }
        }
        is(0.U){
            when(inBufr > 0.U){ // Trailing  \_ = inBufr b10 -> b00
                // When trailing, decrment inBufr.. looks like: 11 [Trailing] 10
                inBufr := inBufr - 1.U
            }
        }        
    }
    when((inBufr(0)) ^ (inBufr(1))){    // Difference in input buffer? - Must be change. 
        change := 1.U
    }

    /*
        WHENEVER A CHANGE IS REGISTERED:
    */
    when(change === 1.U){
        // Ensure that 'change' will go low, two cycles from now.
        change := RegNext(RegNext(0.U, 0.U(1.W)), 0.U(1.W))
        // FLip the clock recovery register
        clkRec      := ~clkRec
        // Reset the delta counter (cycles since last change)
        deltaCntr   := 0.U        
        // Prepare for clock recovery during the coming zeros, and syncwords:
        zeroFlipped := 0.U
        syncFlipped := 0.U
        syncFlipped1:= 0.U
        syncWord := 0.U
    }
    
    /*
        DETECT A INCOMING 1
    */
    when((deltaCntr <= (lastOne + 1.U))){
        // We always assume the in coming data to be a 1 bit.
        // We are only sure if in incoming bit is infact a 1,
        when(change === 1.U){
            // If a change is present, whilst the deltacounter is smaller than
            // or equal to, our expected 1 cycles (lastOne) + 1.U (slack)
            dataOut := 1.U
            
            // Bring back lastOne := deltaCntr? ie. Dynamic 1 bit reference.
            //lastOne := deltaCntr
        }
    }

    /*
        DETECT A INCOMING 0
    */
    when((deltaCntr > (lastOne + 1.U)) & (deltaCntr < ((lastOne * 2.U) + 2.U))){
        // If the deltaCounter has surpassed the reference for a 1 bit.
        // Then we must have a zero.
        when(zeroFlipped === 0.U){
        // And will have to flip the clockregister by an approximation.
            // Flip Clock register, only once for this bit.   
            clkRec := ~clkRec
            zeroFlipped := 1.U
        }
        // Change data output.
        dataOut := 0.U
    }

    /*
        DETECT A SYNCWORD (header-bits)
          \ __ __ /\ _ /
    */
    when(change === 0.U){

        when(deltaCntr === ((lastOne * 2.U) + 2.U)){ // Add some slack: +2.U
            
            // \ __|__ /\ _ /          , where | is time at which the above is true.

            // If this is true, the deltaCounter has surpassed the reference
            // of an incoming zero. As such it must be a syncword:
            
            when(syncFlipped === 0.U){
                // Flip clk once
                clkRec := ~clkRec
                syncFlipped := 1.U
            }                    
        }    
        when(deltaCntr === ((lastOne * 3.U))){ // Add some slack: -4.U

            // \ __ _|_ /\ _ /          , where | is time at which the above is true.

            // One more clock reg flip is necessary inbetweeen syncWord detect,
            // and the incoming hardcoded 1 bit, in the syncWord / header-bits.

            syncWord := 1.U

            when(syncFlipped1 === 0.U){
                // Flip clk once
                clkRec := ~clkRec
                syncFlipped1 := 1.U
            }
        }            
    }
}


class interVox_Reciever() extends Module {
  val io = IO(new Bundle {
    val INTERVOX_IN = Input(UInt(1.W))
    val CLK_REC     = Output (UInt(1.W))
    val DATA_OUT    = Output (UInt(1.W))
    val CLK_DBUG    = Output (UInt(1.W))
    val DBUG        = Output (UInt(1.W))
    val DBUG1       = Output (UInt(1.W))
    val LEDS        = Output (UInt(16.W))
  })

    val clockRec = Module(new clock_Recovery())

    clockRec.io.DATA_IN := io.INTERVOX_IN

    io.LEDS             := clockRec.io.LEDS
    io.DATA_OUT         := clockRec.io.DATA_OUT
    io.CLK_DBUG         := clockRec.io.CLK_OUT
    io.DBUG1            := clockRec.io.DBUG1
    io.DBUG             := clockRec.io.DBUG

    // Instantiate blackboxed MMCM.
    // Input: 3.072 MHz, Output 6.144MHz, but configured as: 12.288MHz and 24.576 MHz... Doesn't seem to work, unfortunately.
    
    val pll = Module(new clk_wiz_0_clk_wiz)   

    // Connect recovered clock reg to PLL input.
    pll.io.CLK_IN := clockRec.io.CLK_OUT
    io.CLK_REC := pll.io.CLK_OUT 
}

object HelloMain extends App {
  println("Hello World, I will now generate the Verilog file!")
  emitVerilog(new interVox_Reciever())
}
