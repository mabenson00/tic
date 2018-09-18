require_relative 'Player'
class ComputerPlayer < Player


  def initialize(team, board)
    @board = board
    @team = team
    @open = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]


    p "ok, the computer is #{@team}"
  end
  def take_turn
    position = @open.sample(1)[0]
    p "computer chooses #{position}"
    return position
  end

  


end
