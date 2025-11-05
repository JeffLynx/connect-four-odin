require 'rspec'
require_relative '../lib/player.rb'

describe Player do
  describe '#initialize' do
    it 'has a name and symbol' do
      player = Player.new('Jeff', "\u25CB")
      expect(player.name).to eq('Jeff')
      expect(player.symbol).to eq("\u25CB")
    end
  end

  describe '#make_move' do
    it 'returns the chosen column index as an integer' do
      player = Player.new('Jeff', "\u25CB")
      allow($stdin).to receive(:gets).and_return("3\n")
      expect(player.make_move).to eq(3)
    end
  end
end
