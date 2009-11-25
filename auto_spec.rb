# auto_spec.rb
require 'rubygems'
require 'spec'
require 'auto'
require 'auto_types'
require 'auto_manager'

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
    am.cars[0].should be_instance_of(Auto)
  end
  
  it "should find add and remove car properly" do
    am = Auto_manager.new
    #car1 = am.find_car("ASD124")
    #if car1 !=nil then
    #  am.delete_at(33)
    #end
    #(reg_num, brand, model, type, color)
    car1 = am.add_car("ASD124", "VW", "Gold", "compact", "red")
    car1.should_not == nil
    car1.reg_num.should == "ASD124"
    am.delete_auto(car1.auto_id)
    
    car2 = am.find_car("ASD124")
    car2.should == nil
    #am.delete_auto(car2.auto_id)  end
end
end