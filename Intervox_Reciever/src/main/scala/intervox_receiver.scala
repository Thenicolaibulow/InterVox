import chisel3._
import chisel3.util._

// Include blackboxed PLL from vivado:
class clk_wiz_0_clk_wiz extends BlackBox with HasBlackBoxResource {
  // Class should have same name, as module in blackbox!
  val io = IO(new Bundle {
    val PLL_MCLK  = Output(UInt(1.W))
    val locked    = Output(UInt(1.W))
    val PLL_IN    = Input (UInt(1.W))
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
    })

    // 100MHz MasterClock / Incoming (upto) 6.144 MHz = 16.27 CLK_CYCLES / Incoming Clock.
    // Ie. 16x oversampling should be possible.    

    val clkCntr     = RegInit(0.U(2.W))
    val clkCntr1    = RegInit(0.U(8.W))
    val clkCntr2    = RegInit(0.U(4.W))
    val clkCntr3    = RegInit(0.U(4.W))
    val clkDelta    = RegInit(0.U(8.W))
    val lastOne     = RegInit(7.U(8.W)) // Initially 7 (roughly 100MHz / 6.144MHz) - will be adjusted live, accordingly.
    val pllCntr     = RegInit(0.U(8.W))
    val inBufr      = RegInit(0.U(2.W))
    val whatChange  = RegInit(0.U(2.W))
 
    val outReg      = RegInit(0.U(1.W))
    val clkRec      = RegInit(0.U(1.W))
    val change      = RegInit(0.U(1.W))
    val dataOut     = RegInit(0.U(1.W))
    val nextFrame   = RegInit(0.U(1.W))
    val zeroPeriode = RegInit(0.U(1.W))
    val syncWord    = RegInit(0.U(1.W))

    io.CLK_OUT      := clkRec
    io.DATA_OUT     := dataOut
    io.DBUG         := zeroPeriode
    io.DBUG1        := change

    /*
        Rising/Trailing Edge detector.
    */

    // Increment oversample counter:
    clkCntr     := clkCntr + 1.U
    // Increment clock counter
    clkCntr1    := clkCntr1 + 1.U
    // Reset oversample counter
    when(clkCntr === 1.U){
        clkCntr := 0.U
        change := 0.U
    }
    // Log the changes in the input buffer register:
    when(io.DATA_IN === 1.U){    
        when(inBufr < 3.U){
            inBufr := inBufr + 1.U
        }
    }
    when(io.DATA_IN === 0.U){    
        when(inBufr > 0.U){
            inBufr := inBufr - 1.U
        }
    }    
    when(change === 0.U){
        // Look for changes in the logged data:
        when(inBufr(0) =/= inBufr(1)){
            change := 1.U
            clkCntr1 := 0.U
            clkDelta := clkCntr1
        }
    }

    /*
        Change Interpretor
    */

    // Detect a syncword (can be done prior to the buffered data)
    /*
    when((clkCntr1 > (14.U)) & (io.DATA_IN === 0.U)){
        syncWord := 1.U
    }
    */    

    when(clkCntr1 > 16.U){
        syncWord := 1.U
    }

    // Detect a 1
    when((clkDelta > 0.U) & (clkDelta < 10.U)){
        zeroPeriode := 0.U
        dataOut := 1.U
        when(zeroPeriode === 0.U){
            syncWord := 0.U
        }

        // How many cycles were between the last two changes?
        lastOne := clkDelta
        /*
            As a transmitted 1 will be the fastest two transitions
            the cycles between these two changes (in the single 1-bit)
            will determine the ratio between the local and incoming clock.
            This will be used to predict / reconstruct the clock in the 0-bit 
            periodes, where it switches at half the rate of the wanted clock.
        */
    }
    // Detect a 0
    when((clkDelta > 10.U) & (clkDelta < 16.U)){
        dataOut := 0.U
        when(zeroPeriode === 0.U){
            syncWord := 0.U
        }
    }  
    
    /*
        Clock regenerator
    */

    switch(change){
        is(1.U){
            clkCntr2 := clkCntr2 + 1.U
            when(whatChange >= 0.U){
                whatChange := whatChange - 1.U
            }   
        }
        is(0.U){
            whatChange := whatChange + 1.U

            clkCntr2 := clkCntr2 + 1.U
            when(clkCntr2 === lastOne - 1.U){
                clkCntr2    := 0.U
            }
        }
    }

    // On trailing edge of 'change'
    when((whatChange(0) === 1.U) & (whatChange(1) === 0.U)){
        // Reset counter
        when(clkCntr1 < lastOne){
            clkCntr2    := 0.U
        }            
    }

    // On rising edge of 'change'
    when(clkCntr1 < lastOne){
        when((whatChange(0) === 0.U) & (whatChange(1) === 1.U)){
            // FLip clk reg
            clkRec := ~clkRec    
            // Reset counter
            clkCntr3 := 0.U
            syncWord := 0.U
        }
    }



    when((clkCntr1 > lastOne)){  
        // As we, in a 'zero-bit' cycle have no rising edge (after about 7 cycles) 
        // - so we create this manually
        // Only do this, if we're in a 'zero-bit'..otherwise it causes trouble
        when((zeroPeriode === 0.U) & (clkCntr2 >= (lastOne / 2.U) + 1.U)){
            clkRec := ~clkRec
            clkCntr3 := 0.U
        } 
        zeroPeriode := 1.U 

        // in the case where we have a zero periode, 
        // and need to flip the clock for the second time, in that periode. 
        // ie. when we're halfway through (lastOne), but want the clk hi/lo periode to be lastOne / 2.
        /*when(clkCntr1 === ((2.U * lastOne) - (lastOne / 2.U) + 1.U)){
            clkRec := ~clkRec
        }*/
    }

    // Whenever we reach a syncWord the clock will be.. approximated..
    /*
    when(syncWord === 1.U){
        clkCntr3 := clkCntr3 + 1.U

        when(clkCntr3 === 0.U){
            clkRec := ~clkRec
        }
        when((clkCntr3 === (lastOne / 2.U))){
            clkCntr3 := 0.U
        }
    }
    */
}


class interVox_Reciever() extends Module {
  val io = IO(new Bundle {
    val INTERVOX_IN = Input(UInt(1.W))
    val CLK_REC     = Output (UInt(1.W))
    val DATA_OUT    = Output (UInt(1.W))
    val NEXT_FRAME  = Output (UInt(1.W))
    val DBUG        = Output (UInt(1.W))
    val DBUG1       = Output (UInt(1.W))
  })

    val clockRec = Module(new clock_Recovery())

    clockRec.io.DATA_IN := io.INTERVOX_IN
    io.DATA_OUT         := clockRec.io.DATA_OUT
    io.NEXT_FRAME       := clockRec.io.DBUG
    io.DBUG1            := clockRec.io.DBUG1
    io.DBUG             := clockRec.io.CLK_OUT

    // Instantiate blackboxed PLL.
    val pll = Module(new clk_wiz_0_clk_wiz)   

    // Connect recovered clock reg to PLL input.
    pll.io.PLL_IN := clockRec.io.CLK_OUT

    // Once PLL is locked
    when(pll.io.locked === 1.U){
        io.CLK_REC := pll.io.PLL_MCLK
    }
    .otherwise{
        io.CLK_REC := 0.U
    }

}

object HelloMain extends App {
  println("Hello World, I will now generate the Verilog file!")
  emitVerilog(new interVox_Reciever())
}
