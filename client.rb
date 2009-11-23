#!/usr/bin/ruby -w
# client.rb
require 'file_helper'

class Client
  attr_accessor :name, :lastname, :phone_num, :soc_id, :driving_license_id, :email, :address
  attr_reader :client_id
  
  def initialize(name, lastname, phone_num, soc_id, driving_license_id)
    @name = name
    @lastname = lastname
    @phone_num = phone_num
    @soc_id = soc_id
    @driving_license_id = driving_license_id

    @email = "-"
    @address = "-"
    
    fh = File_helper.new
    fh.file_name="data/client_id.txt"
    @client_id = fh.get_last_id
  end
  
  def to_string
    s = "id: #{@client_id}, "
    s = s + "name: #{@name}, "
    s = s + "lastname: #{@lastname}, "
    s = s + "phone_num: #{@phone_num}, "
    s = s + "soc_id: #{@soc_id}, "
    s = s + "driving_license_id: #{@driving_license_id}, "
    s = s + "email: #{@email}, "
    s = s + "address: #{@address}"
    return s    
  end
  
end