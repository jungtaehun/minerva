class UsersController < ApplicationController
  def index
    @favorite_courses = []
    Favorite.where('user_id = ?', current_user.id).each do |f|
      @favorite_courses << Course.find(f.course_id)
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to "/"
    else
      redirect_to :back
    end
  end

  def favorites_add
    user = User.find(params[:u_id])
    course = Course.find(params[:c_id])
    if user.favorites_addition(user.id, course.id)
      redirect_to request.referer
    end
  end

  def favorites_delete
    user = User.find(params[:u_id])
    course = Course.find(params[:c_id])
    if user.favorites_deletion(user.id, course.id)
      redirect_to request.referer
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
