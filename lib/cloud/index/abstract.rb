module Cloud
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
        @type_klass ||= Module.find_const("Cloud::Indicies::#{@type.to_s.to_const_string}")
      end
      
      def run(obj, &proc)
        klass = type_klass
        r = Cloud::Connections.adapters[:redis]
        proc.call(obj, klass.new(get_key(obj)))
      end
    end
  end
end