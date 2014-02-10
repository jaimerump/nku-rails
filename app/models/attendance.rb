class Attendance < ActiveRecord::Base
  validates :student_id, uniqueness: { scope: :attended_on, 
    message: "Can only attend once per day." }
#  validates :seat, numericality: { only_integer: true,
  #  greater_than: 0, less_than: 5 }
end