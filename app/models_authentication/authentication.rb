class Authentication < ApplicationRecord
  
  belongs_to :user
  
  has_one :password_authentication

  def authenticate(params)
    if params[:password] && password_authentication.authenticate(params[:password])
      true
    else
      false
    end
  end

  def password=(password)
    if !password_authentication
      self.password_authentication = PasswordAuthentication.create(authentication: self, password: password)
      self.save
      return
    end
    password_authentication.password = password
  end

end
