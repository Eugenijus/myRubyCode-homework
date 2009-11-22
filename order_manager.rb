#!/usr/bin/ruby -w
# order_manager.rb

require 'yaml'
require "file_helper"
require "order"
class Order_manager
  attr_reader :orders, :orders_file, :fh
  
  def initialize
    @orders = Array.new
    @orders_file = "data/all_clients.txt"
    @fh = File_helper.new
    @fh.file_name=@orders_file
    load_orders   
  end

  def add_order(pickup_date, return_date, auto_id, garage_id, client_id)
    if find_order(order_id) == nil then
      o = Order.new(pickup_date, return_date, auto_id, garage_id, client_id)
      @orders.push(o)
      y_o = YAML::dump(@orders)
      @fh.clean
      @fh.write_obj(y_o)
      return o
    end
    return nil
  end
    
  def find_order(order_id)
    @orders.each do |o|
      if o.order_id.eql?(order_id) 
        return o
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