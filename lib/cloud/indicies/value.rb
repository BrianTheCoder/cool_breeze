module Cloud
  module Indicies
    class Value < Abstract
      def set(val)
        @redis[@key] = val
      end
    end
  end
end