class FilmsController < ApplicationController
  before_action :set_url_slug, only: [:create, :update]
  before_action :set_film, only: [:show, :update, :destroy]

  def index
    @films = Film.paginate(page: params[:page], per_page: 10)
    json_response(@films)
  end

  def create
    # puts film_params
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
    params.permit(:title, :description, :created_by, :year, :related_film_ids, :url_slug)
  end

  def set_url_slug
    params[:url_slug] = params[:title].parameterize(separator: '_')
  end

  def set_film
    @film = Film.find(params[:id])
  end
end
