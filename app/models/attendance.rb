class Attendance < ActiveRecord::Base
  belongs_to :student
  
  validates :student_id, uniqueness: { scope: :attended_on, 
    message: "can only attend once per day." }
  validates :seat, numericality: { only_integer: true,
    greater_than_or_equal_to: 1, less_than_or_equal_to: 4 }
end