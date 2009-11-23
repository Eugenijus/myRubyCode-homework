#!/usr/bin/ruby -w
# client_manager.rb

require 'yaml'
require 'file_helper'
require 'client'
class Client_manager
  attr_reader :clients, :clients_file, :fh
  
  def initialize
    @clients = Array.new
    @clients_file = "data/all_clients.txt"
    @fh = File_helper.new
    @fh.file_name=@clients_file
    load_clients   
  end

  def add_client(name, lastname, phone_num, soc_id, driving_license_id)
    if find_client(soc_id) == nil then
      c = Client.new(name, lastname, phone_num, soc_id, driving_license_id)
      @clients.push(c)
      y_c = YAML::dump(@clients)
      @fh.clean
      @fh.write_obj(y_c)
      return c
    end
    return nil
  end
    
  def find_client(soc_id)
    @clients.each do |c|
      if c.soc_id.eql?(soc_id) 
        return c
      end
    end
    return nil
  end
  
  def set_clients(values)
    values.each do |c|
        @clients.push(c)
    end
  end 
  
  def load_clients
    str = @fh.read_obj_no_par
    if str!=nil && str.size>0 then
      c_arr = YAML::load(str)
      set_clients(c_arr)
      i = @clients.size
      print "Successfully loaded #{i} "
      if i>1 
        puts "clients!"
        return 1
      end
      if i==1
        puts "client!"  
      end
      return 1
    end
    puts "No clients were found!"
    return -1
  end
  
  def print_clients
    i = 1
    if @clients.length == 0 then
      puts "There are no clients!"
      return -1
    end
    @clients.each do |c| 
      print "#{i}. "
      puts c.to_string
      i = i+1
    end
    return 1
  end
  
end