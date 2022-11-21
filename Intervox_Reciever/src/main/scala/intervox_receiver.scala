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
        val NEXT_FRAME  = Output (UInt(1.W))
    })

    // 100MHz MasterClock / Incoming (upto) 6.144 MHz = 16.27 CLK_CYCLES / Incoming Clock.
    // Ie. 16x oversampling should be possible.    

    val clkCntr     = RegInit(0.U(2.W))
    val clkCntr1    = RegInit(0.U(8.W))
    val clkDelta    = RegInit(0.U(8.W))
    val pllCntr     = RegInit(0.U(8.W))
    val inBufr      = RegInit(0.U(2.W))
 
    val outReg      = RegInit(0.U(1.W))
    val change      = RegInit(0.U(1.W))
    val nextFrame   = RegInit(0.U(1.W))

    io.CLK_OUT      := outReg
    io.DATA_OUT     := change
    io.NEXT_FRAME   := nextFrame

    // PLL Testing: 
    pllCntr := pllCntr + 1.U
    when(pllCntr === 7.U){
        // PLL_MCLK = 3.071 MHz
        // Works with both MMCM and PLL. MMCM actually looks to be more stable.      
        outReg := ~outReg
        pllCntr := 0.U
    }

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
    
    // Detect a syncword
    when((clkCntr1 > 32.U)){nextFrame := 0.U}    

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

    // Detect a 1
    when((clkDelta > 0.U) & (clkDelta < 10.U)){nextFrame := 1.U}
    // Detect a 0
    when((clkDelta > 10.U) & (clkDelta < 32.U)){nextFrame := 0.U}              

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
    io.NEXT_FRAME       := clockRec.io.NEXT_FRAME
    io.DBUG             := clockRec.io.CLK_OUT

    // Instantiate blackboxed PLL.
    val pll = Module(new clk_wiz_0_clk_wiz)   

    // Connect recovered clock reg to PLL input.
    pll.io.PLL_IN := clockRec.io.CLK_OUT

    // Once PLL is locked
    when(pll.io.locked === 1.U){
        io.CLK_REC := pll.io.PLL_MCLK
        io.DBUG1   := 1.U
    }
    .otherwise{
        io.CLK_REC := 0.U
        io.DBUG1   := 0.U
    }

    /*
  // Clock recovery

    // Should be a mux.. : 
    // Detect syncword
    when(intervox_in === 0)
        cycles++

    // Count sys-clk cycles between each rising edge
    when(intervox_in === 1)
        cycles++ 

    // When we've exceeded the amount of cycles expected for a syncword
    when (cycles > expected_periode_syncw)
        bit_cntr    := 0.U
        cycles      := 0.U

    // Determine if 1 | 0
    when(cycles >= expected_periode_0)

        when(cycles <  expected_periode_0){ 
            decoded_nxt := 1 
            bit_cntr++
        }
        when(cycles >= expected_periode_0){
            decoded_nxt := 0 
            bit_cntr++
        }

    when(bit_cntr === (64-4)) // (absolute framewidth) - (syncword width)
        ready_process := 1.U

  // Data extraction

    when(ready_process === 1.U){

        // Extract audio left and right data -> I2S transmitter
        // Extract CTRL_DATA. -> control logic.
        ready_process := 0.U
    }

    */
}

object HelloMain extends App {
  println("Hello World, I will now generate the Verilog file!")
  emitVerilog(new interVox_Reciever())
}
