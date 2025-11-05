class Board
  attr_reader :grid
  ROWS = 6
  COLS = 7

  def initialize
    @grid = Array.new(ROWS) { Array.new(COLS, nil) }
  end

  def drop_piece(column, symbol)
    row = (ROWS - 1).downto(0).find { |r| grid[r][column].nil? }
    grid[row][column] = symbol if row
  end

  def column_full?(column)
    grid[0][column] != nil
  end

  def winner?(symbol)
    horizontal_win?(symbol) ||
      vertical_win?(symbol) ||
      diagonal_win?(symbol)
  end

  def draw?
    grid.flatten.none?(&:nil?) && !winner?("\u25CF") && !winner?("\u25CB")
  end

  private

  def horizontal_win?(symbol)
    grid.any? { |row| row.each_cons(4).any? { |seq| seq.all?(symbol) } }
  end

  def vertical_win?(symbol)
    COLS.times.any? do |col|
      grid.map { |row| row[col] }.each_cons(4).any? { |seq| seq.all?(symbol) }
    end
  end

  def diagonal_win?(symbol)
    topleft_bottomright_win?(symbol) || topright_bottomleft_win?(symbol)
  end

  def topleft_bottomright_win?(symbol)
    (0..ROWS - 4).any? do |r|
      (0..COLS - 4).any? do |c|
        (0..3).all? { |i| grid[r + i][c + i] == symbol }
      end
    end
  end

  def topright_bottomleft_win?(symbol)
    (3..ROWS - 1).any? do |r|
      (0..COLS - 4).any? do |c|
        (0..3).all? { |i| grid[r - i][c + i] == symbol }
      end
    end
  end
end
