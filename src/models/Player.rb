class Player
  attr_accessor :name, :kills

  def initialize(name)
    @name = name
    @kills = 0
  end

  def as_json(options={})
    {
      name: name,
      kills: kills
    }
  end

end