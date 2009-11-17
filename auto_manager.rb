#!/usr/bin/ruby -w
# auto_manager.rb

require 'yaml'
require "file_helper"
require "auto"
require "auto_types"

class Auto_manager
  attr_reader :cars, :cars_file, :fh
  
  def initialize()
    @cars = Array.new
    @at = Auto_types.new
    @cars_file = "data/all_cars.txt"
    @fh = File_helper.new
    @fh.file_name=@cars_file
    load_cars
  end
  
  #====
  
  def add_car(reg_num, brand, model, type, color)
    if find_car(reg_num) == nil then
      true_type = ""
      if type.class == Fixnum
        true_type = @at.types[type]
      end
            
      c = Auto.new(reg_num, brand, model, true_type, color)
      @cars.push(c)
      y_c = YAML::dump(@cars)
      @fh.clean
      @fh.write_obj(y_c)
      return c
    end
    return nil
  end
  
  def find_car(reg_num)
    @cars.each do |c|
      if c.reg_num.eql?(reg_num) 
        return c
      end
    end
    return nil
  end
  
  #===
  
  def set_cars(values)
    values.each do |c|
      @cars.push(c)
    end
  end
  
  def load_cars
    str = @fh.read_obj_no_par
    if str!=nil && str.size>0 then
      c_arr = YAML::load(str)
      set_cars(c_arr)
      i = @cars.size
      print "Successfully loaded #{i} "
      if i>1 
        puts "cars!"
        return 1
      end
      if i==1
        puts "car!"  
      end
      return 1
    end
    puts "No cars were found!"
    return -1
  end
  
  def print_cars
    i = 1
    @cars.each do |c| 
      print "#{i} "
      puts c.to_string
      i = i+1
    end
  end
  
end