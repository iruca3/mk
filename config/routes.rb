Rails.application.routes.draw do
  devise_for :users

  root to: 'top#index'

  post 'user' => 'user#update', as: :update_user_status
  get 'user/option' => 'user#option', as: :user_option
  patch 'user/option' => 'user#update_option', as: :update_user_option
  get 'user/rss' => 'user#rss', as: :user_rss
end
