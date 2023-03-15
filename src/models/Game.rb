require_relative './Player'

class Game

  # Atribuitos do Game.
  attr_accessor :id, :game, :total_kills, :players, :kills
  
  # Método Construtor.
  def initialize(id)
    @id = id
    @game = "game_#{id}"
    @total_kills = 0
    @players = []
  end

  def as_json(options={})
    {
      id: id,
      game: game,
      total_kills: total_kills,
      players: players.map(&:as_json)
    }
  end
  
  # Return a posição na lista 'players' pelo name do jogador.
  # Se não for encontrado, o retorno será -1.
  def has_player(name)
    for i in 0...@players.length
      player = @players[i]

      if player.name == name
        return i
      end
    end
    return -1
  end

  # Adiciona ou Remove uma kill do player pela sua posição
  # na lista 'players' de acordo com o parâmetro world.
  # 'world', se refere a morte para o mapa. 
  def change_player_kills(index, world=false)
    if world
      @players[index].kills -= 1
    else
      @players[index].kills += 1
    end
  end

end