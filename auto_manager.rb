#!/usr/bin/ruby -w
# auto_manager.rb

require 'yaml'
require "file_helper"
require "auto"
#require "auto_types"

class Auto_manager
  attr_reader :cars, :cars_file, :fh, :types
  
  def initialize()
    @types= ["economy", "compact", "full-size", "luxury", "convertable", "sports-car", "minivan", "pick-up-truck", "van"];
    @cars = Array.new
    #@at = Auto_types.new
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
        true_type = @types[type]
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
  
  def find_car_by_id(auto_id)
    @cars.each do |c|
      if c.auto_id == auto_id
        return c
      end
    end
    return nil
  end
  
  def save_cars()
    y_c = YAML::dump(@cars)
    @fh.clean
    @fh.write_obj(y_c)
  end
    
  def delete_at(i)
    if @cars.length > i and i != -1 then
      @cars[i] = nil
      @cars = @cars.compact #removes nils
      save_cars
      return true
    end
    return false
  end
  
  def delete_auto(auto_id)
    c = find_car_by_id(auto_id)
    if c != nil then
      i = what_is_index_of(c.auto_id)
    return delete_at(i)
    end
    return false
  end
  
  def what_is_index_of(auto_id)
    i = 0
    while (i<@cars.length) do
      if @cars.at(i).auto_id == auto_id then
        return i
      end
      i=i+1
    end
    return -1
  end  
  #===
  
  def set_cars(values)
    values.each do |c|
      @cars.push(c)
    end
  end
  
  def load_cars
    @cars = Array.new
    str = @fh.read_obj_no_par
    #puts str
    if str!=nil && str.size>0 then
      c_arr = YAML::load(str)
      set_cars(c_arr)
      i = @cars.size
      #puts "car size: #{@cars.size}"
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
  
  def change_cars_file(msg)
    @cars_file = msg
    @fh = File_helper.new
    @fh.file_name=@cars_file
    #puts "changed cars file to #{msg}"
  end
  
  def print_cars
    i = 1
    if @cars.length == 0 then
      puts "There are no Cars!"
      return -1
    end    
    @cars.each do |c|
      puts c.to_string
      i = i+1
    end
    return 1
  end
  
end