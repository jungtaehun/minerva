class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.integer :lecture_id
      t.integer :professor_id
      t.string :dept
      t.integer :year
      t.integer :samester
      t.integer :grade

      t.timestamps
    end
  end
end
