class Authentication < ApplicationRecord
  
  belongs_to :user

  def password=(password)
    puts "To set password"
  end

end
