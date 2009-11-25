# bl_spec.rb

require 'rubygems'
require 'spec'
require 'rate_bl'

describe Rate_bl do
  before(:each) do
    @rbl = Rate_bl.new      end
  it "should count rate" do
    @rbl.count_rate("economy")
    @rbl.rate.should == 70  end
  
  it "should set default rate to 100" do
    @rbl.count_rate("")
    @rbl.rate.should == 100
  end
end