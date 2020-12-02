module SessionsHelper
  
  # 渡されたuserでloginする
  def log_in(user)
    # userのブラウザ内の一時cookiesに暗号化済みのuseridが自動で作成される
    session[:user_id] = user.id
  end
end
