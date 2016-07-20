class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @movies = @movies.where("title like ?", "%#{params[:title]}%") if params[:title]
    @movies = @movies.where("director like ?", "%#{params[:director]}%") if params[:director]
    @movies = @movies.where("runtime_in_minutes < ?", 90) if params[:duration] == '2'
    @movies = @movies.where("runtime_in_minutes >= ? AND runtime_in_minutes <= ?", 90, 120) if params[:duration] == '3'
    @movies = @movies.where("runtime_in_minutes > ?", 120) if params[:duration] == '4'
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(:title, :director, :runtime_in_minutes, :poster_image_url, :description, :release_date, :poster)
  end
end
