#!/usr/bin/ruby -w
# order.rb
require "file_helper"

class Order
	attr_accessor :pickup_date, :return_date, :auto_id, :garage_id, :client_id
	attr_reader :order_id
	
	def initialize(pickup_date, return_date, auto_id, garage_id, client_id)
		@pickup_date = pickup_date
		@return_date = return_date
		@auto_id = auto_id
    @garage_id = garage_id
		@client_id = client_id
		
    fh = File_helper.new
    fh.file_name="data/order_id.txt"
    @order_id = fh.get_last_id
	end
	
	def to_string
		s = "id: #{@order_id}, "
		s = s + "pickup date: #{@pickup_date}, "
		s = s + "return date: #{@return_date}, "
    s = s + "auto_id: #{@auto_id}, "		
		s = s + "garage_id: #{@garage_id}, "
		s = s + "client_id: #{@client_id}"
		return s
	end
end