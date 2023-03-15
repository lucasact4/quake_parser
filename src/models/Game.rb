require_relative './Player'
require_relative './Weapon'

class Game

  # Atribuitos do Game.
  attr_accessor :id, :game, :totalKills, :players, :killsByMean
  
  # Método Construtor.
  def initialize(id)
    puts "Test #{id}"
    @id = id
    @game = "game_#{id}"
    @totalKills = 0
    @players = []
    @killsByMean = []
  end
end