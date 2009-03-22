module Cloud
  module Indicies
    class List
      attr_accessor :key, :redis
      def initialize(key,r)
        @key = key
        @redis = r
      end
      
      def push(val)
        @redis.push_tail(@key, val)
      end
      
      def shift(val)
        @redis.push_heaf(@key, val)
      end
      
      def trim(start, stop)
        @redis.list_trim(@key, start, stop)
      end
      
      def range(start, stop)
        @redis.list_range(@key, start, stop)
      end
    end
  end
end