class Permission < ApplicationRecord

  def owner
    owner_class.constantize.find_by(owner_id)
  end

end
