# auto_spec.rb
require "rubygems"
require "spec"
require "auto"
require "auto_types"

describe Auto do
	it "should let create a new Auto object" do
		Auto.new("034NNAS", "BMW", "335i", "Convertable", "silver").should be_instance_of(Auto)
	end
	
	it "should have auto_id, reg. number, brand, name, type, color" do
    at = Auto_types.new.types
	  mycar = Auto.new("035NNAS", "BMW", "335i", at[4], "silver")
		mycar.auto_id.should_not == nil
		
		mycar.reg_num.should == "035NNAS"
		mycar.brand.should == "BMW"
		mycar.model.should == "335i"
		mycar.type.should == at[4]
		mycar.color.should == "silver"
	end

end