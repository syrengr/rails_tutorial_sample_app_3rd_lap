# rails_helperを読み込む
require "rails_helper"

# タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
RSpec.describe "access to users", type: :request do
  # タイトルの引用元：Rails チュートリアル（３章、４章、５章）をRSpecでテスト
  describe "GET #new" do
    # タイトルの引用元：Rails Tutorial
    it "should get new" do
      # アクションをgetして正常に動作することを検証する
      get signup_path
      # 200レスポンスが返却されていることを検証する
      expect(response).to have_http_status 200
    end
  end

  # コンセプトを明確にする意味とユーザー登録ページをダブルチェックする意味も兼ねて、両方のメソッドを呼び出す
  # 有効なuserの検証
  context "valid request" do
    # userが追加される
    it "adds a user" do
      expect do
        # user数を覚えた後にデータを投稿してみて、user数が変わらないかどうかを検証する
      #   post signup_path, params: { user: attributes_for(:user) }
      # end.to change(User, :count).by(1)
      end
    end
    # userが追加されたときの検証
    context "adds a user" do
      # paramsの値をsignup_pathに登録する（attributes_forはハッシュで返す）
      # before { post signup_path, params: { user: attributes_for(:user) } }
      # レスポンスを検証する
      # subject { response }
      # showページにリダイレクトされることを期待する
      # it { is_expected.to redirect_to user_path(User.last) }
      # リダイレクトに成功することを期待する
      # it { is_expected.to have_http_status 302 }
      # エラーメッセージを検証する
      # it { is_expected.to 'div#<CSS id for error explanation>' }
      # it { is_expected.to 'div.<CSS class for field with error>' }
    end
  end
end
