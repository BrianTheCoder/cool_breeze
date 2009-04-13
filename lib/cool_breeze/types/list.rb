module CoolBreeze
  module Types
    class List < Abstract
      def length
        @index_store.list_length(@key)
      end
      
      def push(val)
        @index_store.push_tail(@key, val)
      end
      
      def pop
        @index_store.pop_tail(@key)
      end
      
      def unshift
        @index_store.pop_head(@key)
      end
      
      def shift(val)
        @index_store.push_head(@key, val)
      end
      
      def trim(start, stop)
        @index_store.list_trim(@key, start, stop)
      end
      
      def range(start, stop)
        @index_store.list_range(@key, start, stop)
      end
    end
  end
end