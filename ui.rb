#!/usr/bin/ruby -w
# ui.rb

require "user_manager"

class Ui
    def initialize()
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
    #0.Exit
    def meniu1
      puts "1.Create user\n2.Login\n0.Exit"
      n = gets.to_i
      if !(n>0 && n<3) then
        n = -1 #out of bounds error
      end
      return n;
    end
    
    #Console Meniu2
    #Username: 
    #Password:
    def meniu2
      puts "Username:"
      u = gets
      puts "Password:"
      p = gets
      
      usr = User_manager.new.add_user(u,p)

      if usr == nil
        puts "Error: User already exists";
        return -1;
      end
      puts "Successfuly created!"  
      return 0;
    end
    
    #Console Meniu3
    #Username:
    #Password:
    def meniu3
      puts "Username:"
      u = gets
      puts "Password:"
      p = gets
      
      if !(check_login_info(u,p) > 0)
        return -1;
      end
      meniu4
    end
    
    def check_login_info(username, password)
      puts "Error: wrong username or password!"
      return -1
    end
    
    #Console Meniu4
    def meniu4
      puts "1.Edit Your info"
      puts "2.Autos"
      puts "3.Customers"
      puts "0.Exit"
      n = gets.to_i
       
    end
end