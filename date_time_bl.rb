#!/usr/bin/ruby -w
# date_time_bl.rb

class Date_time_bl
   
  def check_year(year)
    if year.size == 4
      return true
    end
    return false
  end
    
end