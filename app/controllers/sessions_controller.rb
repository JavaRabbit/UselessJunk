class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])       #find user by email typed in
    if user && user.authenticate(params[:password]) # if user was found matching that email and if password
                                                    # matches with authenticate
      session[:user_id] = user.id                   #store user id to session
      redirect_to root_url#, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy #creates logout function
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged Out!"
  end

end
