#!/usr/bin/ruby -w
# client.rb
require 'file_helper'

class Client
  attr_accessor :order_ids, :name, :lastname, :phone_num, :soc_id, :driving_license_id, :email, :address
  attr_reader :client_id
  
  def initialize(name, lastname, phone_num, soc_id, driving_license_id)
    @name = name
    @lastname = lastname
    @phone_num = phone_num
    @soc_id = soc_id
    @driving_license_id = driving_license_id
    @order_ids = Array.new

    @email = "-"
    @address = "-"
    
    fh = File_helper.new
    fh.file_name="data/client_id.txt"
    @client_id = fh.get_last_id
  end

  def add_order_id(order_id)
    if @order_ids == nil then
      @order_ids = Array.new
    end
    @order_ids.push(order_id)
  end
  
  def to_string
    s = "ID: #{@client_id}, "
    s = s + "name: #{@name}, "
    s = s + "lastname: #{@lastname}, "
    s = s + "phone_num: #{@phone_num}, "
    s = s + "soc_id: #{@soc_id}, "
    s = s + "driving_license_id: #{@driving_license_id}, "
    s = s + "email: #{@email}, "
    s = s + "address: #{@address}"
    s = s + "order_ids: #{@order_ids}"
    return s    
  end
  
end