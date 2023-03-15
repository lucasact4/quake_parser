require_relative '../models/Game'
require_relative '../models/Player'

require 'json'

class GameLogParser

  # Responsável por processar o arquivo de .log puro e transformá-lo em objetos Ruby
  def process_file
    # Variáveis
    count_game = 0
    games = []
    atual_game = nil
    log_file = nil
    last_line = nil
      
    begin
      # Obtém o caminho completo do arquivo da classe
      log_file = File.expand_path(__FILE__)
      # Obtém o caminho completo do arquivo que deseja ler
      log_file = File.join(File.dirname(log_file), "games.log")
        
      # Começa a leitura do arquivo linha por linha
      File.foreach(log_file) do |line, last|
        # Se a um novo jogo
        if line.include?("InitGame:")
          begin
            if count_game != 0
              games.push(atual_game) # Adiciona a lista
              atual_game = Game.new(count_game) # Atribui um novo jogo a variável atualGame
              count_game += 1
            else
              atual_game = Game.new(count_game) # Atribui um novo jogo a variável atualGame
              count_game += 1
            end
          rescue => exception
            puts "Não foi possivel criar um novo game"
          end
        # Se a uma morte
        elsif line.include?("Kill:")
          # Incrementa o contador de mortes do jogo atual
          begin
            atual_game.total_kills += 1
          rescue => exception
            puts "Não foi possivel contar o total de mortes"
          end
    
          # Essa variaveís são usadas para conseguir os nomes dos respectivos jogadores envolvidos na kill
          begin
            last_two_points_index = line.rindex(":")
            killed_index = line.rindex("killed")
            by_index = line.rindex("by")
            # Nome do jogador que matou
            hunter_player = line[(last_two_points_index + 1)...killed_index].strip
            # Nome do jogador que morreu
            dead_player = line[(killed_index + 6)...by_index].strip
          rescue => exception
            puts "Não foi possível conseguir o nome dos jogadores envolvidos na kill"
          end
    
          # Lógica para o Player que matou
          begin
            if hunter_player != "<world>"
              hunter_player_index = atual_game.has_player(hunter_player)
              if hunter_player_index == -1
                # Caso o player não exista, deve se criar ele pela primeira vez
                player = Player.new(hunter_player)
                atual_game.players.push(player)
                hunter_player_index = atual_game.players.length - 1
              end
              atual_game.change_player_kills(hunter_player_index)
            end
          rescue => exception
            puts "Não foi possivel registrar o player que matou"
          end
    
          # Lógica para o Player morto
          begin
            dead_player_index = atual_game.has_player(dead_player)
            if dead_player_index == -1
              # Caso o player não exista, deve se criar ele pela primeira vez
              player = Player.new(dead_player)
              atual_game.players.push(player)
              dead_player_index = atual_game.players.length - 1
            end
            if hunter_player == "<world>"
              atual_game.change_player_kills(dead_player_index, true)
            end
          rescue => exception
            puts "Não foi possivel registrar o player que morreu"
          end
        end
      end
      # Se for a última linha
      begin
        if last_line.nil?
          puts "File 100% read."
          games.push(atual_game)
          create_games_file(games)
        else
          puts "last line: #{last_line}."
        end
      rescue => exception
        puts "Não foi possível saber se foi a última linha."
      end
    rescue => exception
      puts "Não foi possivel ler o log com exatidão."
    end
  end
  def create_games_file(games)
    json_string = JSON.generate(games, {
      only: ["game", "total_kills"],
      include: {
        players: {
          only: ["name", "kills"]
        }
      }
    })
    
    # Imprime em formato JSON os dados dos objetos dentro do array
    json_string = JSON.generate(games.map(&:as_json))
    puts JSON.pretty_generate(JSON.parse(json_string))
  end
  def print_json
    process_file()
  end
end