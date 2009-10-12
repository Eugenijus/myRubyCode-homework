#!/usr/bin/ruby -w
# user.rb
class User
	attr_accessor :username, :password, :name, :lastname

	def initialize(username, password)
		@username = username
		@password = password
		@name = "name"
		@lastname = "lastname"
	end
end
