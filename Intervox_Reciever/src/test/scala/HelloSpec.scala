import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

import chisel3._
import chisel3.util._
import org.scalatest.{Matchers, FlatSpec}


class interVox_Reciever_spec extends AnyFlatSpec with ChiselScalatestTester {
  "interVox_Reciever" should "pass" in {
    test(new interVox_Reciever())
      .withAnnotations(Seq(WriteVcdAnnotation)) { dut => 
    
      dut.clock.setTimeout(0)
      println("Testing InterVox receiver!")

      for (i <- 0 until 4) {
        /*
            SyncWord (4Bit) = bxxx0
        */

        dut.io.INTERVOX_IN.poke(0.U)
        dut.clock.step(16)  // #0
        dut.clock.step(16)  // #1
        dut.clock.step(16)  // #2
        dut.io.INTERVOX_IN.poke(1.U)
        dut.clock.step(16)  // #3
        dut.io.INTERVOX_IN.poke(0.U)

        /*
            2 x 24Bit Audio Data
        */  

        // Send 4 Ones
        for(j <- 0 until 4){

          dut.clock.step(8)
          dut.io.INTERVOX_IN.poke(1.U)
          dut.clock.step(8)
          dut.io.INTERVOX_IN.poke(0.U)
        }
        // Send 4 Zeros
        for(j <- 0 until 2){

          dut.clock.step(16)
          dut.io.INTERVOX_IN.poke(1.U)
          dut.clock.step(16)
          dut.io.INTERVOX_IN.poke(0.U)
        }    
        // Send 20 Ones
        for(j <- 0 until 20){

          dut.clock.step(8)
          dut.io.INTERVOX_IN.poke(1.U)
          dut.clock.step(8)
          dut.io.INTERVOX_IN.poke(0.U)
        }   
        // Send 4 Zeros
        for(j <- 0 until 2){

          dut.clock.step(16)
          dut.io.INTERVOX_IN.poke(1.U)
          dut.clock.step(16)
          dut.io.INTERVOX_IN.poke(0.U)
        }
        // Send 10 Ones
        for(j <- 0 until 10){

          dut.clock.step(8)
          dut.io.INTERVOX_IN.poke(1.U)
          dut.clock.step(8)
          dut.io.INTERVOX_IN.poke(0.U)
        }  
        // Send 4 Zeros
        for(j <- 0 until 2){

          dut.clock.step(16)
          dut.io.INTERVOX_IN.poke(1.U)
          dut.clock.step(16)
          dut.io.INTERVOX_IN.poke(0.U)
        }   
        // Send 2 Ones
        for(j <- 0 until 2){

          dut.clock.step(8)
          dut.io.INTERVOX_IN.poke(1.U)
          dut.clock.step(8)
          dut.io.INTERVOX_IN.poke(0.U)
        }           

        /*
            DSP DATA
        */

        // Send 12 Ones
        for(j <- 0 until 12){

          dut.clock.step(8)
          dut.io.INTERVOX_IN.poke(1.U)
          dut.clock.step(8)
          dut.io.INTERVOX_IN.poke(0.U)
        }                                                 

        println("i: " + i)
      }
    }
  } 
}