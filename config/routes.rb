Rails.application.routes.draw do
  get 'contacts/index'
  get 'ajax/write_in'
  #devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, ActiveAdmin::Devise.config
#             controllers: { registrations: 'users/registrations',
#                            sessions: 'users/sessions'}

  get 'schedule/index'
  ActiveAdmin.routes(self)
  get 'static/index'
  root to: "static#index"
  resource :events
  post "ajax/write_in"
end
