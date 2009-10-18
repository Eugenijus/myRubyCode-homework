#!/usr/bin/ruby -w
# order.rb
require "file_helper"

class Order
	attr_accessor :pickup_date, :return_date, :garage_id, :client_id
	
	def initialize(pickup_date, return_date, garage_id, client_id)
		@pickup_date = pickup_date
		@return_date = return_date
		@garage_id = garage_id
		@client_id = client_id
	end
	
	def to_string
		s = "pickup date is: #{@pickup_date}, "
		s = s + "return date is: #{@return_date}, "
		s = s + "garage_id is: #{@garage_id}, "
		s = s + "clien_id is: #{@client_id}"
		return s
	end
end