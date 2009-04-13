module CoolBreeze
  module Types
    class Value < Abstract
      def set(val)
        @index_store[@key] = val
      end
    end
  end
end