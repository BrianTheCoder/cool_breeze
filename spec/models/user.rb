class User
  include CoolBreeze::Model
  
  property :email
  property :salt
  property :crypted_password
end