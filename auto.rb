#!/usr/bin/ruby -w
# auto.rb
require "file_helper"

class Auto
	attr_accessor :reg_num, :brand, :name, :type, :color
	attr_reader :auto_id
	
	def initialize(reg_num, brand, name, type, color)
		@reg_num = reg_num
		@brand = brand
		@name = name
		@type = type
		@color = color
		@auto_id = File_helper.new("auto_id.txt").get_last_id
	end
	
end