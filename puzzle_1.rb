require "i2c/drivers/ss1602"

class LCD
  def initialize
    @dis = I2C::Drivers::SS1602::Display.new("/dev/i2c-1", 0x27)
    @m = 4
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

lcd1 = LCD.new()
lcd1.text_inicial()
lcd1.lect_teclat()
