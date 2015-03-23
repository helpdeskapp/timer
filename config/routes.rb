Rails.application.routes.draw do
  mount Api => '/'

  devise_for :users

  root :to => 'application#index'
end
