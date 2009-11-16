# file_helper.rb

class File_helper
	attr_reader :file_name
	
	def initialize()
		create_if_missing "users"
	end

	def create_if_missing name
		if File.directory?(name) == false
			Dir.mkdir(name)
		end
	end 
  
	def file_name=(value)
	  @file_name = value
    if File.exists?(@file_name) == false then
      puts "#{@file_name} doesn't exist"
      file = File.new(@file_name, "w")
      puts "#{@file_name} created"
    end
	end
	
	def get_last_id
		#read from file, find last id
		file = nil
		if File.exists?(@file_name) == false then
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
	
	def read_obj(file_name)
	  if File.exists?(file_name) == false
	    puts "Error: #{file_name} doesn't exist"
	    return nil
	  end
    if File.exists?(file_name) == true
      str = ""
      file = File.open(file_name, "r+")
      file.each_line do |line|
        str += line
      end
      return str
    end	  
	end
	
	def read_obj_no_par
      return read_obj(@file_name)	  
	end
	
	def clean
		if File.exists?(@file_name) == true
			file = File.delete(@file_name)
			file = File.new(@file_name, "w")
		end
	end

end