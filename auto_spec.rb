# auto_spec.rb
require 'rubygems'
require 'spec'
require 'auto'
require 'auto_types'
require 'auto_manager'

Spec::Matchers.define :be_array_of_class do |expected|
  match do |actual|
    actual.should be_instance_of(expected)
  end
end

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

describe Auto_manager do
  it "should let create auto_manager" do
    am = Auto_manager.new
  end
  
  it "should store all cars in array" do
    am = Auto_manager.new
    am.cars.should be_instance_of(Array)
  end
  
  it "should load cars array of Auto objects" do
    am = Auto_manager.new
    am.cars.should be_array_of_class(Auto)
  endend