#!/usr/bin/ruby -w
# user.rb
require 'yaml'
require "file_helper"

class User
	#getters
	attr_reader :username, :password, :name, :lastname, :user_id, :file_name

	def initialize(username, password, name, lastname)
		@username = username
		@password = password
		@name = name
		@lastname = lastname
		fh = File_helper.new
		fh.file_name="data/user_id.txt"
		@user_id = fh.get_last_id
		
		#serialize = self.to_yaml
		#@file_name = "users/" + "u_" + @username.to_s + @user_id.to_s + ".txt"
		#filehelper = File_helper.new()
		#filehelper.file_name=@file_name
		#filehelper.write_obj(serialize)
	end
	
	#setters
	def username=(value)
		@username = value
		#serialize_all
	end

	def lastname=(value)
		@lastname = value
		#serialize_all
	end

	def name=(value)
		@name = value
		#serialize_all
	end

	def password=(value)
		@password = value
		#serialize_all
	end
	#end setters
  
	def to_string
	  s = "id: #{user_id}, "
	  s = s + "username: #{username}, "
	  s = s + "name: #{name}, "
	  s = s + "lastname: #{lastname}"
	  return s
	end
	
	#def serialize_all
		#serialize = self.to_yaml
		#filehelper = File_helper.new
		#filehelper.file_name=@file_name
		#filehelper.clean
		#filehelper.write_obj(serialize)
	#end
end
