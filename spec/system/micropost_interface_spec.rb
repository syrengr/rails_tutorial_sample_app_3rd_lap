=begin
メール送信の実装を省いたためコメントアウト

# rails_helperを読み込む
require "rails_helper"

# マイクロポストのUIに対するテスト
RSpec.describe "MicropostsInterfaces", type: :system do
  # Userモデルのファクトリ作成
  let(:user) { FactoryBot.create(:user) }
  # Micropostモデルのファクトリ作成
  let(:micropost) { FactoryBot.create(:micropost) }

  # 前処理
  before do
    # 繰り返し処理
    34.times do
      # ダミーデータ生成
      content = Faker::Lorem.sentence(word_count: 5)
      # マイクロポスト作成
      user.microposts.create!(content: content)
    end
  end

  # UIテスト
  scenario "micropost interface" do
    # メソッド呼び出し
    login_as(user)
    # ボタンへのクリックをシュミレート
    click_on "Home"

    # ボタンへのクリックをシュミレート
    click_on "Post"
    # 指定のCSSがありtruthyを返すことを期待する
    expect(has_css?('.alert-danger')).to be_truthy

    # ボタンへのクリックをシュミレート
    click_on "2"
    # 静的解析
    expect(URI.parse(current_url).query).to eq "page=2"

    # 変数定義
    valid_content = "This micropost really ties the room together"
    # フォームへの入力をシュミレートする
    fill_in "micropost_content", with: valid_content
    # 画像をアップロードするためのテスト
    attach_file "micropost[image]", "#{Rails.root}/spec/fixtures/kitten.jpg"
    # 以下の挙動を期待する
    expect do
      # ボタンへのクリックをシュミレートする
      click_on "Post"
      # 現在の場所がrootページであることを期待する
      expect(current_path).to eq root_path
      # 指定のCSSがありtruthyを返すことを期待する
      expect(has_css?(".alert-success")).to be_truthy
      # 画像が表示されていることを期待する
      expect(page).to have_selector "img[src$='kitten.jpg']"
    # 1件増加していることを期待する
    end.to change(Micropost, :count).by(1)

    # 以下の挙動を期待する
    expect do
      # 確認
      page.accept_confirm do
        # ボタンへのクリックをシュミレート
        all("ol li")[0].click_on "delete"
      end
      # 現在の場所がrootページであることを期待する
      expect(current_path).to eq root_path
      # 指定のCSSがありtruthyを返すことを期待する
      expect(has_css?(".alert-success")).to be_truthy
    # 1件減少していることを期待する
    end.to change(Micropost, :count).by(-1)

    # userページを開く
    visit user_path(micropost.user)
    # リンクが無いことを期待する
    expect(page).not_to have_link "delete"
  end
end

=end
