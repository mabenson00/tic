require_relative 'player'
require 'pry'

class Board
  attr_reader :complete, :open, :print_board
  def initialize
    @spaces = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    @complete = false
  end

  def duplicate(obj) ## when I did board = @board.dup it still referenced @board, and changed it when i was trying to print
   Marshal::load(Marshal.dump(obj))
  end

  def find_spot(position, team)
    row = find_row(position[0])
    pos = (position[1].to_i) -1
    if row[pos] == nil
      row[pos] = team
      check_for_winner
    else
      p "that spot is already taken"
      return false
    end
    print_board
  end

  def find_row(letter)
    alpha_table = {}
    (('A'..'Z').zip(0..25)).each { |x| alpha_table[x[0]] = x[1] }
    @spaces[alpha_table[letter.capitalize]]
  end

  def print_board
    letter = "A"
    p " 1 2 3"
    board = duplicate(@spaces)
    board.each do |row|
      row.unshift(letter)
      p row.join("|")
      letter.next!
    end
  end

  def check_for_winner
    board = duplicate(@spaces)
    check_for_horizontal(board)
    check_for_vertical(board)
    check_for_diagonal(board)
  end

  def check_for_horizontal(board)
    board.each do |row|
      if row.uniq.length == 1 && row[0] == ("x" || "o") ## check to see if any row is all X's or O's
        @complete = true
      end
    end
  end

  def check_for_vertical(board) #Transpose the board so that the columns are now rows, then check for horizontal
    board = board.transpose
    check_for_horizontal(board)
  end

  def check_for_diagonal(board) #rotate the rows, so that the diagonals are now columns, then check for rows. I might be missing an edge case here.
      board.each_with_index do |row, i|
        row.rotate!(i)
      end
      check_for_vertical(board)
  end

end
