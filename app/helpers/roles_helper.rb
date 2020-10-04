module RolesHelper
  def is_admin?
    current_user&.admin? || current_admin_user
  end

end
