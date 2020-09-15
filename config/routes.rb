Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  get 'schedule/index'
  ActiveAdmin.routes(self)
  get 'static/index'
  root to: "static#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
