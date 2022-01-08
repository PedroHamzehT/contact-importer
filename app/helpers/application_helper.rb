module ApplicationHelper
  def authenticated_user?
    session[:user_id] ? true : false
  end
end
