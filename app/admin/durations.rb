ActiveAdmin.register Duration do
  permit_params :name, :minutes
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :minutes
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :minutes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
