Rails.application.routes.draw do
  mount Api => '/'

  devise_for :users

  resources :timers, :except => :show do
    put 'start' => 'timers#start', :as => :start
    put 'stop' => 'timers#stop', :as => :stop
  end

  root :to => 'timers#index'
end
