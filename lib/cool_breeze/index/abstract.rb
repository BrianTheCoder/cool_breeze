module CoolBreeze
  module Index
    class Abstract
      attr_accessor :name, :type
      def initialize(name,type)
        @name = name
        @type = type
      end
      
      def get_key(klass)
        @get_key ||= "#{klass.to_s.downcase}:#{@name}"
      end
      
      def type_klass
        @type_klass ||= Module.find_const("CoolBreeze::Indices::#{@type.to_s.to_const_string}")
      end
    end
  end
end