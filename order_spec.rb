# order_spec.rb
require 'rubygems'
require 'spec'
require 'order'

describe Order do
  before(:each) do
    @t1 = Time.mktime(2009, 11, 24, 10, 17)
    @t2 = Time.mktime(2009, 11, 25, 10, 17)  end
	
  it "should let create new order" do
		Order.new(@t1, @t2,2,1,2).should be_instance_of(Order)
	end
  
	it "should have pickup time" do
	  o = Order.new(@t1, @t2, 1, 1, 1)
	  o.pickup_time.should be_instance_of(Time)	end
	
  it "should have return time" do
    o = Order.new(@t1, @t2, 1, 1, 1)
    o.return_time.should be_instance_of(Time)
  end
	
	it "should have auto_id, garage_id, client_id" do
		ord = Order.new(@t1, @t2, 2,1,2)
		ord.auto_id.should == 2
		ord.garage_id.should == 1
		ord.client_id.should == 2
	end
end