module CoolBreeze
  module Model
    def self.included(model)
      model.send(:include, InstanceMethods)
      model.send(:include, Validatable)
      model.send(:include, Extlib::Hook)
      model.send(:include, CoolBreeze::Mixins::Indices)
      model.send(:include, CoolBreeze::Mixins::Associations)
      model.class_inheritable_accessor(:default_conditions)
      model.extend(ClassMethods)
      model.class_eval do
        self.default_conditions = {:model_type => self.to_s.downcase}
      end
    end
    module ClassMethods            
      def get(id)
        attrs = data_store[id]
        cast(attrs) unless attrs.blank?
      end
      
      alias :[] :get
      
      def find(query = {})
        rs = CoolBreeze::Query.new(self,query).run
        l = LazyArray.new
        l = rs.to_a
      end
      
      def first(query = {})
        attrs = find(query.merge(default_conditions.merge(:limit => 1))).first
        cast(attrs) unless attrs.blank?
      end
      
      def index_store
        adapter(:redis)
      end
      
      def data_store
        adapter(:tokyo)
      end
            
      def all(query = {})
        attrs = find(query.merge(default_conditions))
        attrs.map{|a| cast(a)} unless attrs.blank?
      end
      
      def adapter(name)
        Connections.adapters[name]
      end
      
      def create(data = {})
        m = self.new(data)
        m.save
      end
      
      def timestamps!
        before :save do
          self.created_at = Time.now if new?
          self.updated_at = Time.now
        end
      end
      
      def count(query = {})
        find(query.merge(default_conditions)).size
      end
      
      protected
      
      def cast(attrs)
        key = attrs.delete(:pk)
        m = self.new(attrs)
        m.key = key
        m
      end
    end
    
    module InstanceMethods
      def initialize(data = {})
        @index_store = self.class.index_store
        @data_store = self.class.data_store
        @data = {}
        data.each do |k,v|
          self.send(:"#{k}=",v.to_s)
        end
      end
      
      def properties
        @data.keys
      end
      
      def key
        @key ||= "#{self.class.to_s.downcase}:#{Guid.new.to_s}"
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
        unless @data.has_key?(:model_type)
          self.model_type = self.class.to_s.downcase
        end
        @data_store[key] = @data
        return @data_store[key] == @data
      end
      
      def destroy
        @data_store.delete(key)
      end
      
      def method_missing(method_symbol, *arguments)
        method_name = method_symbol.to_s

        case method_name[-1..-1]
        when "="
          @data[method_name[0..-2]] = arguments.first.to_s
        when "?"
          @data[method_name[0..-2]] == true
        else
          # Returns nil on failure so forms will work
          @data.has_key?(method_name) ? @data[method_name] : nil
        end
      end
    end
  end
end