class User < ApplicationRecord
  # 仮想の属性を作成する
  attr_accessor :remember_token
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
  # passwordの存在性を検証し、最小文字数を検証するためにminimumで最小文字数を制限する
  # allow_nil: trueオプションを追加することで、パスワードのバリデーションに対して空の時は例外処理を加えられる
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    # secure_passwordのソースコード
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    # パスワードを生成する
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    # 長さ22のランダムな文字列を返す
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにuserをDBに記憶する
  def remember
    # remember_token遠いう名前のローカル変数を作成しないように、selfキーワードを与え、記憶トークン（ブラウザを閉じてもログイン情報を記憶している）を作成する
    self.remember_token = User.new_token
    # update_attributeメソッド（バリデーションを素通りさせる）を使って記憶ダイジェストを更新する）
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    # ダイジェストがnilの場合はfalseを返す
    return false if remember_digest.nil?
    # 渡されたトークンがuserの記憶ダイジェストと一致することを確認する
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # userのlogin情報を破棄する
  def forget
    # userを忘れる
    update_attribute(:remember_digest, nil)
  end
end
