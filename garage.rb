#!/usr/bin/ruby -w
# garage.rb
class Garage
  attr_accessor :address1, :address2, :phone_num
  def initialize(address1, address2, phone_num)
    @address1 = address1
    @address2 = address2
    @phone_num = phone_num
  end
  
  def to_string
    s = "Address1: #{@address1}, "
    s = s + "Address2: #{@address2}, "
    s = s + "Phone num: #{@phone_num}"
  end
end