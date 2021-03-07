require "i2c/drivers/ss1602"

#creating LCD class for our 20x04 LCD
class LCD
  def initialize
    @dis = I2C::Drivers::SS1602::Display.new("/dev/i2c-1", 0x27)
    @m = 4  #number of rows of the display
    @n = []
  end

  def text_inicial
    @dis.clear
    @dis.text("        Nomes       ",0)
    @dis.text("         20         ",1)
    @dis.text("      caracters     ",2)
    @dis.text("      per linia     ",3)
    sleep(5)
    @dis.clear
    #This message will be shown on the display for a couple of seconds and then it will disapear, it's just a little test to be sure that the LCD works properl
  end

  def lect_teclat
    for i in (0..(@m - 1))
      begin
        line = gets.chomp
        if line
          @n.push(line)
        end
      rescue EOFError
        break
      end
      @dis.clear
      for i in (0..@n.length() - 1)
        @dis.text(@n[i], i)
      end
    end
  end
end 

# Example of main: first we create a LCD object, then it will show us the previous messages of text_inicial function and finally we will be able to write on our shell 
# whatever we want and it will be shown on the display 
lcd1 = LCD.new()
lcd1.text_inicial()
lcd1.lect_teclat()
