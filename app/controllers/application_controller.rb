class ApplicationController < ActionController::API
    
    include RenderHelper

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
        !!current_user
    end
    
    def admin?
        logged_in? && current_user.admin?
    end

    def require_login
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end

    def require_admin
        render json: { message: 'Unauthorized' }, status: :unauthorized unless admin?
    end

end
