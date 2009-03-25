module Cloud
  module Indices
    class Value < Abstract
      def set(val)
        @redis[@key] = val
      end
    end
  end
end