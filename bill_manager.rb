#!/usr/bin/ruby -w
# bill_manager.rb

require 'yaml'
require 'file_helper'
require 'bill'

class Bill_manager
  attr_reader :bills, :bills_file, :fh
  
  def initialize
    @bills = Array.new
    @bills_file = "data/all_bills.txt"
    @fh = File_helper.new
    @fh.file_name=@bills_file
    load_bills
  end
  
  def add_bill(order_obj, rate)
    if order_obj.class != Order
      return nil
    end
    b = Bill.new(order_obj,rate)
    @bills.push(b)
    save_bills()
    return b   
  end
  
  def find_bill(bill_id)
    @bills.each do |b|
      if b.bill_id == bill_id
        return b
      end
    end
    return nil
  end
  
  def change_bills_file(msg)
    @bills_file = msg
    @fh = File_helper.new
    @fh.file_name=@bills_file
  end

  def get_bill_info(bill_id)
    bill_obj = find_bill(bill_id)
    if bill_obj != nil
      y_b = YAML::dump(bill_obj)
      return y_b
    end
    return nil
  end
  
  def save_bills
    y_b = YAML::dump(@bills)
    @fh.clean
    @fh.write_obj(y_b)    
  end
  
  def set_bills(values)
    values.each do |b|
        @bills.push(b)
    end
  end
  
  #from file to array
  def load_bills
    @bills = Array.new
    str = @fh.read_obj_no_par
    if str!=nil && str.size>0 then
      b_arr = YAML::load(str)
      set_bills(b_arr)
      i = @bills.size
      print "Successfully loaded #{i} "
      if i>1 
        puts "bills!"
        return 1
      end
      if i==1
        puts "bill!"  
      end
      return 1
    end
    puts "No bills were found!"
    return -1
  end

  def find_bill_by_id(bill_id)
    @bills.each do |c|
      if c.bill_id == bill_id
        return c
      end
    end
    return nil
  end
 #=============
  def delete_at(i)
    if @bills.length > i and i != -1 then
      @bills[i] = nil
      @bills = @bills.compact #removes nils
      save_bills
      return true
    end
    return false
  end
  
  def delete_bill(bill_id)
    c = find_bill_by_id(bill_id)
    if c != nil then
      i = what_is_index_of(c.bill_id)
      return delete_at(i)
    end
    return false
  end
  
  def what_is_index_of(bill_id)
    i = 0
    while (i<@bills.length) do
      if @bills.at(i).bill_id == bill_id then
        return i
      end
      i=i+1
    end
    return -1
  end
#====================

  def print_bills
    i = 1
    if @bills.length == 0 then
      puts "There are no Bills!"
      return -1
    end    
    @bills.each do |b|
      puts b.to_string
      i = i+1
    end
    return 1
  end  
end