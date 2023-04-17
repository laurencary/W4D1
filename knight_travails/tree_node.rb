class PolyTreeNode
    
    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent)
        # return @parent.children.delete(self) if parent == nil 
        if parent == nil 
            @parent.children.delete(self)
            @parent = nil 
        
        elsif @parent == nil
            @parent = parent
            parent.children << self
        elsif @parent != nil && @parent != parent 
            @parent.children.delete(self)
            @parent = parent
            parent.children << self
        end
    end

    def add_child(child)
        
        if !self.children.include?(child)
            child.parent = self
        end
    end
    def remove_child(child)
        if @children.include?(child)
            child.parent = nil 
        else 
            raise "this child does not exist"
        end
    end

    def dfs(target)
        # puts self.value
        return self if self.value == target 
        self.children.each do |child|
            found = child.dfs(target)
            return found if found
        end
        nil
    end

    def bfs(target)
        # return self if self.value == target
        queue = [self] 
        until queue.empty? 
            node = queue.shift 
            if node.value == target 
                return node
            else 
            queue += node.children 
            end
        end
        nil
    end

end
