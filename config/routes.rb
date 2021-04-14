Rails.application.routes.draw do
  # resources :friends
  post 'friends/new'
  get 'friends/index'
  devise_for :users
  resources :posts
  get 'welcome/index'
  root 'welcome#index'
  resources :conversations, only: [:create,:index] do
		member do
				post :close
		end
	resources :messages, only: [:create]
	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
