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
    val zeroClkFlp  = RegInit(0.U(1.W))

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
        when(inBufr < 3.U){     // 00 01 10 11
            inBufr := inBufr + 1.U
        }
    }
    when(io.DATA_IN === 0.U){   // 11 10 01 00   
        when(inBufr > 0.U){
            inBufr := inBufr - 1.U
        }
    }    

    /*
        Data Interpretor
    */

    when(change === 0.U){
        // Look for changes in the logged data:
        when(inBufr(0) =/= inBufr(1)){
            // Ensure that we don't do this check twice.
            change := 1.U
            when(clkCntr1 < 9.U){
                // Data 1
                lastOne := clkCntr1
                dataOut := 1.U
                zeroPeriode := 0.U
                syncWord := 0.U
                zeroClkFlp := 0.U
            }            
            clkCntr1 := 0.U
            clkDelta := clkCntr1              
        }
    }
    when((clkCntr1 >= 9.U) & (clkCntr1 < 16.U)){
        // Data 0
        dataOut := 0.U
        zeroPeriode := 1.U 
        syncWord := 0.U
        when(zeroClkFlp === 0.U){
            clkRec := ~clkRec
            zeroClkFlp := 1.U
        }
    }     
    when(clkCntr1 > 16.U){
        // Detect syncword.
        syncWord := 1.U
    }
    // When we're in a zero-periode, we can't rely on rising edges. 
    // Thus we rely on the last one-cycle cyclecounter to approximate when to flip the clk.
    when((zeroPeriode === 1.U) & (clkCntr1 === lastOne + 2.U)){
        // lastOne + 2.U, as we're always trailing 2 cycles behind the incoming data.
        clkRec := ~clkRec
    }     
    
    /*
        Clock regenerator
    */

    switch(change){
        is(1.U){
            when(whatChange >= 0.U){
                whatChange := whatChange - 1.U
            }    
        }
        is(0.U){
            when(whatChange < 3.U){
                whatChange := whatChange + 1.U
            }
        }
    }
    when(whatChange === 1.U){ // 01 < Earliest sign of a rising edge.
        clkRec := ~clkRec
    }
    when(whatChange === 2.U){ // 10 < Earliest sign of a trailing edge.
        //clkRec := ~clkRec
    }    
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
