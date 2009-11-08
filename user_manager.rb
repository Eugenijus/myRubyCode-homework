#!/usr/bin/ruby -w
# user_manager.rb

require "user"

class User_manager
  attr_reader :users
  
  def initialize()
    @users = Array.new
  end
  
  def add_user(username, password)
    if find_user(username) == nil
      u = User.new(username,password)
      @users.push(u)
      return u
    end
    return nil
  end
  
  def find_user(username)
    @users.each do |u|
      if u.username() == username
        return u
      end
    end
    return nil
  end
  
  def set_users(values)
    values.each do |u|
      #if user.class == User.new.class
        @users.push(u)
      #end
    end
  end
  
  def print_users
    @users.each {|u| print u.username; print " "; puts u.password}    
  end
end