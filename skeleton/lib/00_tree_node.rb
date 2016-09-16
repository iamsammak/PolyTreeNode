class PolyTreeNode
  attr_accessor :value, :children

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @children = []
  end

  def parent
    @parent
  end

  def parent=(new_parent)
    child = self
    old_parent = child.parent
    @parent = new_parent
    if new_parent.nil?
      return @parent
    elsif old_parent == nil
      new_parent.children += [child] unless new_parent.children.include?(child)
    else #if child has parent before
      new_parent.children += [child] unless new_parent.children.include?(child)
      old_parent.children.delete(child) unless new_parent == old_parent
    end
  end
  # if old_parent == nil then assign it if not
  # reassign it, but then delete that self from parent child array

  def children
    @children
  end

  def add_child(child)
    parent = self
    # parent.children << child
    child.parent = parent
  end

  def remove_child(child)
    parent = self
    child.parent = nil

    raise "Node not a child!" if child.parent == nil
  end

  def dfs(target)
    return self if self.value == target
    self.children.each do |child|
      result = child.dfs(target)
      return result if result #unless result.nil?
    end
    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      return queue[0] if queue[0].value == target
      queue += queue[0].children
      queue.shift
    end
    nil
  end
end

# node1 = PolyTreeNode.new('root')
# node2 = PolyTreeNode.new('child1')
# node3 = PolyTreeNode.new('child2')
#
# node2.parent = node1
# node3.parent = node1
# node4 = PolyTreeNode.new('child3')
# node4.parent = node3
