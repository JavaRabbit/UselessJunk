
class UsersController < ActionController::Base
  def show
    @user = User.find_by id: params[:id]
    @logged_user = @user #just to test
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


end
