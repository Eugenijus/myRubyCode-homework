# user_spec.rb
require 'rubygems'
require 'spec'
require 'user'
require 'user_manager'
 
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

describe User, "to_string" do
  it "should return string" do
    a = User.new("account2","randompass2", "randomname", "randomlastname")
    a.to_string.should be_instance_of(String)
  end
end

describe User_manager do
	it "should let create user_manager" do
		um = User_manager.new
	end
	
	it "should store all users in file and should always load all users" do
		um = User_manager.new
		um.users.should be_instance_of(Array)
		um.add_user("username","password", "name", "lastname")
		um = nil
		
		um2 = User_manager.new
		um2.find_user("username").should be_instance_of(User)
		um2.delete_user("username")
	end

  it "should not let add user with same username" do
    um = User_manager.new
    user1 = um.add_user("account2","randompass2", "randomname", "randomlastname")
    user2 = um.add_user("account2","randompass2", "randomname", "randomlastname")
    um.delete_user(user1.username)
    user2.should be(nil)
  end

  it "should have print_users method which returns -1 if no users where printed" do
    um = User_manager.new
    um.change_users_file("data/test/empty_text_file.txt")
    um.load_users
    um.print_users.should == -1
  end

  it "should have print_user method which returns 1 if one was printed" do
    um = User_manager.new
    um.change_users_file("data/test/one_user.txt")
    um.load_users
    um.print_users.should == 1
  end

end
