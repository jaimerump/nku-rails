class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :student_id
      t.string :name
      t.integer :score
      t.integer :total
    end
  end
end
