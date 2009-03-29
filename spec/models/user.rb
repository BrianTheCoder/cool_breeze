class User
  include CoolBreeze::Model
  
  property :email
  property :salt
  property :crypted_password
  property :first_name
  property :last_name
end