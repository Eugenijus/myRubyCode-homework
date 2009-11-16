# user_spec.rb
require 'rubygems'
require 'spec'
require 'user'
 
describe User do
	it "should let create new user" do
		User.new("admin", "pass", "name", "lastname").should be_instance_of(User)
	end
   
	it "shoould have username and password" do
		admin_account = User.new("admin", "pass","name", "lastname")
		admin_account.username.should == "admin"
		admin_account.password.should == "pass"

		user_account = User.new("username1", "pass1", "name2", "lastname2")
		user_account.username.should == "username1"
		user_account.password.should == "pass1"
  end

	it "should let change username and password" do
		admin_account2 = User.new("admin","pass","name", "lastname") 		
		admin_account2.username = "admin2"
		admin_account2.username.should == "admin2"
		admin_account2.password = "newpass"
		admin_account2.password.should == "newpass"
	end

	it "can have name and lastname" do
		account = User.new("account1","randompass", "name", "lastname")
		account.name = "John"
		account.name.should == "John"
		account.lastname = "Steward"
		account.lastname.should == "Steward"
	end
end

describe User, "user_id" do
	it "should be automaticly generated" do
		account1 = User.new("account2","randompass2", "randomname", "randomlastname")
		account1.user_id.should be_instance_of(Fixnum)
	end

	it "should be unique" do
		account3 = User.new("account3","randompass3", "rname3", "rlastname3")
		account4 = User.new("account4","randompass4", "rname4", "rlastname4")
		account3.user_id.should_not == account4.user_id
	end	
	
end