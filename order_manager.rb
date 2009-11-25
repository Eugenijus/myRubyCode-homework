#!/usr/bin/ruby -w
# order_manager.rb

require 'yaml'
require 'file_helper'
require 'order'

class Order_manager
  attr_reader :orders, :orders_file, :fh
  
  def initialize
    @orders = Array.new
    @orders_file = "data/all_orders.txt"
    @fh = File_helper.new
    @fh.file_name=@orders_file
    load_orders   
  end

  def add_order(pickup_time, return_time, auto_id, garage_id, client_id)
    if check_times(pickup_time, return_time) == -1 then
      return nil
    end
    if find_order(pickup_time, auto_id) == nil then
      o = Order.new(pickup_time, return_time, auto_id, garage_id, client_id)
      @orders.push(o)
      y_o = YAML::dump(@orders)
      @fh.clean
      @fh.write_obj(y_o)
      return o
    end
    puts "Auto #{auto_id} is reserved!"
    return nil
  end
  
  def check_times(pickup_time, return_time)
    if !pickup_time.instance_of?(Time) then
      puts "Pickup Time is of wrong format!"
      return -1
    end
    if !return_time.instance_of?(Time) then
      puts "Return Time is of wrong format!"
      return -1
    end
    return 1
  end
    
  def find_order(pickup_time, auto_id)
    @orders.each do |o|
      if o.auto_id == auto_id
        if o.pickup_time.eql?(pickup_time)
          return o
        end
      end
    end
    return nil
  end
  
  def find_order_by_id(order_id)
    @orders.each do |o|
      if o.order_id == order_id
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
  
  def save_orders()
    y_o = YAML::dump(@orders)
    @fh.clean
    @fh.write_obj(y_o)
  end
    
  def delete_at(i)
    if @orders.length > i then
      @orders[i] = nil
      @orders = @orders.compact #removes nils
      save_orders
    end
  end
  
  def delete_order(order_id)
    o = find_order_by_id(order_id)
    i = what_is_index_of(o.order_id)
    delete_at(i)
  end
  
  def what_is_index_of(order_id)
    i = 0
    while (i<@orders.length) do
      if @orders.at(i).order_id == order_id then
        return i
      end
      i=i+1
    end
  end  
  
  def print_orders
    i = 1
    if @orders.length == 0 then
      puts "There are no Orders!"
      return -1
    end    
    @orders.each do |o|
      puts o.to_string
      i = i+1
    end
    return 1
  end
end