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
    @path = []
    @visited_positions = [start_pos]
    parent = PolyTreeNode.new(start_pos)
    @tree = build_move_tree(parent)
  end
  
  def find_path(target_pos)
    target = @tree.dfs(target_pos)
    trace_path_back(target)
    @path.push(target_pos)
  end
  
  def trace_path_back(target)
    return @path if target.parent.nil? 
    trace_path_back(target.parent).push(target.parent.value)
  end 
  
  def build_move_tree(parent_node)
    queue = [parent_node]
    until queue.empty? 
      parent = queue.shift 
      val_moves = new_move_positions(parent.value)
      val_moves.each do |move|
        child = PolyTreeNode.new(move)
        child.parent = parent
        queue.push(child)
      end
      @visited_positions.push(parent.value)
    end 

    parent_node
  end
  
  def display_tree
    p @tree#.children.each { |child| puts child.value }
  end
  
end 

kpf = KnightPathFinder.new([0, 0])
#kpf.display_tree
p kpf.find_path([7, 6])