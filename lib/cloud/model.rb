module Cloud
  module Model
    def self.included(model)
      model.class_eval do
        attr_accessor :data
        
        @class_indicies = {}
        @instance_indicies = {}
        
        include InstanceMethods
        include Validatable
        include Extlib::Hook
      end
      model.extend ClassMethods
    end
    module ClassMethods
      INDEX_TYPES = %w(value list set counter)
      
      def get(id)
        d = adapter(:tokyo)[id]
        return nil if d.nil?
        m = Message.new(d)
        m.key = id
        m
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
        klass = Module.find_const("Cloud::Indicies::#{type.to_s.to_const_string}")
        class_indicies[name] = "#{self.to_s.downcase}:#{name}"
        instance_eval <<-RUBY, __FILE__, __LINE__
          def #{name}(opts = {})
            adapter(:redis)["#{self.to_s.downcase}:#{name}"]
          end
        RUBY
        callbacks.each do |method|
          after method do
            key = "#{self.class.to_s.downcase}:#{name}"
            proc.call(klass.new(key,@r)) unless proc.nil?
          end
        end
      end
      
      def instance_index(name,type, methods = nil, &proc)
        callbacks = methods || [:create, :destroy]
        klass = Module.find_const("Cloud::Indicies::#{type.to_s.to_const_string}")
        instance_indicies[name] = ''
        class_eval do
          define_method name do |*args|
            key = "#{self.class.to_s.downcase}:#{self.key}:#{name}"
            p key
            p @r
            @r[key]
          end
          callbacks.each do |method|
            after method do
              key = "#{self.class.to_s.downcase}:#{self.key}:#{name}"
              proc.call(klass.new(key,@r)) unless proc.nil?
            end
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
        @data = data.each{|k,v| data[k] = v.to_s}
        @r = self.class.adapter(:redis)
        @t = self.class.adapter(:tokyo)
      end
      
      def key
        @key ||= Guid.new.to_s
      end
      
      def key=(k)
        @key = k
      end
      
      def new?
        @t[key].nil?
      end
      
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
        @t[key] = @data
      end
      
      def update
        @t[key] = @data
      end
      
      def destroy
        @t.delete(key)
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