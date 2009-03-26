module CoolBreeze
  class Connections
    @adapters = {}
    def self.adapters
      @adapters
    end
    
    def self.setup(name, instance)
      adapters[name] = instance
    end
  end
end