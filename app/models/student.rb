class Student < ActiveRecord::Base
  has_many :attendances, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_secure_password
  
  def self.absent(date=Date.today)
    attendances = Attendance.where("attended_on = ?", date)
    present_students = attendances.collect{ |a| a.student_id }
    return Student.where.not(id: present_students)
  end
    
  def self.in_seat(seat, date=Date.today)
    attendances =  Attendance.where("attended_on = ? AND seat = ?", date, seat)
    student_ids = attendances.collect{ |a| a.student_id }
    return Student.find(student_ids)
  end
  
end
