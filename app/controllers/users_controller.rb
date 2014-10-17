
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

  def signin(user)
    if self.current_user = user
      redirect_to root_path
    else
      render :new
    end
  end

  def create
    @user = User.new
    if @user.save
      #sign_in @user
      flash[:notice] = "You signed up successfully"
      flash[:color] = "valid"
      redirect_to root_path
    else
      flash[:notice] = "Form is invalid"
      flash[:color] = "invalid"
    end
    render :new
  end

def login
  @user = User.new
  if @user.password == params[:password]
  else
    redirect_to root_path
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
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :id)
  end
end
