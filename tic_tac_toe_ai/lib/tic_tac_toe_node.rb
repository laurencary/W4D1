require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      return (@board.winner != evaluator) && @board.won?
    end

    if evaluator == @next_mover_mark
      children.all? { |state| state.losing_node?(evaluator)}
      #return true if losers
    else
      children.any? { |state| state.losing_node?(evaluator) }
    end

  end

  def winning_node?(evaluator)
    if @board.over?
      return (@board.winner == evaluator) && @board.won?
    end

    if evaluator == @next_mover_mark
      children.any? { |state| state.winning_node?(evaluator) }
    else
      children.all? { |state| state.winning_node?(evaluator)}
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  
  def children
    @board.open_positions.map do |pos|
      state = @board.dup
      state[pos] = next_mover_mark
      @prev_move_pos = pos
      next_mark = @next_mover_mark == :x ? :o : :x
      TicTacToeNode.new(state, next_mark, @prev_move_pos)
    end
  end

end