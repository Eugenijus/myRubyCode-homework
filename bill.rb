#!/usr/bin/ruby -w
# bill.rb
require 'file_helper'

class Bill
  attr_accessor :order_obj, :order_id, :rent_time, :rate, :total
  attr_reader :bill_id, :discount
  
  def initialize(order_obj, rate)
    @order_obj = order_obj
    @order_id = @order_obj.order_id
    @rate = rate
    @rent_time = find_rent_time
    @total = find_total
    @discount = 1

    fh = File_helper.new
    fh.file_name="data/bill_id.txt"
    @bill_id = fh.get_last_id              
  end
  
  def find_rent_time
    t1 = @order_obj.pickup_time
    t2 = @order_obj.return_time
    @rent_time = (t2-t1)/ (60*60) #hours
    return  @rent_time
    #puts @rent_time.class
  end
  
  def find_total
    @total = @rent_time * rate
    @discount = find_discount
    @total = @total * @discount
    return @total    
  end
    
  def find_discount
    #discount for more than 24 hours
    if (@order_obj.pickup_time.month == 12) then
      if(@order_obj.pickup_time.day >= 24) then
        return 0.9
      end
    end
    if (@rent_time >= 24.0) then
      return 0.9
    end
    if (@rent_time >= 6.0) then
      return 0.95
    end
    return 1.0
  end

  def to_string
    s = "ID: #{@bill_id}, "
    s = s + "Order_id: #{@order_id}, "
    s = s + "Rent_time: #{@rent_time}, "
    s = s + "Rate: #{@rate}, "
    s = s + "Total: #{@total}, "
    s = s + "Discount: #{@discount}"
  end  
end