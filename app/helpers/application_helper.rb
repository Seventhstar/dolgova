module ApplicationHelper
  def user_name
    current_admin_user&.name
  end

end
