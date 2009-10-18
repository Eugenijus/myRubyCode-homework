# auto_spec.rb
require "rubygems"
require "spec"
require "auto"

describe Auto do
	it "should let create a new Auto object" do
		Auto.new("034NNAS", "BMW", "335i", "Convertable", "silver").should be_instance_of(Auto)
	end
	
	it "should have auto_id, reg. number, brand, name, type, color" do
		mycar = Auto.new("035NNAS", "BMW", "335i", "Convertable", "silver")
		mycar.auto_id.should_not == nil
		mycar.reg_num.should == "035NNAS"
		mycar.brand.should == "BMW"
		mycar.name.should == "335i"
		mycar.type.should == "Convertable"
		mycar.color.should == "silver"
	end

end