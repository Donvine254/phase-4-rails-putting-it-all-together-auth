class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    def show
      user = User.find_by(id: session[:user_id])
      if user
        render json: user
      else
        render json: { error: 'Not authorized' }, status: :unauthorized
      end
    end
    def create 
      user=User.create!(user_params)
      session[:user_id]=user.id
      render json: user, status: :created
  
    end
  
    private
  
    def render_not_found
      render json: { error: 'user not found' }, status: :not_found
    end
    def render_unprocessable_entity (invalid)
        render json:{errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
    def user_params 
      params.permit(:username, :password, :bio, :image_url, :password_confirmation)
    end
end
