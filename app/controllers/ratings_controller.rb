class RatingsController < ApplicationController
  before_action :set_film
  before_action :set_film_rating, only: [:show, :update, :destroy]

  def index
    json_response(@film.ratings)
  end

  def show
    json_response(@rating)
  end

  def create
    @film.ratings.create!(rating_params)
    json_response(@film, :created)
  end

  def update
    @rating.update(rating_params)
    head :no_content
  end

  def destroy
    @rating.destroy
    head :no_content
  end

  private

  def rating_params
    params.permit(:rating_value, :comment)
  end

  def set_film
    @film = Film.find(params[:film_id])
  end

  def set_film_rating
    @rating = @film.ratings.find_by!(id: params[:id]) if @film
  end
end
