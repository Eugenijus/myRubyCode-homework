# order_spec.rb
require "rubygems"
require "spec"
require "order"

describe Order do
	it "should let create new order" do
		Order.new("2009-10-12 19:00", "2009-10-13 19:00",1,2).should be_instance_of(Order)
	end

	it "should have pickup date, return date, garage_id, client_id" do
		ord = Order.new("2009-10-12 19:00", "2009-10-13 19:00",1,2)
		ord.pickup_date.should == "2009-10-12 19:00"
		ord.return_date.should == "2009-10-13 19:00"
		ord.garage_id.should == 1
		ord.client_id.should == 2
	end
end