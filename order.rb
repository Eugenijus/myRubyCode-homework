#!/usr/bin/ruby -w
# order.rb
require 'file_helper'

class Order
	attr_accessor :pickup_time, :return_time, :auto_id, :garage_id, :client_id
	attr_reader :order_id
	
	def initialize(pickup_time, return_time, auto_id, garage_id, client_id)
		@pickup_time = pickup_time
		@return_time = return_time
		@auto_id = auto_id
    @garage_id = garage_id
		@client_id = client_id
		
    fh = File_helper.new
    fh.file_name="data/order_id.txt"
    @order_id = fh.get_last_id
	end
	
	def to_string
		s = "ID: #{@order_id}, "
		s = s + "pickup date: #{@pickup_time}, "
		s = s + "return date: #{@return_time}, "
    s = s + "auto_id: #{@auto_id}, "		
		s = s + "garage_id: #{@garage_id}, "
		s = s + "client_id: #{@client_id}"
		return s
	end
end