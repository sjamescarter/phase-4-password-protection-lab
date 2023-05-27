class SessionsController < ApplicationController
  
  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user
    elsif user
      render json: { errors: user.errors.full_messages }, status: :unauthorized
    else
      render json: { error: "Please sign up" }, status: :unauthorized
    end
  end

  def destroy
    session.delete :user_id
    head :no_content
  end
end
