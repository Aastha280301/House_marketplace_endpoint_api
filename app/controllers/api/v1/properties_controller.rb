class Api::V1::PropertiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @properties = Property.all
    render json: @properties
  end

  def show
    @property = Property.find(params[:id])
    render json: @property
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      render json: @property, status: :created
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      render json: @property
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    head :no_content
  end

  private

  def property_params
    params.require(:property).permit(:city, :district, :bedrooms, :rent, :mrt_line, :user_id)
  end
end
