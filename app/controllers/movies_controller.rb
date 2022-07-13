class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]

  # GET /movies or /movies.json
  def index
    @movies = Contexts::Movies::Queries::MovieQueries.new.all
    @movies
  end

  # GET /movies/1 or /movies/1.json
  def show; end

  # GET /movies/new
  def new
    @movie = Movie.create!
  end

  # GET /movies/1/edit
  def edit; end

  # POST /movies or /movies.json
  def create
    @movie = Contexts::Movies::Commands::Create.new.call(params: movie_params)

    respond_to do |format|
      if @movie.errors.size.equal? 0
        format.html { redirect_to movie_url(@movie), notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if Contexts::Movies::Commands::Update.new.call(params: movie_params)
        format.html { redirect_to movie_url(@movie), notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    Contexts::Movies::Commands::Delete.new.call(@movie.id)

    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Contexts::Movies::Queries::MovieQueries.new.find_by({id: params[:id]})
  end

  # Only allow a list of trusted parameters through.
  def movie_params
    params.permit(:imdb_id, :title, :rating, :rank, :year, :data)
  end
end
