Rails.application.routes.draw do

  namespace :api do
		namespace :v1 do

			get '/current_user', to: 'users#current'
			resources :users, only: [:create, :show, :index]
			post '/login', to: 'auth#create'
			get '/profile', to: 'users#profile'

			resources :sections, only: [:create, :index, :show] do
				resources :subsections, only: [:create, :index]
			end

			resources :subsections, only: [] do 
				resources :topics, only: [:create, :index]
			end

			resources :topics, only: [:show] do
				resources :posts, only: [:create, :index]
			end

		end
  end

end
