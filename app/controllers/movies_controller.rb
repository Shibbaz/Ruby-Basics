# frozen_string_literal: true

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
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit; end

  # POST /movies or /movies.json
  def create
    respond_to do |format|
      @movie = Contexts::Movies::Commands::Create.new.call(params: movie_params)
      format.html { redirect_to movie_url(@movie), notice: 'Movie was successfully created.' }
      format.json { render :show, status: :created, location: @movie }
    rescue ActiveRecord::RecordInvalid => e
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      @movie = Contexts::Movies::Commands::Update.new.call(movie_params)
      format.html { redirect_to movies_url(@movie), notice: 'Movie was successfully updated.' }
      format.json { render :show, status: :created, location: @movie }
    rescue ActiveRecord::RecordNotFound => e
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    respond_to do |format|
      @movie = Contexts::Movies::Commands::Delete.new.call(params[:id])
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    rescue ActiveRecord::RecordNotFound => e
      format.html { render :destroy, status: :unprocessable_entity }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
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
