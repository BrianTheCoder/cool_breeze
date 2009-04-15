module CoolBreeze
  module Mixins
    module Associations
      def self.included(base)
        base.class_eval <<-EOS, __FILE__, __LINE__
          class_inheritable_accessor(:associations)
          self.associations = {}
        EOS
        
        base.extend(ClassMethods)
      end
    end
    
    module ClassMethods
      def many(name, options = {})
        associations[name] = CoolBreeze::Association.new(self,name,options = {})
        class_eval <<-EOS, __FILE__, __LINE__
          def #{name}
            self.class.associations[:"#{name}"].for(self)
          end
        EOS
      end
    end
  end
end