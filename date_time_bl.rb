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
end

