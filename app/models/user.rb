class User < ApplicationRecord

    has_one :password_authentication
    
    accepts_nested_attributes_for :password_authentication

end
