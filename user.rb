#!/usr/bin/ruby -w
# user.rb
require 'yaml'
require "file_helper"

class User
	#getters
	attr_reader :username, :password, :name, :lastname, :user_id, :file_name

	def initialize(username, password)
		@username = username
		@password = password
		@name = "name"
		@lastname = "lastname"
		@user_id = File_helper.new("user_id.txt").get_last_id
		
		serialize = self.to_yaml
		@file_name = "users/" + @username.to_s + @user_id.to_s + ".txt"
		filehelper = File_helper.new(@file_name)
		filehelper.write_obj(serialize)
	end
	
	#setters
	def username=(value)
		@username = value
		serialize_all
	end

	def lastname=(value)
		@lastname = value
		serialize_all
	end

	def name=(value)
		@name = value
		serialize_all
	end

	def password=(value)
		@password = value
		serialize_all
	end
	#end setters

	def serialize_all
		serialize = self.to_yaml
		filehelper = File_helper.new(@file_name)
		filehelper.clean
		filehelper.write_obj(serialize)
	end
end
