class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    puts "after_sign_in_path_for fired"
    static_index_path
  end

end
