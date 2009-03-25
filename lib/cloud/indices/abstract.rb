module Cloud
  module Indices
    class Abstract
      attr_accessor :key, :redis
      def initialize(key,r)
        @key = key
        @redis = r
      end
      
      def get
        @redis[@key]
      end
      
      def destroy
        @redis.delete(@key)
      end
    end
  end
end