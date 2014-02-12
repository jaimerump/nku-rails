class Student < ActiveRecord::Base
  has_many :attendances, dependent: :destroy
  has_secure_password
  
  def self.absent(date)
    student_ids = Attendance.select("student_id").where("attended_on = ?", date)
    return Student.find(student_ids)
  end
    
  def self.in_seat(seat, date)
    attendances =  Attendance.where("attended_on = ? AND seat = ?", date, seat)
    student_ids = attendances.collect{ |a| a.student_id }
    return Student.find(student_ids)
  end
  
end
