
class UsersController < ActionController::Base
  def show
    @user = User.find_by id: params[:id]
    @logged_user = @user #just to test
    if @user == nil
      redirect_to root_path
    end
    @products = @user.products
  end

  def edit
    @user = User.find_by id: params[:id]
    @logged_user = @user # just to test, later this should come from session
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

end
