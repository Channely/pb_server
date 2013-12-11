class UsersController < ApplicationController
  before_action :signed_in_user_or_admin, only: [:edit, :update]
  before_action :correct_user,            only: [:edit, :update]
  before_action :is_admin,                only: :index

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = 'welcome!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_update_params)
      flash[:success] = "Profile updated"
      unless admin?
        redirect_to @user
      else
        redirect_to users_path
      end
    else
      render 'edit'
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end


  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :question, :answer, :password_confirmation)
    end

    def user_update_params
      params.require(:user).permit(:name, :password, :question, :answer, :password_confirmation)
    end

    def signed_in_user_or_admin
      unless signed_in? || admin?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) || admin?
    end

    def is_admin
      unless admin?
        redirect_to root_path, notice: "Sorry,You aren't admin."
      end
    end
end
