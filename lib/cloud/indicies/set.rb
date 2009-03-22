module Cloud
  module Indicies
    class Set
      attr_accessor :key, :redis
      def initialize(key,r)
        @key = key
        @redis = r
      end
      
      def add(val)
        
      end
      
      def member?(val)
        
      end
      
      def intersect(key)
        
      end
    end
  end
end