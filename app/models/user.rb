class User < ApplicationRecord

    has_one :password_authentication
    
    accepts_nested_attributes_for :password_authentication

    has_many :posts

    def to_s
        "#{username} - #{id}"
    end

    def password_authenticate(password)
        password_authentication && password_authentication.authenticate(password)
    end

    def admin?
        account_level == 'admin'
    end

end
