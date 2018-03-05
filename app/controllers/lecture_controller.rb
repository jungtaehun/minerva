class LectureController < ApplicationController
  def info
    lec = params[:id]
    @lecture = Lecture.find(lec)
    @professors = Array.new
    @prof_evaluation = Hash.new
    Course.where('lecture_id = ?', lec).each do |c|
      prof = Professor.find(c.professor_id)
      @professors << prof

      avg = 0
      count = 0
      Evaluation.where('course_id = ?', c.id).each do |e|
        count = count + 1
        avg = ( avg * (count - 1) + e.point ) / count
      end

      @prof_evaluation[prof.id] = avg
    end


  end
end
