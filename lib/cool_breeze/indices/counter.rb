module CoolBreeze
  module Indices
    class Counter
      def incr
        @index_store.incr(@key)
      end
      
      def decr
        @index_store.decr(@key)
      end
    end
  end
end