class Message
  include CoolBreeze::Model
  
  def key
    @key ||= "message:#{self['id']}"
  end
  
  timestamps!
  
  class_index :count, :counter
  instance_index :tags, :set
end