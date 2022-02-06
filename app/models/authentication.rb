class Authentication < ApplicationRecord
  
  belongs_to :user
  
  has_one :password_authentication, dependent: :delete

  def authenticate(params)
    if params[:password] && password_authentication.authenticate(params[:password])
      true
    else
      false
    end
  end

  def password=(password)
    if password_authentication
      password_authentication.password = password
    else
      self.password_authentication = PasswordAuthentication.create(authentication: self, password: password)
    end
  end

end
