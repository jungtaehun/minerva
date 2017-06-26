class EvaluationsController < ApplicationController
  def index
    @evaluations = Evaluation.all
  end

  def new
    @evaluation = Evaluation.new
    @courses = Course.all
  end

  def create
    @user = current_user
    evaluation = Evaluation.new(evaluation_params)
    evaluation.set_user!(@user)
    if evaluation.save
      redirect_to "/"
    else
      redirect_to :back
    end
  end

  private
  def evaluation_params
    params.require(:evaluation).permit(:user_id, :course_id, :point, :content)
  end
end
