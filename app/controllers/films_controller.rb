class FilmsController < ApplicationController
  before_action :set_film, only: [:show, :update, :destroy]

  def index
    @films = Film.all
    json_response(@films)
  end

  def create
    @film = Film.create!(film_params)
    json_response(@film, :created)
  end

  def show
    json_response(@film)
  end

  def update
    @film.update(film_params)
    head :no_content
  end

  def destroy
    @film.destroy
    head :no_content
  end



  private

  def film_params
    params.permit(:title, :description, :created_by, :year, :related_film_ids)
  end

  def set_film
    @film = Film.find(params[:id])
  end
end
