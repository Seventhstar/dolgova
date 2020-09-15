ActiveAdmin.register User do
  permit_params :email, :password, :name, :phone, :password_confirmation, :admin

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :phone
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :phone
      f.input :admin, as: :boolean
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
