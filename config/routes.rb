Rails.application.routes.draw do

	mount ActionCable.server => '/cable'
	resources :posts

	namespace :api do
		namespace :v1 do

			get '/current_user', to: 'users#current'
			patch '/current_user', to: 'users#update'
			resources :users, only: [:create, :index]
			get 'users/:user_slug', to: 'users#show'
			post '/login', to: 'auth#create'
			get '/profile', to: 'users#profile'

			resources :sections, only: [:create, :index, :show] do
				resources :subsections, only: [:create]
			end

			resources :subsections, only: [:index] do 
				resources :topics, only: [:create, :index]
			end

			get 'forum/:subsection_slug', to: 'subsections#show'

			resources :topics, only: [] do
				resources :posts, only: [:create, :index]
			end

			get 'forum/:subsection_slug/topics', to: 'topics#index'
			post 'forum/:subsection_slug/topics', to: 'topics#create'
			get 'forum/:subsection_slug/:topic_slug', to: 'topics#show'
			patch 'forum/:subsection_slug/:topic_slug', to: 'topics#update'

			resources :posts, only: [:show] do
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
