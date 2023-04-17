require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return false if @board.over? && !@board.won?
    return true if @board.winner != evaluator 
    return false if @board.winner == evaluator

    if evaluator == @next_mover_mark
      losers = children.all? { |state| state.losing_node?(evaluator)}
      return true if losers
    else
      children.any? { |state| state.losing_node?(evaluator) }
    end

  end

  def winning_node?(evaluator)

  end

  # This method generates an array of all moves that can be made after
  # the current move.
  
  def children
    @board.open_positions.map do |pos|
      state = @board.dup
      state[pos] = next_mover_mark
      @prev_move_pos = pos
      TicTacToeNode.new(state, state.next_mark, @prev_move_pos)
    end
  end

end