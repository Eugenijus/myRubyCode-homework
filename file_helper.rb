# file_helper.rb

class File_helper
	attr_accessor :file_name
	
	def initialize(file_name)
		@file_name = file_name
	end
	
	def get_last_id
		#read from file, find last id
		file = nil
		if File.exists?(@file_name) == false
			puts "#{@file_name} doesn't exist"
			file = File.new(@file_name, "w")
			puts "#{@file_name} created"
		end
		if File.exists?(@file_name) == true
			file = File.open(@file_name, "r+")
		end
		
		line = 0
		line = file.gets.to_i

		#set id
		tmp_id = line
		
		#increment id in the file
		line = line + 1
		file.rewind
		file.write(line)
		
		file.close

		return tmp_id
	end
end