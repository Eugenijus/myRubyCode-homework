# bl_spec.rb

require 'rubygems'
require 'spec'
require 'rate_bl'
require 'date_time_bl'

describe Rate_bl do
  before(:each) do
    @rbl = Rate_bl.new    
  end
  
  it "should count rate" do
    @rbl.count_rate("economy")
    @rbl.rate.should == 70
  end

  it "should set default rate to 100" do
    @rbl.count_rate("")
    @rbl.rate.should == 100
  end
end

describe Date_time_bl, "chech_year" do
  before(:each) do
    @dt_bl = Date_time_bl.new    
  end

  it "should check if year is a number" do
    @dt_bl.check_year(2009).should == true
  end

  it "should not let enter year less than today's year" do
    @dt_bl.check_year(2008).should == false
  end

  it "should not let enter year higher by 10 after today's year" do
    @dt_bl.check_year(2999).should == false
  end
end

describe Date_time_bl, "check_month" do
  before(:each) do
    @dt_bl = Date_time_bl.new    
  end

  it "should check if month is a number and in range of 1.12" do
    (1..12).each do |i|
      @dt_bl.check_month(i).should == true
    end
  end

  it "should not pass letters" do
    @dt_bl.check_month("Jan").should == false
  end

  it "should pass month with leading 0" do
    @dt_bl.check_month(02).should == true
  end

  it "should not pass month with leading 00 or more than 2 zeros" do
    @dt_bl.check_month(002).should == true
  end
end

describe Date_time_bl, "check_day" do
  before(:each) do
    @dt_bl = Date_time_bl.new    
  end

  it "should check if day is a number and in range of 1..31" do
    (1..31).each do |i|
      @dt_bl.check_day(i).should == true
    end
  end

  it "should pass day with leading 0" do
    @dt_bl.check_day(02).should == true
  end

  it "should not pass month with leading 00 or more than 2 zeros" do
    @dt_bl.check_day(002).should == true
  end
end

