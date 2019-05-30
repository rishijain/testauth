class Api::V1::SessionsController < ApplicationController
  
  def create
    data = ::V1::UserAuth.new(session_params[:email], session_params[:password]).authenticate_user
    if data[:status]
      session[:user_id] = 70144
    end
    render json: data
  end

  private
  
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
