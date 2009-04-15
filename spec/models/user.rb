class User
  include CoolBreeze::Model
  
  many :messages
end