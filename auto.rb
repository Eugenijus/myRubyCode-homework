#!/usr/bin/ruby -w
# auto.rb
require 'file_helper'

class Auto
	attr_accessor :reg_num, :brand, :model, :type, :color
	attr_reader :auto_id
	
	def initialize(reg_num, brand, model, type, color)
		@reg_num = reg_num #245FGH
		@brand = brand  #BMW, Mercedes-Benz
		@model = model  #z350
		@type = type  #string from auto_types
		@color = color  #black, silver, white, red
		fh = File_helper.new
		fh.file_name="data/auto_id.txt"
    @auto_id = fh.get_last_id
	end
	
	def to_string
    s = "id: #{@auto_id}, "
    s = s + "Reg.Num: #{@reg_num}, "
    s = s + "Brand: #{@brand}, "
    s = s + "Model: #{@model}, "
    s = s + "Type: #{@type}, "
    s = s + "Color: #{@color}"
    return s    	  
	end
	
end