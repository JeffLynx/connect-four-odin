require_relative './lib/player.rb'
require_relative './lib/board.rb'
require_relative './lib/display.rb'
require_relative './lib/game.rb'

puts 'Welcome to Connect Four!'
puts '------------------------'

print 'Enter Player 1 name: '
p1_name = gets.chomp
print 'Enter Player 2 name: '
p2_name = gets.chomp

player1 = Player.new(p1_name.empty? ? 'Player 1' : p1_name, "\u25CF")
player2 = Player.new(p2_name.empty? ? 'Player 2' : p2_name, "\u25CB")

game = Game.new(player1, player2)

puts "\nLet's play! #{player1.name} goes first."
puts '.........................................'
game.play

puts "\nThanks for playing!"
