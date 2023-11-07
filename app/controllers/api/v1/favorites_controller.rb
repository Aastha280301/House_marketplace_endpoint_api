class Api::V1::FavoritesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    favorites = current_user.favorites
    render json: favorites
  end

  def create
    @favorite = current_user.favorites.create(property_id: params[:property_id])
    authorize! :create, @favorite
    if @favorite.save
      render json: { message: 'Favorite created successfully' }
    else
      render json: { errors: @favorite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    authorize! :delete, @favorite
    if @favorite.destroy
      render json: {message: 'Removed from favorites.'}
    else
      render json: { errors: @favorite.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
