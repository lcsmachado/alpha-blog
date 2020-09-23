class UsersController < ApplicationController

  before_action :set_users, only: [:edit, :update, :show]

  def show
    @articles = @user.articles
  end
  
  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your user information was successfully updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Welcome to Alpha blog, you have successfully signed up, #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  private 

  def set_users
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end