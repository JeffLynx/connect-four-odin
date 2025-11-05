require 'rspec'
require_relative '../lib/display.rb'
require_relative '../lib/board.rb'

describe Display do
  describe '.render_board' do
    it 'prints the board in the correct format' do
      board = Board.new
      exected_output = <<~BOARD
       0 1 2 3 4 5 6 
      | | | | | | | |
      | | | | | | | |
      | | | | | | | |
      | | | | | | | |
      | | | | | | | |
      | | | | | | | |
      ¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
      BOARD

      expect { Display.render_board(board) }.to output(exected_output).to_stdout
    end

    it 'displays symbols in correct positions' do
      board = Board.new
      board.grid[5][0] = "\u25CF"
      board.grid[4][0] = "\u25CB"

      exected_output = <<~BOARD
       0 1 2 3 4 5 6 
      | | | | | | | |
      | | | | | | | |
      | | | | | | | |
      | | | | | | | |
      |\u25CB| | | | | | |
      |\u25CF| | | | | | |
      ¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
      BOARD
      expect { Display.render_board(board) }.to output(exected_output).to_stdout
    end
  end
end
