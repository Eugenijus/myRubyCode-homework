#!/usr/bin/ruby -w
# user_manager.rb

require "user"

class User_manager
  attr_reader :users
  
  def initialize()
    @users = Array.new
  end
  
  def add_user(username, password)
    return nil
  end
  
  def set_users(values)
    values.each do |u|
      #if user.class == User.new.class
        @users.push(u)
      #end
    end
  end
  
end