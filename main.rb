#!/usr/bin/ruby -w
# main.rb
require 'yaml'
require "user"
require "auto"
require "order"
require "ui"
require "file_helper"
require "user_manager"
require "auto_types"
require 'date_time_bl'

#o = Order.new("2009-10-12 19:00", "2009-10-13 19:00",1,2)
#puts o.to_string

#u = User.new("Jonas", "Jonikaitis")
#u.username="Povilaitis"
#puts File_helper.new("auto_id.txt").get_last_id

#f = File_helper.new()
#f.file_name="users/Jonas106.txt"
#str = f.read_obj_no_par

#y_obj = YAML::load(str)
#puts y_obj.class
#puts y_obj.username

#u = Ui.new
#um = User_manager.new
#u = User.new("jonas","asdsd","asd","asd")
#uj = User.new("petras","asdadsasdsd","asd","asd")
#arr = Array.new
#arr.push(u)
#arr.push(uj)
#y_arr = arr.to_yaml
#f = File_helper.new()
#f.file_name="users/all_users2.txt"
#f.write_obj(y_arr)
#um.set_users(arr)
#um.users.each {|u| print u.username; print " "; puts u.password}
#puts um.users.to_s
#uui = Ui.new
#uui.get_console_string("asd:")

u = Ui.new

#TODO: Create Auto_manager, it will show all cars and will save them into file
#How Orders should be saved?
#Create Client class, Client_manager
#rake -T
#rake examples_with_rcov