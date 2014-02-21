class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :student_id
      t.date :attended_on
      t.integer :seat
      
      t.timestamps
    end
  end
end
