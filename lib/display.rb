module Display
  def self.render_board(board)
    puts ' 0 1 2 3 4 5 6 '
    board.grid.each do |row|
      print '|'
      row.each do |cell|
        print (cell.nil? ? ' ' : "#{cell}")
        print '|'
      end
      puts
    end
    puts '¨' * 15
  end
end
