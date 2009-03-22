module Cloud
  module Indicies
    class Value
      attr_accessor :key, :redis
      def initialize(key,r)
        @key = key
        @redis = r
      end
    end
  end
end