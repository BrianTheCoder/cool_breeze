module Cloud
  module Indices
    class Counter
      def incr
        @redis.incr(@key)
      end
      
      def decr
        @redis.decr(@key)
      end
    end
  end
end