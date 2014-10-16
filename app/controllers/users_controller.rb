
class UsersController < ApplicationController

  def show
    @user = User.find_by id: params[:id]
    @logged_user = User.first #just to test
    if @user == nil
      redirect_to root_path
    end
    @products = @user.products
  end

  def new
    @user = User.new
  end

  def create
      @user = User.new(params.require(:user).permit(:name))
    if @user.save
      session[:id] = @user.id
      redirect_to users_path
    else
      render :new
    end
  end

  def signin
    if User.exists?(params.require(:user).permit(:username, :id))
      @user = User.find(params[:user][:id])
      session[:id] = @user.id
      redirect_to users_path
    else
      redirect_to users_login_path
    end
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
    params.require(:user).permit(:username, :email, :password)
  end

  # def destroy
  #   user = User.find(params[:id])
  #   delete_user(user)
  #   redirect_to user_path
  # end

end
