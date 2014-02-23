class AttendancesController < ApplicationController
  
  def index
    @current_student = get_current_student
    # Get the students in each seat
    @selected_date = params[:selected_date] || Date.today
    @in_seat_1 = Student.in_seat(1, @selected_date)
    @in_seat_2 = Student.in_seat(2, @selected_date)
    @in_seat_3 = Student.in_seat(3, @selected_date)
    @in_seat_4 = Student.in_seat(4, @selected_date)
    @absent = Student.absent(@selected_date)
  end
  
  def new
    # Make sure they're logged in
    @current_student = get_current_student
    
    if !@current_student
      redirect_to login_page_path
    end
    
    @attendance = Attendance.new
  end
  
  def create
    # Make sure they're logged in
    @current_student = get_current_student
    
    if !@current_student
      redirect_to login_page_path
    end
    
    # Record the attendance
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      # Send them to the index page
      redirect_to attendances_path, notice: "Attendance successfully recorded!"
    else
      render 'new'
    end
  end

  private
  def attendance_params
    current_student = get_current_student
    params[:attendance][:student_id] = current_student.id
    params[:attendance][:attended_on] = Date.today
    params.require(:attendance).permit(:seat, :student_id, :attended_on)
    
  end
  
end