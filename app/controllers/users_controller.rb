
class UsersController < ApplicationController
  def index
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    @logged_user = User.first #just to test
    if @user == nil
      redirect_to root_path
    end
    @products = @user.products
  end

  def create
    @user = User.new(user_params)
    if @vendor.save
      session[:id] = @vendor.id
      redirect_to vendors_path
    else
      render :new
    end
  end

def login
    @user = User.new
    render :login
end

  def edit
    @user = User.find_by id: params[:id]
    @logged_user = User.first # just to test, later this should come from session
    if @user != @logged_user
      redirect_to user_path(params[:id])
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(params[:id])
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password_digest, :id)
  end
end
