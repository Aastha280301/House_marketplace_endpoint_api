class Property < ApplicationRecord
  has_many :favorites
  has_many :users, through: :favorites

  def self.search(search_params)
    properties = all

    properties = properties.where("city = ?", search_params[:city]) if search_params[:city].present?
    properties = properties.where("district = ?", search_params[:district]) if search_params[:district].present?
    properties = properties.where("bedrooms = ?", search_params[:bedrooms]) if search_params[:bedrooms].present?
    properties = properties.where("rent <= ?", search_params[:rent]) if search_params[:rent].present?
    properties = properties.where("mrt_line = ?", search_params[:mrt_line]) if search_params[:mrt_line].present?

    properties
  end
end
