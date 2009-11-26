#client_spec.rb
require 'rubygems'
require 'spec'
require 'client'
require 'client_manager'

describe Client do
  it "should let create new client" do
      Client.new("Name", "Lastname", "865512345", "38501010001", "NZD09876").should be_instance_of(Client) 
  end
  
  it "should have name, lastname, phone nr., soc_id nr., driving_license_id" do
      cl = Client.new("Name", "Lastname", "865512345", "38501010001", "NZD09876")
      cl.name.should == "Name"
      cl.lastname.should == "Lastname"
      cl.phone_num.should == "865512345"
      cl.soc_id.should == "38501010001"
      cl.driving_license_id.should == "NZD09876"
  end
  
  it "should be possible to add email and address" do
    cl = Client.new("Name1", "Lastname1", "865512345", "38501010001", "NZD09876")
    cl.email = "myemail@mail.com"
    cl.address = "123 FunnyRoad, CA 41001, USA"
    
    cl.email.should == "myemail@mail.com"
    cl.address.should == "123 FunnyRoad, CA 41001, USA"
  end
  
end

describe Client_manager do
  it "should let create client_manager" do
    cm = Client_manager.new
  end
  
  it "should store all clients in array" do
    cm = Client_manager.new
    cm.clients.should be_instance_of(Array)
  end
end