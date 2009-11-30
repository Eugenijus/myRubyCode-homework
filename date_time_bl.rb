#!/usr/bin/ruby -w
# date_time_bl.rb

class Date_time_bl
  attr_reader :this_year, :this_month
  
  def initialize
    @this_year = Time.now.year
    @this_month = Time.now.month
  end

  def check_year(year)
    if year.class != Fixnum then
      puts "year should be a number"
      return false
    end
    if year.size != 4 then
      puts "year should have 4 digits"
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
    
    if month.size > 4 then
      puts "month should have two digits"
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
      puts "day  #{day} should be a number, not #{day.class}"
      return false
    end
    
    if day.size > 4 then
      puts "day should have two digits, not #{day.size}"
      return false
    end

    if day > 31 or month < 1 then
      puts "day should be in range 1..31"
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
end

