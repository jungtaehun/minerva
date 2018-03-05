class ProfessorController < ApplicationController
  def info

    prof = params[:id]
    @professor = Professor.find(prof)

    @avg = 0
    count = 0
    Course.where('professor_id = ?', prof).each do |c|

      Evaluation.where('course_id = ?', c.id).each do |e|
        count = count + 1
        @avg = ( @avg * (count - 1) + val ) / count
      end
    end


  end
end
