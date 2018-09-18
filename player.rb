class Player
require 'pry'
attr_reader :team
attr_accessor :remove_position
  def initialize(team, board)
    @board = board
    @team = team
    @open = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]
  end

  def remove_position(position)
     @open-=[position]
  end

  def restart
    @open = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]
  end

  def check_for_out_of_bounds(position)
    if position[0] != "A" && position[0] !="B" && position[0] !="C"
      p "you put an invalid space"
      take_turn
    elsif position[1] != "1" && position[1] !="2" && position[1] !="3"
      p "you put an invalid space"
      take_turn
    end
  end


end
