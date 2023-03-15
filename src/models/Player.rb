class Player
  attr_acessor :name, :kills

  def initialize(name)
    @name = name
    @kills = 0
  end

end