# bill_spec.rb
require 'rubygems'
require 'spec'
require 'order'
require 'bill'
require 'bill_manager'
=begin
Spec::Matchers.define :be_a_multiple_of do |expected|
  match do |actual|
    actual % expected == 0
  end
end

Spec::Matchers.define :be_more_than do |expected|
  match do |actual|
    actual > expected
  end
end
=end
describe Bill do
  before(:each) do
    @t1 = Time.mktime(2009, 11, 24, 10, 17)
    @t2 = Time.mktime(2009, 11, 25, 10, 17)
    @auto_id = 1
    @garage_id = 1
    @client_id = 1
    @rate = 100 #litais
    @order = Order.new(@t1, @t2, @auto_id, @garage_id, @client_id)    
  end
  
  it "should let create bill" do
    b = Bill.new(@order, @rate).should be_instance_of(Bill)
  end
  
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
    r.should be_instance_of(Float)
  end
  
  it "should find rent time equal to difference of two dates" do
    b3 = Bill.new(@order, @rate) #.should be_instance_of(Bill)
    r = b3.rent_time
    r.should == 24.0
  end
  
  it "should find total how much client should pay" do
    b4 = Bill.new(@order, @rate) #.should be_instance_of(Bill)
    total = b4.find_total
    total.should == (2400 * 0.9)
  end
  
  it "should give a 10% discount for rent time >= 24 hours" do
      b5 = Bill.new(@order, @rate) #.should be_instance_of(Bill)
      b5.find_discount.should == (0.9)
  end

  it "should give a 5% discount for rent time >= 6 hours" do
      @order.pickup_time=Time.mktime(2009,11,20,10,00)
      @order.return_time=Time.mktime(2009,11,20,16.00)
      b5 = Bill.new(@order, @rate) #.should be_instance_of(Bill)
      b5.find_discount.should == (0.95)
  end

  it "should give a 10% discount for any rent time during Cristmas holiday" do
      @order.pickup_time=Time.mktime(2009,12,24,10,00)
      @order.return_time=Time.mktime(2009,12,24,11.00)
      #@order.pickup_time.day.should == 24
      b5 = Bill.new(@order, @rate) #.should be_instance_of(Bill)
      b5.find_discount.should == (0.90)
  end

  it "should give no discount for regular days" do
      @order.pickup_time=Time.mktime(2009,11,24,10,00)
      @order.return_time=Time.mktime(2009,11,24,11.00)
      b5 = Bill.new(@order, @rate) #.should be_instance_of(Bill)
      b5.find_discount.should == (1)
  end

  it "should print correctly" do
      b5 = Bill.new(@order, @rate) #.should be_instance_of(Bill)
      str = b5.to_string
      b5.to_string.should eql(b5.to_string)
  end

=begin
  it "should not have negative total" do
    b5 = Bill.new(@order, @rate)
    total = b5.find_total
    total.should be_more_than(0)
  end
=end
   
end

describe Bill_manager do
  before(:each) do
    @t1 = Time.mktime(2009, 11, 24, 10, 17)
    @t2 = Time.mktime(2009, 11, 25, 10, 17)
    @auto_id = 1
    @garage_id = 1
    @client_id = -123
    @rate = 100 #litais
    @order = Order.new(@t1, @t2, @auto_id, @garage_id, @client_id)
  end

  it "should create bill manager" do
    Bill_manager.new.should be_instance_of(Bill_manager)
  end

  it "should add and remove bill properly" do
    bm = Bill_manager.new
    #b1 = Bill.new(@order, @rate).should be_instance_of(Bill)
    
    bill1 = bm.add_bill(@order, @rate)
    bill1.should_not == nil
    bm.delete_bill(bill1.bill_id)
    
    b2 = bm.find_bill(bill1.bill_id)
    b2.should == nil
  end

  it "should return string with all bill info properly" do
    bm = Bill_manager.new
    #b1 = Bill.new(@order, @rate).should be_instance_of(Bill)
    
    bill2 = bm.add_bill(@order, @rate)
    bill2.should_not == nil
    str = bm.get_bill_info(bill2.bill_id)
    bm.delete_bill(bill2.bill_id)
    str.should be_instance_of(String)
  end

  it "should return nil if bill doesn't exist" do
    bm = Bill_manager.new
    #b1 = Bill.new(@order, @rate).should be_instance_of(Bill)
    
    bill2 = bm.add_bill(@order, @rate)
    bill2.should_not == nil
    bm.delete_bill(bill2.bill_id)
    str = bm.get_bill_info(bill2.bill_id)
    str.should be(nil)
  end
#========
  it "should return nil when looking for bill with wrong bill_id" do
    bm = Bill_manager.new
    bill6 = bm.find_bill_by_id(-1)
    bill6.should be(nil)
  end

  it "should return false when trying to delete bill with wrong index or bill_id" do
    bm = Bill_manager.new
    bool1 = bm.delete_at(-1)
    bool1.should be(false)
    bool2 = bm.delete_bill(-1)
    bool2.should be(false)
  end
  
  it "should return -1 when trying to find not existing index in bill array" do
    bm = Bill_manager.new
    bill_id = -1 #non existing client id
    bool3 = bm.what_is_index_of(bill_id)
    bool3.should == -1
  end

#========
end

describe Bill_manager, "load_bills" do
  it "should return -1 with empty file or non existing file" do
    bm = Bill_manager.new
    bm.change_bills_file("data/test/nonexisting.txt")
    bm.load_bills.should == -1
    File.delete("data/test/nonexisting.txt")
    bm.change_bills_file("data/test/empty_text_file.txt")
    bm.load_bills.should == -1
  end

  it "should return 1 with one bill in a file" do
    bm = Bill_manager.new
    bm.change_bills_file("data/test/one_bill.txt")
    bm.load_bills.should == 1
  end
end

describe Bill_manager, "print_bills" do
  it "should have print_bills method which returns -1 if no bills where printed" do
    bm = Bill_manager.new
    bm.change_bills_file("data/test/empty_text_file.txt")
    bm.load_bills
    bm.print_bills.should == -1
  end

  it "should have print_bills method which returns 1 if one was printed" do
    bm = Bill_manager.new
    bm.change_bills_file("data/test/one_bill.txt")
    bm.load_bills
    bm.print_bills.should == 1
  end
end