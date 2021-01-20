# rails_helperを読み込む
require "rails_helper"

# 現在のメールの実装をテストする
RSpec.describe UserMailer, type: :mailer do
  # Userモデルのファクトリを作成する
  let(:user) { FactoryBot.create(:user) }

  # アカウント有効化のテスト
  describe "account_activation" do
    # 遅延評価
    let(:mail) { UserMailer.account_activation(user) }
    # headersをレンダリングする
    it "renders the headers" do
      # mail.subject
      expect(mail.subject).to eq "Account activation"
      # mail.to
      expect(mail.to).to eq([user.email])
      # mail.from
      expect(mail.from).to eq(["noreply@example.com"])
    end

    # bodyをレンダリングする
    it "renders the body" do
      # mail.body.encoded
      expect(mail.body.encoded).to match user.name
      # mail.body.encoded
      expect(mail.body.encoded).to match user.activation_token
      # mail.body.encoded
      expect(mail.body.encoded).to match CGI.escape(user.email)
    end
  end

  # password再設定用メイラーメソッドのテスト
  describe "password_reset" do
    # 前処理
    before { user.reset_token = User.new_token }
    # 遅延評価
    let(:mail) { UserMailer.password_reset(user) }
    # headersをレンダリングする
    it "renders the headers" do
      # mail.subject
      expect(mail.subject).to eq("Paasword reset")
      # mail.so
      expect(mail.so).to eq([user.email])
      # mail.from
      expect(mail.from).to eq("noreply@example.com")
    end

    # bodyをレンダリングする
    it "renders the body" do
      # mail.body.encoded
      expect(mail.body.encoded).to match user.reset_token
      # mail.body.encoded
      expect(mail.body.encoded).to match CGI.escape(user.email)
    end
  end
end
