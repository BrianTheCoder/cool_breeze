module CoolBreeze
  module Types
    class Abstract
      attr_accessor :key, :index_store
      def initialize(key)
        @key = key
        @index_store = CoolBreeze::Connections.adapters[:redis]
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