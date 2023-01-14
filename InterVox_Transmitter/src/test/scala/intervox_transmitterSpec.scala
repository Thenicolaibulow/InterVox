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
    
      dut.clock.setTimeout(4)

      println("Testing I2S transmitter!")
      // Init system        

      //dut.clock.step(1)


      dut.io.LRCLK_IN.poke(1.U)
      for (i <- 0 until 6) {
        // 12 low cycles - purposely fuck shit up, 
        // to verify that the clk sync works
        dut.io.BCLK_IN.poke(1.U)    
        dut.clock.step(4)
        dut.io.BCLK_IN.poke(0.U)
        dut.clock.step(4)
        dut.io.SDATA_IN.poke(0.U)
        dut.io.BCLK_IN.poke(1.U)        
        dut.clock.step(4)    
        dut.io.BCLK_IN.poke(0.U)
        dut.clock.step(4)
      }
      /*
      dut.io.LRCLK_IN.poke(0.U)
      for (i <- 0 until 16) {
        // 32 low cycles
        dut.io.BCLK_IN.poke(1.U)           
        dut.clock.step(4)
        dut.io.BCLK_IN.poke(0.U)
        dut.clock.step(4)
        dut.io.SDATA_IN.poke(0.U)
        dut.io.BCLK_IN.poke(1.U)        
        dut.clock.step(4)    
        dut.io.BCLK_IN.poke(0.U)
        dut.clock.step(4)
      }      

      for(i <- 0 until 8){
        dut.io.LRCLK_IN.poke(1.U)
        for (i <- 0 until 1) {
          // First frame

          for (i <- 0 until 4) {
            // Eight high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)    
          }
          dut.io.SDATA_IN.poke(0.U)    
          for (i <- 0 until 2) {
            // Four low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }        
          for (i <- 0 until 4) {
            // Eight high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }
          dut.io.SDATA_IN.poke(0.U)    
          for (i <- 0 until 1) {
            // 2 low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }   
          for (i <- 0 until 1) {
            // Two high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)            
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }           
          for (i <- 0 until 4) {
            // 8 low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)            
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }                
          println("i: " + i)
        }
        dut.io.LRCLK_IN.poke(0.U)
        for (i <- 0 until 1) {
          // First frame

          for (i <- 0 until 4) {
            // Eight high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)            
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)    
          }
          dut.io.SDATA_IN.poke(0.U)    
          for (i <- 0 until 2) {
            // Four low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U) 
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }        
          for (i <- 0 until 2) {
            // Four high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }
          dut.io.SDATA_IN.poke(0.U)    
          for (i <- 0 until 8) {
            // Sixteen low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }        

          println("i: " + i)
        }      
        dut.io.LRCLK_IN.poke(1.U)
        for (i <- 0 until 1) {
          // First frame

          for (i <- 0 until 4) {
            // Eight high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)            
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)    
          }
          dut.io.SDATA_IN.poke(0.U)    
          for (i <- 0 until 2) {
            // Four low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U) 
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }        
          for (i <- 0 until 2) {
            // Four high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }
          dut.io.SDATA_IN.poke(0.U)    
          for (i <- 0 until 8) {
            // Sixteen low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }        

          println("i: " + i)
        }          
        dut.io.LRCLK_IN.poke(0.U)
        for (i <- 0 until 1) {
          // First frame

          for (i <- 0 until 4) {
            // Eight high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)    
          }
          dut.io.SDATA_IN.poke(0.U)    
          for (i <- 0 until 2) {
            // Four low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }        
          for (i <- 0 until 4) {
            // Eight high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }
          dut.io.SDATA_IN.poke(0.U)    
          for (i <- 0 until 1) {
            // 2 low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }   
          for (i <- 0 until 1) {
            // Two high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)            
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }           
          for (i <- 0 until 4) {
            // 8 low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)            
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }                
          println("i: " + i)
        }         
      }

      dut.io.LRCLK_IN.poke(1.U)
      for (i <- 0 until 16) {
        // 32 low cycles
        dut.io.BCLK_IN.poke(1.U)    
        dut.clock.step(4)
        dut.io.BCLK_IN.poke(0.U)
        dut.clock.step(4)
        dut.io.SDATA_IN.poke(0.U)
        dut.io.BCLK_IN.poke(1.U)        
        dut.clock.step(4)    
        dut.io.BCLK_IN.poke(0.U)
        dut.clock.step(4)
      }
      dut.io.LRCLK_IN.poke(0.U)
      for (i <- 0 until 16) {
        // 32 low cycles
        dut.io.BCLK_IN.poke(1.U)           
        dut.clock.step(4)
        dut.io.BCLK_IN.poke(0.U)
        dut.clock.step(4)
        dut.io.SDATA_IN.poke(0.U)
        dut.io.BCLK_IN.poke(1.U)        
        dut.clock.step(4)    
        dut.io.BCLK_IN.poke(0.U)
        dut.clock.step(4)
      }
      dut.io.LRCLK_IN.poke(1.U)
      for (i <- 0 until 16) {
        // 32 low cycles
        dut.io.BCLK_IN.poke(1.U)    
        dut.clock.step(4)
        dut.io.BCLK_IN.poke(0.U)
        dut.clock.step(4)
        dut.io.SDATA_IN.poke(0.U)
        dut.io.BCLK_IN.poke(1.U)        
        dut.clock.step(4)    
        dut.io.BCLK_IN.poke(0.U)
        dut.clock.step(4)
      }
      dut.io.LRCLK_IN.poke(0.U)
      for (i <- 0 until 16) {
        // 32 low cycles
        dut.io.BCLK_IN.poke(1.U)           
        dut.clock.step(4)
        dut.io.BCLK_IN.poke(0.U)
        dut.clock.step(4)
        dut.io.SDATA_IN.poke(0.U)
        dut.io.BCLK_IN.poke(1.U)        
        dut.clock.step(4)    
        dut.io.BCLK_IN.poke(0.U)
        dut.clock.step(4)
      }    
      */

      dut.io.LRCLK_IN.poke(0.U)
      for (i <- 0 until 16) {
        // 32 low cycles
        dut.io.BCLK_IN.poke(1.U)           
        dut.clock.step(4)
        dut.io.BCLK_IN.poke(0.U)
        dut.clock.step(4)
        dut.io.SDATA_IN.poke(0.U)
        dut.io.BCLK_IN.poke(1.U)        
        dut.clock.step(4)    
        dut.io.BCLK_IN.poke(0.U)
        dut.clock.step(4)
      }      

      for(i <- 0 until 8){
        dut.io.LRCLK_IN.poke(1.U)
        for (i <- 0 until 1) {
          // First frame
          for (i <- 0 until 1) {
            // Two high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)    
          }
          //dut.io.SDATA_IN.poke(0.U)    
          for (i <- 0 until 10) {
            // 20 low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }        

          for (i <- 0 until 1) {
            // Two high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)            
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }           
          for (i <- 0 until 4) {
            // 8 low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)            
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }                
          println("i: " + i)
        }
        dut.io.LRCLK_IN.poke(0.U)
        for (i <- 0 until 1) {
          // First frame
          for (i <- 0 until 1) {
            // Two high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)    
          }
          //dut.io.SDATA_IN.poke(0.U)    
          for (i <- 0 until 10) {
            // 20 low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }        

          for (i <- 0 until 1) {
            // Two high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)            
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }           
          for (i <- 0 until 4) {
            // 8 low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)            
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }                
          println("i: " + i)
        }      
        dut.io.LRCLK_IN.poke(1.U)
        for (i <- 0 until 1) {
          // First frame

          for (i <- 0 until 4) {
            // Eight high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)            
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)    
          }
          dut.io.SDATA_IN.poke(0.U)    
          for (i <- 0 until 2) {
            // Four low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U) 
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }        
          for (i <- 0 until 2) {
            // Four high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }
          dut.io.SDATA_IN.poke(0.U)    
          for (i <- 0 until 8) {
            // Sixteen low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }        

          println("i: " + i)
        }          
        dut.io.LRCLK_IN.poke(0.U)
        for (i <- 0 until 1) {
          // First frame

          for (i <- 0 until 4) {
            // Eight high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)    
          }
          dut.io.SDATA_IN.poke(0.U)    
          for (i <- 0 until 2) {
            // Four low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }        
          for (i <- 0 until 4) {
            // Eight high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }
          dut.io.SDATA_IN.poke(0.U)    
          for (i <- 0 until 1) {
            // 2 low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }   
          for (i <- 0 until 1) {
            // Two high cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(1.U)            
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }           
          for (i <- 0 until 4) {
            // 8 low cycles
            dut.io.BCLK_IN.poke(1.U)    
            dut.clock.step(4)
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
            dut.io.SDATA_IN.poke(0.U)            
            dut.io.BCLK_IN.poke(1.U)        
            dut.clock.step(4)    
            dut.io.BCLK_IN.poke(0.U)
            dut.clock.step(4)
          }                
          println("i: " + i)
        }         
      }


    }
  } 
}
