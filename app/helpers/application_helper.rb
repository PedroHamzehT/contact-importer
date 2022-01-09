module ApplicationHelper
  def authenticated_user?
    session[:user_id] ? true : false
  end

  def current_controller?(controller)
    request.path.include?(controller)
  end
end
