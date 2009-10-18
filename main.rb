#!/usr/bin/ruby -w
# main.rb

require "user"
require "auto"
require "order"
require "file_helper"

o = Order.new("2009-10-12 19:00", "2009-10-13 19:00",1,2)
puts o.to_string

#u = User.new("Jonas", "Jonikaitis")
#puts File_helper.new("auto_id.txt").get_last_id