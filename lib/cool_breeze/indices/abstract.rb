module CoolBreeze
  module Indices
    class Abstract
      attr_accessor :key, :index_store
      def initialize(key,index_store)
        @key = key
        @index_store = index_store
      end
      
      def get
        @index_store[@key]
      end
      
      def destroy
        @index_store.delete(@key)
      end
    end
  end
end