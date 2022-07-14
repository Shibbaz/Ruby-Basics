class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]

  # GET /movies or /movies.json
  def index
    begin
      @movies = Contexts::Movies::Queries::MovieQueries.new.all
    rescue ActiveRecord::CatchAll
      render :json => "records not found"
    end
    render json: @movies
  end

  # GET /movies/1 or /movies/1.json
  def show; end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit; end

  # POST /movies or /movies.json
  def create
    respond_to do |format|
      begin
        @movie = Contexts::Movies::Commands::Create.new.call(params: movie_params)
      rescue ActiveRecord::CatchAll
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end      
      format.html { redirect_to movie_url(@movie), notice: 'Movie was successfully created.' }
      format.json { render :show, status: :created, location: @movie }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      begin
        Contexts::Movies::Commands::Update.new.call(params: movie_params)
      rescue ActiveRecord::CatchAll
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
        format.html { redirect_to movie_url(@movie), notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    respond_to do |format|
      Contexts::Movies::Commands::Delete.new.call(@movie.id)
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
