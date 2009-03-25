module Cloud
  module Index
    class InstanceIndex < Abstract
      def get_key(klass)
        "#{klass.class.to_s.downcase}:#{klass.key}:#{@name}"
      end
    end
  end
end