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
    when at.types[1]
      @rate = 90
    else
      @rate = 100
    end
  end
  
end