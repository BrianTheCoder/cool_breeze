module Cloud
  module Indicies
    class List < Abstract
      def length
        @redis.list_length(@key)
      end
      
      def push(val)
        @redis.push_tail(@key, val)
      end
      
      def pop
        @redis.pop_tail(@key)
      end
      
      def unshift
        @redis.pop_head(@key)
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