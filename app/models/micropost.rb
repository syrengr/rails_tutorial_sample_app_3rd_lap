class Micropost < ApplicationRecord
  # Userモデルに属する
  belongs_to :user
  # マイクロポストを順序付ける
  default_scope -> { order(created_at: :desc )}
  # CarrieWaveに画像と関連付けたモデルを伝える
  mount_uploader :picture, PictureUploader
  # user_id属性の存在性の検証をする
  validates :user_id, presence: true
  # content属性の存在性の検証をする
  validates :content, presence: true, length: { maximum: 140 }
  # 画像に対するバリデーション
  validate :picture_size

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    # picture.sizeが5.megabytes以下の場合
    if picture.size > 5.megabytes
      # エラーメッセージを表示する
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
