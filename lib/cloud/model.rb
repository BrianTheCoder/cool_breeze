module Cloud
  module Model
    def self.included(model)
      model.class_eval do
        attr_accessor :data
        
        @class_indicies = {}
        @instance_indicies = {}
        @properties = []
        
        include InstanceMethods
        include Validatable
        include Extlib::Hook
      end
      model.extend ClassMethods
    end
    module ClassMethods
      INDEX_TYPES = %w(value list set counter)
      
      def property(name)
        properties << name
        class_eval <<-RUBY, __FILE__, __LINE__
          def #{name}()
            data['#{name.to_s}']
          end
          
          def #{name}=(val)
            data['#{name.to_s}'] = val
          end
          
          def #{name}?
            data['#{name.to_s}'] == true
          end
        RUBY
      end
      
      def cast(name,opts = {})
        property(name) unless properties.include?(name)
        klass = opts.delete(:as)
        raise if klass.nil?
        class_eval <<-RUBY, __FILE__, __LINE__
          def #{name}()
          end
          
          def #{name}=(val)
          end
        RUBY
      end
      
      def get(id)
        d = data_store[id]
        return nil if d.nil?
        m = self.new(d)
        m.key = id
        m
      end
      
      def find(query)
        rs = Cloud::Query.new(self,query)
        l = LazyArray.new
        l = rs.to_a
        rs.free
        l
      end
      
      def first(query)
        find(query.merge(:limit => 1))
      end
      
      def index_store
        adapter(:redis)
      end
      
      def data_store
        adapter(:tokyo)
      end
      
      def properties
        @properties
      end
      
      def class_indicies
        @class_indicies
      end
      
      def instance_indicies
        @instance_indicies
      end
      
      def class_index(name,type, methods=nil, &proc)
        callbacks = methods || [:create, :destroy]
        #key is created on method call
        klass = Module.find_const("Cloud::Indices::#{type.to_s.to_const_string}")
        class_indicies[name] = "#{self.to_s.downcase}:#{name}"
        instance_eval <<-RUBY, __FILE__, __LINE__
          def #{name}(opts = {})
            adapter(:redis)["#{self.to_s.downcase}:#{name}"]
          end
        RUBY
        callbacks.each do |method|
          after method do
            key = "#{self.class.to_s.downcase}:#{name}"
            proc.call(klass.new(key,index_store)) unless proc.nil?
          end
        end
      end
      
      def instance_index(name,type, methods = nil, &proc)
        callbacks = methods || [:create, :destroy]
        klass = Module.find_const("Cloud::Indices::#{type.to_s.to_const_string}")
        instance_indicies[name] = ''
        class_eval do
          define_method name do
            key = "#{self.class.to_s.downcase}:#{self.key}:#{name}"
            @r[key]
          end
        end
        callbacks.each do |method|
          after method do
            key = "#{self.class.to_s.downcase}:#{self.key}:#{name}"
            proc.call(klass.new(key,index_store)) unless proc.nil?
          end
        end
      end
      
      def all(*ids)
        ids.map{|id| get(id)}
      end
      
      def adapter(name)
        Connections.adapters[name]
      end
    end
    
    module InstanceMethods
      def initialize(data = {})
        @data = {}
        data.each do |k,v|
          self.send(:"#{k}=",v.to_s)
        end
        @index_store = self.class.index_store
        @data_store = self.class.data_store
      end
      
      def key
        @key ||= Guid.new.to_s
      end
      
      def key=(k)
        @key = k
      end
            
      def new?
        @data_store[key].nil?
      end
      
      alias :new_record? :new?
      
      def [](key)
        @data[key]
      end
      
      def []=(key,val)
        @data[key] = val.to_s
      end
      
      def save
        if new?
          create
        else
          update
        end
      end
      
      def create
        @data_store[key] = @data
      end
      
      def update
        @data_store[key] = @data
      end
      
      def destroy
        @data_store.delete(key)
      end
    end
  end
end