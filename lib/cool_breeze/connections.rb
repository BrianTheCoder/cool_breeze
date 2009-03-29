module CoolBreeze
  class Connections
    class_inheritable_accessor(:adapters)
    self.adapters ||= {}

    def self.setup(name, instance)
      adapters[name] = instance
    end
  end
end