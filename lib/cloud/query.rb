module Cloud
  class Query
    def initialize(klass,conditions = {})
      @klass = klass
      @query = Rufus::Tokyo::TableQuery.new(Cloud::Connections.adapters[:tokyo])
      parse_conditions(conditions)
    end
    
    def parse_conditions(conds)
      # check for order condtion
      order = conds.delete(:order_by)
      @query.order_by(*order) unless order.nil?
      # check for limit condition
      offset = conds.delete(:offset)
      limit = conds.delete(:limit)
      @query.limit(limit, offset || -1) unless limit.nil?
      # take conditions from :prop.op => val to add(prop, op, value)
      conds.each do |key, val|
        raise unless @klass.properties.include?(key.first)
        @query.add *(key + [val.to_s])
      end
      
      def run
        @query.run
      end
    end
  end
end