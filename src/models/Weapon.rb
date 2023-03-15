class Weapon
  attr_accessor :name, :kills
  
  def initialize(name)
    @name = name
    @kills = 0
  end
end