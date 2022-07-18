class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    respond_to do |format|
      begin
        @users = Contexts::Users::Queries::UserQueries.new.all(page: params[:page])
      rescue ActiveRecord::CatchAll
        format.json { render json: @users.errors, status: :unprocessable_entity }
        format.html { render :index, status: :unprocessable_entity }
      end
      format.html { render :index }
      format.json { render json: @users }
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
      if @user.errors.size > 0
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      @user = Contexts::Users::Commands::Update.new.call(params: user_params)
      if @user.errors.size > 0
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user = Contexts::Users::Commands::Delete.new.call(@user.id)

    respond_to do |format|
      if @user.errors.size > 0
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = Contexts::Users::Queries::UserQueries.new.find_by({ id: params[:id] })
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:email, :first_name, :last_name, :role, :password)
  end
end
