#!/usr/bin/ruby -w
# user_manager.rb

require 'yaml'
require "file_helper"
require "user"

class User_manager
  attr_reader :users, :users_file, :fh
  
  def initialize()
    @users = Array.new
    @users_file = "data/all_users.txt"
    @fh = File_helper.new
    @fh.file_name=@users_file
    load_users
  end
  
  def add_user(username, password, name, lastname)
    if find_user(username) == nil then
      u = User.new(username,password,name,lastname)
      @users.push(u)
      save_users()
      return u
    end
    return nil
  end
  
  def save_users()
    y_u = YAML::dump(@users)
    @fh.clean
    @fh.write_obj(y_u)
  end
  
  def find_user(username)
    @users.each do |u|
      if u.username.eql?(username) 
        return u
      end
    end
    return nil
  end
  
  def set_users(values)
    #puts values.class
    values.each do |u|
      #if user.class == User.new.class
        @users.push(u)
      #end
    end
  end
  
  #from file to array
  def load_users
    str = @fh.read_obj_no_par
    if str!=nil && str.size>0 then
      u_arr = YAML::load(str)
      set_users(u_arr)
      i = @users.size
      print "Successfully loaded #{i} "
      if i>1 
        puts "users!"
        return 1
      end
      if i==1
        puts "user!"  
      end
      return 1
    end
    puts "No users were found!"
    return -1
  end
  
  def delete_at(i)
    if @users.length > i then
      @users[i] = nil
      @users = @users.compact #removes nils
      save_users
    end
  end
  
  def delete_user(username)
    u = find_user(username)
    i = what_is_index_of(u.username)
    delete_at(i)
  end
  
  def what_is_index_of(username)
    i = 0
    while (i<@users.length) do
      if @users.at(i).username.eql?(username) then
        return i
      end
      i=i+1    end
  end
  
  def print_users
    i = 1
    if @users.length == 0 then
      puts "There are no Users!"
      return -1
    end  
    @users.each do |u| 
      puts u.to_string
      i = i+1
    end
  end
end