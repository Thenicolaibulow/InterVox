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
    val expected_cycles_syncword = (32.U * 4.U) - 1.U   // Syncword is 4 bit, hence * 4. 
    val expected_cycles_zero = 64.U - 1.U               // A transmitted zero will be sent @ BCLK = 3072MHz = ~sysclk/32.
    val expected_cycles_one = 32.U - 1.U                // A transmitted one will be sent @ BCLK*2 = 6144MHz = ~sysclk/16.

    val clkCntr     = RegInit(0.U(8.W))
    val pllCntr     = RegInit(0.U(8.W))
    val inState     = RegInit(0.U(1.W))
    val prevInState = RegInit(0.U(1.W))
    val inStateWas  = RegInit(0.U(1.W))
    val outReg      = RegInit(0.U(1.W))
    val dataOut     = RegInit(0.U(1.W)) 
    val nextFrame   = RegInit(0.U(1.W))
    val noChange    = RegInit(0.U(1.W))

    io.CLK_OUT      := outReg
    io.DATA_OUT     := dataOut
    io.NEXT_FRAME   := nextFrame

    pllCntr := pllCntr + 1.U
    when(pllCntr === 7.U){      // (pllCntr === 3.U) = PLL_MCLK = 6.143 MHz | (pllCntr === 15.U) = PLL_MCLK = x... | (pllCntr === 7.U) = PLL_MCLK = 3.071 MHz
        outReg := ~outReg
        pllCntr := 0.U
    }

    // On incoming data
    switch(io.DATA_IN){
        // If 0
        is(0.U){
            // If incoming was just high
            when((inState === 1.U)){
                // Then update state
                inState := 0.U
            }
            // Else, just increment the clock counter
            clkCntr := clkCntr + 1.U
        }
        is(1.U){
            // If incoming was just low
            when(inState === 0.U){
                // Then update state
                inState := 1.U
            }          
            // Else, just increment the clock counter
            clkCntr := clkCntr + 1.U
        }
    }
    // Detect Syncword
    when(clkCntr >= (expected_cycles_syncword - 16.U)){
        // Detect the rising edge
        when(inState === 1.U){
            // New frame incoming
            nextFrame := 1.U
        }   
        when(clkCntr >= (expected_cycles_syncword)){
            // Sync Word over, Reset cntr. 
            clkCntr := 0.U    
        }
    }
    // Detect changes in incoming data 
    // (Always check in the middle of a cycle (16 | 48), since this is where we'd expect the change.)
    when(clkCntr === 16.U || clkCntr === 48.U){
        // If we for 16 cycles didn't see a change:
        when(inState === io.DATA_IN){
            // Then flag noChange
            noChange := 1.U
        }
        // If we on the 16th cycle saw a change:
        when(inState === ~io.DATA_IN){
            // Then unflag noChange
            noChange := 0.U
        }        
    }
    // If the counter reaches expected length of a one:
    when(clkCntr === expected_cycles_one){        
        // If there was a change within the last 32 cycles (expected length of one)
        when(noChange === 0.U){
            // Then note the one, and reset the clock counter.
            dataOut := 1.U
            clkCntr := 0.U
        }
    }
    // If the counter reaches beyond the expected length of a one:
    when(clkCntr > expected_cycles_one){
        // If there was no change in the last 32 cycles (expected length of one)
        when(noChange === 1.U){        
            // Then we must have received a zero. Note that..
            dataOut := 0.U
        }

        when(clkCntr === expected_cycles_zero){
            // Reset counter, when it reaches the length of a zero (64 cycles)
            clkCntr := 0.U
        }        
    }    
    // Always flip clock
    /*when((clkCntr === 15.U) || (clkCntr === 31.U) || (clkCntr === 47.U) || (clkCntr === 63.U)){
        outReg := ~outReg
    }*/
 
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
