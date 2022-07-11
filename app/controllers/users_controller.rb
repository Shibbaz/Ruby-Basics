class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  attr_reader :user_repository

  def initialize
    @user_repository = Contexts::Users::Repository.new
  end

  # GET /users or /users.json
  def index
    @users = Contexts::Users::Queries::UserQueries.new.all
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = @user_repository.create
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = Contexts::Users::Commands::Create.new(@user_repository).call(params: user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if Contexts::Users::Commands::Update.new(@user_repository).call(params: user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    Contexts::Users::Commands::Delete.new(@user_repository).call(@user.id)

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = @user_repository.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:email, :first_name, :last_name, :role, :password)
  end
end
