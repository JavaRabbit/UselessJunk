class UsersController < ActionController::Base
  def show
    @user = User.find_by id: params[:id]
    @logged_user = @user #just to test
    if @user == nil
      redirect_to root_path
    end
    @products = @user.products
  end
end
