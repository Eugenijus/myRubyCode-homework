#!/usr/bin/ruby -w
# rate_bl.rb

require 'auto_types'

class Rate_bl
  attr_reader :rate
  
  def initialize()
    @rate = 0
  end
  
  def count_rate(car_type)
    at = Auto_types.new
    case car_type
    when at.types[0]
      @rate = 70
    when at.types[1]
      @rate = 80
    when at.types[2]
      @rate = 80
    when at.types[3]
      @rate = 120
    when at.types[4]
      @rate = 100
    when at.types[5]
      @rate = 120   
    #for other types (from 6 to 8) rate is 100
    else
      @rate = 100
    end
  end
  
end