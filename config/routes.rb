Rails.application.routes.draw do

  namespace :api do
		namespace :v1 do

			resources :users, only: [:create, :show, :index]
			post '/login', to: 'auth#create'
			get '/profile', to: 'users#profile'

			resources :sections, only: [:create, :index]
			resources :subsections, only: [:create, :index]

		end
  end

end
