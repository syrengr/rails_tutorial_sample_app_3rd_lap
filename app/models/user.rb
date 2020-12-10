class User < ApplicationRecord
  # Micropostを所有する
  has_many :microposts, dependent: :destroy
  # 仮想の属性を作成する
  attr_accessor :remember_token, :activation_token, :reset_token
  # userをDBに保存する前にemail属性を小文字にする
  before_save :downcase_email
  # userをDBに作成する前にメソッドを参照する
  before_create :create_activation_digest
  
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
  def authenticated?(attribute, token)
    # 変数にダイジェストを代入する
    digest = send("#{attribute}_digest")
    # ダイジェストがnilの場合はfalseを返す
    return false if digest.nil?
    # 渡されたトークンがuserの記憶ダイジェストと一致することを確認する
    BCrypt::Password.new(digest).is_password?(token)
  end

  # userのlogin情報を破棄する
  def forget
    # userを忘れる
    update_attribute(:remember_digest, nil)
  end

  # アカウントを有効にする
  def activate
    # userの有効化属性を更新し、userのTime.zoneを設定する
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    # 有効化メールを送信する
    UserMailer.account_activation(self).deliver_now
  end

  # password再設定の属性を設定する
  def create_reset_digest
    # 変数にトークンを代入する
    self.reset_token = User.new_token
    # ダイジェストとTime.zoneを更新する
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  # password再設定のメールを送信する
  def send_password_reset_email
    # password再設定
    UserMailer.password_reset(self).deliver_now
  end

  # password再設定用メソッドを追加する
  def password_reset_expired?
    # 2時間以上passwordが再設定されていないか確認する
    reset_sent_at < 2.hours.ago
  end

  # マイクロポストのステータスフィードを実装するための準備
  def feed
    # Micropostモデルのidを取得する
    Micropost.where("user_id = ?", id)
  end

  private

  # emailを全て小文字にする
  def downcase_email
    # 変数に小文字化したemailを代入する
    self.email = email.downcase
  end

  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    # 変数にUserモデルのnew_tokenを代入する
    self.activation_token = User.new_token
    # 変数にUserモデルのactivation_tokenを代入する
    self.activation_digest = User.digest(activation_token)
  end
end
