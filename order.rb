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
		s = "order id: #{id}, "
		s = s + "pickup date: #{@pickup_date}, "
		s = s + "return date: #{@return_date}, "
		s = s + "garage_id: #{@garage_id}, "
		s = s + "clien_id: #{@client_id}"
		return s
	end
end