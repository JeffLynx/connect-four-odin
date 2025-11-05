require 'rspec'
require_relative '../lib/board.rb'

describe Board do
  describe '#initialize' do
    it 'initializes an empty grid with 6 rows and 7 columns' do
      board = Board.new
      expect(board.grid.size).to eq(6)
      expect(board.grid.all? { |row| row.size == 7 }).to be true
      expect(board.grid.flatten.all?(&:nil?)).to be true
    end
  end

  describe '#drop_piece' do
    it 'places a symbol in the lowest possible slot of a column' do
      board = Board.new
      board.drop_piece(0, 'O')
      board.drop_piece(0, 'X')
      expect(board.grid[5][0]).to eq('O')
      expect(board.grid[4][0]).to eq('X')
    end
  end

  describe '#column_full?' do
    it 'returns true if a column is full' do
      board = Board.new
      6.times { board.drop_piece(0, 'O') }
      expect(board.column_full?(0)).to be true
    end

    it 'returns false if a column has space' do
      board = Board.new
      5.times { board.drop_piece(0, 'O') }
      expect(board.column_full?(0)).to be false
    end
  end

  describe '#winner?' do
    it 'detects a horizontal win' do
      board = Board.new
      4.times { |i| board.grid[5][i] = 'X' }
      expect(board.winner?('X')).to be true
    end

    it 'detects a vertical win' do
      board = Board.new
      4.times { |i| board.grid[5 - i][0] = 'O' }
      expect(board.winner?('O')).to be true
    end

    it 'detects a top left - bottom right diagonal win' do
      board = Board.new
      4.times { |i| board.grid[2 + i][i] = 'X' }
      expect(board.winner?('X')).to be true
    end

    it 'detects a top right - bottom left diagonal win' do
      board = Board.new
      4.times { |i| board.grid[5 - i][i] = 'O' }
      expect(board.winner?('O')).to be true
    end
  end

  describe '#draw?' do
    it 'returns true if the board is full and there is no winner' do
      board = Board.new
      symbols = ['X', 'O']
      6.times do |r|
        7.times do |c|
          board.grid[r][c] = symbols.sample
        end
      end
      allow(board).to receive(:winner?).and_return(false)
      expect(board.draw?).to be true
    end

    it 'returns false if there is a winner' do
      board = Board.new
      4.times { |i| board.grid[5][i] = 'X' }
      expect(board.draw?).to be false
    end
  end
end
