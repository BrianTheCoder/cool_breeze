module CoolBreeze
  module Model
    def self.included(model)
      model.send(:attr_accessor, :data)
      model.send(:include, InstanceMethods)
      model.send(:include, Validatable)
      model.send(:include, Extlib::Hook)
      model.send(:include, CoolBreeze::Mixins::Properties)
      model.send(:include, CoolBreeze::Mixins::Indices)
      model.extend(ClassMethods)
    end
    module ClassMethods            
      def get(id)
        d = data_store[id]
        return nil if d.nil?
        m = self.new(d)
        m.key = id
        m
      end
      
      alias :[] :get
      
      def find(query)
        rs = CoolBreeze::Query.new(self,query)
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