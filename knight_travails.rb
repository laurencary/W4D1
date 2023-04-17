require_relative "tree_node.rb"
require 'byebug'

class KnightPathFinder

    def self.valid_moves(pos)
        potential_move = [[-1, -2], [-1, 2], [1, -2], [1, 2]]
        valid_positions = []

        potential_move.each do |move|
            new_row = pos[0] + move[0]
            new_col = pos[1] + move[1]
            #debugger

            if (0..7).to_a.include?(new_row) && (0..7).to_a.include?(new_col)
                valid_positions << [new_row, new_col]
                valid_positions << [new_col, new_row]
            end

        end
        valid_positions
    end

    attr_reader :root_node 

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        
    end

    def build_move_tree

    end

end