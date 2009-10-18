#!/usr/bin/ruby -w
# user.rb
class User
	attr_accessor :username, :password, :name, :lastname
	attr_reader :user_id

	def initialize(username, password)
		@username = username
		@password = password
		@name = "name"
		@lastname = "lastname"
		init_user_id
	end
	
	private
	
	#TODO add exception!
	def init_user_id
		#read from file, find last id
		file_name = "user_id.txt"
		file = nil
		if File.exists?(file_name) == false
			puts "#{file_name} doesn't exist"
			file = File.new(file_name, "r+")
			puts "#{file_name} created"
		end
		if File.exists?(file_name) == true
			file = File.open(file_name, "r+")
		end
		
		line = 0
		line = file.gets.to_i

		#set id
		@user_id = line
		
		#increment id in the file
		line = line + 1
		file.rewind
		file.write(line)
		
		file.close
	end
end
