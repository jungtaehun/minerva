class CreateEvaluations < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluations do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :point
      t.string :content

      t.timestamps
    end
  end
end
