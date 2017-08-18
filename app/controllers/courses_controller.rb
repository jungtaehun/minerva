class CoursesController < ApplicationController
  def index
    require 'kaminari'
    @courses = Course.page(params[:page])
    #@courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end
  def search
    search_keyword=params[:keyword]
  @result=Course.all
  @array=Array.new
    @result.each do |k|
    
    if !k.lecture.name.exclude? "#{search_keyword}"
      @array << k.lecture.name
      @array << k.professor.name
    end
  end
    
    respond_to do |format|
        format.js { render :json => @array }
      end
    
  end
end
