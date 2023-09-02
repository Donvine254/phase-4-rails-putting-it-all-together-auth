class SessionsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      render json: @user, status: :ok
    else
      render_not_found
    end
  end

  def destroy
    if session[:user_id]
    session.delete(:user_id)
    head :no_content
    else
      render_not_found
    end      
  end

  private

  def render_not_found
    render json: { errors: ['User not found'] }, status: 401
  end
end
