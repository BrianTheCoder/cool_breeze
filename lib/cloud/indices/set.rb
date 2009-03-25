module Cloud
  module Indices
    class Set < Abstract
      def get
        @redis.set_members(@key)
      end
      
      def add(val)
        @redis.set_add(@key,val)
      end
      
      def size
        @redis.set_count(@key)
      end
      
      def include?(val)
        @redis.set_member?(@key, val)
      end
      
      def remove(val)
        @redis.set_delete(@key, val)
      end
      
      def intersect(key)
        @redis.set_intersect(@key, key)
      end
    end
  end
end