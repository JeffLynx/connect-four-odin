require_relative './board.rb'
require_relative './player.rb'
require_relative './display.rb'

class Game
  attr_reader :board, :current_player
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @current_player = player1
    @board = Board.new
  end

  def switch_player
    @current_player = (@current_player == @player1 ? @player2 : @player1)
  end

  def take_turn
    column = nil
    loop do
      column = current_player.make_move
      break unless board.column_full?(column)
      puts "Column #{column} is full. Try another one."
    end
    board.drop_piece(column, current_player.symbol)
  end

  def play
    loop do
      Display.render_board(board)
      take_turn
      if board.winner?(current_player.symbol)
        Display.render_board(board)
        puts "#{current_player.name} wins!"
        break
      elsif board.draw?
        Display.render_board(board)
        puts "It's a draw!"
        break
      else
        switch_player
      end
    end
  end
end
