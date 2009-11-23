#!/usr/bin/ruby -w
# order_manager.rb

require 'yaml'
require "file_helper"
require "order"
class Order_manager
  attr_reader :orders, :orders_file, :fh
  
  def initialize
    @orders = Array.new
    @orders_file = "data/all_orders.txt"
    @fh = File_helper.new
    @fh.file_name=@orders_file
    load_orders   
  end

  def add_order(pickup_date, return_date, auto_id, garage_id, client_id)
    if check_dates == -1 then
      return nil
    end
    if find_order(pickup_date, auto_id) == nil then
      o = Order.new(pickup_date, return_date, auto_id, garage_id, client_id)
      @orders.push(o)
      y_o = YAML::dump(@orders)
      @fh.clean
      @fh.write_obj(y_o)
      return o
    end
    puts "Auto #{auto_id} is reserved!"
    return nil
  end
  
  def check_dates(pickup_date, return_date)
    if !pickup_date.instance_of?(Date) then
      puts "Pickup Date is of wrong format!"
      return -1
    end
    if !return_date.instance_of?(Date) then
      puts "Return Date is of wrong format!"
      return -1
    end
    return 1
  end
    
  def find_order(pickup_date, auto_id)
    @orders.each do |o|
      if o.auto_id == auto_id
        if o.pickup_date.eql?(pickup_date)
          return o
        end
      end
    end
    return nil
  end
  
  def set_orders(values)
    values.each do |o|
        @orders.push(o)
    end
  end 
  
  def load_orders
    str = @fh.read_obj_no_par
    if str!=nil && str.size>0 then
      o_arr = YAML::load(str)
      set_orders(o_arr)
      i = @orders.size
      print "Successfully loaded #{i} "
      if i>1 
        puts "orders!"
        return 1
      end
      if i==1
        puts "order!"  
      end
      return 1
    end
    puts "No orders were found!"
    return -1
  end
  
  def print_orders
    i = 1
    @orders.each do |o| 
      print "#{i}. "
      puts o.to_string
      i = i+1
    end
  end
end