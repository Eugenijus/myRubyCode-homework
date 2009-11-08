#!/usr/bin/ruby -w
# main.rb

require "user"
require "auto"
require "order"
require "ui"
require "file_helper"

#o = Order.new("2009-10-12 19:00", "2009-10-13 19:00",1,2)
#puts o.to_string

#u = User.new("Jonas", "Jonikaitis")
#u.username="Povilaitis"
#puts File_helper.new("auto_id.txt").get_last_id

f = File_helper.new()
f.file_name="users/Jonas106.txt"
str = f.read_obj_no_par

y_obj = YAML::load(str)
puts y_obj.class
puts y_obj.username

u = Ui.new