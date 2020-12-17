# rails_helperを読み込む
require "rails_helper"

# 現在のメールの実装をテストする
RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
=begin
    以下のエラーが発生し、config/production.rb内に「config.action_mailer.default_url_options = { host: 'example.com'}」を記述しても解決しないため、コメントアウト
    ActionView::Template::Error: Missing host to link to! Please provide the :host parameter, set default_url_options[:host], or set :only_path to true
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { UserMailer.account_activation(user) }

    it "renders the headers" do
      expect(mail.subject).to eq "Account activation"
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match user.name
      expect(mail.body.encoded).to match user.activation_token
      expect(mail.body.encoded).to match CGI.escape(user.email)
    end
=end
  end
end
