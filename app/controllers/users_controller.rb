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
    @total_rev_pending = total_rev("pending")
    @total_rev_paid = total_rev("paid")
    @total_rev_complete = total_rev("complete")
    @total_rev_cancelled = total_rev("cancelled")
    @num_orders_pending = num_orders("pending")
    @num_orders_paid = num_orders("paid")
    @num_orders_complete = num_orders("complete")
    @num_orders_cancelled = num_orders("cancelled")

    @orders, @pending_orders , @paid_orders, @complete_orders, @cancelled_orders = [], [], [], [], []

    current_user.order_items.each do |o_item|
      o_item.order.order_items.where(product_id: o_item.product_id).each do |item|
        @orders << item.order
      end
    end

    @orders.each do |order|
      @pending_orders << order if order.state == 'pending'
      @paid_orders << order if order.state == 'paid'
      @compelte_orders << order if order.state == 'complete'
      @cancelled_orders << order if order.state == 'cancelled'
    end

  end

  def filter_orders
    #raise params[:state].inspect
    @orders = pending_orders
    render :my_orders
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
      unless item.order.state == "pending"
        total_rev += (item.subtotal * item.quantity_of_product)
      end
    end
    total_rev
  end

  def total_rev_paid_orders
    total_rev = 0
    current_user.order_items.each do |item|
      if item.order.state == "paid"
        total_rev += (item.subtotal * item.quantity_of_product)
      end
    end
    total_rev
  end

  def total_rev(state)
    total_rev = 0
    current_user.order_items.each do |item|
      if item.order.state == state
        total_rev += (item.subtotal * item.quantity_of_product)
      end
    end
    total_rev
  end

  def num_orders(state)
    order_num = 0
    current_user.order_items.each do |item|
      if item.order.state == state
        order_num += 1
      end
    end
    order_num
  end

  def pending_orders
    orders = []
    current_user.order_items.each do |item|
      if item.order.state == "pending"
        orders << item.order
      end
    end
    orders
  end




end
