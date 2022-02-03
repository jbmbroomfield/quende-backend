class ChangeUserAccountLevelDefaultToMember < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :account_level, from: nil, to: "member"
  end
end
