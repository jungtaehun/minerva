class EvaluationsController < ApplicationController
  def index
    @evaluations = Evaluation.all
    
  end
  before_action :authenticate_user!

  def new
    @evaluation = Evaluation.new
    @courses = Course.all
    @lectures = Lecture.all
    @professors = Professor.all
  end

  def create
    @user = current_user
    prof = evaluation_params[:professor]
    lec = evaluation_params[:lecture]
    evaluation = Evaluation.new(evaluation_params)
    evaluation.set_user!(@user)
    if evaluation.save!
      redirect_to "/"
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def evaluation_params
    params.require(:evaluation).permit(:user_id, :course_id, :point, :content, :professor_id, :lecture_id)
  end
end
