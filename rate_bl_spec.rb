# rate_bl_spec.rb
require 'rubygems'
require 'spec'
require 'rate_bl'

describe Rate_bl do
  before(:each) do
    @rbl = Rate_bl.new    
  end
  
  it "should count rate" do
    @rbl.count_rate("economy")
    @rbl.rate.should == 70
  end

  it "should give rate of 80 for compact car" do
    @rbl.count_rate("compact")
    @rbl.rate.should == 80
  end

  it "should give rate of 80 for full-size car" do
    @rbl.count_rate("full-size")
    @rbl.rate.should == 80
  end

  it "should give rate of 120 for luxury car" do
    @rbl.count_rate("luxury")
    @rbl.rate.should == 120
  end

  it "should give rate of 100 for convertable car" do
    @rbl.count_rate("convertable")
    @rbl.rate.should == 100
  end

  it "should give rate of 120 for sport-car car" do
    @rbl.count_rate("sports-car")
    @rbl.rate.should == 120
  end

  it "should set default rate to 100" do
    @rbl.count_rate("")
    @rbl.rate.should == 100
  end
end
