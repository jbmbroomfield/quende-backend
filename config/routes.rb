Rails.application.routes.draw do

	mount ActionCable.server => '/cable'
	resources :posts

	namespace :api do
		namespace :v1 do

			get '/current_user', to: 'users#current'
			resources :users, only: [:create, :show, :index]
			post '/login', to: 'auth#create'
			get '/profile', to: 'users#profile'

			resources :sections, only: [:create, :index, :show] do
				resources :subsections, only: [:create]
			end

			resources :subsections, only: [:index] do 
				resources :topics, only: [:create]
			end

			resources :topics, only: [:show, :index] do
				resources :posts, only: [:create, :index]
			end

		end
	end

end
