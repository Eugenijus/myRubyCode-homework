#!/usr/bin/ruby -w
# garage.rb
require 'file_helper'

class Garage
  attr_accessor :address1, :address2, :phone_num
  attr_reader :garage_id
  def initialize(address1, address2, phone_num)
    @address1 = address1
    @address2 = address2
    @phone_num = phone_num
    
    #fh = File_helper.new
    #fh.file_name="data/garage_id.txt"
    @garage_id = 1
  end
  
  def to_string
    s = "ID: #{@garage_id}, "
    s = s + "Address1: #{@address1}, "
    s = s + "Address2: #{@address2}, "
    s = s + "Phone num: #{@phone_num}"
  end
end