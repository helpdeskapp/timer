Rails.application.routes.draw do
  mount Api => '/'

  devise_for :users

  get 'timers/manual' => 'timers#manual'
  post 'timers/manual' => 'timers#manual'

  resources :timers, :except => :show do
    put 'start' => 'timers#start', :as => :start
    put 'stop' => 'timers#stop', :as => :stop
  end

  root :to => 'timers#index'
end
