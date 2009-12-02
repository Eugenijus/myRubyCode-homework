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

describe Date_time_bl, "chech_year" do
  before(:each) do
    @dt_bl = Date_time_bl.new    
  end

  it "should check if year is a number" do
    @dt_bl.check_year("asd").should == false
  end
  
  it "should not let enter year with more than 4 digits in it" do
    @dt_bl.check_year(20080).should == false
  end

  it "should not let enter year less than today's year" do
    @dt_bl.check_year(2008).should == false
  end

  it "should not let enter year higher by 10 after today's year" do
    @dt_bl.check_year(2999).should == false
  end

  it "should let enter this year" do
    @dt_bl.check_year(Time.now.year).should == true
  end
end

describe Date_time_bl, "check_month" do
  before(:each) do
    @dt_bl = Date_time_bl.new    
  end

  it "should check if month is a number and in range of 1.12" do
    @dt_bl.check_month(1).should == true
  end

  it "should not pass letters" do
    @dt_bl.check_month("Jan").should == false
  end

  it "should pass month with leading 0" do
    @dt_bl.check_month(02).should == true
  end

  it "should not pass month with more than 2 digits" do
    @dt_bl.check_month(123).should == false
  end

  it "should pass month with leading 00 or more than 2 zeros" do
    @dt_bl.check_month(002).should == true
    @dt_bl.check_month(0000002).should == true
  end
end

describe Date_time_bl, "check_day" do
  before(:each) do
    @dt_bl = Date_time_bl.new    
  end

  it "should not pass not a Fixnum object" do
    @dt_bl.check_day("asd").should be(false)
  end

  it "should check if day is a number and in range of 1..31" do
    (1..31).each do |i|
      @dt_bl.check_day(i).should == true
    end
  end

  it "should not pass number not in a range of 1.31" do
    @dt_bl.check_day(32).should be(false)
  end

  it "should pass day with leading 0" do
    @dt_bl.check_day(02).should == true
  end

  it "should not pass month with leading 00 or more than 2 zeros" do
    @dt_bl.check_day(002).should == true
  end
end

describe Date_time_bl, "check_hour" do
  before(:each) do
    @dt_bl = Date_time_bl.new    
  end

  it "should not pass not a Fixnum object" do
    @dt_bl.check_hour("asd").should be(false)
  end

  it "should check if hour is a number and in range of 0.23" do
    (0..23).each do |i|
      @dt_bl.check_hour(i).should == true
    end
  end

  it "should not pass number not in range of 0.23" do
    @dt_bl.check_hour(24).should be(false)
    @dt_bl.check_hour(-1).should be(false)
  end
end

describe Date_time_bl, "check_mins" do
  before(:each) do
    @dt_bl = Date_time_bl.new    
  end

  it "should not pass not a Fixnum object" do
    @dt_bl.check_mins("asd").should be(false)
  end

  it "should check if mins is a number and in range of 0.59" do
    (0..59).each do |i|
      @dt_bl.check_mins(i).should == true
    end
  end

  it "should not pass number not in range of 0.59" do
    @dt_bl.check_mins(60).should be(false)
    @dt_bl.check_mins(-1).should be(false)
  end
end