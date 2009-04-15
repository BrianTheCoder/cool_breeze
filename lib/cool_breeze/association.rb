module CoolBreeze
  class Association
    include Enumerable
    
    def initialize(klass, name, options = {})
      @list_name = "#{name}_list"
      @klass = klass
      klass.instance_index :"#{name}_list", :list
    end
    
    def for(instance)
      @list = instance.method(@list_name)
      self
    end
    
    def add(obj)
      @list.call.push(obj.key)
    end
    
    def remove(obj)
      @list.call.remove(1,obj.key)
    end  
    
    def destroy(obj)
      remove(obj)
      obj.destroy
    end
    
    def get(start = 0, stop = -1)
      keys = @list.call.range(start, stop)
      return [] if keys.blank?
      keys.map{|k| @klass.get k}
    end
    
    def size
      @list.call.length
    end
    
    def first
      key = @list.call.range(0,1)
      @klass.get(key) unless key.blank? 
    end
    
    def each
      values = @list.call.range(0,-1)
      return if values.blank?
      values.each do |val|
        yield @klass.get val
      end
    end
  end
end