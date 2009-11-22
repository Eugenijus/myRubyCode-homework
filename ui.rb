#!/usr/bin/ruby -w
# ui.rb

require "user_manager"
require "auto_manager"
require "client_manager"
require "order_manager"
  
class Ui
  attr_reader :um, :am, :cm, :om
  
  def initialize()
      @um = User_manager.new
      @am = Auto_manager.new
      @cm = Client_manager.new
      @om = Order_manager.new
      run
  end
    
  def run
      i = 1
      while i!=0 do
        j = meniu1()
        if !(j>0) then
          i = 0
        end
        
        while j>0 do
          case j
          when 1
            j = meniu2()
          when 2
            j = meniu3()
          when 3
            @um.print_users
            j = 0 
          else
            j = 0
          end #end of case
        end #end of while
      end #end of while
      puts "Bye!"
    end #end of run
    
    #Console
    #1.Create user
    #2.Login
    #3.Print all users
    #0.Exit
    def meniu1
      puts "1.Create user\n2.Login\n3.Print all users\n0.Exit"
      n = gets.to_i
      if !(n>0 && n<4) then
        n = -1 #out of bounds error
      end
      return n;
    end
    
    #Creates a new User
    #Console Meniu2
    #Username:
    #Password:
    #Name:
    #Lastname:
    def meniu2
      u = get_console_string("Username:")
      p = get_console_string("Password:")
      n = get_console_string("Name:")
      l = get_console_string("Lastname:")
      
      usr = @um.add_user(u,p,n,l)

      if usr == nil
        puts "Error: User already exists";
        return -1;
      end
      print "Successfuly created User: "
      puts usr.username
      return 0;
    end
    
    #Login
    #Console Meniu3
    #Username:
    #Password:
    def meniu3
      u = get_console_string("Username:")
      p = get_console_string("Password:")
      
      if check_login_info(u,p) == -1
        return -1;
      end
      meniu4
    end
    
    def check_login_info(username, password)
      usr = @um.find_user(username)
      if usr != nil
        if usr.password == password
          return 0;
        end
      end
      puts "Error: wrong username or password!"
      return -1
    end
    
    #User is loged in, Main Meniu
    #Console Meniu4
    def meniu4
      n = 1
      
      while(n>0) do
        puts "1.Edit Your info"
        puts "2.Autos"
        puts "3.Clients"
        puts "4.Orders"
        puts "0.Go back"
        n = gets.to_i
        case n  
        when 1:
          n = 1
        when 2:
          n = autos_meniu()    
        when 3:
          n = clients_meniu()
        when 4:
          n = 1
        else
          n = 0      
        end
              end
      
      return 0;
    end
    
    def autos_meniu()
      puts "1.Add"
      puts "2.View all Cars"
      #puts "3.Edit"
      #puts "4.Delete"
      puts "0.Go back"
      
      n = gets.to_i
      # range n can be 0 or 1
      case n
      when 1:
        reg_num = get_console_string("Registration Number:")
        brand = get_console_string("Brand:")
        model = get_console_string("Model:")
        puts("Type: [Select number]")
        i = 1
        at = Auto_types.new
        at.types.each do |t|
          print i
          print "."
          print t
          print " "
          i=i+1
        end
        type = gets.to_i-1
        puts at.types[type]
        color = get_console_string("Color:")
        @am.add_car(reg_num, brand, model, type, color)
        puts "Successfuly added car!"
        return 1      
      when 2:
        @am.print_cars
        puts ""
        return 1
      when 0:
        return 1
      else
        return -1        
      end
      return 0;
    end
    
    def clients_meniu
      puts "1.Add"
      puts "2.View all Clients"
      #puts "3.Edit"
      #puts "4.Delete"
      puts "0.Go back"
      
      n = gets.to_i
      case n
      when 1:
        name = get_console_string("Name: ")
        lastname = get_console_string("Lastname: ")
        phone_num = get_console_string("Phone num.: ")
        soc_id = get_console_string("Social id.: ")
        driving_license_id = get_console_string("Driving License id.: ")
        @cm.add_client(name, lastname, phone_num, soc_id, driving_license_id)
        puts "Successfuly added client!"
        return 1      
      when 2:
        @cm.print_clients
        puts ""
        return 1
      when 0:
        return 1
      else
        return -1        
      end        
      return 0;            
    end
    
    def orders_meniu
      puts "1.Add"
      puts "2.View all Orders"
      #puts "3.Edit"
      #puts "4.Delete"
      puts "0.Go back"
      
      n = gets.to_i
      case n
      when 1:
        return 1
	#order has few dependencies
	pickup_date = get_console_string("Pickup Date: ")
        return_date = get_console_string("Return Date: ")
        
        auto_id = get_console_string("Auto id: ")
        garage_id = get_console_string("Garage id: ")
        client_id = get_console_string("Client id: ")
        @om.add_order(pickup_date, return_date, auto_id, garage_id, client_id)
        puts "Successfuly added order!"
        return 1      
      when 2:
        @om.print_orders
        puts ""
        return 1
      when 0:
        return 1
      else
        return -1        
      end        
      return 0; 
    end
    
    def return_date(msg)
      puts msg
      str = ""
      str = gets
      str.chomp!
      return str
    end
end
