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
    # Cria o relátorio em formato JSON que retorna algo parecido a TASK 1
    # Mas tem a mesma função da TASK 2 que imprime um relátorio
    # (simplemente imprimindo o "hash" pois está em formato JSON, parecido com o formato HASH)
    begin
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
      puts "="*60
      puts JSON.pretty_generate(JSON.parse(json_string))
      puts "="*60
      
    rescue => exception
      puts "Não foi possível imprimir o json com os dados das partidas"
    end
    # Imprime um relatório personalizado de cada partida
    begin
      puts "="*60
      games.each do |game|
        puts "A partida de ID Nº#{game.id} teve um total de #{game.total_kills} mortes e um total de #{game.players.length} jogadores"
      end
      puts "="*60
    rescue => exception
      puts "Não foi possível emitir o relatório personalizado"
    end
    # Impreme um ranking geral de kills dos jogadores
    begin
      players_kills = Hash.new(0)
      games.each do |game|
        game.players.each do |player|
          players_kills[player.name] += player.kills
          # puts "Player: #{player.name} Kills: #{player.kills}"
        end
      end
      # p players_kills
  
      # Classificar jogadores por número de kills
      sorted_players = players_kills.sort_by { |name, kills| kills }.reverse
      
      # p sorted_players

      # Adicionar ranking ao JSON
      ranking = sorted_players.map { |name, kills| { name: name, kills: kills } }
      # p ranking
  
      # Imprime o Ranking em formato JSON
      # puts JSON.pretty_generate(ranking)

      # Imprime o Ranking em formato NormalConsole
      cont = 1
      puts "="*60
      sorted_players.each do |name, kills|
        puts "#{cont}º Player: #{name} Kills: #{kills}"
        cont += 1
      end
      puts "="*60
    rescue => exception
      puts "Não foi possível emitir o ranking de kills gerais"
    end

  end
  def print_json
    process_file()
  end
end