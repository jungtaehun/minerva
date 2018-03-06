class CoursesController < ApplicationController
  def index
    require 'kaminari'
    @courses = Course.page(params[:page])
  end

  def show
    @course = Course.find(params[:id])
  end

  def search
    search_keyword=params[:keyword]
    @result=Course.all
    @array=Array.new
    i=0
    @result.each do |k|
    
      if !k.lecture.name.exclude? "#{search_keyword}"
        hash = Hash.new
        if Favorite.exists?(course_id: k.id, user_id: current_user.id) 
          hash["fav"]=true
        else
          hash["fav"]=false
        end
          hash["lecture_name"]= k.lecture.name
          hash["professor"]= k.professor.name
          hash["lecture_code"]= k.id
          @array[i]=hash
          i+=1
      end
    end
    
    # respond_to do |format|
    #     format.js { render :json => @array }
    #   end
    render :json => @array
end
  def favorites_add
    user = User.find(params[:u_id])
    course = Course.find(params[:c_id])
    
     
    if user.favorites_addition(user.id, course.id)
      respond_to do |format|
        format.js { render :json => true }
      end
    else
      respond_to do |format|
        format.js { render :json => false }
      end
    end
  end

  def favorites_delete
    user = User.find(params[:u_id])
    course = Course.find(params[:c_id])
    
     
    if user.favorites_deletion(user.id, course.id)
      respond_to do |format|
        format.js { render :json => true }
      end
    else
      respond_to do |format|
        format.js { render :json => false }
      end
    end
    
  end
end
