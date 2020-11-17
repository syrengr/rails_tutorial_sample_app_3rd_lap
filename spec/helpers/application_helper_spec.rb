# rails_helperを読み込む
require "rails_helper"

# ApplicationHelperを読み込む
RSpec.describe ApplicationHelper, type: :helper do
  # タイトルの引用元：Rails Tutorial
  describe "#full title helper" do
    # full_titileメソッドに文字列"Ruby on Rails Tutorial Sample App"が含まれていることを検証する
    it { expect(full_title("")).to eq "Ruby on Rails Tutorial Sample App" }
    # "help"を引数に渡しているfull_titileメソッドに、文字列"Help | Ruby on Rails Tutorial Sample App"が含まれていることを検証する
    it { expect(full_title("Help")).to eq "Help | Ruby on Rails Tutorial Sample App" }
  end
end
