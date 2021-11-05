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

			resources :posts, only: [] do
				resources :flags, only: [:create]
				delete 'flags', to: 'flags#destroy'
			end

			get 'user_topics/:topic_id', to: 'user_topics#show'
			post 'user_topics/:topic_id/subscribe', to: 'user_topics#subscribe'

			resources :notifications, only: [:index, :destroy]

			post '/upload_avatar', to: 'users#upload_avatar'
			
		end
	end

end
