#!/usr/bin/ruby -w
# auto_types.rb

class Auto_types
  attr_reader :types
    
  def initialize
    @types= ["economy", "compact", "full-size", "luxury", "convertable",
      "sports-car", "minivan", "pick-up-truck", "van"];
  end
end