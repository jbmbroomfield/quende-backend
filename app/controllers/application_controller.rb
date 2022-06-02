class ApplicationController < ActionController::API
  
	def default_render
		json = { success: !!@data }
		json[:data] = @data if @data
		json[:jwt] = @jwt if @jwt
		json[:errors] = @errors if @errors
		json[:error] = @error if @error
		render json: json, status: @status || :ok
	end

  def encode_token(payload)
    JWT.encode(payload, ENV['jwt_key'])
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, ENV['jwt_key'], true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    current_user && current_user.member?
  end
  
  def admin?
    logged_in? && current_user.admin?
  end

  def require_user
    user_not_found unless current_user
  end

  def user_not_found
		@errors = { slug: "User not found." }
		@status = :not_found
    default_render
  end

  def require_login
    please_login unless logged_in?
  end

  def please_login
    @error = 'Please log in.'
    @status = :unauthorized
    default_render
  end

  def require_admin
    unauthorized unless admin?
  end

  def unauthorized
    @error = 'Unauthorized'
    @status = :unauthorized
    default_render
  end

  def require_viewer
    url = "forum/#{params[:subsection_slug]}/#{params[:topic_slug]}"
    unauthorized unless !topic || topic.can_view(current_user, url)
  end

  def require_poster
    unauthorized unless !topic || topic.can_post(current_user, params[:password])
  end

  def subsection
    Subsection.find_by(slug: params[:subsection_slug])
  end

  def topic
    Topic.find_by(subsection: subsection, slug: params[:topic_slug])
  end

end
