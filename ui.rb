#!/usr/bin/ruby -w
# ui.rb

require 'user_manager'
require 'auto_manager'
require 'client_manager'
require 'order_manager'
require 'bill_manager'
require 'garage'
require 'rate_bl'
#require 'date_time_bl'
  
class Ui
  attr_reader :um, :am, :cm, :om, :bm, :garage, :rate_bl, :date_time_bl, :this_year, :this_month
  
  def initialize()
      @um = User_manager.new
      @am = Auto_manager.new
      @cm = Client_manager.new
      @om = Order_manager.new
      @bm = Bill_manager.new
      @rate_bl = Rate_bl.new
      
      @this_year = Time.now.year
      @this_month = Time.now.month

      #@date_time_bl = Date_time_bl.new
      @garage = Garage.new("124 Ruby road", "10211 New York, USA", "123456543")
      run
  end
    
  def run
      i = 1
      while i!=0 do
        j = welcome_meniu()
        if !(j>0) then
          i = 0
        end
        
        while j>0 do
          case j
          when 1
            j = create_user()
          when 2
            j = login()
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
    def welcome_meniu
      puts ""
      puts "Welcome to car rent app!"
      puts ""
      puts "1.Create user\n2.Login\n3.Print all users\n0.Exit"
      n = gets.to_i
      if !(n>0 && n<4) then
        n = -1 #out of bounds error
      end
      return n;
    end
    
    #Creates a new User
    #Console create_user
    #Username:
    #Password:
    #Name:
    #Lastname:
    def create_user
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
    #Console login
    #Username:
    #Password:
    def login
      u = get_console_string("Username:")
      p = get_console_string("Password:")
      
      if check_login_info(u,p) == -1
        return -1;
      end
      main_meniu
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
    #Console main_meniu
    def main_meniu
      n = 1
      
      while(n>0) do
        puts "1.Edit Your info"
        puts "2.Autos"
        puts "3.Clients"
        puts "4.Orders"
        puts "5.Bills"
        puts "0.Go back"
        n = gets.to_i
        case n  
        when 1:
          n = 1
        when 2:
          n = autos_meniu 
        when 3:
          n = clients_meniu
        when 4:
          n = orders_meniu
        when 5:
          n = bills_meniu
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
        #if user enters 1, then we take 0th element from array
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
        #order has few dependencies
        pickup_time = get_console_date_and_time("Pickup Date and Time:")
        if pickup_time == nil
          return 1
        end
        return_time = get_console_date_and_time("Return Date and Time: ")
        if return_time == nil
          return 1
        end
        #choose garage
        puts @garage.to_string
        garage_id = get_console_int("Garage id: ")
        if garage_id != @garage.garage_id
          return 1
        end
        #print all cars
        if @am.print_cars == -1 then
          return 1
        end
        auto_id = get_console_int("Auto id: ")
        #print all clients
        if @cm.print_clients == -1 then
          return 1
        end
        client_id = get_console_int("Client id: ")
        o = @om.add_order(pickup_time, return_time, auto_id, garage_id, client_id)
        if o != nil then
          puts "Successfuly added order!"
          if @cm.add_order(o.order_id, client_id) == -1 then
            puts "Couldn't write order_id to client obj."
          end
        end
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
    
    def bills_meniu
      puts "1.Add"
      puts "2.View all Bills"
      puts "3.Print Bill"
      #puts "4.Delete"
      puts "0.Go back"
      
      n = gets.to_i
      case n
      when 1:
        if @om.print_orders == -1 then
          return 1
        end
        order_id = get_console_int("Choose Order id: ")
        order_obj = @om.find_order_by_id(order_id)
        rate = count_rate(order_obj)
        if order_obj != nil and rate != nil then
          b = @bm.add_bill(order_obj,rate)
          if b != nil then
            puts "Successfuly added bill!"
            @om.delete_order(order_id)
            puts "Order #{order_id} was deleted!"
          end
        end
        
        return 1      
      when 2:
        if @bm.print_bills != -1 then
            puts ""
            return 1
        end
        
        return 1       
      when 3:
        if @bm.print_bills != -1 then
            puts ""
            bill_id = get_console_int("Choose Bill id: ")
            b_info = @bm.get_bill_info(bill_id)
            if b_info != nil then 
              puts b_info
              return 1
            end
            puts "Sorry that bill doesn't exist!"
            return 1
        end
        return 1
      when 0:
        return 1
      else
        return -1        
      end        
      return 0;
    end
    
    def count_rate(order_obj)
      auto_obj = @am.find_car_by_id(order_obj.auto_id)
      @rate_bl.count_rate(auto_obj.type)
      rate = @rate_bl.rate
      if rate!= 0 then
        return rate
      end
      return nil
    end
    
    def get_console_date_and_time(msg)
      puts msg
      y = get_console_int("Year:")
      if check_year(y) == false then
        puts "Error: wrong Year parameter"
        return nil
      end
      m = get_console_int("Month:")
      if check_month(m) == false then
        puts "Error: wrong Month parameter"
          return nil
      end

      d = get_console_int("Day:")
      if check_day(d) == false then
        puts "Error: wrong Day parameter"
          return nil
      end
      
      h = get_console_int("Hours:")
      if check_hour(h) == false then
        puts "Error: wrong Hours parameter"
          return nil
      end
      mins = get_console_int("Minutes:")
      if check_mins(mins) == false then
          puts "Error: wrong Minutes  parameter"
          return nil
      end
      
      begin
        time1 = Time.mktime(y,m,d,h,mins)
      rescue
        puts "Error: wrong date or time"
        return nil
      end
      return time1
    end

#=== start of date and time checkers

  def check_year(year)
    if year.class != Fixnum then
      puts "year should be a number"
      return false
    end
    
    if year < @this_year then
      puts "year is before 2009"
      return false
    end

    if year > (@this_year+10) then
      puts "year should be before #{@this_year+10}"
      return false
    end

    return true
  end

  def check_month(month)
    if month.class != Fixnum then
      puts "month #{month} should be a number, not #{month.class}"
      return false
    end

    if month > 12 or month < 1 then
      puts "month should be in range 1..12"
      return false
    end
    
    return true
  end
  
  def check_day(day)
    if check_if_num(day) == false then
      puts "day #{day} should be a number, not #{day.class}"
      return false
    end

    if day > 31 or day < 1 then
      puts "day should be in range 1..31"
      return false
    end
    return true
  end

  def check_hour(hour)
    if check_if_num(hour) == false then
      puts "day #{hour} should be a number, not #{hour.class}"
      return false
    end
  
    if hour < 0 or hour > 23 then
      puts "day should be in range 0..23"
      return false
    end
    return true
  end

  def check_mins(mins)
    if check_if_num(mins) == false then
      puts "day #{mins} should be a number, not #{mins.class}"
      return false
    end
  
    if mins < 0 or mins > 59 then
      puts "day should be in range 0..59"
      return false
    end
    return true
  end

  def check_if_num(num)
    if num.class != Fixnum then
      return false
    end
    return true
  end

#== end of date and time checkers
    
    def get_console_int(msg)
      print msg
      print " "
      i = gets.to_i
      if i.class == Fixnum
        return i
      end
      return nil
    end
    
    def get_console_string(msg)
      puts msg
      str = ""
      str = gets
      str.chomp!
      return str
    end
end
