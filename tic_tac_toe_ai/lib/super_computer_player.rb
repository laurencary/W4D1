require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    debugger
    children_arr = node.children
    children_arr.each do |child|
      if child.winning_node?(mark)
        return child.prev_move_pos
      end
    end
    
    children_arr.each do |child|
      if !child.losing_node?(mark)
        return child.prev_move_pos
      end
    end  
    
    raise 'you gon lose'
  end
end

if $PROGRAM_NAME == __FILE__
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end