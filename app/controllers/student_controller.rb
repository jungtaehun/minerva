class StudentController < ApplicationController
  def index
    @favorite_courses = []
    Favorite.where('user_id = ?', current_student.id).each do |f|
      @favorite_courses << Course.find(f.course_id)
    end
  end

  def favorites_add
    user = Student.find(params[:u_id])
    course = Course.find(params[:c_id])
    if user.favorites_addition(user.id, course.id)
      redirect_to root_path
    end
  end

  def favorites_delete
    user = Student.find(params[:u_id])
    course = Course.find(params[:c_id])
    if user.favorites_deletion(user.id, course.id)
      redirect_to root_path
    end
  end
end
