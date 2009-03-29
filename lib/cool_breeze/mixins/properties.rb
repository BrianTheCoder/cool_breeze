module CoolBreeze
  module Mixins
    module Properties
      def self.included(base)
        base.class_eval <<-EOS, __FILE__, __LINE__
          class_inheritable_accessor(:properties)
          self.properties ||= []
        EOS
        base.extend(ClassMethods)
      end
    
      module ClassMethods
        def property(name, klass = String, options = {})
          existing_property = self.properties.find{|p| p.name == name.to_s}
          if existing_property.nil? || (existing_property.default != options[:default])
            define_property(name, options)
          end
        end
      
        def timestamps!
          property(:created_at, Time)
          property(:updated_at, Time)
          before :save do
            self.updated_at = Time.now
            self.created_at = self.updated_at unless self.new?
          end
        end
      
        protected
      
        def define_property(name, klass, options={})
          # check if this property is going to casted
          property = CoolBreeze::Property.new(name, klass, options)
          create_property_getter(property) 
          create_property_setter(property) unless property.read_only == true
          properties << property
        end
      
        # defines the getter for the property (and optional aliases)
        def create_property_getter(property)
          # meth = property.name
          class_eval <<-EOS, __FILE__, __LINE__
            def #{property.name}
              self['#{property.name}']
            end
          EOS

          if property.alias
            class_eval <<-EOS, __FILE__, __LINE__
              alias #{property.alias.to_sym} #{property.name.to_sym}
            EOS
          end
        end

        # defines the setter for the property (and optional aliases)
        def create_property_setter(property)
          meth = property.name
          class_eval <<-EOS
            def #{meth}=(value)
              self['#{meth}'] = value
            end
          EOS

          if property.alias
            class_eval <<-EOS
              alias #{property.alias.to_sym}= #{meth.to_sym}=
            EOS
          end
        end
      end
    end
  end
end