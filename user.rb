#!/usr/bin/ruby -w
# user.rb
require "file_helper"

class User
	attr_accessor :username, :password, :name, :lastname
	attr_reader :user_id

	def initialize(username, password)
		@username = username
		@password = password
		@name = "name"
		@lastname = "lastname"
		@user_id = File_helper.new("user_id.txt").get_last_id
	end
	
end
