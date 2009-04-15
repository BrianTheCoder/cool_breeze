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
        
        def destroy
          instance_indices.each{|idx| idx.destroy }
          super
        end
      end
    
      module ClassMethods
        def class_indicies
          @class_indicies
        end
      
        def instance_indicies
          @instance_indicies
        end
      
        def class_index(name,type)
          klass = Module.find_const("CoolBreeze::Types::#{type.to_s.to_const_string}")
          instance_eval <<-RUBY, __FILE__, __LINE__
            class_indices[name] = klass.new("#{self.to_s.downcase}:#{name}")
            def #{name}(opts = {})
              class_indices[:"#{name}"]
            end
          RUBY
        end
      
        def instance_index(name,type)
          klass = Module.find_const("CoolBreeze::Types::#{type.to_s.to_const_string}")
          class_eval do
            define_method name do
              if instance_indices[name].nil?
                instance_indices[name] = klass.new("#{self.key}:#{name}")
              end
              instance_indices[name]
            end
          end
        end
      end
    end
  end
end