# rails_helperを読み込む
require "rails_helper"

# アカウント有効化に対するテストをする
RSpec.describe "AccountActivations", type: :request do
  # Userモデルのファクトリを作成する
  let(:user) { FactoryBot.create(:user, :no_activated) }
  # 正しいトークンと間違ったemailの場合のテスト
  context "when user sends right token and wrong email" do
    # 前処理
    before do
      # edit_account_activationページへアクセスする
      get edit_account_activation_path(
        # アクセス情報
        user.activation_token,
        # アクセス情報
        email: "wrong",
      )
    end

    # loginに失敗した場合の処理
    it "falis login" do
      # is_logged_in?メソッドの戻り値がfalsyであることを期待する
      expect(is_logged_in?).to be_falsy
      # rootページへリダイレクトすることを期待する
      expect(response).to redirect_to root_url
    end
  end

  # 間違ったトークンと正しいemailの場合のテスト
  context "when user sends wrong token and right email" do
    # 前処理
    before do
      # edit_account_activationページへアクセスする
      get edit_account_activation_path(
        # アクセス情報
        "wrong",
        # アクセス情報
        email: user.email,
      )
    end

    # loginに失敗した場合の処理
    it "falis login" do
      # is_logged_in?メソッドの戻り値がfalsyであることを期待する
      expect(is_logged_in?).to be_falsy
      # rootページへリダイレクトすることを期待する
      expect(response).to redirect_to root_url
    end
  end

  # トークン、emailが両方正しい場合のテスト
  context "when user sends right token and right email" do
    # 前処理
    before do
      # edit_account_activationページへアクセスする
      get edit_account_activation_path(
        # アクセス情報
        user.activation_token,
        # アクセス情報
        email: user.email,
      )
    end

    # loginに成功した場合の処理
    it "succeeds login" do
      # is_logged_in?メソッドの戻り値がfalsyであることを期待する
      expect(is_logged_in?).to be_truthy
      # rootページへリダイレクトすることを期待する
      expect(response).to redirect_to user
    end
  end
end
