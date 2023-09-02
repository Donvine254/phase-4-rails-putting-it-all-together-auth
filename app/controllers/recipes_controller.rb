class RecipesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
def index 
    user= find_user
    render json: user.recipes, status: :ok
end    
def create 
    user= find_user
    recipe=user.recipes.create!(recipe_params)
    render json:recipe, status: :created
end
  private

  def render_not_found
    render json: { errors: ['User not found'] }, status: 401
  end

  def render_unprocessable_entity(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
def find_user 
    session[:user_id]
    user=User.find(session[:user_id])
end
  def recipe_params
    params.permit(:instructions, :title, :minutes_to_complete)
  end
end
