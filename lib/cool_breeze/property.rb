module CoolBreeze
  # Basic attribute support for adding getter/setter + validation
  class Property
    attr_reader :name, :type, :read_only, :alias, :default, :init_method, :options
    
    # attribute to define
    def initialize(name, type = String, options = {})
      @name = name.to_s
      parse_options(options)
      self
    end
    
    
    private
      def parse_options(options)
        return if options.empty?
        @validation_format  = options.delete(:format)     if options[:format]
        @read_only          = options.delete(:read_only)  if options[:read_only]
        @alias              = options.delete(:alias)      if options[:alias]
        @default            = options.delete(:default)    if options[:default]
        @init_method        = options[:send] ? options.delete(:send) : 'new'
        @options            = options
      end
    
  end
end