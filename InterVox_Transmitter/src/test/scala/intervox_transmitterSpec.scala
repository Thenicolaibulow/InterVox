import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

import chisel3._
import chisel3.util._
import org.scalatest.{Matchers, FlatSpec}


class I2S_Periph_spec extends AnyFlatSpec with ChiselScalatestTester {
  val bitdepth = 32 
  "interVox_Encoder" should "pass" in {
    test(new interVox_Encoder(bitdepth.U))
      .withAnnotations(Seq(WriteVcdAnnotation)) { dut => 
    
      dut.clock.setTimeout(0)
      println("Testing I2S transmitter!")

      for (i <- 0 until 15) {
        //0 1 0 0 1 .. 0 1 0 0 1 .. 
        dut.io.SDATA_IN.poke(0.U)
        dut.clock.step(4)        
        dut.io.SDATA_IN.poke(1.U)
        dut.clock.step(4)       
        dut.io.SDATA_IN.poke(0.U)
        dut.clock.step(4)       
        dut.io.SDATA_IN.poke(0.U)
        dut.clock.step(4)     
        dut.io.SDATA_IN.poke(1.U)
        dut.clock.step(4)         

        println("i: " + i)
      }
    }
  } 
}
