# rails_helperを読み込む
require "rails_helper"

# password再設定の統合テスト
RSpec.describe "PasswordResets", type: :request do
  # Userモデルのファクトリを作成する
  let(:user) { FactoryBot.create(:user) }
  # 前処理
  before { user.create_reset_digest }
  # newアクションのテスト
  describe "def new" do
    # password再設定用ページへアクセスした場合を検証する
    it "returns http success" do
      # 成功したHTTPを返却する
      get "/password_resets/new"
      # 集計に失敗する
      aggregate_failures do
        # レスポンスに成功することを期待する
        expect(response).to have_http_status(:success)
        # レスポンスに"Forgot password"が含まれていることを期待する
        expect(response.body).to include "Forgot password"
      end
    end
  end

  # createアクションのテスト
  describe "def create" do
    # emailが無効な場合を検証する
    it "falis create with invalid email" do
      # password_resetを登録する
      post password_resets_path, params: { password_reset: { email: "" } }
      # 集計に失敗する
      aggregate_failures do
        # レスポンスに成功することを期待する
        expect(response).to have_http_status(200)
        # レスポンスに"Forgot password"が含まれていることを期待する
        expect(response.body).to include "Forgot password"
      end
    end

    # emailが有効な場合を検証する
    it "succeds create with valid email" do
      # password_resetを登録する
      post password_resets_path, params: { password_reset: { email: user.email } }
      # 集計に失敗する
      aggregate_failures do
        # user.reset_digestとuser.reload.reset_digestが等しくないことを期待する
        expect(user.reset_digest).not_to eq user.reload.reset_digest
        # ActionMailer::Base.deliveriesが1であることを期待する
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end
    end
  end

  # editアクションのテスト
  describe "def edit" do
    # emailが無効な場合を検証する
    context "when user sends correct token and wrong email" do
      # 前処理
      before { get edit_password_reset_path(user.reset_token, email: "") }
      # 編集に失敗した場合を検証する
      it "fails" do
        # rootページへリダイレクトする
        expect(response).to redirect_to root_url
      end
    end
    
    # 無効なuserの場合を検証する
    context "when not activated user sends correct token and email" do
      # 前処理
      before do
        # 真偽値を反対にして保存する
        user.toggle!(:activated)
        # edit_password_resetページへアクセスする
        get edit_password_reset_path(user.reset_token, email: user.email)
      end
      # 編集に失敗した場合を検証する
      it "fails" do
        # rootページへリダイレクトする
        expect(response).to redirect_to root_url
      end
    end

    # emailが有効でトークンが無効な場合を検証する
    context "when user sends wrong token and correct email" do
      # 前処理
      before { get edit_password_reset_path("wrong", email: user.email) }
      # 編集に失敗した場合を検証する
      it "fails" do
        # rootページへリダイレクトする
        expect(response).to redirect_to root_url
      end
    end

    # emailもトークンも有効な場合を検証する
    context "when user sends correct token and email" do
      # 前処理
      before { get edit_password_reset_path(user.reset_token, email: user.email) }
      # 編集に成功した場合を検証する
      it "succeeds" do
        # 集計に失敗する
        aggregate_failures do
          # レスポンスに成功することを期待する
          expect(response).to have_http_status(200)
          # レスポンスに"Reset password"が含まれていることを期待する
          expect(response.body).to include "Reset password"
        end
      end
    end
  end

  # updateアクションのテスト
  describe "def update" do
    # 無効なpasswordとpassword_confirmationを検証する
    context "when user sends wrong password" do
      # 前処理
      before do
        # passwordとpassword_confirmationを更新する
        patch password_reset_path(user.reset_token),
          # params
          params: {
            # email
            email: user.email,
            # user
            user: {
              # password
              password: "foobaz",
              # password_confirmation
              password_confirmation: "barquux",
            },
          }
      end

      # 更新に失敗した場合を検証する
      it "fails" do
        # 集計に失敗する
        aggregate_failures do
          # レスポンスに成功することを期待する
          expect(response).to have_http_status(200)
          # レスポンスに"Reset password"が含まれていることを期待する
          expect(response.body).to include "Reset password"
        end        
      end
    end

    # passwordが空の場合を検証する
    context "when user sends blank password" do
      # 前処理
      before do
        # passwordとpassword_confirmationを更新する
        patch password_reset_path(user.reset_token),
          # params
          params: {
            # email
            email: user.email,
            # user
            user: {
              # password
              password: "",
              # password_confirmation
              password_confirmation: "",
            },
          }
      end

      # 更新に失敗した場合を検証する
      it "fails" do
        # 集計に失敗する
        aggregate_failures do
          # レスポンスに成功することを期待する
          expect(response).to have_http_status(200)
          # レスポンスに"Reset password"が含まれていることを期待する
          expect(response.body).to include "Reset password"
        end        
      end
    end

    # 有効なpasswordとpassword_confirmationを検証する
    context "when user sends correct password" do
      # 前処理
      before do
        # passwordとpassword_confirmationを更新する
        patch password_reset_path(user.reset_token),
          # params
          params: {
            # email
            email: user.email,
            # user
            user: {
              # password
              password: "foobaz",
              # password_confirmation
              password_confirmation: "foobaz",
            },
          }
      end

      # 更新に失敗した場合を検証する
      it "fails" do
        # 集計に失敗する
        aggregate_failures do
          # is_logged_in?メソッドの戻り値がtruthyであることを期待する
          expect(is_logged_in?).to be_truthy
          # ダイジェストがnilになることを期待する
          expext(user.reload.reset_digest).to eq nil
          # userページへリダイレクトすることを期待する
          expect(response).to redirect_to user
        end        
      end
    end
  end

  # check_expirationアクションのテスト
  describe "def check_expiration" do
    # password再設定が有効期限切れの場合を検証する
    context "when user updates after 3 hours" do
      # 前処理
      before do
        # 3時間後
        user.update_attribute(:reset_sent_at, 3.hours.ago)
        # passwordとpassword_confirmationを更新する
        patch password_reset_path(user.reset_token),
          # params
          params: {
            # email
            email: user.email,
            # user
            user: {
              # password
              password: "foobar",
              # password_confirmation
              password_confirmation: "foobar",
            },
          }
      end

      # password再設定が有効期限切れの場合を検証する
      it "fails" do
        # new_password_resetページへリダイレクトする
        expect(response).to redirect_to new_password_reset_url
      end
    end
  end
end
