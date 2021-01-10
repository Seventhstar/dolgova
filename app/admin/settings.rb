ActiveAdmin.register Setting do

  permit_params :key, :name, :value
  
end
