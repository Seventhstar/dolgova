ActiveAdmin.register Meeting do
  menu label: "Вид консультации"
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :format_id, :duration_id
  #
  # or
  #
  permit_params do
    permitted = [:name, :format_id, :duration_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
end
