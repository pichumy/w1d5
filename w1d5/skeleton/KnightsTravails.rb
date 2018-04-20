require 'byebug'
require_relative "lib/00_tree_node.rb"

class KnightPathFinder
  attr_reader :visited_positions, :tree
  
  def self.valid_moves(valid_move_list)
    valid_move_list.select { |move| move.all? { |xy| xy < 8 && xy >= 0 } } 
  end
  
  def new_move_positions(pos)
    x, y = pos
    valid_moves_list = [
      [x + 1, y + 2],
      [x + 2, y + 1],
      [x + 2, y - 1],
      [x + 1, y - 2],
      [x - 1, y + 2],
      [x - 2, y + 1],
      [x - 2, y - 1],
      [x - 1, y - 2]]
    validated_moves = KnightPathFinder.valid_moves(valid_moves_list)
    validated_moves.select { |move| !@visited_positions.include?(move) }
  end
  
  
  
  def initialize(start_pos)
    @path = [start_pos]
    @visited_positions = [start_pos]
    @tree = build_move_tree(start_pos)
    
  end
  
  def find_path(target_pos)
    
  end
  
  def build_move_tree(start)
    parent = PolyTreeNode.new(start)
    val_moves = new_move_positions(start)
    val_moves.each do |move|
      child = PolyTreeNode.new(move)
      child.parent = parent
    end

    parent
  end
  
  def display_tree
    p @tree#.children.each { |child| puts child.value }
  end
  
end 

kpf = KnightPathFinder.new([0, 1])
kpf.display_tree