require_relative '../models/Player'
require_relative '../models/Kills'
require_relative '../models/Game'
require_relative '../controllers/GameLogParser'

object0 = GameLogParser.new
# object1 = Player.new("Player")
# object2 = Kills.new("Player")
# object3 = Game.new("123")

# p object1
# p object2
# p object3

object0.print_json
