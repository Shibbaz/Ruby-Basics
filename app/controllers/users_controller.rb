class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    begin
      @users = Contexts::Users::Queries::UserQueries.new.all
    rescue ActiveRecord::CatchAll
      render :json => "records not found"
    end
    render json: @users
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
      begin
        @user = Contexts::Users::Commands::Create.new.call(params: user_params)
      rescue ActiveRecord::CatchAll
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end      
      format.html { redirect_to movie_url(@user), notice: 'User was successfully created.' }
      format.json { render :show, status: :created, location: @user }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      begin
        Contexts::Users::Commands::Update.new.call(params: user_params)
      rescue ActiveRecord::CatchAll
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
        format.html { redirect_to movie_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    respond_to do |format|
    begin
      Contexts::Users::Commands::Delete.new.call(@user.id)
    rescue ActiveRecord::CatchAll
    end

    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    begin
      @user = Contexts::Users::Queries::MovieQueries.new.find_by({id: params[:id]})
    rescue ActiveRecord::CatchAll
    end
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:email, :first_name, :last_name, :role, :password)
  end
end
