module Cloud
  module Indicies
    class Counter
      attr_accessor :key, :redis
      def initialize(key,r)
        @key = key
        @redis = r
      end
      
      def incr
        @redis.incr(@key)
      end
      
      def decr
        @redis.decr(@key)
      end
    end
  end
end