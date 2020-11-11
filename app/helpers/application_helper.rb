module ApplicationHelper
# モジュールは、関連したメソッドをまとめる方法の１つで、includeメソッドを使ってモジュールを読み込むことができる
# full_titleメソッドは自動的にすべてのビューで利用できる

  # ページごとの完全なタイトルを返す
  def full_title(page_title = '') # メソッド定義とオプション引数
    base_title = "Ruby on Rails Tutorial Sample App" # 変数への代入
    if page_title.empty? # 論理値テスト
      base_title # 暗黙の戻り値
    else
      page_title + " | " + base_title # 文字列の結合
    end
  end
end
