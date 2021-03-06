require "i2c/drivers/ss1602"

#creating LCD class for our 20x04 LCD
class LCD
  def initialize
    @dis = I2C::Drivers::SS1602::Display.new("/dev/i2c-1", 0x27)
    @m = @dis.rows()  #number of rows of the display that has been set up on the display.rb file
    @n = []   #array
  end
  def lect_teclat
    @dis.clear
    @dis.text("        Nomes       ",0)
    @dis.text("         20         ",1)
    @dis.text("      caracters     ",2)
    @dis.text("      per linia     ",3)
    sleep(5)
    @dis.clear
    #This message will be shown on the display for a couple of seconds and then it will disappear, it's just a little test to be sure that the LCD works properly
    
    for i in (0..(@m - 1)) #we run from row 0..3 of the LCD Display
      begin
        text = gets.chomp  #text variable saves each line we write (gets method) until it finds a '\n'. Finally we don't store "\n" (chomp function)
       #if text exists then we store each character inside the array 
        if text           
          @n.push(text)
        end
      rescue EOFError
        break
      end
      @dis.clear
      for i in (0..@n.length() - 1) #we run @n array to place on our display each character that we have written on the shell 
        @dis.text(@n[i], i)
      end
      sleep(5)
    end
  end

def mostrar_IP
    
    #Improvements from the main program
    ip_add = Socket.ip_address_list[1].ip_address #it provides us an array with all the local IP addresses, but I just wanted the Rpi one.
    wireless = `iwgetid -r` #withe the following command I can get the WiFi's name. 
    @dis.text("Xarxa: ", 0)
    @dis.text(wireless, 1)
    sleep(1)
    @dis.text("IP Address RPi3: ", 2)
    @dis.text(ip_add,3)
    sleep(5)
    @dis.clear
   
    s = Socket.getaddrinfo('www.upc.edu', 'http') #Returns an array of arrays. Each subarray contains the address family, port number, host name, host IP address, protocol family, socket type, and protocol.
    @dis.text("This IP Address: ",0) # I've just focused on the host IP Address 
    @dis.text(s[0][3],1) #getaddrinfo provides many information but I just wanted the IP Address so I accessed where it was located that's the main reason why I access to [0][3] position
    sleep(1)
    
    @dis.text("Corresponds to: ",2)
    a = Socket.gethostbyname("147.83.2.135")  #this method provides a four-element array containing the host name, a subarray of host aliases, the address family, and the address portion of the sockaddr structure
    
    #this function returns an array with the host name, address family, and sockaddr component for the given address but I just wanted to get the host name to emphasize that the IP Address we've obtained before was correct
    url = Socket.gethostbyaddr[0](a[3], a[2]) #I access the first position of the array to get just the host name
    @dis.text(url,3) 
  end  
 end 

# Example of main: first we create a LCD object, then it will show us the previous messages of lect_teclat function and finally we will be able to write on our shell 
# whatever we want and it will be shown on the display 
lcd1 = LCD.new()
lcd1.lect_teclat()
lcd1.mostrar_IP()
