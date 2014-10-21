class UsersController < ApplicationController
before_filter :authorize, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end

  def show
    @user = User.find_by id: params[:id]
    if @user == nil
      redirect_to root_path
    end
    @products = @user.products
  end

  def edit
    user = User.find_by id: params[:id]
    if user != current_user
      redirect_to user_path(params[:id]), notice: "You can't edit other accounts."

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

  def destroy
    user = User.find(params[:id])
    delete_user(user)
    redirect_to root_path
  end

  def my_orders
    @total_rev = my_total_revenue
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :id)
  end

  def confirm
   @user = User.find_by id: params[:id]
   # for sessions, use session[:user_id]
  end

  def my_total_revenue
    total_rev = 0
    current_user.order_items.each do |item|
      total_rev += (item.subtotal * item.quantity_of_product)
    end
    total_rev
  end

end
