module LoginHelper

  def logged_in?
    current_user
  end

  def current_user
    User.find id: session[:user_id]
  end

end
