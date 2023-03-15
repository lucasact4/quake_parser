class Weapon
  attr_accessor :name, :kills
  
  def initialize(name)
    puts "Test #{name}"
    @name = name
    @kills = 0
  end
end