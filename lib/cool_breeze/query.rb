module CoolBreeze
  class Query
    def initialize(klass,conditions = {})
      @klass = klass
      @query = Rufus::Tokyo::TableQuery.new(CoolBreeze::Connections.adapters[:tokyo])
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
        key = [key,:eq] if key.is_a?(Symbol)
        if key.last == :eq 
          if val.is_a? Numeric
            key[1] = :numeq
          else val.is_a? String
            key[1] = :streq
          end
        end
        key[0] = key.first.to_s
        @query.add *(key + [val.to_s])
      end
      
      def run
        @query.run
      end
    end
  end
end