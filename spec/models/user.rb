class User
  include Cloud::Model
  
  property :email
  property :salt
  property :crypted_password
end