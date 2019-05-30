class Api::V1::UsersController < ApplicationController
  def create
    _upsert
  end

  def update
    _upsert
  end

  def index
    render json: ::V1::UserSerializer.new(User.all).serializable_hash
  end

  private

  def _upsert
    user, errors = ::V1::Users::UpsertUser.new(user_params).exec
    render json: { 
                  errors: Array(errors),
                  status: user ? 200 : 500
                 }.merge(V1::UserSerializer.new(user).serializable_hash)
  end

  def user_params
    params.require(:user).permit(:email, :name, :password_digest, :activated, regions: {})
  end
end
