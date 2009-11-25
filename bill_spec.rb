# bill_spec.rb
require 'rubygems'
require 'spec'
require 'order'
require 'bill'

describe Bill do
  before(:each) do
    @t1 = Time.mktime(2009, 11, 24, 10, 17)
    @t2 = Time.mktime(2009, 11, 25, 10, 17)
    @auto_id = 1
    @garage_id = 1
    @client_id = 1
    @rate = 100 #litais
    @order = Order.new(@t1, @t2, @auto_id, @garage_id, @client_id)      end
  
  it "should let create bill" do
    b = Bill.new(@order, @rate).should be_instance_of(Bill)  end
  
  it "should have order_id" do
    b1 = Bill.new(@order, @rate)
    b1.order_id.should be_instance_of(Fixnum)
  end
  
  it "should have rate" do
    b5 = Bill.new(@order, @rate)
    b5.rate.should be_instance_of(Fixnum)
  end
  
  it "should find rent time" do
    b2 = Bill.new(@order, @rate) #.should be_instance_of(Bill)
    r = b2.rent_time
    r.should be_instance_of(Float)  end
  
  it "should find rent time equal to difference of two dates" do
    b3 = Bill.new(@order, @rate) #.should be_instance_of(Bill)
    r = b3.rent_time
    r.should == 24.0
  end
  
  it "should find total how much client should pay" do
    b4 = Bill.new(@order, @rate) #.should be_instance_of(Bill)
    total = b4.find_total.should == 2400
  end

end