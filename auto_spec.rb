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
  
  it "should add and remove car properly" do
    am = Auto_manager.new
    car1 = am.add_car("ASD124", "VW", "Gold", "compact", "red")
    car1.should_not == nil
    car1.reg_num.should == "ASD124"
    am.delete_auto(car1.auto_id)
    
    car2 = am.find_car("ASD124")
    car2.should == nil
  end
  
  it "should find car by reg_num" do
    am = Auto_manager.new
    car1 = am.add_car("ASD124", "VW", "Gold", "compact", "red")
    car2 = am.find_car("ASD124")
    am.delete_auto(car1.auto_id)
    car1.auto_id.should == car2.auto_id
  end
  
  it "should find car by auto_id" do
    am = Auto_manager.new
    car1 = am.add_car("ASD124", "VW", "Gold", "compact", "red")
    car2 = am.find_car_by_id(car1.auto_id)
    am.delete_auto(car1.auto_id)
    car1.reg_num.should == car2.reg_num
    car1.model.should == car2.model
    car1.color.should == car2.color
  end
  
  it "should let add car with type being integer" do
    am = Auto_manager.new
    car3 = am.add_car("ASD124", "VW", "Gold", 1, "red")
    am.delete_auto(car3.auto_id) #just making sure its not saved in file
    car3.type.should == Auto_types.new.types[1]
    #this will work too
    #car3.type.should == "compact"
  end

  it "should not let add car with same reg_num" do
    am = Auto_manager.new
    car4 = am.add_car("ASD124", "VW", "Gold", 1, "red")
    car5 = am.add_car("ASD124", "BMW", "335i", "convertable", "silver")
    am.delete_auto(car4.auto_id)
    car5.should be(nil)
  end

  it "should return nil when looking for car with wrong auto_id" do
    am = Auto_manager.new
    car6 = am.find_car_by_id(-1)
    car6.should be(nil)
  end

  it "should return false when trying to delete car with wrong index or auto_id" do
    am = Auto_manager.new
    bool1 = am.delete_at(-1)
    bool1.should be(false)
    bool2 = am.delete_auto(-1)
    bool2.should be(false)
  end

  it "should return -1 when trying to find not existing index in car array" do
    am = Auto_manager.new
    auto_id = -1 #non existing car id
    bool3 = am.what_is_index_of(auto_id)
    bool3.should == -1
  end

  it "should have print cars method which returns -1 if no cars where printed" do
    am = Auto_manager.new
    am.change_cars_file("data/test/empty_text_file.txt")
    am.load_cars
    am.print_cars.should == -1
  end

  it "should have print cars method which returns 1 if one car was printed" do
    am = Auto_manager.new
    am.change_cars_file("data/test/one_car.txt")
    am.load_cars
    am.print_cars.should == 1
  end
end

describe Auto_manager, "load_cars" do
  it "should return -1 with empty file or non existing file" do
    am = Auto_manager.new
    am.change_cars_file("data/test/nonexisting.txt")
    am.load_cars.should == -1
    File.delete("data/test/nonexisting.txt")
    am.change_cars_file("data/test/empty_text_file.txt")
    am.load_cars.should == -1
  end

  it "should return 1 with one car in a file" do
    am = Auto_manager.new
    am.change_cars_file("data/test/one_car.txt")
    am.load_cars.should == 1
  end
end

describe Auto, "to_string" do
  it "should return string" do
    a = Auto.new("034NNAS", "BMW", "335i", "Convertable", "silver")
    a.to_string.should be_instance_of(String)
  end
end

describe Auto_types do
  it "should contain exact auto types" do
    at = Auto_types.new
    my_types = ["economy", "compact", "full-size", "luxury", "convertable", "sports-car", "minivan", "pick-up-truck", "van"]
    at.types.should == my_types
  end
end
