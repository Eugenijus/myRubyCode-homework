# file_helper.rb

class File_helper
	attr_accessor :file_name
	
	def initialize(file_name)
		@file_name = file_name
		create_if_missing "users"
	end

	def create_if_missing name
		if File.directory?(name) == false
			Dir.mkdir(name)
		end
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

	def write_obj(obj)
		if File.exists?(@file_name) == false
			file = File.new(@file_name, "w")
		end
		if File.exists?(@file_name) == true
			file = File.open(@file_name, "r+")
			file.write(obj)
			file.close
		end
	end

	def clean
		if File.exists?(@file_name) == true
			file = File.delete(@file_name)
			file = File.new(@file_name, "w")
		end
	end

end