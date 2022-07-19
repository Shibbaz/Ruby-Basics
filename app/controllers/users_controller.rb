class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    respond_to do |format|
      @users = Contexts::Users::Queries::UserQueries.new.all
      format.html { render :index }
      format.json { render json: @users }
    rescue ActiveRecord::RecordInvalid => e
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
      format.html { render :index, status: :unprocessable_entity }
    end
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.create!
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    respond_to do |format|
      @user = Contexts::Users::Commands::Create.new.call(params: user_params)
      format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
      format.json { render json: @user, status: :created, location: @user }
    rescue ActiveRecord::RecordInvalid => e
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      @user = Contexts::Users::Commands::Update.new.call(user_params)
      format.html { redirect_to users_url(@user), notice: 'User was successfully updated.' }
      format.json { render json: @user, status: :ok, location: @user }
    rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid => e
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    respond_to do |format|
      @user = Contexts::Users::Commands::Delete.new.call(params[:id])
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    rescue ActiveRecord::RecordNotFound => e
      format.html { render :destroy, status: :unprocessable_entity }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = Contexts::Users::Queries::UserQueries.new.find_by({ id: params[:id] })
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:id, :email, :first_name, :last_name, :role, :password)
  end
end
