class PasswordAuthentication < ApplicationRecord
  
  belongs_to :authentication
  
  has_secure_password

end
