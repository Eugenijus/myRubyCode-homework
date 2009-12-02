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

describe Client, "add_order_id" do
  it "should let add order_id" do
    a = Client.new("Name", "Lastname", "865512345", "38501010001", "NZD09876")
    a.add_order_id(123)
    a.order_ids.should have(1).items
    a.order_ids.should include(123)
  end

  it "should return false if order_id is nil" do
    a = Client.new("Name", "Lastname", "865512345", "38501010001", "NZD09876")
    a.order_ids=nil
    a.add_order_id(nil).should be(false)
  end
end

describe Client, "to_string" do
  it "should return string" do
    a = Client.new("Name", "Lastname", "865512345", "38501010001", "NZD09876")
    a.to_string.should be_instance_of(String)
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
  
  it "should load clients array of Client objects" do
    cm = Client_manager.new
    cm.clients[0].should be_instance_of(Client)
  end

  it "should add and remove client properly" do
    cm = Client_manager.new
    client1 = cm.add_client("name", "lastname", "phone_num", "ABC123", "driving_license_id")
    client1.should_not == nil

    client1.soc_id.should == "ABC123"
    cm.delete_client(client1.client_id)
    
    client2 = cm.find_client("ABC123")
    client2.should == nil
  end

  it "should not let add client with same soc_id" do
    cm = Client_manager.new
    client4 = cm.add_client("name", "lastname", "phone_num", "ABC123", "driving_license_id")
    client5 = cm.add_client("name", "lastname", "phone_num", "ABC123", "driving_license_id")
    cm.delete_client(client4.client_id)
    client5.should be(nil)
  end

  it "should return nil when looking for client with wrong client_id" do
    cm = Client_manager.new
    client6 = cm.find_client_by_id(-1)
    client6.should be(nil)
  end

  it "should return false when trying to delete client with wrong index or client_id" do
    cm = Client_manager.new
    bool1 = cm.delete_at(-1)
    bool1.should be(false)
    bool2 = cm.delete_client(-1)
    bool2.should be(false)
  end
  
  it "should return -1 when trying to find not existing index in client array" do
    cm = Client_manager.new
    client_id = -1 #non existing client id
    bool3 = cm.what_is_index_of(client_id)
    bool3.should == -1
  end

  it "should let add order_id" do
    cm = Client_manager.new
    client7 = cm.add_client("name", "lastname", "phone_num", "ABC123", "driving_license_id")
    client_id = client7.client_id
    int1 = cm.add_order(12, client_id)
    int1.should be(1)
    int2 = cm.add_order(12, -1)
    int2.should be(-1)
    cm.delete_client(client_id)
  end
  
  it "should have print_clients method which returns -1 if no clients where printed" do
    cm = Client_manager.new
    cm.change_clients_file("data/test/empty_text_file.txt")
    cm.load_clients
    cm.print_clients.should == -1
  end

  it "should have print_clients method which returns 1 if one was printed" do
    cm = Client_manager.new
    cm.change_clients_file("data/test/one_client.txt")
    cm.load_clients
    cm.print_clients.should == 1
  end

end

describe Client_manager, "load_clients" do
  it "should return -1 with empty file or non existing file" do
    cm = Client_manager.new
    cm.change_clients_file("data/test/nonexisting.txt")
    cm.load_clients.should == -1
    File.delete("data/test/nonexisting.txt")
    cm.change_clients_file("data/test/empty_text_file.txt")
    cm.load_clients.should == -1
  end

  it "should return 1 with one client in a file" do
    cm = Client_manager.new
    cm.change_clients_file("data/test/one_client.txt")
    cm.load_clients.should == 1
  end
end