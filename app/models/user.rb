class User < ApplicationRecord
  # userをDBに保存する前に、email属性を強制的に小文字に変換する
  before_save { email.downcase! }
  
  # name属性の存在性の検証をし、長さの上限を強制する
  validates :name,  presence: true, length: { maximum: 50 }
  # 正規表現を適用してemailのフォーマットを検証する
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  # email属性の存在性の検証をし、長さの上限を強制する（maximumで最大文字数を制限できる）
  validates :email, presence: true, length: { maximum: 255 },
  # emailのフォーマットを検証するために、formatというオプションを使う
  format: { with: VALID_EMAIL_REGEX },
  # emailの一意性を検証し、重複した大文字のemailの場合もfalseになる
  uniqueness: { case_sensitive: false }

  # userがセキュアなパスワードを持っているようにする
  has_secure_password
  # passwordの存在性を検証し、最小文字数を検証する（minimumで最小文字数を制限できる）
  validates :password, presence: true, length: { minimum: 6 }
end
