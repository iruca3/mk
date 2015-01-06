Rails.application.routes.draw do
  devise_for :users

  root to: 'top#index'

  post 'user' => 'user#update', as: :update_user_status
end
