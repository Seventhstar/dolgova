ActiveAdmin.register User do
  permit_params :email, :password, :name, :phone, :password_confirmation, :admin, :tarif_id, :actual
  menu label: "Пользователи"

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :phone
    column :actual
    column :current_sign_in_at
    column :sign_in_count
    column :tarif
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
      f.input :tarif, as: :select, collection: Tarif.all.map{|t| ["#{t.name} (#{t.amount})", t.id]}
      f.input :actual, as: :boolean
      f.input :admin, as: :boolean
      f.input :password if f.object.new_record?
      f.input :password_confirmation if f.object.new_record?
    end
    f.actions
  end

end
