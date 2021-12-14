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
      post '/guest-login', to: 'auth#guest_login'
			
			get '/profile', to: 'users#profile'

			resources :sections, only: [:create, :index, :show] do
				resources :subsections, only: [:create]
			end

			resources :subsections, only: [:index] do 
				resources :topics, only: [:create, :index]
			end

			get 'forum/:subsection_slug', to: 'subsections#show'

			get 'forum/:subsection_slug/topics', to: 'topics#index'
			post 'forum/:subsection_slug/topics', to: 'topics#create'
			get 'forum/:subsection_slug/:topic_slug', to: 'topics#show'
			patch 'forum/:subsection_slug/:topic_slug', to: 'topics#update'

			patch 'forum/:subsection_slug/:topic_slug/add-viewer', to: 'topics#add_viewer'
			patch 'forum/:subsection_slug/:topic_slug/add-poster', to: 'topics#add_poster'

			post 'forum/:subsection_slug/:topic_slug/posts', to: 'posts#create'
			get 'forum/:subsection_slug/:topic_slug/posts', to: 'posts#index'

			resources :posts, only: [:show] do
				resources :flags, only: [:create]
				delete 'flags', to: 'flags#destroy'
			end

			get 'user_topics/:subsection_slug/:topic_slug', to: 'user_topics#show'
			post 'user_topics/:subsection_slug/:topic_slug/subscribe', to: 'user_topics#subscribe'
			patch 'user_topics/:subsection_slug/:topic_slug', to: 'user_topics#update'

			resources :notifications, only: [:index, :destroy]

			post '/upload_avatar', to: 'users#upload_avatar'
			
		end
	end

end
