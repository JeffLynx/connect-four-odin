class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def make_move
    print "#{name}, choose where to drop your token (0-6): "
    $stdin.gets.chomp.to_i
  end

end
