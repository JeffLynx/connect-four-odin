require 'rspec'
require_relative '../lib/game.rb'
require_relative '../lib/player.rb'
require_relative '../lib/board.rb'
require_relative '../lib/display.rb'

describe Game do
  let(:player1) { Player.new('Jeff', "\u25CF") }
  let(:player2) { Player.new('Anna', "\u25CB") }
  let(:board) { instance_double(Board) }

  describe '#initialize' do
    it 'initializes with two players and a new board' do
      game = Game.new(player1, player2)
      expect(game.instance_variable_get(:@player1)).to eq(player1)
      expect(game.instance_variable_get(:@player2)).to eq(player2)
      expect(game.instance_variable_get(:@current_player)).to eq(player1)
      expect(game.instance_variable_get(:@board)).to be_a(Board)
    end
  end

  describe '#switch_player' do
    it 'switches from player1 to player2 and back' do
      game = Game.new(player1, player2)
      expect(game.current_player).to eq(player1)
      game.switch_player
      expect(game.current_player).to eq(player2)
      game.switch_player
      expect(game.current_player).to eq(player1)
    end
  end

  describe '#take_turn' do
    it 'drops a piece in a valid column' do
      game = Game.new(player1, player2)
      allow(game.board).to receive(:column_full?).and_return(false)
      allow(game.board).to receive(:drop_piece)
      allow(player1).to receive(:make_move).and_return(3)
      game.take_turn
      expect(game.board).to have_received(:drop_piece).with(3, player1.symbol)
    end

    it 'asks again if column is full' do
      game = Game.new(player1, player2)
      allow(game.board).to receive(:column_full?).and_return(true, false)
      allow(player1).to receive(:make_move).and_return(3, 4)
      allow(game.board).to receive(:drop_piece)
      game.take_turn
      expect(game.board).to have_received(:drop_piece).with(4, player1.symbol)
    end
  end

  describe '#play' do
    it 'ends when a player wins' do
      game = Game.new(player1, player2)
      allow(Display).to receive(:render_board)
      allow(game.board).to receive(:winner?).and_return(false, false, true)
      allow(game.board).to receive(:draw?).and_return(false)
      allow(game).to receive(:take_turn)
      expect { game.play }.to output(/#{player1.name} wins!/).to_stdout
    end

    it 'ends when the board is a draw' do
      game = Game.new(player1, player2)
      allow(Display).to receive(:render_board)
      allow(game.board).to receive(:winner?).and_return(false)
      allow(game.board).to receive(:draw?).and_return(true)
      allow(game).to receive(:take_turn)
      expect { game.play }.to output(/It's a draw!/).to_stdout
    end
  end
end
