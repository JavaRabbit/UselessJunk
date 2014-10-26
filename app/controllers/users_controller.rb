class UsersController < ApplicationController

  before_filter :user_is_current_user, only: [:edit, :update, :destroy, :my_orders, :filter_orders]

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
    @retired_products = @user.products.where(retired: true)
    @active_products = @user.products.where("retired is NULL or retired = false")
  end

  def edit
    user = User.find_by id: params[:id]
    if user != current_user
      redirect_to user_path(params[:id]), notice: "You can't edit other accounts."
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(params[:id])
    else
      # raise current_user.errors.inspect
      render :edit
    end
  end

  def confirm
   @user = User.find_by id: params[:id]
  end

  def destroy
    user = User.find(params[:id])
    delete_user(user)
    redirect_to root_path
  end

  def my_orders
    @state = "all"
    @total_rev = total_rev(@state)
    @orders = filtered_orders(@state)
  end

  def filter_orders
    state = params[:state]
    @orders = filtered_orders(state)
    @total_rev = total_rev(state)
    @state = state
    render :my_orders
  end

  def ship_order_item
    order_item = OrderItem.find(params[:item_id])
    order_item.shipped = true
    order_item.save
    complete = true
    this_order = order_item.order
    this_order.order_items.each do |item|
      if item.shipped == false
        complete = false
      end
    end
    if complete == true
      this_order.state = "complete"
      this_order.save
    end
    redirect_to my_orders_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :id)
  end

  def total_rev(state)
    total_rev = 0
    current_user.order_items.each do |item|
      if state == "all"
        total_rev += item.subtotal
      elsif state == item.order.state
        total_rev += item.subtotal
      end
    end
    total_rev
  end

  def filtered_orders(state)
    orders = []
    unless state == "all"
      current_user.order_items.each do |item|
        if item.order.state == state
          unless orders.include? item.order
            orders << item.order
          end
        end
      end
    else
      current_user.order_items.each do |item|
        unless orders.include? item.order
          orders << item.order
        end
      end
    end
    orders
  end


  def user_is_current_user
    unless current_user == nil || current_user.id == params[:id].to_i
      flash[:notice] = "You may only edit/delete your own account."
      redirect_to root_path
    end
  end

end
