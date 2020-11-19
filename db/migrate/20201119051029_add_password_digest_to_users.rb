class AddPasswordDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    # セキュアなpasswordを実装する
    # password_digestは属性、stringは型
    add_column :users, :password_digest, :string
  end
end
