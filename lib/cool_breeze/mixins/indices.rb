module CoolBreeze
  module Mixins
    module Indices
      def self.included(base)
        base.class_eval <<-EOS, __FILE__, __LINE__
          class_inheritable_accessor(:index_types)
          class_inheritable_accessor(:class_indices)
          class_inheritable_accessor(:instance_indices)
          self.index_types = %w(value list set counter)
          self.class_indices = {}
          self.instance_indices = {}
        EOS
        
        base.extend(ClassMethods)
      end
    
      module ClassMethods
        def class_indicies
          @class_indicies
        end
      
        def instance_indicies
          @instance_indicies
        end
      
        def class_index(name,type, methods=nil, &proc)
          callbacks = methods || [:create, :destroy]
          #key is created on method call
          klass = Module.find_const("CoolBreeze::Indices::#{type.to_s.to_const_string}")
          instance_eval <<-RUBY, __FILE__, __LINE__
            def #{name}(opts = {})
              CoolBreeze::Connections.adapters[:redis]["#{self.to_s.downcase}:#{name}"]
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
          klass = Module.find_const("CoolBreeze::Indices::#{type.to_s.to_const_string}")
          class_eval do
            define_method name do
              key = "#{self.class.to_s.downcase}:#{self.key}:#{name}"
              CoolBreeze::Connections.adapters[:redis][key]
            end
          end
          callbacks.each do |method|
            after method do
              key = "#{self.class.to_s.downcase}:#{self.key}:#{name}"
              proc.call(klass.new(key,index_store)) unless proc.nil?
            end
          end
        end
      end
    end
  end
end