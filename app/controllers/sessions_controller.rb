class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = Student.find_by_email(params[:email])
    if user && User.find_by_password(params[:password])
      session[:user_id] = user.id
      redirect_to "/"
    else
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/"
  end
end
