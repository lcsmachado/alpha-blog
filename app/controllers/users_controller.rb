class UsersController < ApplicationController

  before_action :set_users, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [ :edit, :update  ]
  before_action :require_same_user, only: [ :edit, :update, :destroy ]
  before_action :require_not_logged_in, only: [:new]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Alpha blog, you have successfully signed up, #{@user.username}"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your user information was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated articles successfully deleted"
    redirect_to root_path
  end

  private 

  def set_users
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own account"
      redirect_to @user
    end
  end
end