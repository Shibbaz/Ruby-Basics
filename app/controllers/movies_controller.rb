class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]

  # GET /movies or /movies.json
  def index
    respond_to do |format|
      @movies = Contexts::Movies::Queries::MovieQueries.new.all(page: params[:page])
      format.html { render :index }
      format.json { render json: @movies }
    end
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
    respond_to do |format|
      @movie = Contexts::Movies::Commands::Create.new.call(params: movie_params)
      format.html { redirect_to movie_url(@movie), notice: 'Movie was successfully created.' }
      format.json { render :show, status: :created, location: @movie }
    rescue ActiveRecord::RecordInvalid
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: { message: 'Cannot create the user' }, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      @movie = Contexts::Movies::Commands::Update.new.call(movie_params)
      format.html { redirect_to movies_url(@movie), notice: 'Movie was successfully updated.' }
      format.json { render :show, status: :created, location: @movie }
    rescue ActiveRecord::RecordNotFound
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: { message: 'Cannot update the user' }, status: :unprocessable_entity }
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    respond_to do |format|
      @movie = Contexts::Movies::Commands::Delete.new.call(params[:id].to_i)
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    rescue ActiveRecord::RecordNotFound
      format.html { render :new, status: :unprocessable_entity }
      format.json do
        render json: { message: 'Cannot delete, such record already does not exist' }, status: :unprocessable_entity
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Contexts::Movies::Queries::MovieQueries.new.find_by({ id: params[:id] })
  end

  # Only allow a list of trusted parameters through.
  def movie_params
    params.permit(:id, :imdb_id, :title, :rating, :rank, :year, :data)
  end
end
