module CoolBreeze
  module Indices
    class Set < Abstract
      def get
        @index_store.set_members(@key)
      end
      
      def add(val)
        @index_store.set_add(@key,val)
      end
      
      def size
        @index_store.set_count(@key)
      end
      
      def include?(val)
        @index_store.set_member?(@key, val)
      end
      
      def remove(val)
        @index_store.set_delete(@key, val)
      end
      
      def intersect(key)
        @index_store.set_intersect(@key, key)
      end
    end
  end
end