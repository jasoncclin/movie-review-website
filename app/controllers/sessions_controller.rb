class SessionsController < ApplicationController
  
  def new
  
  end

  def create
    # All emails are stored lowercase
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Logged In"
      redirect_to user
    else
      # redirect will show flash again without .now
      flash.now[:danger] = "Something wrong with login information"
      render 'new'
    end
  end


  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to root_path
  end
  
end