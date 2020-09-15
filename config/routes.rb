Rails.application.routes.draw do
  get 'schedule/index'
  ActiveAdmin.routes(self)
  devise_for :users, ActiveAdmin::Devise.config
  get 'static/index'
  root to: "static#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
