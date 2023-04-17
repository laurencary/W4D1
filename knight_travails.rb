require_relative "tree_node.rb"
require 'byebug'

class KnightPathFinder

    def self.valid_moves(pos)
        potential_move = [[-1, -2], [-1, 2], [1, -2], [1, 2],[-2,-1],[2,-1],[-2,1],[2,1]]
        valid_positions = []

        potential_move.each do |move|
            #debugger
            new_row = pos[0] + move[0]
            new_col = pos[1] + move[1]
            
            if (0..7).to_a.include?(new_row) && (0..7).to_a.include?(new_col)
                valid_positions << [new_row, new_col]
            end

        end
        valid_positions
    end

    attr_reader :root_node
    attr_accessor :considered_pos

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @considered_pos = [start_pos]
    end

    def new_move_positions(pos)
        new_moves = KnightPathFinder.valid_moves(pos)
        filtered_moves = new_moves.reject { |el| @considered_pos.include?(el) }
        @considered_pos += filtered_moves
        filtered_moves 
    end

    def build_move_tree
        queue = [@root_node]

        until queue.empty?
            node = queue.shift
            new_positions = new_move_positions(node.value)
            new_positions.each do |pos|
                child = PolyTreeNode.new(pos)
                node.add_child(child)
                queue << child
            end
        end
    end

    def find_path(end_pos)
        trace_path_back(@root_node.dfs(end_pos))
    end

    def trace_path_back(end_node)

        path = [end_node]
        
        until path[0] == @root_node
            # debugger
            path.unshift(path[0].parent)
        end
        path.map { |node| node.value}
    end

end