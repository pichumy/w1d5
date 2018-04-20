class PolyTreeNode
  attr_reader :value, :parent, :children
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent=(node)
    return if @parent == node
    
    if node.nil? 
      @parent.remove_from_children(self)
      @parent = nil 
      return 
    end 
    
    if @parent.nil?
      @parent = node
    else
      @parent.remove_from_children(self)
      @parent = node
    end
    
    node.children.push(self)
  end
  
  def remove_from_children(node)
    @children.delete(node)
  end
  
  def add_child(child_node)
    child_node.parent = self 
  end 
  
  def remove_child(child_node)
    raise "Error, not a child!" unless @children.include?(child_node)
    child_node.parent = nil 
  end 
  
  def dfs(target_value)
    return self if self.value == target_value
    children.each do |node| 
      value = node.dfs(target_value)
      return value unless value.nil? 
    end
    nil
  end 
  
  def bfs(target_value)
    queue = [self]
    until queue.empty? 
      node = queue.shift
      if node.value == target_value
        return node 
      else 
        node.children.each do |node| 
          queue.push(node)
        end  
      end 
    end 
    nil  
  end 
  
  def inspect
      { 'value' => @value, 'parent_value' => @parent.value }.inspect
  end 
  
end


