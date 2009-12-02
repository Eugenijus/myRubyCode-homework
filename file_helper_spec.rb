#file_helper_spec.rb
require 'rubygems'
require 'spec'
require 'file_helper'
require 'user'
require 'yaml'

describe File_helper do
  it "should create file_helper obj" do
    File_helper.new.should be_instance_of(File_helper)
  end

  it "should let set file name" do
    fh = File_helper.new
    fh.file_name="data/test/empty_text_file.txt"
    fh.file_name.should eql("data/test/empty_text_file.txt")
  end

end

describe File_helper, "write_obj" do
  it "should create file if it is not created" do
    fh = File_helper.new
    fh.file_name="data/test/test_user_file.txt"
    user = User.new("user1","pass","Name","Lastname")
    str = YAML::dump(user)
    fh.write_obj(str)
    file = File.open("data/test/test_user_file.txt", "r")
    file.should_not be(nil)
    File.delete("data/test/test_user_file.txt")
  end
end

describe File_helper, "get_last_id" do
    fh = File_helper.new
    fh.file_name="data/test/test_user_file.txt"
    fh.get_last_id.should == 0
    File.delete("data/test/test_user_file.txt")
end

describe File_helper, "create_if_missing" do
  it "should create directory if it doesn't exist" do
    fh = File_helper.new
    name = "test2"
    fh.create_if_missing(name)
    File.directory?(name).should be(true)
    Dir::rmdir(name)
  end
end

describe File_helper, "read_obj" do
  it "should return nil if file is not created" do
    fh = File_helper.new
    fh.read_obj("data/test/test_user_file.txt").should be(nil)
  end
end