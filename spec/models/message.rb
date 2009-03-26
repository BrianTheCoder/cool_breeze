class Message
  include CoolBreeze::Model
  
  property :profile_image_url
  property :created_at
  property :from_user
  property :text
  property :to_user_id
  property :id
  property :from_user_id
  property :iso_language_code
  property :source
  
  def key
    self['id'].to_s
  end
  
  class_index :count, :counter do |obj|
    obj.incr
  end
  
  instance_index :tags, :set do |obj|
    obj.push(self.text.split.first)
  end
end