module CoolBreeze
  module Types
    class Counter < Abstract
      def incr
        @index_store.incr(@key)
      end
      
      def decr
        @index_store.decr(@key)
      end
    end
  end
end