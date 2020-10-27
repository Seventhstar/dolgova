class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    puts "after_sign_in_path_for fired"
    static_index_path
  end

  def authenticate_active_admin_user!
    authenticate_user!
    # unless current_user.superadmin?
    #   flash[:alert] = "Unauthorized Access!"
    #   redirect_to root_path
    # end
  end

end
