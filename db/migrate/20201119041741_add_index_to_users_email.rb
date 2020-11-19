class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    # add_indexでusersテーブルのemailカラムにインデックスを追加し、unique: trueで一意性を強制する
    # 全表スキャンを使わずに済む
    add_index :users, :email, unique: true
  end
end
